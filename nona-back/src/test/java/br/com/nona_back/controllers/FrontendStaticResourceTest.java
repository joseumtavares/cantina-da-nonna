package br.com.nona_back.controllers;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.forwardedUrl;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

// Criado por Jose Tavares para proteger a limpeza da rota temporaria de desenvolvimento.
// O front-end deve abrir pela raiz, servido como arquivo estatico pelo Spring Boot.
@SpringBootTest
@AutoConfigureMockMvc
class FrontendStaticResourceTest {

    // MockMvc permite testar a rota raiz sem abrir navegador durante a verificacao automatizada.
    @Autowired
    private MockMvc mockMvc;

    @Test
    void shouldServeIndexHtmlFromStaticFrontendWhenRootIsCalled() throws Exception {
        mockMvc.perform(get("/"))
                .andExpect(status().isOk())
                .andExpect(forwardedUrl("index.html"));
    }

    @Test
    void shouldNotServeOldLocalFolderShortcut() throws Exception {
        mockMvc.perform(get("/dev/nonna/nona-front"))
                .andExpect(status().isNotFound());
    }
}