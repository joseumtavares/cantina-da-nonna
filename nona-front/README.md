# Cantina da Nonna

Projeto front-end em HTML, CSS e JavaScript para estudo de estrutura semantica, organizacao profissional de arquivos e preparacao para crescimento Full Stack.

## Navegacao

- [README principal](../README.md)
- [Padrao de desenvolvimento](../PADRAO_DESENVOLVIMENTO.md)
- [Configuracao do ambiente](../CONFIGURACAO_AMBIENTE.md)
- [Materiais de estudo](../MATERIAIS_ESTUDO.md)
- [Documentacao tecnica](../DOCUMENTACAO_TECNICA.md)
- [Configuracao do Supabase](../SUPABASE.md)
- [Notas rapidas de continuidade](../AGENTS.md)

## Nesta pagina

- [Estrutura principal](#estrutura-principal)
- [Responsabilidade dos CSS](#responsabilidade-dos-css)
- [Como adicionar uma nova pagina](#como-adicionar-uma-nova-pagina)
- [Como adicionar novos componentes](#como-adicionar-novos-componentes)
- [Flexbox e Bootstrap](#flexbox-e-bootstrap)
- [Observacao de estudo](#observacao-de-estudo)

## Estrutura principal

- `public/index.html`: pagina inicial do site.
- `public/pages/`: paginas internas do projeto.
- `public/pages/nossa-historia.html`: pagina institucional com a historia da Cantina da Nonna.
- `public/pages/cardapio.html`: cardapio completo com entradas, massas, pizzas, sobremesas e bebidas.
- `public/pages/reserva.html`: formulario visual para reserva de mesa.
- `public/pages/cadastro-produtos.html`: pagina administrativa visual para cadastro de produtos.
- `public/css/`: estilos do projeto.
- `public/css/variables.css`: cores, fontes, medidas e variaveis integradas ao Bootstrap.
- `public/css/theme.css`: identidade visual, navbar, cards, formularios, rodape e mapa.
- `public/images/`: imagens organizadas por categoria.
- `public/favicon/`: icone exibido na aba do navegador.
- `public/js/`: scripts JavaScript do projeto.

## Responsabilidade dos CSS

O front-end atual usa dois arquivos CSS proprios:

- `variables.css`: guarda a base visual da marca, como paleta, fontes, tamanhos, sombras e variaveis `--bs-*` do Bootstrap.
- `theme.css`: aplica o visual da Cantina da Nonna sobre os componentes do Bootstrap e sobre blocos proprios, como mapa, hero, cards e formularios.

O Bootstrap continua carregado por CDN em cada pagina HTML. Ele fornece grid, containers, navbar responsiva, botoes, cards, formularios e utilitarios de Flexbox.

## Como adicionar uma nova pagina

1. Crie o arquivo HTML dentro de `public/pages/`.
2. Use o mesmo bloco de `<head>` das paginas existentes.
3. Carregue Bootstrap antes dos CSS do projeto.
4. Carregue os CSS proprios nesta ordem:

```html
<link rel="stylesheet" href="../css/variables.css">
<link rel="stylesheet" href="../css/theme.css">
```

5. Se a pagina tiver o mapa no rodape, carregue tambem o CSS e o JS do Leaflet, seguindo o modelo das paginas publicas.
6. Ajuste os caminhos relativos: paginas dentro de `public/pages/` usam `../css`, `../js` e `../images`.

## Como adicionar novos componentes

Componentes usados em mais de uma pagina devem ser estilizados em `public/css/theme.css` enquanto o projeto ainda esta pequeno.

Exemplos:

- botoes;
- cards;
- menus;
- formularios;
- rodape;
- cabecalho;
- mapa.

Se o CSS crescer muito, a proxima etapa natural sera separar novamente por responsabilidade, mas somente quando isso reduzir confusao de verdade.

## Flexbox e Bootstrap

O projeto usa principalmente as classes prontas do Bootstrap para Flexbox e Grid.

Exemplo:

```html
<section class="row align-items-center g-4">
  <div class="col-12 col-lg-6">Conteudo 1</div>
  <div class="col-12 col-lg-6">Conteudo 2</div>
</section>
```

Classes usadas com frequencia:

- `d-flex`: ativa Flexbox.
- `flex-column`: organiza itens em coluna.
- `flex-wrap`: permite quebra de linha.
- `justify-content-center`: centraliza no eixo principal.
- `justify-content-between`: separa itens nas extremidades.
- `align-items-center`: centraliza no eixo cruzado.
- `gap-2`, `gap-3`, `g-4`: controlam espacamentos.
- `row`, `col-12`, `col-md-6`, `col-lg-8`: controlam o grid responsivo.

## Observacao de estudo

Os arquivos HTML, CSS e JavaScript possuem comentarios explicando a funcao dos principais blocos do codigo. A ideia e manter os comentarios didaticos enquanto eles ajudam a entender o projeto, sem transformar o codigo em repeticao do obvio.

[Voltar ao topo](#cantina-da-nonna)
