/*
  site.js
  ---------------------------------------------------------------------------
  O Bootstrap já cuida da abertura e fechamento do menu hambúrguer. Este arquivo
  só adiciona um cuidado de usabilidade: quando a pessoa toca em um link no menu
  aberto do celular, o menu fecha para liberar a tela.

  Também deixamos registrado onde futuramente poderemos buscar dados reais do
  back-end, como os produtos do cardápio vindos da API.
*/

document.addEventListener("DOMContentLoaded", function () {
  /* Mesmo id usado no data-bs-target do botão hambúrguer. */
  const menuPrincipal = document.getElementById("menuPrincipal");

  /* Se uma página não tiver navbar, não há nada para ajustar. */
  if (!menuPrincipal) {
    return;
  }

  /* Cada link do menu fecha a navbar apenas quando ela estiver aberta no modo celular. */
  menuPrincipal.querySelectorAll(".nav-link, .btn").forEach(function (link) {
    link.addEventListener("click", function () {
      const estaAberto = menuPrincipal.classList.contains("show");

      if (estaAberto && window.bootstrap && window.bootstrap.Collapse) {
        const instanciaMenu = window.bootstrap.Collapse.getOrCreateInstance(menuPrincipal);
        instanciaMenu.hide();
      }
    });
  });

  /*
    Ponto de expansão futura: integração com o back-end
    ---------------------------------------------------
    Quando a API estiver integrada ao front, esta area pode buscar produtos reais e montar
    os cards dinamicamente. Por enquanto, o cardápio continua escrito no HTML
    para manter a etapa de front-end simples e fácil de estudar.

      fetch("/produtos")
        .then(function (resposta) { return resposta.json(); })
        .then(function (produtos) { montarCardsDeProdutos(produtos); });
  */
});
