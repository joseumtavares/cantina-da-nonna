# Padrão de desenvolvimento do projeto

Este arquivo existe para manter a Cantina da Nonna organizada enquanto o projeto cresce. Ele não é um conjunto de regras para engessar o trabalho; é um combinado para que qualquer pessoa consiga abrir o repositório, entender o que está acontecendo e continuar de onde paramos.

O projeto ainda está em fase de estudo e evolução. Por isso, clareza vale muito. Código simples, nomes bem escolhidos e comentários úteis ajudam mais do que soluções grandes que parecem bonitas, mas são difíceis de manter.


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

- [Tecnologias do projeto](#tecnologias-do-projeto)
- [Antes de alterar qualquer coisa](#antes-de-alterar-qualquer-coisa)
- [Organização do back-end](#organização-do-back-end)
- [Código limpo, sem mistério](#código-limpo-sem-mistério)
- [Comentários no código](#comentários-no-código)
- [Comentários didáticos](#comentários-didáticos)
- [HTML](#html)
- [CSS](#css)
- [JavaScript](#javascript)
- [Banco de dados](#banco-de-dados)
- [Segurança](#segurança)
- [Testes](#testes)
- [Documentação](#documentação)
- [Git e commits](#git-e-commits)
- [Compatibilidade com as IDEs](#compatibilidade-com-as-ides)
- [Quando criar novas dependências](#quando-criar-novas-dependências)
- [Antes de finalizar uma alteração](#antes-de-finalizar-uma-alteração)
- [Ideia principal](#ideia-principal)

## Tecnologias do projeto

Hoje o projeto usa principalmente:

- Java
- Spring Boot
- Maven
- HTML
- CSS
- JavaScript
- Bootstrap
- MySQL/MariaDB local
- Supabase/PostgreSQL
- Git e GitHub

## Antes de alterar qualquer coisa

Antes de mexer em um arquivo, faça uma leitura rápida do contexto. Veja onde a funcionalidade se encaixa, quais nomes já são usados e qual padrão o projeto já adotou.

Evite mudanças grandes quando uma mudança pequena resolve. Também evite trocar uma estrutura que já funciona apenas por preferência pessoal. O projeto precisa evoluir sem perder o fio.

Checklist rápido antes de começar:

- entenda a pasta e a camada onde o arquivo está;
- reaproveite padrões já existentes;
- não duplique código sem necessidade;
- não remova código funcional sem motivo claro;
- não adicione dependência nova sem necessidade real;
- preserve compatibilidade com VS Code e IntelliJ;
- pense em quem vai ler esse código depois.

## Organização do back-end

O back-end segue o padrão MVC com camadas bem separadas:

```text
Controller -> Service -> Repository -> Banco de dados
     ^                         |
     |                         v
   HTTP                      Model
```

Responsabilidade de cada camada:

- `controllers`: recebem requisições HTTP e devolvem respostas.
- `service`: concentram regras de negócio e coordenam o fluxo.
- `repository`: acessam o banco de dados e executam SQL.
- `model`: representam os dados usados pela aplicação.

Ao criar uma nova funcionalidade, mantenha esse formato:

```text
controllers/NomeController.java
service/NomeService.java
repository/NomeRepository.java
model/Nome.java
```

Controllers não devem ter SQL. Repositories não devem decidir regra de negócio. Services fazem a ponte entre as duas coisas.

## Código limpo, sem mistério

Escreva código para ser lido por uma pessoa. Um bom nome muitas vezes evita um comentário inteiro.

Prefira:

```java
BigDecimal valorTotal;
```

Em vez de:

```java
BigDecimal x;
```

Prefira:

```java
validarReserva();
```

Em vez de:

```java
valRes();
```

Nomes claros, métodos pequenos e responsabilidades bem separadas deixam o projeto mais fácil de corrigir e ampliar.

## Comentários no código

Comentário bom explica intenção, regra ou contexto. Comentário ruim apenas repete a linha seguinte.

Evite:

```java
// Cria um produto
Produto produto = new Produto();
```

Prefira comentar quando houver algo que o código sozinho não conta:

```java
// Produto inativo continua no banco para preservar histórico, mas não aparece no cardápio.
if (!produto.isAtivo()) {
    return;
}
```

Use comentários para explicar:

- regra de negócio;
- decisão técnica;
- comportamento que pode causar dúvida;
- integração com serviço externo;
- compatibilidade entre ambientes;
- limitação temporária;
- ponto de expansão futura.

Não use comentário para decorar o código. Se o comentário não ajuda alguém a entender melhor, ele provavelmente não precisa estar ali.

## Comentários didáticos

Este projeto também é usado para estudo, então comentários didáticos são bem-vindos. Só cuide para que eles tenham utilidade real.

Um bom comentário didático explica o motivo:

```java
// BigDecimal evita erros de arredondamento em valores monetários.
private BigDecimal preco;
```

Um comentário fraco apenas traduz a sintaxe:

```java
// Variável preço
private BigDecimal preco;
```

## HTML

Use HTML semântico sempre que fizer sentido:

- `header` para cabeçalho;
- `nav` para navegação;
- `main` para o conteúdo principal;
- `section` para blocos de conteúdo;
- `article` para itens independentes, como cards de produto;
- `footer` para rodapé.

Comentários em HTML devem ajudar a navegar em páginas maiores ou explicar uma decisão de estrutura.

Bom exemplo:

```html
<!-- Categoria do cardápio; futuramente este bloco virá da API de produtos. -->
<section class="mb-5">
```

Evite:

```html
<!-- Botão -->
<button>Salvar</button>
```

## CSS

O CSS deve ser organizado por seções. No projeto atual, `variables.css` guarda cores, fontes e variáveis globais. O `theme.css` guarda os detalhes visuais próprios da Cantina da Nonna.

Comentários em CSS devem explicar decisões, não propriedades óbvias.

Bom exemplo:

```css
/* Foco dourado ajuda na navegação por teclado sem fugir da identidade visual. */
--bs-focus-ring-color: rgba(200, 155, 60, 0.5);
```

Evite:

```css
/* Define a cor */
color: red;
```

## JavaScript

JavaScript deve ficar simples e direto. Se uma biblioteca já resolve bem o problema, como Bootstrap para o menu ou Leaflet para o mapa, use a biblioteca e deixe o código local apenas para os ajustes específicos do projeto.

Comentários em JavaScript devem explicar comportamento, integração ou cuidado com erro.

Exemplo:

```javascript
// Algumas páginas administrativas não têm mapa; nesse caso o script termina sem erro.
if (!elementoMapa) {
  return;
}
```

## Banco de dados

O projeto usa dois caminhos de banco:

```text
local     -> XAMPP / MySQL ou MariaDB
supabase  -> Supabase / PostgreSQL
```

Mantenha scripts separados quando a sintaxe for diferente entre os bancos. No projeto atual:

```text
schema.sql              -> MySQL/MariaDB
schema-postgres.sql     -> Supabase/PostgreSQL
data.sql                -> MySQL/MariaDB
data-postgres.sql       -> Supabase/PostgreSQL
```

IDs devem seguir o padrão definido no projeto:

```sql
PRIMARY KEY DEFAULT (UUID())
```

No PostgreSQL/Supabase, use o equivalente com `gen_random_uuid()`.

## Segurança

Nunca coloque senha, token, chave de API ou segredo real no GitHub.

Use `.env` para valores locais e mantenha esse arquivo fora do Git. Use `.env.example` apenas para mostrar o nome das variáveis necessárias, sem dados sensíveis.

Antes de commitar, confira se não entrou nada como:

- senha de banco;
- token de serviço;
- chave secreta;
- arquivo `.env` real;
- certificado privado.

Mensagens de erro também não devem expor detalhes internos, senhas ou configuração sensível.

## Testes

Sempre que mexer em Java, Spring, banco, configuração ou regra de negócio, rode os testes Maven.

Comando padrão:

```powershell
cd nona-back
.\mvnw.cmd test
```

Para forçar Supabase:

```powershell
.\mvnw.cmd "-Dspring.profiles.active=supabase" test
```

Para forçar banco local:

```powershell
.\mvnw.cmd "-Dspring.profiles.active=local" test
```

Mudanças apenas em documentação normalmente não exigem teste Maven, mas ainda precisam passar por revisão de diff.

## Documentação

A documentação deve contar a verdade do projeto. Não escreva que uma funcionalidade existe se ela ainda é apenas plano.

Antes de atualizar README ou documentação técnica, confira:

- `pom.xml`;
- arquivos `application*.properties`;
- scripts de banco;
- estrutura real de pastas;
- comandos usados para rodar e testar;
- funcionalidades que realmente já existem.

Escreva como alguém explicando o projeto para outro desenvolvedor. Texto claro, simples e útil é melhor do que texto cheio de termos bonitos ou frases genéricas.

## Git e commits

Use commits pequenos, com mensagens diretas. O histórico deve contar a evolução do projeto sem exigir adivinhação.

Bons exemplos:

```text
feat: adiciona cadastro de produtos
fix: corrige health check do banco
docs: atualiza instrucoes do Supabase
style: padroniza comentarios do codigo
test: adiciona testes de produtos
```

Evite mensagens vagas:

```text
alteracoes
arrumei
teste
final
```

Antes de commitar:

- veja `git status`;
- revise o diff;
- confirme que não há credenciais;
- rode testes quando a mudança pedir;
- mantenha o commit focado no assunto.

## Compatibilidade com as IDEs

O projeto deve continuar funcionando no VS Code e no IntelliJ IDEA.

Para isso:

- use o Maven Wrapper (`mvnw.cmd`);
- mantenha dependências no `pom.xml`;
- não dependa de configuração exclusiva de uma IDE;
- configure variáveis de ambiente fora do código;
- mantenha apenas um repositório Git na raiz `nonna`.

## Quando criar novas dependências

Só adicione biblioteca nova quando ela resolver um problema real. Antes disso, veja se o Spring Boot, o Bootstrap, o Java ou o próprio projeto já oferecem uma solução simples.

Toda dependência nova precisa ter um motivo claro, porque ela aumenta a responsabilidade de manutenção.

## Antes de finalizar uma alteração

Faça uma última passada:

- o código continua simples?
- a arquitetura foi respeitada?
- os comentários ajudam de verdade?
- a documentação continua correta?
- os testes necessários foram executados?
- não entrou senha ou token no Git?
- o projeto continua fácil de abrir no VS Code e no IntelliJ?

## Ideia principal

O objetivo não é apenas fazer funcionar. O objetivo é construir um projeto que dê orgulho de abrir depois: organizado, seguro, legível e fácil de continuar.

Cada mudança deve deixar o projeto um pouco melhor do que encontrou.

[Voltar ao topo](#padrão-de-desenvolvimento-do-projeto)
