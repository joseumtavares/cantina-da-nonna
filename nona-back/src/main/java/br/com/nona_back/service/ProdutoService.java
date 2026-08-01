package br.com.nona_back.service;

import br.com.nona_back.model.Produto;
import br.com.nona_back.repository.ProdutoRepository;
import org.springframework.stereotype.Service;

import java.util.List;

// Criado por Jose Tavares.
// Referencia da aula: SENAC_back/src/main/java/br/com/nonna/service/ProdutoService.java
//
// SERVICE - camada de regras de negocio.
// Nao sabe o que e HTTP e nao escreve SQL. Ele conversa com o Repository
// e entrega dados prontos para o Controller.
@Service
public class ProdutoService {

    // O Service depende do Repository, seguindo a seta da aula:
    // Controller -> Service -> Repository.
    private final ProdutoRepository repository;

    // Injecao de dependencia via construtor.
    public ProdutoService(ProdutoRepository repository) {
        this.repository = repository;
    }

    // Metodo publico chamado pelo Controller.
    // O nome listar foi mantido igual ao da aula.
    public List<Produto> listar() {
        return repository.buscarTodos();
    }
}