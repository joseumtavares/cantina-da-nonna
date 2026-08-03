package br.com.nona_back;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

// Criado por Jose Tavares, tomando como referência a estrutura da aula do professor Gabriel Carvalho.
// Esta é a porta de entrada do Spring Boot: IntelliJ, VS Code e Maven iniciam o back-end por aqui.
@SpringBootApplication
public class NonaBackApplication {

    public static void main(String[] args) {
        SpringApplication.run(NonaBackApplication.class, args);
    }
}
