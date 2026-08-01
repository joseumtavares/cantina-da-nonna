package br.com.nona_back.controllers;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
// IMPORT ORIGINAL USADO EM EXEMPLOS DO SPRING BOOT 3:
// No Spring Boot 4 este pacote mudou, por isso ficou comentado para consulta.
// import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;

// IMPORT AJUSTADO PARA SPRING BOOT 4:
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

// Criado por Jose Tavares.
// Referencia da aula: SENAC_back/src/main/java/br/com/nonna/controllers/HealthCheckController.java
//
// TESTE DO CONTROLLER DE HEALTH CHECK:
// Esta classe valida se os endpoints de servidor web e banco respondem corretamente.
@SpringBootTest
@AutoConfigureMockMvc
class HealthCheckControllerTest {

    // MockMvc permite testar uma rota HTTP sem precisar abrir o navegador ou subir servidor manualmente.
    @Autowired
    private MockMvc mockMvc;

    // TESTE ORIGINAL AJUSTADO:
    // Antes esperava "OK" e depois apenas "Servidor Web Online".
    // Agora espera a mensagem completa com servidor web e banco de dados.
    @Test
    void shouldReturnServidorWebAndDatabaseOnlineWhenLivenessEndpointIsCalled() throws Exception {
        mockMvc.perform(get("/health-check/liveness"))
                .andExpect(status().isOk())
                .andExpect(content().string("Servidor Web Online | conexao com banco de dados efetuada com sucesso"));
    }

    // NOVO TESTE:
    // Valida se o endpoint do banco consegue executar SELECT 1 no MySQL/MariaDB do XAMPP.
    @Test
    void shouldReturnDatabaseSuccessWhenDatabaseEndpointIsCalled() throws Exception {
        mockMvc.perform(get("/health-check/database"))
                .andExpect(status().isOk())
                .andExpect(content().string("conexao com banco de dados efetuada com sucesso"));
    }

    // NOVO TESTE:
    // Valida a rota geral que informa servidor web online e banco conectado.
    @Test
    void shouldReturnGeneralStatusWhenAllServicesAreOnline() throws Exception {
        mockMvc.perform(get("/health-check/status"))
                .andExpect(status().isOk())
                .andExpect(content().string("Servidor Web Online | conexao com banco de dados efetuada com sucesso"));
    }

    // NOVO TESTE:
    // Simula uma falha no banco e confirma se o controller informa qual servico nao esta funcionando.
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
