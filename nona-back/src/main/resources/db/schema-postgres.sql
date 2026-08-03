-- Criado por Jose Tavares.
-- Perfil Supabase/PostgreSQL.
-- Este arquivo cria as tabelas principais da Cantina da Nonna usando sintaxe PostgreSQL.

-- ==========================================================
-- SCHEMA DO BANCO DE DADOS - CANTINA DA NONNA / SUPABASE
-- O Supabase ja entrega um banco PostgreSQL pronto, entao nao usamos
-- CREATE DATABASE nem USE como no MySQL local.
-- ==========================================================

-- Extensao usada para gerar UUIDs no PostgreSQL.
-- Equivalente ao padrao MySQL DEFAULT (UUID()) usado no projeto local.
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- ==========================================================
-- TABELA: categorias
-- Guarda as secoes do cardapio: Entradas, Massas, Pizzas,
-- Sobremesas e Bebidas.
-- ==========================================================
CREATE TABLE IF NOT EXISTS public.categorias (
  -- ID padrao no Supabase/PostgreSQL: chave primaria gerada por UUID no banco.
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- Nome exibido para o usuario no cardapio.
  nome VARCHAR(80) NOT NULL,

  -- Slug usado pelo sistema para filtrar produtos por categoria.
  slug VARCHAR(80) NOT NULL,

  -- Texto opcional para explicar a categoria.
  descricao VARCHAR(255),

  -- Controla se a categoria aparece ou nao no cardapio.
  ativo BOOLEAN NOT NULL DEFAULT TRUE,

  -- Define a ordem de exibicao no cardapio.
  ordem_exibicao INTEGER NOT NULL DEFAULT 0,

  -- Datas de auditoria para saber quando o registro foi criado/alterado.
  criado_em TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  atualizado_em TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  -- Evita duas categorias com o mesmo identificador textual.
  CONSTRAINT uk_categorias_slug UNIQUE (slug)
);

-- ==========================================================
-- TABELA: produtos
-- Guarda os produtos exibidos no cardapio e cadastrados pela
-- pagina cadastro-produtos.html.
-- ==========================================================
CREATE TABLE IF NOT EXISTS public.produtos (
  -- ID padrao no Supabase/PostgreSQL: chave primaria gerada por UUID no banco.
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- Relaciona o produto com uma categoria do cardapio.
  categoria_id UUID NOT NULL,

  -- Codigo interno informado no formulario administrativo.
  codigo VARCHAR(30) NOT NULL,

  -- Nome publico do produto.
  nome VARCHAR(120) NOT NULL,

  -- Descricao do produto, ingredientes ou detalhes do preparo.
  descricao TEXT,

  -- Valor monetario do produto.
  valor NUMERIC(10,2) NOT NULL,

  -- Caminho da imagem usada no front-end.
  imagem VARCHAR(255),

  -- Controla se o produto aparece no cardapio.
  ativo BOOLEAN NOT NULL DEFAULT TRUE,

  -- Permite marcar produtos de destaque para a pagina inicial.
  destaque BOOLEAN NOT NULL DEFAULT FALSE,

  -- Define a ordem de exibicao dentro da categoria.
  ordem_exibicao INTEGER NOT NULL DEFAULT 0,

  -- Datas de auditoria para saber quando o registro foi criado/alterado.
  criado_em TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  atualizado_em TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  -- Evita cadastrar dois produtos com o mesmo codigo interno.
  CONSTRAINT uk_produtos_codigo UNIQUE (codigo),

  -- Garante que o produto sempre pertence a uma categoria existente.
  CONSTRAINT fk_produtos_categorias
    FOREIGN KEY (categoria_id)
    REFERENCES public.categorias(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,

  -- Evita valores negativos no cardapio.
  CONSTRAINT chk_produtos_valor CHECK (valor >= 0)
);

-- ==========================================================
-- TABELA: reservas
-- Guarda os dados enviados pela pagina reserva.html.
-- ==========================================================
CREATE TABLE IF NOT EXISTS public.reservas (
  -- ID padrao no Supabase/PostgreSQL: chave primaria gerada por UUID no banco.
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- Nome do cliente informado no formulario de reserva.
  nome_cliente VARCHAR(120) NOT NULL,

  -- Telefone ou WhatsApp para contato.
  telefone VARCHAR(20) NOT NULL,

  -- E-mail opcional do cliente.
  email VARCHAR(120),

  -- Quantidade de pessoas da reserva. O front usa minimo 1 e maximo 20.
  quantidade_pessoas INTEGER NOT NULL,

  -- Data escolhida para a reserva.
  data_reserva DATE NOT NULL,

  -- Horario escolhido para a reserva.
  horario_reserva TIME NOT NULL,

  -- Preferencia de ambiente escolhida no formulario.
  ambiente VARCHAR(40) NOT NULL DEFAULT 'sem-preferencia',

  -- Observacoes livres: cadeira infantil, aniversario, restricoes etc.
  observacoes TEXT,

  -- Status operacional da reserva.
  status VARCHAR(20) NOT NULL DEFAULT 'PENDENTE',

  -- Datas de auditoria para saber quando o registro foi criado/alterado.
  criado_em TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  atualizado_em TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  -- Replica no banco a regra do front-end: minimo 1, maximo 20 pessoas.
  CONSTRAINT chk_reservas_pessoas CHECK (quantidade_pessoas BETWEEN 1 AND 20),

  -- Mantem status padronizados para facilitar filtros futuros.
  CONSTRAINT chk_reservas_status CHECK (status IN ('PENDENTE', 'CONFIRMADA', 'CANCELADA', 'CONCLUIDA')),

  -- Mantem as mesmas opcoes do select da pagina reserva.html.
  CONSTRAINT chk_reservas_ambiente CHECK (ambiente IN ('salao', 'varanda', 'familia', 'sem-preferencia'))
);

-- ==========================================================
-- TABELA: usuarios_administrativos
-- Preparada para o dashboard administrativo e para o botao Logout.
-- A senha deve ser salva como hash, nunca como texto puro.
-- ==========================================================
CREATE TABLE IF NOT EXISTS public.usuarios_administrativos (
  -- ID padrao no Supabase/PostgreSQL: chave primaria gerada por UUID no banco.
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- Nome do usuario administrador.
  nome VARCHAR(120) NOT NULL,

  -- E-mail usado para login.
  email VARCHAR(120) NOT NULL,

  -- Senha criptografada/hash. Nunca salvar senha aberta no banco.
  senha_hash VARCHAR(255) NOT NULL,

  -- Perfil para autorizacao futura no dashboard.
  perfil VARCHAR(30) NOT NULL DEFAULT 'ADMIN',

  -- Permite desativar usuarios sem apagar historico.
  ativo BOOLEAN NOT NULL DEFAULT TRUE,

  -- Datas de auditoria para saber quando o registro foi criado/alterado.
  criado_em TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  atualizado_em TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  -- Evita dois administradores com o mesmo e-mail.
  CONSTRAINT uk_usuarios_administrativos_email UNIQUE (email)
);

-- ==========================================================
-- ATUALIZACAO AUTOMATICA DO CAMPO atualizado_em
-- PostgreSQL nao possui ON UPDATE CURRENT_TIMESTAMP como MySQL.
-- Esta funcao e os triggers mantem o mesmo comportamento no Supabase.
-- ==========================================================
CREATE OR REPLACE FUNCTION public.atualizar_coluna_atualizado_em()
RETURNS TRIGGER AS $$
BEGIN
  NEW.atualizado_em = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_categorias_atualizado_em ON public.categorias;
CREATE TRIGGER trg_categorias_atualizado_em
BEFORE UPDATE ON public.categorias
FOR EACH ROW
EXECUTE FUNCTION public.atualizar_coluna_atualizado_em();

DROP TRIGGER IF EXISTS trg_produtos_atualizado_em ON public.produtos;
CREATE TRIGGER trg_produtos_atualizado_em
BEFORE UPDATE ON public.produtos
FOR EACH ROW
EXECUTE FUNCTION public.atualizar_coluna_atualizado_em();

DROP TRIGGER IF EXISTS trg_reservas_atualizado_em ON public.reservas;
CREATE TRIGGER trg_reservas_atualizado_em
BEFORE UPDATE ON public.reservas
FOR EACH ROW
EXECUTE FUNCTION public.atualizar_coluna_atualizado_em();

DROP TRIGGER IF EXISTS trg_usuarios_administrativos_atualizado_em ON public.usuarios_administrativos;
CREATE TRIGGER trg_usuarios_administrativos_atualizado_em
BEFORE UPDATE ON public.usuarios_administrativos
FOR EACH ROW
EXECUTE FUNCTION public.atualizar_coluna_atualizado_em();