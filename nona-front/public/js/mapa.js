/*
  Arquivo JavaScript responsável pelo minimapa do rodapé.
  O Leaflet.js usa este arquivo para desenhar o mapa, adicionar o marcador e abrir os links de GPS.
*/

/* Endereço usado nos links de navegação do Google Maps e Waze. */
const enderecoCantina = "Rua Renata Costa 945, Centro, Balneário Arroio do Silva, SC";

/* Coordenadas usadas para centralizar o mapa e posicionar o marcador da cantina. */
const latitudeCantina = -28.98603;
const longitudeCantina = -49.41643;

/* Array com latitude e longitude no formato esperado pelo Leaflet. */
const coordenadasCantina = [latitudeCantina, longitudeCantina];

/* Links externos que abrem a rota em aplicativos de GPS. */
const urlGoogleMaps = "https://www.google.com/maps/dir/?api=1&destination=" + encodeURIComponent(enderecoCantina);
const urlWaze = "https://waze.com/ul?q=" + encodeURIComponent(enderecoCantina) + "&navigate=yes";

/* Aguarda o HTML carregar antes de tentar montar o mapa. */
document.addEventListener("DOMContentLoaded", function () {
  /* Busca a div onde o mapa será exibido no rodapé. */
  const elementoMapa = document.getElementById("mapa-rodape");

  /* Interrompe o código se a página não tiver mapa ou se o Leaflet não carregou. */
  if (!elementoMapa || typeof L === "undefined") {
    return;
  }

  /* Cria o mapa, centraliza na cantina e define o zoom inicial. */
  const mapa = L.map("mapa-rodape").setView(coordenadasCantina, 16);

  /* Adiciona os blocos visuais do OpenStreetMap ao mapa. */
  L.tileLayer("https://tile.openstreetmap.org/{z}/{x}/{y}.png", {
    maxZoom: 19,
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
  }).addTo(mapa);

  /* Cria o marcador no endereço da Cantina da Nonna. */
  const marcador = L.marker(coordenadasCantina, {
    title: "Cantina da Nonna",
    alt: "Marcador da Cantina da Nonna"
  }).addTo(mapa);

  /* Adiciona uma janela de informação ao marcador com links de GPS. */
  marcador.bindPopup(
    '<strong>Cantina da Nonna</strong><br>' +
    'Rua Renata Costa Nº 945 - Centro<br>' +
    '<a class="link-popup-mapa" href="' + urlGoogleMaps + '" target="_blank" rel="noopener noreferrer">Google Maps</a>' +
    ' | ' +
    '<a class="link-popup-mapa" href="' + urlWaze + '" target="_blank" rel="noopener noreferrer">Waze</a>'
  );

  /* Impede que o clique direto no marcador abra a rota antes do cliente ver o popup. */
  marcador.on("click", function (evento) {
    L.DomEvent.stopPropagation(evento.originalEvent);
  });

  /* Ao clicar em qualquer área livre do mapa, abre a rota no Google Maps em uma nova aba. */
  mapa.on("click", function (evento) {
    /* Identifica qual elemento visual recebeu o clique dentro do mapa. */
    const elementoClicado = evento.originalEvent.target;

    /* Evita abrir rota quando o clique acontecer dentro do popup ou nos controles do Leaflet. */
    if (elementoClicado.closest(".leaflet-popup") || elementoClicado.closest(".leaflet-control")) {
      return;
    }

    /* Abre o Google Maps para iniciar a rota para a Cantina da Nonna. */
    window.open(urlGoogleMaps, "_blank");
  });
});
