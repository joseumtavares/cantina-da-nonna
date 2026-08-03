# Cantina da Nonna

Projeto full stack de estudo criado por Jose Tavares, com front-end institucional/cardapio e back-end Java Spring Boot integrado ao banco MySQL/MariaDB do XAMPP.

A ideia do projeto e evoluir passo a passo, mantendo o codigo didatico, comentado e compativel com Visual Studio Code e IntelliJ IDEA.

## Documentacao tecnica

Para continuar o projeto com outra LLM ou com outro programador, consulte:

```text
DOCUMENTACAO_TECNICA.md
```

Padrao de desenvolvimento, comentarios e documentacao:

```text
PADRAO_DESENVOLVIMENTO.md
```

Instrucoes curtas para LLMs/agentes:

```text
AGENTS.md
```

Configuracao do banco no Supabase:

```text
SUPABASE.md
```

## Estrutura do repositorio

```text
nonna/
|-- nona-front/
|   `-- public/
|       |-- index.html
|       |-- css/
|       |-- js/
|       |-- images/
|       `-- pages/
|
|-- nona-back/
|   |-- src/main/java/br/com/nona_back/
|   |   |-- controllers/
|   |   |-- model/
|   |   |-- repository/
|   |   `-- service/
|   |-- src/main/resources/db/
|   |-- src/test/
|   |-- migration/
|   `-- pom.xml
|
|-- .gitignore
`-- README.md
```

## Mapa MVC do back-end

Toda nova funcionalidade do back-end deve seguir a organizacao MVC abaixo. Esse padrao ajuda a manter o codigo separado por responsabilidade, facilitando manutencao, testes e evolucao do projeto.

```text
nona-back/
`-- src/main/java/br/com/nona_back/
    |-- controllers/
    |   |-- HealthCheckController.java
    |   `-- ProdutoController.java
    |
    |-- model/
    |   `-- Produto.java
    |
    |-- service/
    |   `-- ProdutoService.java
    |
    |-- repository/
    |   `-- ProdutoRepository.java
    |
    `-- NonaBackApplication.java
```

Fluxo recomendado para novas telas, rotas ou entidades:

```text
Controller -> Service -> Repository -> Banco de dados
     ^                         |
     |                         v
   HTTP                     Model
```

Responsabilidade de cada camada:

- `controllers`: recebem as requisicoes HTTP e devolvem respostas para o front-end.
- `service`: concentram as regras de negocio e fazem a ponte entre controller e repository.
- `repository`: acessam o banco de dados e executam consultas SQL.
- `model`: representam os dados usados pela aplicacao.

Exemplo para uma futura entidade `Reserva`:

```text
controllers/ReservaController.java
service/ReservaService.java
repository/ReservaRepository.java
model/Reserva.java
```

## Front-end

O front-end esta em `nona-front/public` e foi construido com HTML, CSS, JavaScript e Bootstrap.

Paginas principais:

- `public/index.html`: pagina inicial.
- `public/pages/cardapio.html`: cardapio completo.
- `public/pages/nossa-historia.html`: historia da cantina.
- `public/pages/reserva.html`: formulario visual de reserva.
- `public/pages/cadastro-produtos.html`: tela administrativa visual para cadastro de produtos.

Tambem ha integracao visual com mapa usando Leaflet/OpenStreetMap.

## Back-end

O back-end esta em `nona-back` e usa:

- Java 25 Amazon Corretto.
- Spring Boot 4.1.
- Spring WebMVC.
- Spring JDBC.
- MySQL Connector/J.
- Actuator para verificacao de saude.
- Maven Wrapper para rodar igual no VS Code e no IntelliJ.

Camadas principais:

- `controllers`: recebe requisicoes HTTP.
- `service`: concentra regras de negocio.
- `repository`: conversa com o banco usando SQL e `JdbcTemplate`.
- `model`: representa os dados trafegados pela aplicacao.

## Banco de dados

O projeto possui dois perfis de banco:

```text
local     -> XAMPP / MySQL ou MariaDB
supabase  -> Supabase / PostgreSQL
```

Banco local usado no desenvolvimento:

```text
nona-db
```

Configuracao local padrao:

```text
host: 127.0.0.1
porta: 3306
usuario: root
senha: vazia
```

Arquivos de configuracao:

```text
nona-back/src/main/resources/application-local.properties
nona-back/src/main/resources/application-supabase.properties
```

Scripts automaticos do perfil local MySQL/MariaDB:

```text
nona-back/src/main/resources/db/schema.sql
nona-back/src/main/resources/db/data.sql
```

Scripts automaticos do perfil Supabase/PostgreSQL:

```text
nona-back/src/main/resources/db/schema-postgres.sql
nona-back/src/main/resources/db/data-postgres.sql
```

A pasta `nona-back/migration` foi mantida como referencia didatica da aula, enquanto os scripts em `resources/db` sao usados automaticamente pelo Spring Boot.

Para configurar o banco do Supabase, consulte `SUPABASE.md`.

## Como rodar o back-end

Entre na pasta do back-end:

```powershell
cd nona-back
```

Rode a aplicacao com o Maven Wrapper:

```powershell
.\mvnw.cmd spring-boot:run
```

Endpoints uteis:

```text
GET http://localhost:8080/health-check/liveness
GET http://localhost:8080/health-check/database
GET http://localhost:8080/health-check/status
GET http://localhost:8080/produtos
```

## Como testar

```powershell
cd nona-back
.\mvnw.cmd test
```

## Compatibilidade entre IDEs

Para manter o projeto funcionando no Visual Studio Code e no IntelliJ IDEA:

- Use o Maven Wrapper do projeto (`mvnw.cmd`).
- Mantenha as dependencias dentro do `pom.xml`.
- Configure variaveis locais no ambiente ou em `.env`, sem enviar senhas reais para o Git.
- Abra `nona-back` no IntelliJ quando quiser focar no Spring Boot.
- Abra a pasta raiz `nonna` no VS Code quando quiser trabalhar com front e back juntos.

## Futuras melhorias

- Integrar o front-end com a API real do Spring Boot.
- Criar CRUD completo de produtos.
- Salvar reservas feitas pelo formulario.
- Criar dashboard administrativo.
- Adicionar autenticacao para area administrativa.
- Evoluir a integracao com Supabase para autenticacao e storage de imagens.
- Publicar o front-end na Vercel.
- Configurar variaveis de producao para Vercel e API em ambiente publicado.
- Criar pipeline de CI/CD para testes e deploy automatico.

## Creditos

Projeto desenvolvido por Jose Tavares durante os estudos de desenvolvimento full stack.

Creditos ao professor Gabriel Carvalho: https://github.com/GabrielBdeC
