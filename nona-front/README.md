# Cantina da Nonna

Projeto front-end em HTML, CSS e JavaScript para estudo de estrutura semântica, organização profissional de arquivos e preparação para crescimento Full Stack.


## Navegação

- [README principal](../README.md)
- [Padrão de desenvolvimento](../PADRAO_DESENVOLVIMENTO.md)
- [Documentação técnica](../DOCUMENTACAO_TECNICA.md)
- [Configuração do Supabase](../SUPABASE.md)
- [Notas rápidas de continuidade](../AGENTS.md)

## Nesta página

- [Estrutura Principal](#estrutura-principal)
- [Responsabilidade Dos CSS](#responsabilidade-dos-css)
- [Como Adicionar Uma Nova Página](#como-adicionar-uma-nova-página)
- [Como Adicionar Novos Componentes](#como-adicionar-novos-componentes)
- [Sistema Flexbox](#sistema-flexbox)
- [Observação De Estudo](#observação-de-estudo)

## Estrutura Principal

- `public/index.html`: página inicial do site.
- `public/pages/`: páginas internas do projeto.
- `public/pages/nossa-historia.html`: página institucional com a história da Cantina da Nonna.
- `public/pages/cadastro-produtos.html`: página front-end para cadastro visual de produtos do cardápio.
- `public/css/`: estilos organizados por responsabilidade.
- `public/css/pages/`: estilos específicos de cada página.
- `public/images/`: imagens organizadas por categoria.
- `public/favicon/`: ícone exibido na aba do navegador.
- `public/js/`: scripts JavaScript do projeto.

## Responsabilidade Dos CSS

- `reset.css`: normaliza comportamentos básicos do navegador.
- `variables.css`: guarda cores, fontes, tamanhos e medidas globais.
- `global.css`: estilos globais usados em todas as páginas.
- `components.css`: componentes reutilizáveis, como cabeçalho, menu, botões, cards, tabelas, formulário e rodapé.
- `layout.css`: estrutura geral, containers, seções e responsividade.
- `pages/*.css`: estilos exclusivos de cada página.

## Como Adicionar Uma Nova Página

1. Crie o arquivo HTML dentro de `public/pages/`.
2. Crie o CSS específico em `public/css/pages/nome-da-pagina.css`.
3. No HTML, carregue os CSS nesta ordem:

```html
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/variables.css">
<link rel="stylesheet" href="../css/global.css">
<link rel="stylesheet" href="../css/components.css">
<link rel="stylesheet" href="../css/layout.css">
<link rel="stylesheet" href="../css/pages/nome-da-pagina.css">
```

## Como Adicionar Novos Componentes

Componentes reutilizados em mais de uma página devem ficar em `public/css/components.css`.

Exemplos:

- botões;
- cards;
- menus;
- tabelas;
- formulários;
- rodapé;
- cabeçalho.

Estilos exclusivos de uma única página devem ficar em `public/css/pages/`.

## Sistema Flexbox

O projeto possui classes reutilizáveis de Flexbox em `public/css/layout.css`.

Use no HTML quando precisar controlar alinhamento sem criar um novo CSS:

```html
<section class="flex flex-wrap justify-between items-center gap-md">
  <div class="flex-1">Conteúdo 1</div>
  <div class="flex-none">Conteúdo 2</div>
</section>
```

Classes de container:

- `flex`: ativa Flexbox.
- `inline-flex`: ativa Flexbox em elemento inline.
- `flex-row`: organiza itens em linha.
- `flex-column`: organiza itens em coluna.
- `flex-wrap`: permite quebra de linha.
- `flex-nowrap`: impede quebra de linha.
- `justify-start`, `justify-center`, `justify-end`, `justify-between`, `justify-around`, `justify-evenly`: controlam alinhamento no eixo principal.
- `items-start`, `items-center`, `items-end`, `items-stretch`, `items-baseline`: controlam alinhamento no eixo cruzado.
- `content-start`, `content-center`, `content-between`: controlam múltiplas linhas flexíveis.
- `gap-xs`, `gap-sm`, `gap-md`, `gap-lg`, `gap-xl`: controlam espaçamento entre itens.

Classes de item:

- `flex-1`: item cresce para ocupar espaço disponível.
- `flex-auto`: item cresce e encolhe respeitando seu tamanho natural.
- `flex-none`: item mantém seu tamanho.
- `grow`, `grow-0`: controla crescimento.
- `shrink`, `shrink-0`: controla encolhimento.
- `basis-25`, `basis-33`, `basis-50`, `basis-100`: controla tamanho inicial.
- `order-first`, `order-last`: muda a ordem visual.
- `self-start`, `self-center`, `self-end`, `self-stretch`: alinha um item individualmente.

O menu, o cabeçalho, o formulário de reserva e a página Nossa História já usam Flexbox com variáveis em `public/css/variables.css`.

## Observação De Estudo

Os arquivos HTML, CSS e JavaScript possuem comentários explicando a função dos principais blocos do código.

[Voltar ao topo](#cantina-da-nonna)
