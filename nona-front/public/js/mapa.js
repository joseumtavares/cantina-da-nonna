/*
  mapa.js
  ---------------------------------------------------------------------------
  Monta o minimapa do rodapé com Leaflet e OpenStreetMap. O mapa fica dentro
  da página, mas o clique em uma área livre abre a rota no Google Maps para
  facilitar a navegação do cliente.
*/

/* Endereço usado tanto no popup quanto nos links de rota. */
const enderecoCantina = "Rua Renata Costa 945, Centro, Balneário Arroio do Silva, SC";

/* Coordenadas da Cantina da Nonna, usadas para centralizar mapa e marcador. */
const latitudeCantina = -28.98603;
const longitudeCantina = -49.41643;

/* Leaflet espera coordenadas no formato [latitude, longitude]. */
const coordenadasCantina = [latitudeCantina, longitudeCantina];

/* Links externos são montados por JavaScript para manter o HTML mais limpo. */
const urlGoogleMaps = "https://www.google.com/maps/dir/?api=1&destination=" + encodeURIComponent(enderecoCantina);
const urlWaze = "https://waze.com/ul?q=" + encodeURIComponent(enderecoCantina) + "&navigate=yes";

/* Só tentamos montar o mapa depois que o HTML já está disponível no navegador. */
document.addEventListener("DOMContentLoaded", function () {
  /* Algumas páginas administrativas não têm mapa; nesse caso o script termina sem erro. */
  const elementoMapa = document.getElementById("mapa-rodape");

  /* Também encerramos se o Leaflet não carregou, evitando quebrar o restante da página. */
  if (!elementoMapa || typeof L === "undefined") {
    return;
  }

  /* Cria o mapa já centralizado no endereço da cantina. */
  const mapa = L.map("mapa-rodape").setView(coordenadasCantina, 16);

  /* OpenStreetMap fornece os blocos visuais que formam o mapa. */
  L.tileLayer("https://tile.openstreetmap.org/{z}/{x}/{y}.png", {
    maxZoom: 19,
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
  }).addTo(mapa);

  /* Marcador fixo no endereço da Cantina da Nonna. */
  const marcador = L.marker(coordenadasCantina, {
    title: "Cantina da Nonna",
    alt: "Marcador da Cantina da Nonna"
  }).addTo(mapa);

  /* Popup com endereço e atalhos de GPS para quem clicar diretamente no marcador. */
  marcador.bindPopup(
    '<strong>Cantina da Nonna</strong><br>' +
    'Rua Renata Costa Nº 945 - Centro<br>' +
    '<a class="link-popup-mapa" href="' + urlGoogleMaps + '" target="_blank" rel="noopener noreferrer">Google Maps</a>' +
    ' | ' +
    '<a class="link-popup-mapa" href="' + urlWaze + '" target="_blank" rel="noopener noreferrer">Waze</a>'
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
