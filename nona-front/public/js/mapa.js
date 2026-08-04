/*
  mapa.js
  ---------------------------------------------------------------------------
  Monta o minimapa do rodape com Leaflet e OpenStreetMap. O mapa fica dentro
  da pagina, mas o clique em uma area livre abre a rota no Google Maps para
  facilitar a navegacao do cliente sem poluir o rodape com botoes extras.
*/

/* Endereco usado tanto no popup quanto no link de rota. */
const enderecoCantina = "Rua Renata Costa 945, Centro, Balneario Arroio do Silva, SC";

/* Coordenadas da Cantina da Nonna, usadas para centralizar mapa e marcador. */
const latitudeCantina = -28.98603;
const longitudeCantina = -49.41643;

/* Leaflet espera coordenadas no formato [latitude, longitude]. */
const coordenadasCantina = [latitudeCantina, longitudeCantina];

/* Link externo montado por JavaScript para manter o HTML mais limpo. */
const urlGoogleMaps = "https://www.google.com/maps/dir/?api=1&destination=" + encodeURIComponent(enderecoCantina);

/* So tentamos montar o mapa depois que o HTML ja esta disponivel no navegador. */
document.addEventListener("DOMContentLoaded", function () {
  /* Algumas paginas administrativas nao tem mapa; nesse caso o script termina sem erro. */
  const elementoMapa = document.getElementById("mapa-rodape");

  /* Tambem encerramos se o Leaflet nao carregou, evitando quebrar o restante da pagina. */
  if (!elementoMapa || typeof L === "undefined") {
    return;
  }

  /* Cria o mapa ja centralizado no endereco da cantina. */
  const mapa = L.map("mapa-rodape").setView(coordenadasCantina, 16);

  /* OpenStreetMap fornece os blocos visuais que formam o mapa. */
  L.tileLayer("https://tile.openstreetmap.org/{z}/{x}/{y}.png", {
    maxZoom: 19,
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
  }).addTo(mapa);

  /* Marcador fixo no endereco da Cantina da Nonna. */
  const marcador = L.marker(coordenadasCantina, {
    title: "Cantina da Nonna",
    alt: "Marcador da Cantina da Nonna"
  }).addTo(mapa);

  /* Popup simples: mostra o nome e o endereco, sem links visiveis de GPS. */
  marcador.bindPopup(
    '<strong>Cantina da Nonna</strong><br>' +
    'Rua Renata Costa Nº 945 - Centro<br>' +
    'Balneario Arroio do Silva - SC'
  );

  /* Clique no marcador mostra o popup; clique no restante do mapa abre a rota. */
  marcador.on("click", function (evento) {
    L.DomEvent.stopPropagation(evento.originalEvent);
  });

  mapa.on("click", function (evento) {
    const elementoClicado = evento.originalEvent.target;

    /* Controles e popup precisam continuar interativos sem abrir uma nova aba por engano. */
    if (elementoClicado.closest(".leaflet-popup") || elementoClicado.closest(".leaflet-control")) {
      return;
    }

    window.open(urlGoogleMaps, "_blank");
  });
});
