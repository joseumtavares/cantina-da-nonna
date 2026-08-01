package br.com.nona_back.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

// Criado por Jose Tavares.
// Referencia da aula: SENAC_back/src/main/java/br/com/nonna/controllers/HealthCheckController.java
//
// Na aula, este controller retornava apenas "OK" para provar que o servidor web subiu.
// Melhoria criada por Jose Tavares: alem do servidor web, tambem testamos o banco de dados.
@RestController
public class HealthCheckController {

    private static final String SERVIDOR_WEB_ONLINE = "Servidor Web Online";
    private static final String BANCO_DE_DADOS_ONLINE = "conexao com banco de dados efetuada com sucesso";
    private static final String BANCO_DE_DADOS_OFFLINE = "Banco de dados indisponivel: conexao com banco de dados nao foi efetuada";

    // JdbcTemplate executa o SELECT 1 usado para testar o banco.
    private final JdbcTemplate jdbcTemplate;

    public HealthCheckController(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // Codigo original da aula:
    // @GetMapping("/health-check/liveness")
    // public String liveness() {
    //     return "OK";
    // }

    // Melhoria criada por Jose Tavares:
    // a rota principal informa servidor web e banco de dados na mesma resposta.
    @GetMapping("/health-check/liveness")
    public ResponseEntity<String> liveness() {
        return status();
    }

    // Rota separada para testar somente o banco de dados.
    @GetMapping("/health-check/database")
    public ResponseEntity<String> database() {
        return verificarBancoDeDados();
    }

    // Rota de resumo dos servicos conhecidos ate agora.
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

    // Metodo privado para reaproveitar a mesma verificacao em mais de uma rota.
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