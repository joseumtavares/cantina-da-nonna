package br.com.nona_back.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

// Criado por Jose Tavares.
// Este controller entrega o front-end estático pelo mesmo servidor do back-end.
// Usamos @Controller porque aqui o navegador é encaminhado para arquivos HTML, não para uma resposta JSON.
@Controller
public class FrontendController {

    // Caminho principal para abrir o site durante o desenvolvimento local.
    @GetMapping("/")
    public String abrirPaginaInicial() {
        // forward mantém a URL na raiz e entrega o index.html da pasta pública.
        return "forward:/index.html";
    }

    // Mantemos este atalho porque ele foi usado durante os estudos.
    // O redirect evita que CSS, imagens e JavaScript quebrem por causa de caminhos relativos longos.
    @GetMapping({"/dev/nonna/nona-front", "/dev/nonna/nona-front/"})
    public String redirecionarParaPaginaInicial() {
        return "redirect:/";
    }
}
