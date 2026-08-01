package br.com.nona_back.controllers;

import br.com.nona_back.model.Produto;
import br.com.nona_back.service.ProdutoService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

// Criado por Jose Tavares.
// Referencia da aula: SENAC_back/src/main/java/br/com/nonna/controllers/ProdutoController.java
//
// CONTROLLER - porta de entrada da aplicacao.
// Recebe a requisicao HTTP, chama o Service e devolve a resposta.
// Nao deve ter regra de negocio e nao deve ter SQL aqui dentro.
@RestController
public class ProdutoController {

    // O Controller depende do Service.
    // Ele nao conhece o Repository nem o banco de dados.
    private final ProdutoService service;

    // Injecao de dependencia via construtor.
    // O Spring cria o ProdutoService e entrega aqui automaticamente.
    public ProdutoController(ProdutoService service) {
        this.service = service;
    }

    // @GetMapping("/produtos") mapeia requisicoes GET para a URL /produtos.
    // O Spring le os getters do Produto e monta o JSON automaticamente.
    @GetMapping("/produtos")
    public List<Produto> listar() {
        return service.listar();
    }
}