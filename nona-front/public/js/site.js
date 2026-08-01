/*
  SITE.JS
  ---------------------------------------------------------------------------
  Agora que o menu (navbar) é o componente pronto do Bootstrap, o próprio
  Bootstrap já cuida de abrir e fechar o menu no celular (isso é feito pelo
  atributo "data-bs-toggle=collapse" no botão sanduíche, lá no HTML).

  Este arquivo cuida apenas de dois detalhes extras que o Bootstrap não faz
  sozinho:
    1) Fechar o menu do celular automaticamente depois que a pessoa clica em
       um link (sem isso, o menu ficaria aberto tampando a tela).
    2) Deixar pronta uma futura conexão com o back-end: por enquanto o site
       não tem banco de dados, mas os comentários abaixo marcam os pontos
       onde, no futuro, poderíamos buscar dados reais (ex: produtos do
       cardápio) em vez de conteúdo fixo no HTML.
*/

document.addEventListener("DOMContentLoaded", function () {
  /* Busca o menu recolhível (o mesmo id usado no atributo data-bs-target). */
  const menuPrincipal = document.getElementById("menuPrincipal");

  /* Se a página não tiver menu (não deveria acontecer), encerra aqui. */
  if (!menuPrincipal) {
    return;
  }

  /* Para cada link dentro do menu, escuta o clique. */
  menuPrincipal.querySelectorAll(".nav-link, .btn").forEach(function (link) {
    link.addEventListener("click", function () {
      /* Só fecha o menu se ele estiver realmente aberto (evita erros em
         telas grandes, onde o menu nunca fica "recolhido"). */
      const estaAberto = menuPrincipal.classList.contains("show");

      if (estaAberto && window.bootstrap && window.bootstrap.Collapse) {
        const instanciaMenu = window.bootstrap.Collapse.getOrCreateInstance(menuPrincipal);
        instanciaMenu.hide();
      }
    });
  });

  /*
    PONTO DE EXPANSÃO FUTURA (back-end)
    -----------------------------------
    Quando o back-end e o banco de dados existirem, esta seria a área ideal
    para, por exemplo, buscar os produtos do cardápio de uma API e montar os
    cards dinamicamente, algo como:

      fetch("/api/produtos?categoria=pizzas")
        .then(function (resposta) { return resposta.json(); })
        .then(function (produtos) { montarCardsDeProdutos(produtos); });

    Por enquanto, os produtos ficam escritos diretamente no HTML de
    cardapio.html, então nenhuma chamada é feita.
  */
});
