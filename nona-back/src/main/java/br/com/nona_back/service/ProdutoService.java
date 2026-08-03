package br.com.nona_back.service;

import br.com.nona_back.model.Produto;
import br.com.nona_back.repository.ProdutoRepository;
import org.springframework.stereotype.Service;

import java.util.List;

// Criado por Jose Tavares, seguindo a separação de responsabilidades usada na aula.
// Service é a camada onde as regras de negócio devem nascer. Nesta fase ele apenas coordena
// a busca de produtos, mas já protege o Controller de conhecer SQL ou detalhes do banco.
@Service
public class ProdutoService {

    // Mantém o caminho do MVC do projeto: Controller -> Service -> Repository.
    private final ProdutoRepository repository;

    // Injeção via construtor facilita testes e mantém a dependência explícita.
    public ProdutoService(ProdutoRepository repository) {
        this.repository = repository;
    }

    // Nome simples e próximo da aula para facilitar a comparação durante o aprendizado.
    public List<Produto> listar() {
        return repository.buscarTodos();
    }
}
