# Documentação técnica - Cantina da Nonna

Este documento reúne o contexto técnico da Cantina da Nonna para quem precisar continuar o projeto. O README apresenta a visão geral; aqui ficam os detalhes práticos de arquitetura, caminhos, banco, endpoints e cuidados de manutenção.

## 1. Visão geral

A Cantina da Nonna é um projeto full stack de estudo, dividido em front-end estático e back-end Java com Spring Boot.

O objetivo é construir um site de restaurante com:

- página inicial;
- página Nossa História;
- cardápio completo;
- formulário de reserva;
- tela administrativa inicial para cadastro de produtos;
- API para produtos e futuras reservas;
- integração com banco local e Supabase.

O projeto deve continuar didático, organizado e simples de abrir tanto no Visual Studio Code quanto no IntelliJ IDEA.

## 2. Repositório

Caminho local usado no desenvolvimento:

```text
C:\Users\Jose Tavares\Desktop\dev\nonna
```

Repositório remoto:

```text
https://github.com/joseumtavares/cantina-da-nonna
```

Branch principal:

```text
main
```

Regra importante: existe apenas um repositório Git, na raiz `nonna`. Não deve existir `.git` dentro de `nona-front` nem dentro de `nona-back`.

No IntelliJ IDEA, mantenha somente o mapeamento VCS da raiz:

```text
C:\Users\Jose Tavares\Desktop\dev\nonna
```

## 3. Estrutura atual

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
|       |-- favicon/
|       |-- images/
|       `-- pages/
|           |-- cadastro-produtos.html
|           |-- cardapio.html
|           |-- nossa-historia.html
|           `-- reserva.html
|
|-- nona-back/
|   |-- pom.xml
|   |-- mvnw
|   |-- mvnw.cmd
|   |-- .env.example
|   |-- migration/
|   |-- src/main/java/br/com/nona_back/
|   |   |-- NonaBackApplication.java
|   |   |-- controllers/
|   |   |-- model/
|   |   |-- repository/
|   |   `-- service/
|   |-- src/main/resources/
|   |   |-- application.properties
|   |   |-- application-local.properties
|   |   |-- application-supabase.properties
|   |   `-- db/
|   |       |-- schema.sql
|   |       |-- data.sql
|   |       |-- schema-postgres.sql
|   |       `-- data-postgres.sql
|   `-- src/test/java/br/com/nona_back/
|
|-- AGENTS.md
|-- DOCUMENTACAO_TECNICA.md
|-- PADRAO_DESENVOLVIMENTO.md
|-- SUPABASE.md
|-- README.md
`-- .gitignore
```

## 4. Arquitetura do back-end

O back-end segue MVC com camada de serviço e repositório:

```text
Controller -> Service -> Repository -> Banco de dados
     ^                         |
     |                         v
   HTTP                      Model
```

Responsabilidades:

- `controllers`: recebem requisições HTTP e devolvem respostas.
- `service`: concentram regras de negócio e coordenam o fluxo.
- `repository`: acessam o banco de dados com SQL e `JdbcTemplate`.
- `model`: representam os dados usados pela aplicação.

Ao criar uma nova funcionalidade, siga o mesmo desenho:

```text
controllers/NomeController.java
service/NomeService.java
repository/NomeRepository.java
model/Nome.java
```

Exemplo para reservas:

```text
controllers/ReservaController.java
service/ReservaService.java
repository/ReservaRepository.java
model/Reserva.java
```

## 5. Regras do back-end

- Pacote base: `br.com.nona_back`.
- Use `@RestController` para rotas de API que retornam texto, JSON ou listas.
- Use `@Controller` apenas quando precisar encaminhar ou redirecionar páginas HTML.
- Não coloque SQL em Controller.
- Não coloque regra de negócio em Repository.
- Prefira injeção de dependência via construtor.
- Mantenha comentários quando eles explicarem decisão, regra, contexto de aula ou compatibilidade.
- Preserve a comparação com a aula quando ela ajudar a entender a evolução do código.

## 6. Back-end implementado

### Classe principal

```text
nona-back/src/main/java/br/com/nona_back/NonaBackApplication.java
```

Inicia a aplicação Spring Boot.

### HealthCheckController

Arquivo:

```text
nona-back/src/main/java/br/com/nona_back/controllers/HealthCheckController.java
```

Endpoints:

```text
GET /health-check/liveness
GET /health-check/database
GET /health-check/status
```

Função:

- confirmar se o servidor web está online;
- testar a conexão com o banco;
- informar, em mensagem simples, qual parte falhou caso exista problema.

### ProdutoController

Arquivo:

```text
nona-back/src/main/java/br/com/nona_back/controllers/ProdutoController.java
```

Endpoint:

```text
GET /produtos
```

Função: listar produtos ativos do cardápio vindos do banco.

### FrontendController

Arquivo:

```text
nona-back/src/main/java/br/com/nona_back/controllers/FrontendController.java
```

Função:

- servir o front-end pela mesma porta do Spring Boot;
- permitir acesso pelo caminho raiz `/`;
- redirecionar caminhos antigos usados durante o estudo para evitar quebra de CSS e imagens.

URLs úteis:

```text
http://localhost:8080/
http://localhost:8080/dev/nonna/nona-front
```

Não use `/public` na URL do navegador. A pasta `nona-front/public` vira a raiz do site quando o Spring Boot serve os arquivos estáticos.

## 7. Banco de dados

O projeto trabalha com dois perfis:

```text
local     -> XAMPP / MySQL ou MariaDB
supabase  -> Supabase / PostgreSQL
```

Banco local:

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

Arquivos de configuração:

```text
nona-back/src/main/resources/application.properties
nona-back/src/main/resources/application-local.properties
nona-back/src/main/resources/application-supabase.properties
```

O perfil `local` é o padrão para estudo no computador. O perfil `supabase` deve ser ativado por variável de ambiente quando for usar o banco em nuvem.

Exemplo de configuração local com valores padrão:

```properties
spring.datasource.url=${DB_URL:jdbc:mysql://127.0.0.1:3306/nona-db?useSSL=false&serverTimezone=America/Sao_Paulo&allowPublicKeyRetrieval=true}
spring.datasource.username=${DB_USERNAME:root}
spring.datasource.password=${DB_PASSWORD:}
```

Exemplo de variáveis para Supabase, sem senha real no Git:

```properties
SPRING_PROFILES_ACTIVE=supabase
SUPABASE_DB_URL=jdbc:postgresql://aws-[REGIAO].pooler.supabase.com:5432/postgres?sslmode=require
SUPABASE_DB_USERNAME=postgres.[PROJECT_REF]
SUPABASE_DB_PASSWORD=SUA_SENHA_DO_BANCO
```

Para detalhes da conexão em nuvem, consulte `SUPABASE.md`.

Scripts MySQL/MariaDB:

```text
nona-back/src/main/resources/db/schema.sql
nona-back/src/main/resources/db/data.sql
```

Scripts PostgreSQL/Supabase:

```text
nona-back/src/main/resources/db/schema-postgres.sql
nona-back/src/main/resources/db/data-postgres.sql
```

A pasta `nona-back/migration` fica como referência didática da aula. Os scripts executados automaticamente pelo Spring Boot ficam em `src/main/resources/db`.

Padrão de ID no MySQL/MariaDB:

```sql
id CHAR(36) PRIMARY KEY DEFAULT (UUID())
```

Equivalente no Supabase/PostgreSQL:

```sql
id UUID PRIMARY KEY DEFAULT gen_random_uuid()
```

## 8. Front-end implementado

Pasta principal:

```text
nona-front/public
```

Páginas atuais:

```text
index.html
pages/cardapio.html
pages/nossa-historia.html
pages/reserva.html
pages/cadastro-produtos.html
```

Recursos já usados:

- HTML semântico;
- Bootstrap para grid, navbar, cards, botões e formulários;
- CSS próprio em `variables.css` e `theme.css`;
- mapa no rodapé com Leaflet e OpenStreetMap;
- imagens organizadas em `public/images`;
- página administrativa visual para cadastro de produtos.

URLs pelo Spring Boot:

```text
http://localhost:8080/
http://localhost:8080/pages/cardapio.html
http://localhost:8080/pages/nossa-historia.html
http://localhost:8080/pages/reserva.html
http://localhost:8080/pages/cadastro-produtos.html
```

## 9. Regras do front-end

- Use `header`, `nav`, `main` e `footer` nas páginas públicas.
- Use comentários apenas quando ajudarem a entender estrutura, intenção ou ponto futuro de integração.
- Use Bootstrap para grid, containers, cards, navbar e responsividade.
- Deixe identidade visual e ajustes próprios nos arquivos CSS.
- Não coloque estilos soltos no HTML quando puderem ficar no CSS.
- Mantenha imagens dentro de `nona-front/public/images`.
- Considere `public` como raiz servida pelo navegador.
- Não use `/public` nos links das páginas.

Exemplo correto de imagem na home:

```html
<img src="images/logo/cantina-da-nonna-logo.png" alt="Logotipo da Cantina da Nonna">
```

Exemplo correto em página dentro de `pages`:

```html
<img src="../images/logo/cantina-da-nonna-logo.png" alt="Logotipo da Cantina da Nonna">
```

## 10. Identidade visual

A identidade visual fica concentrada em:

```text
nona-front/public/css/variables.css
nona-front/public/css/theme.css
```

Direção visual atual:

- vinho para identidade, menu e títulos;
- creme e creme claro para fundos;
- marrom/madeira para texto e contraste;
- terracota e laranja para botões e chamadas;
- dourado e verde manjericão para detalhes.

Fontes atuais:

```text
Playfair Display -> títulos
Mulish           -> textos e navegação
```

Bootstrap está sendo usado para manter:

- containers alinhados;
- grid responsivo;
- cards arredondados;
- navbar responsiva;
- botões consistentes.

## 11. Como rodar

Pelo terminal:

```powershell
cd C:\Users\Jose Tavares\Desktop\dev\nonna\nona-back
.\mvnw.cmd spring-boot:run
```

Depois abra:

```text
http://localhost:8080/
```

Pelo IntelliJ IDEA:

1. Abra `nona-back` ou a raiz `nonna`.
2. Garanta que o banco escolhido esteja disponível.
3. Rode `NonaBackApplication`.
4. Acesse `http://localhost:8080/`.

## 12. Testes

Comando padrão:

```powershell
cd C:\Users\Jose Tavares\Desktop\dev\nonna\nona-back
.\mvnw.cmd test
```

Forçando Supabase:

```powershell
.\mvnw.cmd "-Dspring.profiles.active=supabase" test
```

Forçando banco local:

```powershell
.\mvnw.cmd "-Dspring.profiles.active=local" test
```

Estado conhecido no momento desta documentação:

```text
6 testes executados
0 falhas
```

Novas rotas e novas regras de negócio devem receber testes quando alterarem comportamento do back-end.

## 13. Endpoints importantes

Front-end:

```text
GET /
GET /pages/cardapio.html
GET /pages/nossa-historia.html
GET /pages/reserva.html
GET /pages/cadastro-produtos.html
```

Back-end/API:

```text
GET /health-check/liveness
GET /health-check/database
GET /health-check/status
GET /produtos
```

## 14. Segurança

Nunca versionar:

- senhas reais;
- tokens;
- chaves de API;
- arquivos `.env` com credenciais;
- certificados privados.

Use `.env.example` para mostrar quais variáveis existem. Use `.env` local para valores reais, mantendo o arquivo fora do Git.

## 15. Próximas melhorias

- Integrar o front-end com a API `/produtos`.
- Criar CRUD completo de produtos.
- Criar API para reservas.
- Salvar reservas no banco.
- Criar dashboard administrativo.
- Implementar login e logout reais.
- Fazer upload de imagens dos produtos.
- Usar Supabase Storage para imagens.
- Preparar deploy do front-end na Vercel.
- Configurar ambiente de produção com variáveis seguras.
- Criar pipeline de testes e deploy.

## 16. Créditos e referência de aula

Projeto desenvolvido por José Tavares durante os estudos de desenvolvimento full stack.

Agradecimento ao professor Gabriel Carvalho:

```text
https://github.com/GabrielBdeC
```

Referência local da aula usada para alinhar parte do back-end:

```text
C:\Users\Jose Tavares\Desktop\dev\SENAC_back
```

## 17. Checklist antes de entregar mudanças

```text
[ ] O projeto compila?
[ ] Os testes Maven necessários foram executados?
[ ] O front abre em http://localhost:8080/ ?
[ ] O endpoint /health-check/status responde?
[ ] O endpoint /produtos responde?
[ ] Os caminhos das imagens continuam funcionando?
[ ] A estrutura MVC foi respeitada?
[ ] Nenhuma credencial real entrou no Git?
[ ] README, SUPABASE ou esta documentação precisam ser atualizados?
[ ] O commit tem mensagem clara?
[ ] Se necessário, foi feito push para origin/main?
```