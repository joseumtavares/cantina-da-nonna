-- Criado por Jose Tavares.
-- Referencia da aula: SENAC_back/migration/1-produto.sql
-- Melhoria: schema completo para o cardapio real do front-end.

-- ==========================================================
-- SCHEMA DO BANCO DE DADOS - CANTINA DA NONNA
-- Este arquivo cria as tabelas principais usadas pelo front-end:
-- categorias do cardapio, produtos, reservas e usuarios administrativos.
-- O Spring Boot executa este arquivo automaticamente ao iniciar a aplicacao.
-- ==========================================================

-- Cria o banco caso ele ainda nao exista.
-- Como o nome possui hifen, usamos crase: `nona-db`.
CREATE DATABASE IF NOT EXISTS `nona-db`
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

-- Seleciona o banco usado pelos comandos abaixo.
USE `nona-db`;

-- Garante suporte a acentos, cedilha e simbolos como R$.
SET NAMES utf8mb4;

-- ==========================================================
-- TABELA: categorias
-- Guarda as secoes do cardapio: Entradas, Massas, Pizzas,
-- Sobremesas e Bebidas.
-- ==========================================================
CREATE TABLE IF NOT EXISTS categorias (
  -- ID padrao do projeto: chave primaria gerada por UUID no banco.
  id CHAR(36) PRIMARY KEY DEFAULT (UUID()),

  -- Nome exibido para o usuario no cardapio.
  nome VARCHAR(80) NOT NULL,

  -- Slug usado pelo sistema para filtrar produtos por categoria.
  slug VARCHAR(80) NOT NULL,

  -- Texto opcional para explicar a categoria.
  descricao VARCHAR(255) NULL,

  -- Controla se a categoria aparece ou nao no cardapio.
  ativo BOOLEAN NOT NULL DEFAULT TRUE,

  -- Define a ordem de exibicao no cardapio.
  ordem_exibicao INT NOT NULL DEFAULT 0,

  -- Datas de auditoria para saber quando o registro foi criado/alterado.
  criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  -- Evita duas categorias com o mesmo identificador textual.
  CONSTRAINT uk_categorias_slug UNIQUE (slug)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ==========================================================
-- TABELA: produtos
-- Guarda os produtos exibidos no cardapio e cadastrados pela
-- pagina cadastro-produtos.html.
-- ==========================================================
CREATE TABLE IF NOT EXISTS produtos (
  -- ID padrao do projeto: chave primaria gerada por UUID no banco.
  id CHAR(36) PRIMARY KEY DEFAULT (UUID()),

  -- Relaciona o produto com uma categoria do cardapio.
  categoria_id CHAR(36) NOT NULL,

  -- Codigo interno informado no formulario administrativo.
  codigo VARCHAR(30) NOT NULL,

  -- Nome publico do produto.
  nome VARCHAR(120) NOT NULL,

  -- Descricao do produto, ingredientes ou detalhes do preparo.
  descricao TEXT NULL,

  -- Valor monetario do produto.
  valor DECIMAL(10,2) NOT NULL,

  -- Caminho da imagem usada no front-end.
  imagem VARCHAR(255) NULL,

  -- Controla se o produto aparece no cardapio.
  ativo BOOLEAN NOT NULL DEFAULT TRUE,

  -- Permite marcar produtos de destaque para a pagina inicial.
  destaque BOOLEAN NOT NULL DEFAULT FALSE,

  -- Define a ordem de exibicao dentro da categoria.
  ordem_exibicao INT NOT NULL DEFAULT 0,

  -- Datas de auditoria para saber quando o registro foi criado/alterado.
  criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  -- Evita cadastrar dois produtos com o mesmo codigo interno.
  CONSTRAINT uk_produtos_codigo UNIQUE (codigo),

  -- Garante que o produto sempre pertence a uma categoria existente.
  CONSTRAINT fk_produtos_categorias
    FOREIGN KEY (categoria_id)
    REFERENCES categorias(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,

  -- Evita valores negativos no cardapio.
  CONSTRAINT chk_produtos_valor CHECK (valor >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ==========================================================
-- TABELA: reservas
-- Guarda os dados enviados pela pagina reserva.html.
-- ==========================================================
CREATE TABLE IF NOT EXISTS reservas (
  -- ID padrao do projeto: chave primaria gerada por UUID no banco.
  id CHAR(36) PRIMARY KEY DEFAULT (UUID()),

  -- Nome do cliente informado no formulario de reserva.
  nome_cliente VARCHAR(120) NOT NULL,

  -- Telefone ou WhatsApp para contato.
  telefone VARCHAR(20) NOT NULL,

  -- E-mail opcional do cliente.
  email VARCHAR(120) NULL,

  -- Quantidade de pessoas da reserva. O front usa minimo 1 e maximo 20.
  quantidade_pessoas INT NOT NULL,

  -- Data escolhida para a reserva.
  data_reserva DATE NOT NULL,

  -- Horario escolhido para a reserva.
  horario_reserva TIME NOT NULL,

  -- Preferencia de ambiente escolhida no formulario.
  ambiente VARCHAR(40) NOT NULL DEFAULT 'sem-preferencia',

  -- Observacoes livres: cadeira infantil, aniversario, restricoes etc.
  observacoes TEXT NULL,

  -- Status operacional da reserva.
  status VARCHAR(20) NOT NULL DEFAULT 'PENDENTE',

  -- Datas de auditoria para saber quando o registro foi criado/alterado.
  criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  -- Replica no banco a regra do front-end: minimo 1, maximo 20 pessoas.
  CONSTRAINT chk_reservas_pessoas CHECK (quantidade_pessoas BETWEEN 1 AND 20),

  -- Mantem status padronizados para facilitar filtros futuros.
  CONSTRAINT chk_reservas_status CHECK (status IN ('PENDENTE', 'CONFIRMADA', 'CANCELADA', 'CONCLUIDA')),

  -- Mantem as mesmas opcoes do select da pagina reserva.html.
  CONSTRAINT chk_reservas_ambiente CHECK (ambiente IN ('salao', 'varanda', 'familia', 'sem-preferencia'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ==========================================================
-- TABELA: usuarios_administrativos
-- Preparada para o dashboard administrativo e para o botao Logout.
-- A senha deve ser salva como hash, nunca como texto puro.
-- ==========================================================
CREATE TABLE IF NOT EXISTS usuarios_administrativos (
  -- ID padrao do projeto: chave primaria gerada por UUID no banco.
  id CHAR(36) PRIMARY KEY DEFAULT (UUID()),

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
  criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  -- Evita dois administradores com o mesmo e-mail.
  CONSTRAINT uk_usuarios_administrativos_email UNIQUE (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;