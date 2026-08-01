-- Criado por Jose Tavares.
-- Referencia da aula: SENAC_back/migration/1-produto.sql
--
-- Passo 1: referencia didatica da tabela produto usada na aula.
-- Mantemos este arquivo para comparacao com o professor.
-- O schema real do projeto esta em src/main/resources/db/schema.sql,
-- onde usamos categorias separadas, produtos ativos, destaque e imagem.

USE `nona-db`;

-- Codigo original da aula, adaptado apenas para o nome do banco nona-db:
-- CREATE TABLE produto (
--   id        VARCHAR(36)   PRIMARY KEY DEFAULT (UUID()),
--   nome      VARCHAR(80)   NOT NULL,
--   descricao VARCHAR(255),
--   preco     DECIMAL(10,2) NOT NULL,
--   categoria VARCHAR(30)
-- );
--
-- Melhoria criada por Jose Tavares:
-- o projeto real usa as tabelas categorias e produtos em src/main/resources/db/schema.sql.