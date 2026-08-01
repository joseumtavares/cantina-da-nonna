# Documentacao Tecnica - Cantina da Nonna

Este arquivo foi criado para orientar outra LLM ou um programador pleno humano a continuar o projeto sem perder o contexto, os padroes ja definidos e as decisoes tomadas ate agora.

## 1. Visao geral do projeto

O projeto `Cantina da Nonna` e um projeto full stack de estudo composto por:

- `nona-front`: front-end estatico com HTML, CSS, JavaScript e Bootstrap.
- `nona-back`: back-end Java com Spring Boot, Maven e MySQL/MariaDB via XAMPP.

Objetivo principal: construir um site de restaurante/cantina italiana com paginas publicas, cardapio, reservas, area administrativa inicial e API em Spring Boot.

O codigo deve continuar didatico, comentado e compativel com Visual Studio Code e IntelliJ IDEA.

## 2. Estado atual do repositorio

Repositorio local:

```text
C:\Users\Jose Tavares\Desktop\dev\nonna
```

Repositorio remoto:

```text
https://github.com/joseumtavares/cantina-da-nonna
```

Branch principal:

```text
main
```

Regra importante de Git:

- Existe somente um repositorio Git na raiz `nonna`.
- Nao deve existir `.git` dentro de `nona-back` nem dentro de `nona-front`.
- No IntelliJ, mantenha apenas o mapeamento VCS da pasta raiz `C:\Users\Jose Tavares\Desktop\dev\nonna`.
- Se o IntelliJ mostrar `nona-back` como Git separado, remova esse mapeamento em Version Control > Directory Mappings.

## 3. Estrutura atual de diretorios

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
|   |   `-- db/
|   |       |-- schema.sql
|   |       `-- data.sql
|   `-- src/test/java/br/com/nona_back/
|
|-- README.md
|-- DOCUMENTACAO_TECNICA.md
`-- .gitignore
```

## 4. Padrao arquitetural obrigatorio no back-end

O back-end deve seguir o metodo MVC, adaptado para API REST com camada de servico e repositorio.

Fluxo padrao:

```text
Controller -> Service -> Repository -> Banco de dados
     ^                         |
     |                         v
   HTTP                     Model
```

Responsabilidades:

- `controllers`: recebem as requisicoes HTTP e devolvem respostas.
- `service`: concentram regras de negocio e coordenam o fluxo.
- `repository`: executam SQL e acessam o banco de dados.
- `model`: representam os dados usados pela aplicacao.

Regra para novas entidades:

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

## 5. Regras de codigo do back-end

- Manter o pacote base `br.com.nona_back`.
- Usar `@RestController` para endpoints de API que retornam texto, JSON ou listas.
- Usar `@Controller` apenas quando for necessario encaminhar/redirecionar paginas HTML.
- Nao colocar SQL dentro de Controller.
- Nao colocar regra de negocio dentro de Repository.
- Preferir injecao por construtor, como ja esta sendo usado.
- Manter comentarios didaticos nos blocos criados ou alterados.
- Quando o codigo for baseado na aula, manter comentario com referencia ao professor/aula quando fizer sentido.
- Quando uma melhoria for criada no projeto, identificar em comentario como melhoria criada por Jose Tavares.

## 6. Back-end ja implementado

### Classe principal

```text
nona-back/src/main/java/br/com/nona_back/NonaBackApplication.java
```

Responsavel por iniciar o Spring Boot.

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

Objetivo:

- Confirmar se o servidor web esta online.
- Confirmar se a conexao com o banco esta funcionando.
- Informar qual servico falhou caso exista problema.

### ProdutoController

Arquivo:

```text
nona-back/src/main/java/br/com/nona_back/controllers/ProdutoController.java
```

Endpoint:

```text
GET /produtos
```

Objetivo:

- Listar produtos do cardapio vindos do banco de dados.

### FrontendController

Arquivo:

```text
nona-back/src/main/java/br/com/nona_back/controllers/FrontendController.java
```

Objetivo:

- Permitir abrir o front-end pela mesma porta do Spring Boot.
- Redirecionar caminhos antigos usados durante o estudo para a raiz do site.

URLs principais:

```text
http://localhost:8080/
http://localhost:8080/dev/nonna/nona-front
```

Observacao importante:

- Nao usar `/public` no navegador.
- A pasta `nona-front/public` vira a raiz do site quando servida pelo Spring Boot.

## 7. Configuracao do banco de dados

Banco local usado no XAMPP:

```text
nona-db
```

Configuracao padrao:

```text
host: 127.0.0.1
porta: 3306
usuario: root
senha: vazia
```

Arquivo de configuracao:

```text
nona-back/src/main/resources/application.properties
```

Configuracao atual usa variaveis de ambiente com valores padrao:

```properties
spring.datasource.url=${DB_URL:jdbc:mysql://127.0.0.1:3306/nona-db?useSSL=false&serverTimezone=America/Sao_Paulo&allowPublicKeyRetrieval=true}
spring.datasource.username=${DB_USERNAME:root}
spring.datasource.password=${DB_PASSWORD:}
```

Regra para novas tabelas:

```sql
id VARCHAR(36) PRIMARY KEY DEFAULT (UUID())
```

Scripts automaticos:

```text
nona-back/src/main/resources/db/schema.sql
nona-back/src/main/resources/db/data.sql
```

Pasta de referencia didatica:

```text
nona-back/migration
```

Observacao:

- `schema.sql` e `data.sql` sao executados automaticamente pelo Spring Boot porque `spring.sql.init.mode=always` esta ativo.
- Cuidado ao alterar esses arquivos, pois eles impactam a inicializacao da aplicacao.

## 8. Front-end ja implementado

Pasta principal:

```text
nona-front/public
```

Paginas atuais:

```text
index.html
pages/cardapio.html
pages/nossa-historia.html
pages/reserva.html
pages/cadastro-produtos.html
```

Recursos principais:

- Site institucional da Cantina da Nonna.
- Cardapio completo.
- Pagina Nossa Historia.
- Pagina Reserva com formulario visual.
- Pagina Cadastro de Produtos como tela administrativa visual inicial.
- Mapa no rodape usando Leaflet.js e OpenStreetMap.
- Bootstrap para layout responsivo e componentes.
- CSS proprio em `theme.css` e `variables.css`.

URLs pelo Spring Boot:

```text
http://localhost:8080/
http://localhost:8080/pages/cardapio.html
http://localhost:8080/pages/nossa-historia.html
http://localhost:8080/pages/reserva.html
http://localhost:8080/pages/cadastro-produtos.html
```

## 9. Regras de codigo do front-end

- Manter HTML semantico com `header`, `nav`, `main` e `footer` nas paginas publicas.
- Manter comentarios didaticos nos blocos principais.
- Usar Bootstrap para grid, container, cards, navbar e responsividade.
- Usar CSS proprio apenas para identidade visual, ajustes e personalizacoes.
- Nao criar estilos soltos dentro do HTML se puderem ir para CSS.
- Manter imagens dentro de `nona-front/public/images`.
- Manter caminhos relativos considerando que `public` e a raiz servida pelo navegador.
- Nao usar links com `/public` nas paginas.

Exemplo correto de imagem:

```html
<img src="images/logo/cantina-da-nonna-logo.png" alt="Logotipo da Cantina da Nonna">
```

Exemplo incorreto quando servido pelo Spring Boot:

```html
<img src="public/images/logo/cantina-da-nonna-logo.png" alt="Logotipo da Cantina da Nonna">
```

## 10. Padrao visual

Identidade visual definida no CSS:

- Vinho para identidade, menu e titulos.
- Creme e creme claro para fundos.
- Marrom/madeira para textos e contraste.
- Terracota e laranja para botoes e chamadas.
- Dourado e verde manjericao para detalhes.

Fonte inicial usada no projeto:

```text
Verdana
```

Bootstrap esta sendo usado para modernizar:

- Containers.
- Grid responsivo.
- Cards arredondados.
- Navbar responsiva.
- Botoes harmonicos.

## 11. Como rodar o projeto

### Pelo IntelliJ IDEA

1. Abrir a pasta `nona-back` ou a raiz `nonna`.
2. Garantir que o XAMPP/MySQL esteja rodando na porta `3306`.
3. Rodar `NonaBackApplication`.
4. Abrir no navegador:

```text
http://localhost:8080/
```

### Pelo terminal

```powershell
cd C:\Users\Jose Tavares\Desktop\dev\nonna\nona-back
.\mvnw.cmd spring-boot:run
```

Depois abrir:

```text
http://localhost:8080/
```

## 12. Como testar

Rodar:

```powershell
cd C:\Users\Jose Tavares\Desktop\dev\nonna\nona-back
.\mvnw.cmd test
```

Estado conhecido:

```text
6 testes executados
0 falhas
```

Regra para novas funcionalidades:

- Novo endpoint deve ter teste quando alterar comportamento do back-end.
- Nova regra de negocio deve ser testada na camada adequada.
- Antes de commit/push, rodar `mvnw.cmd test`.

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

## 14. Creditos e referencias

Projeto desenvolvido por Jose Tavares durante os estudos de desenvolvimento full stack.

Creditos ao professor Gabriel Carvalho:

```text
https://github.com/GabrielBdeC
```

Referencia da aula usada para alinhar parte do back-end:

```text
C:\Users\Jose Tavares\Desktop\dev\SENAC_back
```

## 15. Futuras melhorias planejadas

- Integrar o front-end com a API real `/produtos`.
- Criar CRUD completo de produtos.
- Criar API e banco para reservas.
- Criar dashboard administrativo.
- Implementar login/autenticacao para area administrativa.
- Fazer upload de imagens dos produtos.
- Integrar Supabase para autenticacao, storage de imagens e possivel banco em nuvem.
- Publicar o front-end na Vercel.
- Configurar ambiente de producao com variaveis seguras.
- Criar pipeline de testes e deploy.

## 16. Cuidados para a proxima pessoa ou LLM

- Nao recriar repositorios Git dentro de `nona-back` ou `nona-front`.
- Nao remover comentarios didaticos sem necessidade.
- Nao trocar a arquitetura MVC sem alinhar antes.
- Nao colocar credenciais reais no Git.
- Nao alterar a porta do banco ou nome do banco sem atualizar a documentacao.
- Nao usar `/public` nos links do navegador.
- Nao mover imagens sem ajustar os caminhos HTML/CSS.
- Manter compatibilidade com IntelliJ IDEA e Visual Studio Code.
- Se adicionar dependencia Java, registrar no `pom.xml`.
- Se adicionar dependencia front-end via CDN, comentar no HTML o motivo do uso.

## 17. Checklist antes de entregar mudancas

```text
[ ] O projeto compila?
[ ] Os testes Maven passam?
[ ] O front abre em http://localhost:8080/ ?
[ ] O endpoint /health-check/status responde?
[ ] O endpoint /produtos responde?
[ ] Os caminhos das imagens continuam funcionando?
[ ] A estrutura MVC foi respeitada?
[ ] O README ou esta documentacao precisam ser atualizados?
[ ] Foi feito commit com mensagem clara?
[ ] Se necessario, foi feito push para origin/main?
```
