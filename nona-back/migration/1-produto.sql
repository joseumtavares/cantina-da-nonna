-- Criado por Jose Tavares, como referência didática da tabela produto vista na aula.
-- Mantemos este arquivo para comparar a versão simples do professor com o schema real do projeto.
-- A estrutura usada pela aplicação está em src/main/resources/db/schema.sql.

USE `nona-db`;

-- Código original da aula, adaptado apenas para o nome do banco nona-db:
-- CREATE TABLE produto (
--   id        VARCHAR(36)   PRIMARY KEY DEFAULT (UUID()),
--   nome      VARCHAR(80)   NOT NULL,
--   descricao VARCHAR(255),
--   preco     DECIMAL(10,2) NOT NULL,
--   categoria VARCHAR(30)
-- );
--
-- No projeto real, produtos ficam ligados à tabela categorias e possuem imagem, destaque, status ativo e ordem de exibição.
