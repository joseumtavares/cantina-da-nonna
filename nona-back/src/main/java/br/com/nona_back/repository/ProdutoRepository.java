package br.com.nona_back.repository;

import br.com.nona_back.model.Produto;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

// Criado por Jose Tavares.
// Referencia da aula: SENAC_back/src/main/java/br/com/nonna/repository/ProdutoRepository.java
//
// REPOSITORY - unica camada que conhece o banco de dados.
// Todo SQL fica aqui. Controller e Service apenas pedem uma List<Produto>
// e nao precisam saber como o banco esta organizado.
@Repository
public class ProdutoRepository {

    // JdbcTemplate e a ferramenta do Spring para executar SQL.
    // O Spring cria a conexao com base no application.properties.
    private final JdbcTemplate jdbcTemplate;

    // Injecao de dependencia via construtor.
    // O Spring cria o JdbcTemplate e entrega para esta classe automaticamente.
    public ProdutoRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // Metodo publico chamado pelo Service.
    // O nome buscarTodos foi mantido igual ao da aula para facilitar a comparacao.
    public List<Produto> buscarTodos() {
        // SQL da aula:
        // SELECT id, nome, preco, categoria FROM produto
        //
        // Melhoria criada por Jose Tavares:
        // nosso banco separa categorias em outra tabela e possui mais campos para o front-end.
        String sql = """
                SELECT
                    p.id,
                    p.codigo,
                    p.nome,
                    p.descricao,
                    p.valor AS preco,
                    p.imagem,
                    p.ativo,
                    p.destaque,
                    c.slug AS categoria
                FROM produtos p
                INNER JOIN categorias c ON c.id = p.categoria_id
                WHERE p.ativo = TRUE
                ORDER BY c.ordem_exibicao, p.ordem_exibicao, p.nome
                """;

        // RowMapper: esta funcao roda uma vez para cada linha retornada pelo banco.
        return jdbcTemplate.query(sql, (rs, linha) -> new Produto(
                rs.getString("id"),
                rs.getString("codigo"),
                rs.getString("nome"),
                rs.getString("descricao"),
                rs.getBigDecimal("preco"),
                rs.getString("imagem"),
                rs.getString("categoria"),
                rs.getBoolean("ativo"),
                rs.getBoolean("destaque")
        ));
    }
}