# Cantina da Nonna

A Cantina da Nonna é um projeto full stack de estudo inspirado em uma cantina italiana familiar. A proposta é construir, aos poucos, um site completo com página institucional, cardápio, reservas, área administrativa e uma API em Java com Spring Boot.

O projeto está sendo desenvolvido por José Tavares durante os estudos de desenvolvimento web. A ideia é manter tudo organizado, fácil de entender e compatível com Visual Studio Code e IntelliJ IDEA, sem esconder os passos importantes do aprendizado.


## Navegação

- [Visão geral do projeto](README.md)
- [Padrão de desenvolvimento](PADRAO_DESENVOLVIMENTO.md)
- [Documentação técnica](DOCUMENTACAO_TECNICA.md)
- [Configuração do Supabase](SUPABASE.md)
- [Notas rápidas de continuidade](AGENTS.md)
- [README do front-end](nona-front/README.md)

## Nesta página

- [O que já existe](#o-que-já-existe)
- [Tecnologias usadas](#tecnologias-usadas)
- [Estrutura do projeto](#estrutura-do-projeto)
- [Padrão MVC do back-end](#padrão-mvc-do-back-end)
- [Banco de dados](#banco-de-dados)
- [Como rodar o back-end](#como-rodar-o-back-end)
- [Como testar](#como-testar)
- [Variáveis de ambiente](#variáveis-de-ambiente)
- [Compatibilidade entre VS Code e IntelliJ](#compatibilidade-entre-vs-code-e-intellij)
- [Documentação do projeto](#documentação-do-projeto)
- [Próximos passos](#próximos-passos)
- [Créditos](#créditos)

## O que já existe

O repositório está dividido em duas partes principais:

- `nona-front`: front-end estático feito com HTML, CSS, JavaScript, Bootstrap e Leaflet.
- `nona-back`: back-end Java com Spring Boot, Maven, JDBC e integração com banco de dados.

No front-end já existem páginas para:

- início do site;
- nossa história;
- cardápio completo;
- formulário visual de reserva;
- cadastro visual de produtos para a futura área administrativa.

No back-end já existem:

- health check do servidor e do banco;
- endpoint de produtos;
- estrutura MVC organizada em controller, service, repository e model;
- scripts de banco para MySQL/MariaDB local e PostgreSQL/Supabase;
- testes automatizados com Maven.

## Tecnologias usadas

- Java 25 Amazon Corretto
- Spring Boot 4.1
- Maven Wrapper
- Spring WebMVC
- Spring JDBC
- MySQL/MariaDB com XAMPP
- PostgreSQL no Supabase
- HTML
- CSS
- JavaScript
- Bootstrap
- Leaflet e OpenStreetMap
- Git e GitHub

## Estrutura do projeto

```text
nonna/
|-- nona-front/
|   |-- README.md
|   `-- public/
|       |-- index.html
|       |-- css/
|       |   |-- theme.css
|       |   `-- variables.css
|       |-- js/
|       |   |-- mapa.js
|       |   `-- site.js
|       |-- images/
|       |-- favicon/
|       `-- pages/
|           |-- cadastro-produtos.html
|           |-- cardapio.html
|           |-- nossa-historia.html
|           `-- reserva.html
|
|-- nona-back/
|   |-- pom.xml
|   |-- mvnw.cmd
|   |-- .env.example
|   |-- migration/
|   |-- src/main/java/br/com/nona_back/
|   |   |-- controllers/
|   |   |-- model/
|   |   |-- repository/
|   |   |-- service/
|   |   `-- NonaBackApplication.java
|   |-- src/main/resources/
|   |   |-- application.properties
|   |   |-- application-local.properties
|   |   |-- application-supabase.properties
|   |   `-- db/
|   |       |-- schema.sql
|   |       |-- data.sql
|   |       |-- schema-postgres.sql
|   |       `-- data-postgres.sql
|   `-- src/test/
|
|-- AGENTS.md
|-- DOCUMENTACAO_TECNICA.md
|-- PADRAO_DESENVOLVIMENTO.md
|-- SUPABASE.md
|-- .gitignore
`-- README.md
```

## Padrão MVC do back-end

Toda nova funcionalidade do back-end deve seguir a mesma organização:

```text
Controller -> Service -> Repository -> Banco de dados
     ^                         |
     |                         v
   HTTP                      Model
```

Na prática:

- `controllers`: recebem as requisições HTTP e devolvem respostas.
- `service`: guardam as regras de negócio e coordenam o fluxo.
- `repository`: acessam o banco com SQL e `JdbcTemplate`.
- `model`: representam os dados que circulam pela aplicação.

Exemplo para uma futura entidade `Reserva`:

```text
controllers/ReservaController.java
service/ReservaService.java
repository/ReservaRepository.java
model/Reserva.java
```

## Banco de dados

O projeto trabalha com dois perfis de banco:

```text
local     -> XAMPP / MySQL ou MariaDB
supabase  -> Supabase / PostgreSQL
```

O banco local usado durante os estudos se chama:

```text
nona-db
```

Configuração local padrão:

```text
host: 127.0.0.1
porta: 3306
usuário: root
senha: vazia
```

Arquivos principais de configuração:

```text
nona-back/src/main/resources/application-local.properties
nona-back/src/main/resources/application-supabase.properties
```

Scripts usados automaticamente pelo Spring Boot:

```text
nona-back/src/main/resources/db/schema.sql
nona-back/src/main/resources/db/data.sql
nona-back/src/main/resources/db/schema-postgres.sql
nona-back/src/main/resources/db/data-postgres.sql
```

A pasta `nona-back/migration` ficou no projeto como referência didática da aula. Os scripts realmente usados pela aplicação ficam em `src/main/resources/db`.

Para detalhes da conexão com o Supabase, consulte [SUPABASE.md](SUPABASE.md).

## Como rodar o back-end

Entre na pasta do back-end:

```powershell
cd nona-back
```

Rode a aplicação:

```powershell
.\mvnw.cmd spring-boot:run
```

Com o back-end rodando, o site pode ser aberto em:

```text
http://localhost:8080/
```

Endpoints úteis durante o desenvolvimento:

```text
GET http://localhost:8080/health-check/liveness
GET http://localhost:8080/health-check/database
GET http://localhost:8080/health-check/status
GET http://localhost:8080/produtos
```

## Como testar

Na pasta `nona-back`, rode:

```powershell
.\mvnw.cmd test
```

Para testar usando explicitamente o perfil Supabase:

```powershell
.\mvnw.cmd "-Dspring.profiles.active=supabase" test
```

Para testar usando o banco local:

```powershell
.\mvnw.cmd "-Dspring.profiles.active=local" test
```

## Variáveis de ambiente

O projeto pode carregar variáveis locais a partir de `.env`, mas arquivos com senha real não devem ir para o GitHub.

Use este arquivo como base:

```text
nona-back/.env.example
```

O `.env.example` mostra os nomes das variáveis necessárias sem expor credenciais reais.

## Compatibilidade entre VS Code e IntelliJ

Para evitar diferença entre as IDEs:

- use o Maven Wrapper do projeto (`mvnw.cmd`);
- mantenha dependências dentro do `pom.xml`;
- configure senhas e URLs por variável de ambiente ou `.env` local;
- abra `nona-back` no IntelliJ quando quiser focar no Spring Boot;
- abra a pasta raiz `nonna` no VS Code quando quiser trabalhar com front e back juntos;
- mantenha apenas um repositório Git na raiz `nonna`.

## Documentação do projeto

Arquivos de apoio:

- [PADRAO_DESENVOLVIMENTO.md](PADRAO_DESENVOLVIMENTO.md): regras de organização, comentários, segurança e commits.
- [DOCUMENTACAO_TECNICA.md](DOCUMENTACAO_TECNICA.md): contexto técnico para continuidade do projeto.
- [SUPABASE.md](SUPABASE.md): configuração do banco no Supabase.
- [AGENTS.md](AGENTS.md): notas curtas para continuidade do projeto.

## Próximos passos

- Integrar o front-end com a API real do Spring Boot.
- Criar CRUD completo de produtos.
- Salvar reservas no banco de dados.
- Criar dashboard administrativo.
- Adicionar autenticação para a área administrativa.
- Usar Supabase Storage para imagens dos produtos.
- Preparar deploy do front-end na Vercel.
- Configurar variáveis de produção.
- Criar pipeline de CI/CD para testes e deploy.

## Créditos

Projeto desenvolvido por José Tavares durante os estudos de desenvolvimento full stack.

Agradecimento ao professor [Gabriel Carvalho](https://github.com/GabrielBdeC), referência durante as aulas.

[Voltar ao topo](#cantina-da-nonna)
