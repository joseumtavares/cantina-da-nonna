-- Criado por Jose Tavares para o perfil Supabase/PostgreSQL.
-- Este schema mantém a mesma intenção do banco local, usando a sintaxe correta do PostgreSQL.

-- ==========================================================
-- SCHEMA DO BANCO DE DADOS - CANTINA DA NONNA / SUPABASE
-- O Supabase já entrega um banco PostgreSQL pronto, então não usamos CREATE DATABASE nem USE como no MySQL local.
-- ==========================================================

-- Extensão usada para gerar UUIDs no PostgreSQL, equivalente ao DEFAULT (UUID()) do MySQL local.
CREATE EXTENSION IF NOT EXISTS pgcrypto^^^

-- ==========================================================
-- TABELA: categorias
-- Guarda as seções do cardápio, como Entradas, Massas, Pizzas, Sobremesas e Bebidas.
-- ==========================================================
CREATE TABLE IF NOT EXISTS public.categorias (
  -- ID gerado pelo próprio PostgreSQL usando UUID.
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- Nome exibido para o cliente no cardápio.
  nome VARCHAR(80) NOT NULL,

  -- Slug estável usado pelo sistema para localizar e filtrar categorias.
  slug VARCHAR(80) NOT NULL,

  -- Texto opcional para descrever melhor a categoria.
  descricao VARCHAR(255),

  -- Permite ocultar uma categoria sem apagar seu histórico.
  ativo BOOLEAN NOT NULL DEFAULT TRUE,

  -- Define a ordem em que a categoria aparece no cardápio.
  ordem_exibicao INTEGER NOT NULL DEFAULT 0,

  -- Datas de auditoria ajudam a acompanhar criação e alterações do registro.
  criado_em TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  atualizado_em TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  -- Garante que cada categoria tenha um slug único.
  CONSTRAINT uk_categorias_slug UNIQUE (slug)
)^^^

-- ==========================================================
-- TABELA: produtos
-- Guarda os produtos exibidos no cardápio e preparados para a futura tela administrativa.
-- ==========================================================
CREATE TABLE IF NOT EXISTS public.produtos (
  -- ID gerado pelo próprio PostgreSQL usando UUID.
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- Relaciona o produto com uma categoria existente do cardápio.
  categoria_id UUID NOT NULL,

  -- Código interno usado para identificar o produto no cadastro administrativo.
  codigo VARCHAR(30) NOT NULL,

  -- Nome público exibido para o cliente.
  nome VARCHAR(120) NOT NULL,

  -- Descrição com ingredientes, preparo ou detalhes úteis para o cardápio.
  descricao TEXT,

  -- Valor monetário do produto.
  valor NUMERIC(10,2) NOT NULL,

  -- Caminho da imagem que o front-end renderiza nos cards.
  imagem VARCHAR(255),

  -- Permite retirar um produto do cardápio sem excluir o registro.
  ativo BOOLEAN NOT NULL DEFAULT TRUE,

  -- Marca produtos que podem aparecer nos destaques da página inicial.
  destaque BOOLEAN NOT NULL DEFAULT FALSE,

  -- Define a ordem de exibição dentro da categoria.
  ordem_exibicao INTEGER NOT NULL DEFAULT 0,

  -- Datas de auditoria ajudam a acompanhar criação e alterações do registro.
  criado_em TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  atualizado_em TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  -- Impede dois produtos com o mesmo código interno.
  CONSTRAINT uk_produtos_codigo UNIQUE (codigo),

  -- Garante que todo produto pertença a uma categoria válida.
  CONSTRAINT fk_produtos_categorias
    FOREIGN KEY (categoria_id)
    REFERENCES public.categorias(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,

  -- Protege o cardápio contra valores negativos.
  CONSTRAINT chk_produtos_valor CHECK (valor >= 0)
)^^^

-- ==========================================================
-- TABELA: reservas
-- Guarda os dados que futuramente serão enviados pelo formulário de reserva.
-- ==========================================================
CREATE TABLE IF NOT EXISTS public.reservas (
  -- ID gerado pelo próprio PostgreSQL usando UUID.
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- Nome informado pelo cliente no formulário de reserva.
  nome_cliente VARCHAR(120) NOT NULL,

  -- Telefone ou WhatsApp para confirmação da reserva.
  telefone VARCHAR(20) NOT NULL,

  -- E-mail opcional para contato com o cliente.
  email VARCHAR(120),

  -- Quantidade de pessoas; a regra do site é mínimo 1 e máximo 20.
  quantidade_pessoas INTEGER NOT NULL,

  -- Data escolhida pelo cliente.
  data_reserva DATE NOT NULL,

  -- Horário escolhido pelo cliente.
  horario_reserva TIME NOT NULL,

  -- Preferência de ambiente escolhida no formulário.
  ambiente VARCHAR(40) NOT NULL DEFAULT 'sem-preferencia',

  -- Observações livres, como cadeira infantil, aniversário ou restrição alimentar.
  observacoes TEXT,

  -- Status usado para acompanhar o atendimento da reserva.
  status VARCHAR(20) NOT NULL DEFAULT 'PENDENTE',

  -- Datas de auditoria ajudam a acompanhar criação e alterações do registro.
  criado_em TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  atualizado_em TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  -- Repete no banco a mesma regra visual do formulário: de 1 a 20 pessoas.
  CONSTRAINT chk_reservas_pessoas CHECK (quantidade_pessoas BETWEEN 1 AND 20),

  -- Mantém os status padronizados para filtros e painéis futuros.
  CONSTRAINT chk_reservas_status CHECK (status IN ('PENDENTE', 'CONFIRMADA', 'CANCELADA', 'CONCLUIDA')),

  -- Mantém no banco as mesmas opções oferecidas no select do formulário.
  CONSTRAINT chk_reservas_ambiente CHECK (ambiente IN ('salao', 'varanda', 'familia', 'sem-preferencia'))
)^^^

-- ==========================================================
-- TABELA: usuarios_administrativos
-- Preparada para o futuro dashboard administrativo e para o fluxo de login/logout.
-- Senha deve ser armazenada somente como hash, nunca em texto puro.
-- ==========================================================
CREATE TABLE IF NOT EXISTS public.usuarios_administrativos (
  -- ID gerado pelo próprio PostgreSQL usando UUID.
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- Nome do usuário administrador.
  nome VARCHAR(120) NOT NULL,

  -- E-mail usado no login administrativo.
  email VARCHAR(120) NOT NULL,

  -- Hash da senha; senha aberta não deve ser gravada em hipótese nenhuma.
  senha_hash VARCHAR(255) NOT NULL,

  -- Perfil pensado para autorização no dashboard futuro.
  perfil VARCHAR(30) NOT NULL DEFAULT 'ADMIN',

  -- Permite desativar usuários sem apagar histórico.
  ativo BOOLEAN NOT NULL DEFAULT TRUE,

  -- Datas de auditoria ajudam a acompanhar criação e alterações do registro.
  criado_em TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  atualizado_em TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  -- Impede dois administradores com o mesmo e-mail.
  CONSTRAINT uk_usuarios_administrativos_email UNIQUE (email)
)^^^

-- ==========================================================
-- ATUALIZACAO AUTOMATICA DO CAMPO atualizado_em
-- PostgreSQL não possui ON UPDATE CURRENT_TIMESTAMP como o MySQL.
-- Esta função e os triggers reproduzem esse comportamento no Supabase.
-- ==========================================================
CREATE OR REPLACE FUNCTION public.atualizar_coluna_atualizado_em()
RETURNS TRIGGER AS $$
BEGIN
  NEW.atualizado_em = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql^^^

DROP TRIGGER IF EXISTS trg_categorias_atualizado_em ON public.categorias^^^
CREATE TRIGGER trg_categorias_atualizado_em
BEFORE UPDATE ON public.categorias
FOR EACH ROW
EXECUTE FUNCTION public.atualizar_coluna_atualizado_em()^^^

DROP TRIGGER IF EXISTS trg_produtos_atualizado_em ON public.produtos^^^
CREATE TRIGGER trg_produtos_atualizado_em
BEFORE UPDATE ON public.produtos
FOR EACH ROW
EXECUTE FUNCTION public.atualizar_coluna_atualizado_em()^^^

DROP TRIGGER IF EXISTS trg_reservas_atualizado_em ON public.reservas^^^
CREATE TRIGGER trg_reservas_atualizado_em
BEFORE UPDATE ON public.reservas
FOR EACH ROW
EXECUTE FUNCTION public.atualizar_coluna_atualizado_em()^^^

DROP TRIGGER IF EXISTS trg_usuarios_administrativos_atualizado_em ON public.usuarios_administrativos^^^
CREATE TRIGGER trg_usuarios_administrativos_atualizado_em
BEFORE UPDATE ON public.usuarios_administrativos
FOR EACH ROW
EXECUTE FUNCTION public.atualizar_coluna_atualizado_em()^^^
