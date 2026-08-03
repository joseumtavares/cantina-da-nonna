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

// Criado por Jose Tavares, acompanhando a estrutura do ProdutoController estudada em aula.
// O teste protege o fluxo Controller -> Service -> Repository e confirma que a API devolve JSON útil ao front-end.
@SpringBootTest
@AutoConfigureMockMvc
class ProdutoControllerTest {

    // MockMvc simula requisições HTTP sem abrir navegador nem subir um servidor manualmente.
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
