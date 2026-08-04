-- Criado por Jose Tavares, partindo da referência de banco usada na aula.
-- Este schema representa a estrutura real que o front-end já começou a usar.

-- ==========================================================
-- SCHEMA DO BANCO DE DADOS - CANTINA DA NONNA
-- Este arquivo cria as tabelas que sustentam o cardápio, as reservas e a área administrativa inicial.
-- O Spring Boot executa o script na inicialização para facilitar os estudos locais.
-- ==========================================================

-- O banco local nona-db deve existir antes da aplicacao iniciar.
-- Para criar manualmente, use nona-back/migration/0-create_db.sql.

-- Mantém suporte a acentos, cedilha e símbolos como R$ nos dados do cardápio.
SET NAMES utf8mb4;

-- ==========================================================
-- TABELA: categorias
-- Guarda as seções do cardápio, como Entradas, Massas, Pizzas, Sobremesas e Bebidas.
-- ==========================================================
CREATE TABLE IF NOT EXISTS categorias (
  -- ID gerado pelo próprio banco, seguindo o padrão UUID definido para o projeto.
  id CHAR(36) PRIMARY KEY DEFAULT (UUID()),

  -- Nome exibido para o cliente no cardápio.
  nome VARCHAR(80) NOT NULL,

  -- Slug estável usado pelo sistema para localizar e filtrar categorias.
  slug VARCHAR(80) NOT NULL,

  -- Texto opcional para descrever melhor a categoria.
  descricao VARCHAR(255) NULL,

  -- Permite ocultar uma categoria sem apagar seu histórico.
  ativo BOOLEAN NOT NULL DEFAULT TRUE,

  -- Define a ordem em que a categoria aparece no cardápio.
  ordem_exibicao INT NOT NULL DEFAULT 0,

  -- Datas de auditoria ajudam a acompanhar criação e alterações do registro.
  criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  -- Garante que cada categoria tenha um slug único.
  CONSTRAINT uk_categorias_slug UNIQUE (slug)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ==========================================================
-- TABELA: produtos
-- Guarda os produtos exibidos no cardápio e preparados para a futura tela administrativa.
-- ==========================================================
CREATE TABLE IF NOT EXISTS produtos (
  -- ID gerado pelo próprio banco, seguindo o padrão UUID definido para o projeto.
  id CHAR(36) PRIMARY KEY DEFAULT (UUID()),

  -- Relaciona o produto com uma categoria existente do cardápio.
  categoria_id CHAR(36) NOT NULL,

  -- Código interno usado para identificar o produto no cadastro administrativo.
  codigo VARCHAR(30) NOT NULL,

  -- Nome público exibido para o cliente.
  nome VARCHAR(120) NOT NULL,

  -- Descrição com ingredientes, preparo ou detalhes úteis para o cardápio.
  descricao TEXT NULL,

  -- Valor monetário do produto.
  valor DECIMAL(10,2) NOT NULL,

  -- Caminho da imagem que o front-end renderiza nos cards.
  imagem VARCHAR(255) NULL,

  -- Permite retirar um produto do cardápio sem excluir o registro.
  ativo BOOLEAN NOT NULL DEFAULT TRUE,

  -- Marca produtos que podem aparecer nos destaques da página inicial.
  destaque BOOLEAN NOT NULL DEFAULT FALSE,

  -- Define a ordem de exibição dentro da categoria.
  ordem_exibicao INT NOT NULL DEFAULT 0,

  -- Datas de auditoria ajudam a acompanhar criação e alterações do registro.
  criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  -- Impede dois produtos com o mesmo código interno.
  CONSTRAINT uk_produtos_codigo UNIQUE (codigo),

  -- Garante que todo produto pertença a uma categoria válida.
  CONSTRAINT fk_produtos_categorias
    FOREIGN KEY (categoria_id)
    REFERENCES categorias(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,

  -- Protege o cardápio contra valores negativos.
  CONSTRAINT chk_produtos_valor CHECK (valor >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ==========================================================
-- TABELA: reservas
-- Guarda os dados que futuramente serão enviados pelo formulário de reserva.
-- ==========================================================
CREATE TABLE IF NOT EXISTS reservas (
  -- ID gerado pelo próprio banco, seguindo o padrão UUID definido para o projeto.
  id CHAR(36) PRIMARY KEY DEFAULT (UUID()),

  -- Nome informado pelo cliente no formulário de reserva.
  nome_cliente VARCHAR(120) NOT NULL,

  -- Telefone ou WhatsApp para confirmação da reserva.
  telefone VARCHAR(20) NOT NULL,

  -- E-mail opcional para contato com o cliente.
  email VARCHAR(120) NULL,

  -- Quantidade de pessoas; a regra do site é mínimo 1 e máximo 20.
  quantidade_pessoas INT NOT NULL,

  -- Data escolhida pelo cliente.
  data_reserva DATE NOT NULL,

  -- Horário escolhido pelo cliente.
  horario_reserva TIME NOT NULL,

  -- Preferência de ambiente escolhida no formulário.
  ambiente VARCHAR(40) NOT NULL DEFAULT 'sem-preferencia',

  -- Observações livres, como cadeira infantil, aniversário ou restrição alimentar.
  observacoes TEXT NULL,

  -- Status usado para acompanhar o atendimento da reserva.
  status VARCHAR(20) NOT NULL DEFAULT 'PENDENTE',

  -- Datas de auditoria ajudam a acompanhar criação e alterações do registro.
  criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  -- Repete no banco a mesma regra visual do formulário: de 1 a 20 pessoas.
  CONSTRAINT chk_reservas_pessoas CHECK (quantidade_pessoas BETWEEN 1 AND 20),

  -- Mantém os status padronizados para filtros e painéis futuros.
  CONSTRAINT chk_reservas_status CHECK (status IN ('PENDENTE', 'CONFIRMADA', 'CANCELADA', 'CONCLUIDA')),

  -- Mantém no banco as mesmas opções oferecidas no select do formulário.
  CONSTRAINT chk_reservas_ambiente CHECK (ambiente IN ('salao', 'varanda', 'familia', 'sem-preferencia'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ==========================================================
-- TABELA: usuarios_administrativos
-- Preparada para o futuro dashboard administrativo e para o fluxo de login/logout.
-- Senha deve ser armazenada somente como hash, nunca em texto puro.
-- ==========================================================
CREATE TABLE IF NOT EXISTS usuarios_administrativos (
  -- ID gerado pelo próprio banco, seguindo o padrão UUID definido para o projeto.
  id CHAR(36) PRIMARY KEY DEFAULT (UUID()),

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
  criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  -- Impede dois administradores com o mesmo e-mail.
  CONSTRAINT uk_usuarios_administrativos_email UNIQUE (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
