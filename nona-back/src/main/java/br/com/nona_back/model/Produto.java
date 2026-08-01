package br.com.nona_back.model;

import java.math.BigDecimal;

// Criado por Jose Tavares.
// Referencia da aula: SENAC_back/src/main/java/br/com/nonna/model/Produto.java
//
// MODEL - representa um dado do sistema.
// Esta classe segue a ideia usada pelo professor: Java puro, sem @Service,
// sem @Repository e sem SQL. A responsabilidade dela e carregar os dados
// de um produto entre as camadas da aplicacao.
public class Produto {

    // UUID gerado pelo banco com DEFAULT (UUID()).
    // Mantemos como String porque no MySQL/MariaDB ele fica salvo como texto de 36 caracteres.
    private String id;

    // Melhoria criada por Jose Tavares:
    // codigo interno do produto, usado futuramente no cadastro administrativo.
    private String codigo;

    private String nome;

    // Melhoria criada por Jose Tavares:
    // descricao aparece no front-end e tambem ajuda no cadastro do produto.
    private String descricao;

    // Mesmo conceito da aula: BigDecimal para dinheiro.
    // No banco da aula a coluna chama preco; no nosso banco ela chama valor.
    // O Repository faz o alias SELECT p.valor AS preco para manter o codigo parecido.
    private BigDecimal preco;

    // Melhoria criada por Jose Tavares:
    // caminho da imagem do produto usada pelo front-end.
    private String imagem;

    private String categoria;

    // Melhoria criada por Jose Tavares:
    // permite esconder produto do cardapio sem apagar do banco.
    private boolean ativo;

    // Melhoria criada por Jose Tavares:
    // permite marcar produtos para exibicao em areas de destaque.
    private boolean destaque;

    // Construtor vazio mantido para facilitar ferramentas que montam objetos automaticamente.
    public Produto() {
    }

    // Construtor usado pelo Repository para montar o objeto a partir de cada linha do banco.
    public Produto(String id, String codigo, String nome, String descricao, BigDecimal preco, String imagem,
                   String categoria, boolean ativo, boolean destaque) {
        this.id = id;
        this.codigo = codigo;
        this.nome = nome;
        this.descricao = descricao;
        this.preco = preco;
        this.imagem = imagem;
        this.categoria = categoria;
        this.ativo = ativo;
        this.destaque = destaque;
    }

    // Getters e setters: o Spring usa os getters para montar o JSON.
    // Se um getter nao existir, o campo nao aparece na resposta da API.

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getCodigo() { return codigo; }
    public void setCodigo(String codigo) { this.codigo = codigo; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getDescricao() { return descricao; }
    public void setDescricao(String descricao) { this.descricao = descricao; }

    // Igual ao padrao da aula: devolvemos String para o JSON mostrar "39.00".
    public String getPreco() { return preco == null ? null : preco.toString(); }
    public void setPreco(BigDecimal preco) { this.preco = preco; }

    public String getImagem() { return imagem; }
    public void setImagem(String imagem) { this.imagem = imagem; }

    public String getCategoria() { return categoria; }
    public void setCategoria(String categoria) { this.categoria = categoria; }

    public boolean isAtivo() { return ativo; }
    public void setAtivo(boolean ativo) { this.ativo = ativo; }

    public boolean isDestaque() { return destaque; }
    public void setDestaque(boolean destaque) { this.destaque = destaque; }
}