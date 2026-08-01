package br.com.nona_back.controllers;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc;
import org.springframework.test.web.servlet.MockMvc;

import static org.hamcrest.Matchers.containsString;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

// Criado por Jose Tavares.
// Referencia da aula: SENAC_back/src/main/java/br/com/nonna/controllers/ProdutoController.java
//
// Este teste confirma se a rota /produtos passa por Controller -> Service -> Repository
// e devolve produtos vindos do banco em formato JSON.
@SpringBootTest
@AutoConfigureMockMvc
class ProdutoControllerTest {

    // MockMvc simula uma chamada HTTP sem precisar abrir navegador.
    @Autowired
    private MockMvc mockMvc;

    @Test
    void shouldReturnProductsFromDatabaseWhenProdutosEndpointIsCalled() throws Exception {
        mockMvc.perform(get("/produtos"))
                .andExpect(status().isOk())
                .andExpect(content().string(containsString("nome")))
                .andExpect(content().string(containsString("preco")))
                .andExpect(content().string(containsString("categoria")));
    }
}