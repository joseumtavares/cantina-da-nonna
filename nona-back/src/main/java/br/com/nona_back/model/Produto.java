package br.com.nona_back.model;

import java.math.BigDecimal;

// Criado por Jose Tavares, tomando como base o model Produto usado na aula.
// Model representa os dados que circulam entre as camadas. Ele fica sem SQL e sem anotações
// de Service/Repository para manter uma responsabilidade simples: carregar informações do produto.
public class Produto {

    // ID gerado pelo banco; usamos String para manter compatibilidade com o UUID em texto do MySQL/MariaDB.
    private String id;

    // Código interno pensado para a futura tela administrativa de cadastro.
    private String codigo;

    private String nome;

    // Descrição exibida no cardápio e reaproveitada no cadastro administrativo.
    private String descricao;

    // BigDecimal evita problemas de arredondamento em valores monetários.
    // O banco real usa a coluna valor, e o Repository aplica alias para manter o model próximo da aula.
    private BigDecimal preco;

    // Caminho da imagem que o front-end usa nos cards do cardápio.
    private String imagem;

    private String categoria;

    // Permite esconder um produto do cardápio sem apagar seu histórico do banco.
    private boolean ativo;

    // Marca produtos que podem aparecer em áreas de destaque da página inicial.
    private boolean destaque;

    // Construtor vazio ajuda frameworks e ferramentas que criam objetos automaticamente.
    public Produto() {
    }

    // Construtor usado pelo Repository ao converter cada linha do banco em Produto.
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

    // O Spring usa os getters para montar o JSON devolvido pela API.

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getCodigo() { return codigo; }
    public void setCodigo(String codigo) { this.codigo = codigo; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getDescricao() { return descricao; }
    public void setDescricao(String descricao) { this.descricao = descricao; }

    // Devolvemos String para preservar o formato monetário simples usado nesta etapa da aula.
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
