package br.com.nona_back.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

// Criado por Jose Tavares.
// Controller usado para abrir a pagina inicial do front-end pelo mesmo servidor do back-end.
// Diferente dos controllers REST, este usa @Controller porque ele encaminha o navegador
// para um arquivo HTML, em vez de devolver somente texto ou JSON.
@Controller
public class FrontendController {

    // Este mapeamento permite abrir o front-end pela raiz do servidor:
    // http://localhost:8080/
    @GetMapping("/")
    public String abrirPaginaInicial() {
        // forward:/index.html entrega o arquivo index.html da pasta de arquivos estaticos.
        return "forward:/index.html";
    }

    // Este mapeamento aceita o caminho digitado durante o estudo:
    // http://localhost:8080/dev/nonna/nona-front
    // O redirect muda a URL do navegador para /, evitando erro nos caminhos de CSS e imagens.
    @GetMapping({"/dev/nonna/nona-front", "/dev/nonna/nona-front/"})
    public String redirecionarParaPaginaInicial() {
        return "redirect:/";
    }
}