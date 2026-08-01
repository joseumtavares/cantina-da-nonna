-- Criado por Jose Tavares.
-- Referencia da aula: SENAC_back/migration/0-create_db.sql
--
-- Passo 0: cria o banco de dados do projeto Cantina da Nonna.
-- Execute manualmente apenas se quiser estudar o fluxo igual ao da aula.
-- No projeto atual, o Spring tambem executa scripts automaticos em src/main/resources/db.

CREATE DATABASE IF NOT EXISTS `nona-db`
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;