package br.com.nona_back;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

// Criado por Jose Tavares.
// Referencia da aula: SENAC_back/src/main/java/br/com/nonna/NonnaApplication.java
//
// Classe principal da aplicacao Spring Boot.
// E por aqui que IntelliJ, VS Code ou Maven iniciam o backend.
@SpringBootApplication
public class NonaBackApplication {

    public static void main(String[] args) {
        SpringApplication.run(NonaBackApplication.class, args);
    }
}