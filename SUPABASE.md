# Configuracao do Supabase - Cantina da Nonna

Este guia explica como usar o banco PostgreSQL do Supabase no back-end Spring Boot da Cantina da Nonna.

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
jdbc:postgresql://aws-[REGIAO].pooler.supabase.com:5432/postgres?sslmode=require
```

Exemplo didatico de usuario do pooler:

```text
postgres.[PROJECT_REF]
```

Nunca coloque a senha real no GitHub.

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
SUPABASE_DB_URL=jdbc:postgresql://aws-[REGIAO].pooler.supabase.com:5432/postgres?sslmode=require
SUPABASE_DB_USERNAME=postgres.[PROJECT_REF]
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
SUPABASE_DB_URL=jdbc:postgresql://aws-[REGIAO].pooler.supabase.com:5432/postgres?sslmode=require
SUPABASE_DB_USERNAME=postgres.[PROJECT_REF]
SUPABASE_DB_PASSWORD=SUA_SENHA_DO_BANCO
SUPABASE_SQL_INIT_MODE=always
```

## 6. Como configurar no terminal PowerShell

```powershell
$env:SPRING_PROFILES_ACTIVE="supabase"
$env:SUPABASE_DB_URL="jdbc:postgresql://aws-[REGIAO].pooler.supabase.com:5432/postgres?sslmode=require"
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

Documentacao oficial do Supabase sobre conexao com Postgres:

```text
https://supabase.com/docs/guides/database/connecting-to-postgres
```