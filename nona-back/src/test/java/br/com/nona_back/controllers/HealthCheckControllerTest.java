package br.com.nona_back.controllers;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
// Referência comum em materiais do Spring Boot 3.
// No Spring Boot 4 o pacote mudou; deixamos a linha antiga como nota de estudo.
// import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;

// Import correto para a versão atual do projeto.
import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.web.servlet.MockMvc;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

// Criado por Jose Tavares, a partir do controller de health check usado na aula.
// Estes testes deixam claro se o servidor web e a conexão com o banco continuam respondendo como esperado.
@SpringBootTest
@AutoConfigureMockMvc
class HealthCheckControllerTest {

    // MockMvc permite testar rotas HTTP sem abrir navegador nem iniciar o servidor manualmente.
    @Autowired
    private MockMvc mockMvc;

    // A rota de liveness confirma apenas que o servidor web respondeu.
    @Test
    void shouldReturnServidorWebOnlineWhenLivenessEndpointIsCalled() throws Exception {
        mockMvc.perform(get("/health-check/liveness"))
                .andExpect(status().isOk())
                .andExpect(content().string("Servidor Web Online"));
    }

    // Valida o endpoint dedicado ao banco, independentemente de ser MySQL local ou Supabase.
    @Test
    void shouldReturnDatabaseSuccessWhenDatabaseEndpointIsCalled() throws Exception {
        mockMvc.perform(get("/health-check/database"))
                .andExpect(status().isOk())
                .andExpect(content().string("conexao com banco de dados efetuada com sucesso"));
    }

    // Garante que o resumo geral continue reunindo os serviços essenciais.
    @Test
    void shouldReturnGeneralStatusWhenAllServicesAreOnline() throws Exception {
        mockMvc.perform(get("/health-check/status"))
                .andExpect(status().isOk())
                .andExpect(content().string("Servidor Web Online | conexao com banco de dados efetuada com sucesso"));
    }

    // Simula falha no banco para garantir que a mensagem de erro seja clara e segura.
    @Test
    void shouldReturnDatabaseFailureMessageWhenDatabaseIsOffline() {
        JdbcTemplate jdbcTemplate = mock(JdbcTemplate.class);
        when(jdbcTemplate.queryForObject("SELECT 1", Integer.class)).thenThrow(new RuntimeException("Falha simulada"));

        HealthCheckController controller = new HealthCheckController(jdbcTemplate);
        ResponseEntity<String> response = controller.database();

        assertEquals(HttpStatus.SERVICE_UNAVAILABLE.value(), response.getStatusCode().value());
        assertEquals("Banco de dados indisponivel: conexao com banco de dados nao foi efetuada", response.getBody());
    }
}
