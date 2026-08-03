package br.com.nona_back.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

// Criado por Jose Tavares, tomando como referência o HealthCheckController da aula.
// A versão da aula confirmava apenas que o servidor subiu; aqui também verificamos o banco,
// porque isso ajuda a enxergar rapidamente qual parte do ambiente está funcionando.
@RestController
public class HealthCheckController {

    private static final String SERVIDOR_WEB_ONLINE = "Servidor Web Online";
    private static final String BANCO_DE_DADOS_ONLINE = "conexao com banco de dados efetuada com sucesso";
    private static final String BANCO_DE_DADOS_OFFLINE = "Banco de dados indisponivel: conexao com banco de dados nao foi efetuada";

    // Usamos o JdbcTemplate apenas para um teste leve de conexão com o banco.
    private final JdbcTemplate jdbcTemplate;

    public HealthCheckController(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // Referência original da aula, mantida para comparação durante o estudo:
    // @GetMapping("/health-check/liveness")
    // public String liveness() {
    //     return "OK";
    // }

    // A rota principal resume servidor web e banco em uma única resposta.
    @GetMapping("/health-check/liveness")
    public ResponseEntity<String> liveness() {
        return status();
    }

    // Rota útil quando queremos testar apenas a conexão com o banco.
    @GetMapping("/health-check/database")
    public ResponseEntity<String> database() {
        return verificarBancoDeDados();
    }

    // Resumo dos serviços essenciais conhecidos nesta fase do projeto.
    @GetMapping("/health-check/status")
    public ResponseEntity<String> status() {
        ResponseEntity<String> respostaBanco = verificarBancoDeDados();

        if (respostaBanco.getStatusCode().is2xxSuccessful()) {
            return ResponseEntity.ok(SERVIDOR_WEB_ONLINE + " | " + BANCO_DE_DADOS_ONLINE);
        }

        return ResponseEntity
                .status(HttpStatus.SERVICE_UNAVAILABLE)
                .body(SERVIDOR_WEB_ONLINE + " | " + respostaBanco.getBody());
    }

    // Centraliza a verificação para manter as rotas consistentes entre si.
    private ResponseEntity<String> verificarBancoDeDados() {
        try {
            Integer respostaBanco = jdbcTemplate.queryForObject("SELECT 1", Integer.class);

            if (respostaBanco != null && respostaBanco == 1) {
                return ResponseEntity.ok(BANCO_DE_DADOS_ONLINE);
            }

            return ResponseEntity
                    .status(HttpStatus.SERVICE_UNAVAILABLE)
                    .body("Banco de dados indisponivel: teste de conexao retornou resposta inesperada");
        } catch (Exception exception) {
            return ResponseEntity
                    .status(HttpStatus.SERVICE_UNAVAILABLE)
                    .body(BANCO_DE_DADOS_OFFLINE);
        }
    }
}
