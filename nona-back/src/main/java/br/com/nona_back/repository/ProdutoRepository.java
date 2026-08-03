package br.com.nona_back.repository;

import br.com.nona_back.model.Produto;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

// Criado por Jose Tavares, mantendo a ideia de Repository apresentada na aula.
// Esta é a única camada que conversa diretamente com o banco; assim Controller e Service
// continuam focados no fluxo da aplicação, sem precisar conhecer a estrutura das tabelas.
@Repository
public class ProdutoRepository {

    // JdbcTemplate executa o SQL usando a conexão configurada nos arquivos application-*.properties.
    private final JdbcTemplate jdbcTemplate;

    // Injeção via construtor deixa claro que o Repository depende de acesso ao banco.
    public ProdutoRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // Método chamado pelo Service; o nome foi mantido simples para seguir a linha da aula.
    public List<Produto> buscarTodos() {
        // Na aula a consulta vinha de uma tabela produto simples.
        // Aqui já usamos o desenho real do projeto: categorias separadas, imagem, destaque e controle de ativo.
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

        // O RowMapper transforma cada linha do ResultSet em um objeto Produto usado pela API.
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
