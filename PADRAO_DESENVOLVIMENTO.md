# PADRÃO DE DESENVOLVIMENTO, COMENTÁRIOS E DOCUMENTAÇÃO DO PROJETO

Você é responsável por auxiliar no desenvolvimento e manutenção deste projeto.

O projeto utiliza principalmente:

* Java
* Spring Boot
* Maven
* HTML
* CSS
* JavaScript
* Git
* GitHub

O projeto ainda está em desenvolvimento, portanto todas as alterações devem priorizar organização, manutenção futura, legibilidade, segurança e facilidade para outros desenvolvedores entenderem o código.

---

# 1. REGRA PRINCIPAL

Antes de modificar qualquer arquivo:

1. Analise a estrutura existente do projeto.
2. Identifique a arquitetura e os padrões já utilizados.
3. Procure reutilizar componentes, classes, métodos e estilos existentes.
4. Não crie código duplicado sem necessidade.
5. Não altere funcionalidades existentes sem necessidade.
6. Não remova código funcional sem justificar.
7. Não introduza bibliotecas ou dependências novas sem necessidade real.
8. Preserve a compatibilidade com o restante do sistema.
9. Faça alterações pequenas, organizadas e fáceis de revisar.
10. Sempre considere que outra pessoa poderá assumir a manutenção do projeto no futuro.

Quando houver dúvida sobre uma decisão arquitetural importante, explique a decisão antes de realizar uma alteração de grande impacto.

---

# 2. PRINCÍPIO DE CÓDIGO LIMPO

O código deve ser escrito para ser facilmente compreendido por uma pessoa.

Priorize:

* nomes claros;
* métodos pequenos;
* responsabilidades bem definidas;
* baixo acoplamento;
* alta coesão;
* reutilização;
* tratamento adequado de erros;
* separação de responsabilidades;
* código simples antes de soluções excessivamente complexas.

Evite criar abstrações desnecessárias apenas para deixar o código "mais sofisticado".

Prefira uma solução simples, clara e sustentável.

---

# 3. COMENTÁRIOS NO CÓDIGO

A regra principal para comentários é:

> O comentário deve explicar aquilo que o código não consegue explicar sozinho.

Não escreva comentários apenas para repetir o que o código já deixa evidente.

## NÃO fazer:

```java
// Cria um usuário
Usuario usuario = new Usuario();
```

```java
// Incrementa o contador
contador++;
```

```html
<!-- Botão -->
<button>Salvar</button>
```

```css
/* Define a cor */
color: red;
```

Esses comentários não agregam informação.

---

# 4. QUANDO ESCREVER COMENTÁRIOS

Comentários são recomendados quando explicarem:

* regras de negócio;
* decisões técnicas;
* comportamentos não óbvios;
* limitações;
* compatibilidade com sistemas externos;
* soluções temporárias;
* situações excepcionais;
* motivos de determinada implementação;
* informações importantes para manutenção futura.

Exemplo:

```java
// Clientes inativos não podem realizar novos pedidos,
// mesmo que possuam saldo disponível.
if (!cliente.isAtivo()) {
    throw new RegraNegocioException("Cliente inativo");
}
```

O objetivo é explicar a regra, e não repetir o código.

---

# 5. PRIORIDADE: CÓDIGO AUTOEXPLICATIVO

Sempre que possível, prefira melhorar o nome do método ou variável em vez de adicionar um comentário.

Evite:

```java
// Verifica se o pedido pode ser cancelado
if (pedido.getStatus() == 2 || pedido.getStatus() == 3) {
```

Prefira:

```java
if (pedido.podeSerCancelado()) {
```

O código deve ser compreensível por si só.

---

# 6. PADRÃO DE COMENTÁRIOS JAVA

Para comentários simples utilize:

```java
// Comentário curto.
```

Para comentários que precisem de mais de uma linha:

```java
/*
 * Este processamento é necessário porque
 * determinados pedidos antigos não possuem
 * informação de frete.
 */
```

Não transforme métodos simples em blocos enormes de comentários.

---

# 7. JAVADOC

Utilize Javadoc principalmente para:

* classes públicas importantes;
* Services;
* Controllers;
* APIs;
* interfaces;
* métodos públicos complexos;
* regras de negócio relevantes;
* componentes utilizados por outras partes do sistema.

Exemplo:

```java
/**
 * Serviço responsável pelo gerenciamento dos pedidos.
 *
 * Centraliza as regras relacionadas à criação,
 * alteração e cancelamento de pedidos.
 */
@Service
public class PedidoService {
```

Métodos importantes:

```java
/**
 * Cria um novo pedido para o cliente informado.
 *
 * @param clienteId identificador do cliente
 * @param request dados necessários para criação do pedido
 * @return pedido criado
 * @throws RegraNegocioException caso o cliente esteja inativo
 */
public PedidoResponse criar(Long clienteId, PedidoRequest request) {
```

Não crie Javadoc desnecessário para getters, setters ou métodos triviais.

---

# 8. TODO, FIXME, HACK E BUG

Utilize os marcadores de maneira padronizada.

## TODO

Para algo que ainda precisa ser implementado:

```java
// TODO: Implementar integração com o serviço de pagamento.
```

## FIXME

Para um problema conhecido que precisa ser corrigido:

```java
// FIXME: Corrigir cálculo quando houver descontos acumulados.
```

## HACK

Para uma solução temporária ou excepcional:

```java
// HACK: Mantido temporariamente para compatibilidade com dados antigos.
```

## BUG

Para registrar um problema conhecido:

```java
// BUG: Produtos sem categoria causam erro durante a exportação.
```

Não utilize comentários TODO como substituto permanente de tarefas do projeto.

Quando possível, problemas maiores devem ser registrados como Issues no GitHub.

---

# 9. NÃO MANTER CÓDIGO COMENTADO

Não deixe grandes blocos de código comentados.

Evite:

```java
// cliente.setNome(nome);
// cliente.setEmail(email);
// cliente.setAtivo(true);
```

Se o código não é mais utilizado, remova-o.

O histórico deve ser preservado pelo Git.

---

# 10. SPRING BOOT

Respeite a separação de responsabilidades.

Sempre que a arquitetura existente utilizar:

* Controller
* Service
* Repository
* Entity
* DTO
* Exception
* Mapper

mantenha essas responsabilidades separadas.

Não coloque regras de negócio complexas dentro de Controllers.

Controllers devem principalmente:

* receber requisições;
* validar entrada quando apropriado;
* chamar os Services;
* devolver respostas.

Regras de negócio devem permanecer nos Services ou componentes apropriados.

Repositories devem ser responsáveis pela persistência e acesso aos dados.

---

# 11. ENTIDADES

Não coloque lógica de negócio complexa em entidades sem avaliar primeiro a arquitetura existente.

Evite transformar Entity em uma classe que faça tudo.

Mantenha responsabilidades claras.

---

# 12. DTOs

Quando o projeto utilizar DTOs, não exponha entidades diretamente em APIs sem uma justificativa clara.

Prefira:

```text
Request DTO
    ↓
Controller
    ↓
Service
    ↓
Entity
    ↓
Repository
```

E para respostas:

```text
Repository
    ↓
Entity
    ↓
Service / Mapper
    ↓
Response DTO
    ↓
Controller
```

Respeite o padrão já utilizado pelo projeto caso exista.

---

# 13. TRATAMENTO DE ERROS

Não utilize exceções genéricas sem necessidade.

Evite:

```java
throw new RuntimeException("Erro");
```

Prefira exceções específicas quando apropriado:

```java
throw new RegraNegocioException("Cliente inativo.");
```

Mensagens de erro devem ser claras e úteis.

Não exponha informações sensíveis, senhas, tokens, chaves de API ou dados internos desnecessários nas mensagens retornadas ao usuário.

---

# 14. LOGS

Não utilize `System.out.println()` para registrar informações do sistema em produção.

Prefira o mecanismo de logging utilizado pelo Spring Boot/projeto.

Exemplo:

```java
log.info("Pedido {} criado para o cliente {}", pedidoId, clienteId);
```

Não registre:

* senhas;
* tokens;
* chaves de API;
* dados sensíveis;
* informações pessoais desnecessárias.

---

# 15. HTML

Utilize comentários somente quando ajudarem a compreender a estrutura.

Exemplo:

```html
<!-- Formulário utilizado para cadastro de clientes -->
<section class="cliente-form">
```

Para páginas grandes, pode utilizar separadores:

```html
<!-- ==================== Cabeçalho ==================== -->

<!-- ==================== Conteúdo principal ==================== -->

<!-- ==================== Rodapé ==================== -->
```

Não utilize comentários para elementos óbvios.

---

# 16. CSS

Organize o CSS de maneira lógica.

Quando o arquivo for grande, utilize seções:

```css
/* ==================== Variáveis globais ==================== */

/* ==================== Layout ==================== */

/* ==================== Cabeçalho ==================== */

/* ==================== Formulários ==================== */

/* ==================== Botões ==================== */

/* ==================== Responsividade ==================== */
```

Não escreva comentários para explicar propriedades CSS óbvias.

Evite:

```css
/* Define margem */
margin: 10px;
```

Prefira comentários que expliquem uma decisão:

```css
/* Espaçamento utilizado para manter alinhamento com o cabeçalho. */
margin-top: 24px;
```

---

# 17. JAVASCRIPT

Utilize as mesmas regras aplicadas ao Java.

Comentários devem explicar:

* regras;
* decisões;
* comportamentos inesperados;
* integrações;
* limitações.

Evite comentários óbvios.

---

# 18. IDIOMA DOS COMENTÁRIOS

Os comentários e a documentação do projeto devem ser escritos em:

**Português do Brasil.**

Utilize uma linguagem natural, clara e humanizada.

Não escreva documentação com linguagem excessivamente robótica ou artificial.

Exemplo ruim:

> Este módulo é responsável pela execução da funcionalidade de processamento de pedidos mediante a utilização do mecanismo de persistência.

Prefira:

> Este módulo concentra as operações relacionadas aos pedidos e reúne as regras utilizadas para criar, alterar e cancelar pedidos.

A documentação deve parecer escrita por uma pessoa que conhece o projeto.

---

# 19. NOMES DE CLASSES, MÉTODOS E VARIÁVEIS

Utilize nomes claros e consistentes.

Evite:

```java
Usuario u;
Pedido p;
BigDecimal x;
```

Prefira:

```java
Usuario usuario;
Pedido pedido;
BigDecimal valorTotal;
```

Não utilize abreviações desnecessárias.

Evite:

```java
calcTot();
procUsr();
valPed();
```

Prefira:

```java
calcularTotal();
processarUsuario();
validarPedido();
```

---

# 20. DOCUMENTAÇÃO DO GITHUB

O projeto deve possuir documentação adequada para que uma pessoa que nunca viu o código consiga entender:

1. O que é o projeto.
2. Qual problema ele resolve.
3. Quais tecnologias são utilizadas.
4. Como executar o projeto.
5. Como configurar o ambiente.
6. Como configurar variáveis de ambiente.
7. Como executar testes.
8. Como gerar o build.
9. Como contribuir.
10. Como entrar em contato ou reportar problemas.

A documentação deve ser escrita de forma humana e objetiva.

---

# 21. README.md

O README deve ser organizado de maneira profissional.

Estrutura recomendada:

```markdown
# Nome do Projeto

Breve descrição do projeto em linguagem simples.

## Sobre o projeto

Explique o que o sistema faz e qual problema ele pretende resolver.

## Funcionalidades

- Funcionalidade 1
- Funcionalidade 2
- Funcionalidade 3

## Tecnologias utilizadas

- Java
- Spring Boot
- Maven
- HTML
- CSS
- JavaScript
- Banco de dados utilizado

## Requisitos

Informe o que é necessário instalar para executar o projeto.

## Como executar

Explique passo a passo como executar o projeto localmente.

## Configuração

Explique as variáveis de ambiente e configurações necessárias.

Nunca coloque senhas, tokens ou chaves reais no README.

## Estrutura do projeto

Explique de forma resumida a organização das principais pastas.

## Testes

Explique como executar os testes.

## Build

Explique como gerar o build da aplicação.

## Deploy

Explique, quando aplicável, como o projeto é publicado.

## Contribuição

Explique como outras pessoas podem contribuir.

## Licença

Informe a licença utilizada pelo projeto.
```

Adapte essa estrutura à realidade do projeto.

Não invente funcionalidades, tecnologias, comandos ou informações que não existam.

---

# 22. DOCUMENTAÇÃO NÃO DEVE MENTIR

Nunca escreva no README algo que não foi confirmado no projeto.

Antes de documentar:

* verifique o `pom.xml`;
* verifique as configurações;
* verifique os scripts;
* verifique as variáveis de ambiente;
* verifique os comandos de execução;
* verifique a estrutura real das pastas;
* verifique os testes existentes;
* verifique o processo de build.

A documentação deve refletir o projeto real.

---

# 23. SEGURANÇA DO REPOSITÓRIO

Antes de preparar arquivos para o GitHub, verifique se existem:

* senhas;
* tokens;
* chaves de API;
* credenciais de banco;
* arquivos `.env`;
* certificados privados;
* credenciais de serviços externos.

Nunca coloque esses dados no GitHub.

Utilize:

```text
.env
```

quando apropriado e adicione ao:

```text
.gitignore
```

Forneça exemplos sem dados reais, por exemplo:

```text
DB_URL=
DB_USERNAME=
DB_PASSWORD=
API_KEY=
```

Pode ser criado um arquivo:

```text
.env.example
```

com os nomes das variáveis necessárias, mas sem valores secretos.

---

# 24. GIT E COMMITS

Utilize mensagens de commit claras e objetivas.

Prefira:

```text
feat: adiciona cadastro de clientes
```

```text
fix: corrige validação do pedido
```

```text
refactor: reorganiza serviço de pedidos
```

```text
docs: atualiza instruções de instalação
```

```text
style: ajusta formatação do código
```

```text
test: adiciona testes para cadastro de clientes
```

Evite:

```text
alterações
```

```text
arrumei
```

```text
teste
```

```text
mudanças finais
```

---

# 25. ANTES DE FINALIZAR QUALQUER ALTERAÇÃO

Sempre que modificar o projeto:

1. Verifique se o código compila.
2. Execute os testes existentes.
3. Verifique possíveis erros de lint/formatação, quando configurados.
4. Confirme que não foram introduzidos arquivos desnecessários.
5. Confirme que não foram incluídas credenciais.
6. Confirme que a documentação continua correta.
7. Verifique se os comentários adicionados realmente são necessários.
8. Remova comentários redundantes.
9. Verifique se a alteração respeita a arquitetura existente.

---

# 26. REGRA PARA DOCUMENTAÇÃO FUTURA

Sempre que uma alteração modificar significativamente:

* arquitetura;
* instalação;
* configuração;
* banco de dados;
* API;
* variáveis de ambiente;
* processo de deploy;
* funcionalidades importantes;

avalie se o README ou outra documentação precisa ser atualizada.

Não deixe a documentação ficar desatualizada em relação ao código.

---

# 27. LINGUAGEM HUMANIZADA

Toda documentação destinada ao GitHub deve ser escrita pensando em uma pessoa que está conhecendo o projeto.

Evite textos excessivamente formais ou genéricos.

Prefira:

> O projeto utiliza Spring Boot para organizar a API e concentrar as regras de negócio. A aplicação foi estruturada em camadas para facilitar a manutenção e permitir que novas funcionalidades sejam adicionadas sem afetar partes não relacionadas do sistema.

Em vez de:

> O sistema possui uma arquitetura baseada em componentes de software responsáveis pelo processamento das informações.

A documentação deve ser clara, direta e natural.

---

# 28. REGRA DE OURO

Sempre siga estas prioridades:

1. Código simples.
2. Código legível.
3. Código seguro.
4. Arquitetura organizada.
5. Comentários somente quando agregarem informação.
6. Documentação atualizada.
7. Consistência em todo o projeto.
8. Facilidade de manutenção.

Não adicione complexidade apenas para seguir um padrão.

Se o código puder ser melhorado simplesmente tornando nomes e responsabilidades mais claros, faça isso antes de adicionar comentários.

---

# 29. COMPORTAMENTO DO CODEX

Ao receber uma solicitação de alteração:

1. Analise primeiro.
2. Explique brevemente o que encontrou quando isso for relevante.
3. Faça somente as alterações necessárias.
4. Preserve o padrão existente quando ele estiver adequado.
5. Melhore padrões ruins apenas quando isso estiver relacionado à tarefa ou quando a alteração for claramente segura.
6. Não faça uma refatoração geral sem solicitação.
7. Não crie documentação fictícia.
8. Não invente funcionalidades.
9. Não exponha informações secretas.
10. Não altere configurações de produção sem necessidade.
11. Após a alteração, valide o resultado.

Quando encontrar um problema não relacionado diretamente à tarefa, não altere automaticamente. Informe o problema para que ele possa ser tratado separadamente.

---

# 30. OBJETIVO FINAL

O objetivo não é simplesmente fazer o código funcionar.

O objetivo é construir um projeto que:

* seja fácil de entender;
* seja fácil de manter;
* seja seguro;
* tenha uma arquitetura organizada;
* possua documentação útil;
* possa ser apresentado profissionalmente no GitHub;
* permita que novos desenvolvedores entendam rapidamente o sistema;
* possa crescer sem se tornar desorganizado.

Siga essas regras em todas as alterações futuras realizadas neste projeto.
