# Configuracao do Supabase - Cantina da Nonna

Este guia explica como usar o banco PostgreSQL do Supabase no back-end Spring Boot da Cantina da Nonna.


## Navegação

- [Visão geral do projeto](README.md)
- [Padrão de desenvolvimento](PADRAO_DESENVOLVIMENTO.md)
- [Configuração do ambiente](CONFIGURACAO_AMBIENTE.md)
- [Materiais de estudo](MATERIAIS_ESTUDO.md)
- [Documentação técnica](DOCUMENTACAO_TECNICA.md)
- [Configuração do Supabase](SUPABASE.md)
- [Notas rápidas de continuidade](AGENTS.md)
- [README do front-end](nona-front/README.md)

## Nesta página

- [1. Ideia da configuracao](#1-ideia-da-configuracao)
- [2. Arquivos criados ou alterados](#2-arquivos-criados-ou-alterados)
- [3. Como obter os dados no Supabase](#3-como-obter-os-dados-no-supabase)
- [3.1. Qual metodo de conexao usar](#31-qual-metodo-de-conexao-usar)
- [3.2. Dados do projeto atual](#32-dados-do-projeto-atual)
- [4. Como configurar no arquivo .env local](#4-como-configurar-no-arquivo-env-local)
- [5. Como configurar no IntelliJ IDEA](#5-como-configurar-no-intellij-idea)
- [6. Como configurar no terminal PowerShell](#6-como-configurar-no-terminal-powershell)
- [7. Como testar se conectou](#7-como-testar-se-conectou)
- [8. Cuidados para publicacao](#8-cuidados-para-publicacao)
- [9. Referencia oficial](#9-referencia-oficial)

## 1. Ideia da configuracao

O projeto agora possui dois perfis de banco:

```text
local     -> XAMPP / MySQL ou MariaDB
supabase  -> Supabase / PostgreSQL
```

O perfil local continua sendo o padrao para estudo no computador. O perfil Supabase deve ser usado quando quisermos testar ou publicar a aplicacao usando o banco em nuvem.

## 2. Arquivos criados ou alterados

```text
nona-back/pom.xml
nona-back/.env.example
nona-back/src/main/resources/application.properties
nona-back/src/main/resources/application-local.properties
nona-back/src/main/resources/application-supabase.properties
nona-back/src/main/resources/db/schema-postgres.sql
nona-back/src/main/resources/db/data-postgres.sql
```

## 3. Como obter os dados no Supabase

No painel do Supabase:

1. Abra o projeto.
2. Clique em `Connect`.
3. Copie a connection string do banco.
4. Para desenvolvimento com Spring Boot em redes IPv4, prefira o `Session pooler`.
5. Mantenha SSL habilitado na URL usando `sslmode=require`.

Exemplo didatico de URL JDBC:

```text
jdbc:postgresql://aws-1-us-west-2.pooler.supabase.com:5432/postgres?sslmode=require
```

Exemplo didatico de usuario do pooler:

```text
postgres.[PROJECT_REF]
```

Nunca coloque a senha real no GitHub.


## 3.1. Qual metodo de conexao usar

Para o nosso projeto Java/Spring Boot, use a aba:

```text
Direct > Connection string
```

Preferencia atual:

```text
Connection Method: Session pooler
Type: URI
```

Motivo: a conexao direta do Supabase pode retornar apenas IPv6. Se a rede local nao tiver IPv6 funcionando, o Java nao consegue conectar. O `Session pooler` costuma evitar esse problema porque fornece um host mais compativel com redes IPv4.

Opcao Direct connection:

```text
postgresql://postgres:[SUA-SENHA]@db.[PROJECT_REF].supabase.co:5432/postgres
```

No Spring Boot essa URL vira:

```properties
SUPABASE_DB_URL=jdbc:postgresql://db.[PROJECT_REF].supabase.co:5432/postgres?sslmode=require
SUPABASE_DB_USERNAME=postgres
```

Opcao Session pooler:

```text
postgresql://postgres.[PROJECT_REF]:[SUA-SENHA]@aws-[REGIAO].pooler.supabase.com:5432/postgres
```

No Spring Boot essa URL vira:

```properties
SUPABASE_DB_URL=jdbc:postgresql://aws-1-us-west-2.pooler.supabase.com:5432/postgres?sslmode=require
SUPABASE_DB_USERNAME=postgres.bvkxyncjqoabipnlhtql
```


## 3.2. Dados do projeto atual

O projeto Supabase atual usa o `Session pooler` abaixo. Estes dados nao sao secretos; a senha continua fora do Git e deve ficar apenas no `.env` local ou nas variaveis do ambiente de deploy.

```properties
SUPABASE_DB_URL=jdbc:postgresql://aws-1-us-west-2.pooler.supabase.com:5432/postgres?sslmode=require
SUPABASE_DB_USERNAME=postgres.bvkxyncjqoabipnlhtql
SUPABASE_DB_PASSWORD=SUA_SENHA_APENAS_NO_ENV
SUPABASE_SQL_INIT_MODE=always
```

Quando o banco ja estiver criado e sem necessidade de executar scripts automaticamente, altere no ambiente de publicacao:

```properties
SUPABASE_SQL_INIT_MODE=never
```

## 4. Como configurar no arquivo .env local

Copie:

```text
nona-back/.env.example
```

para:

```text
nona-back/.env
```

Depois ajuste para Supabase:

```properties
spring.profiles.active=supabase
SUPABASE_DB_URL=jdbc:postgresql://aws-1-us-west-2.pooler.supabase.com:5432/postgres?sslmode=require
SUPABASE_DB_USERNAME=postgres.bvkxyncjqoabipnlhtql
SUPABASE_DB_PASSWORD=SUA_SENHA_DO_BANCO
SUPABASE_SQL_INIT_MODE=always
```

Depois que as tabelas forem criadas e os dados iniciais forem inseridos, podemos trocar:

```properties
SUPABASE_SQL_INIT_MODE=never
```

Assim evitamos rodar scripts de criacao do banco a cada inicializacao em ambiente publicado.

## 5. Como configurar no IntelliJ IDEA

Na configuracao de execucao da classe `NonaBackApplication`, adicione as variaveis de ambiente:

```text
SPRING_PROFILES_ACTIVE=supabase
SUPABASE_DB_URL=jdbc:postgresql://aws-1-us-west-2.pooler.supabase.com:5432/postgres?sslmode=require
SUPABASE_DB_USERNAME=postgres.bvkxyncjqoabipnlhtql
SUPABASE_DB_PASSWORD=SUA_SENHA_DO_BANCO
SUPABASE_SQL_INIT_MODE=always
```

## 6. Como configurar no terminal PowerShell

```powershell
$env:SPRING_PROFILES_ACTIVE="supabase"
$env:SUPABASE_DB_URL="jdbc:postgresql://aws-1-us-west-2.pooler.supabase.com:5432/postgres?sslmode=require"
$env:SUPABASE_DB_USERNAME="postgres.[PROJECT_REF]"
$env:SUPABASE_DB_PASSWORD="SUA_SENHA_DO_BANCO"
$env:SUPABASE_SQL_INIT_MODE="always"

cd C:\Users\Jose Tavares\Desktop\dev\nonna\nona-back
.\mvnw.cmd spring-boot:run
```

## 7. Como testar se conectou

Com o back-end rodando, abra:

```text
http://localhost:8080/health-check/database
http://localhost:8080/health-check/status
http://localhost:8080/produtos
```

Resposta esperada do banco:

```text
conexao com banco de dados efetuada com sucesso
```

## 8. Cuidados para publicacao

- O front-end publicado na Vercel nao deve receber senha do banco.
- A senha do Supabase deve ficar somente no ambiente do back-end.
- O front-end deve chamar a API do Spring Boot, e a API conversa com o banco.
- Se o back-end for publicado em ambiente serverless, revise o tipo de pooler usado.
- Para uma aplicacao Spring Boot persistente, o pooler em session mode costuma ser o caminho mais simples.

## 9. Referencia oficial

- [Documentacao oficial do Supabase sobre conexao com Postgres](https://supabase.com/docs/guides/database/connecting-to-postgres)

[Voltar ao topo](#configuracao-do-supabase---cantina-da-nonna)
