package br.com.nona_back.controllers;

import br.com.nona_back.model.Produto;
import br.com.nona_back.service.ProdutoService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

// Criado por Jose Tavares, seguindo a organização ensinada na aula do professor Gabriel Carvalho.
// Controller é a porta de entrada da API: recebe a requisição HTTP, conversa com o Service
// e devolve a resposta. Regra de negócio e SQL ficam fora daqui.
@RestController
public class ProdutoController {

    // A dependência fica no Service para preservar o fluxo Controller -> Service -> Repository.
    private final ProdutoService service;

    // Injeção via construtor: o Spring cria o Service e entrega pronto para o Controller.
    public ProdutoController(ProdutoService service) {
        this.service = service;
    }

    // Endpoint público do cardápio; o Spring transforma a lista de Produto em JSON pelos getters.
    @GetMapping("/produtos")
    public List<Produto> listar() {
        return service.listar();
    }
}
