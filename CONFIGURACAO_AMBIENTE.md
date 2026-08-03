# Configuracao do ambiente - Cantina da Nonna

Este guia existe para deixar claro como preparar o computador para rodar a Cantina da Nonna sem depender de tentativa e erro. A ideia e simples: o mesmo projeto deve abrir bem no Visual Studio Code, no IntelliJ IDEA e no terminal.

## Navegacao

- [Visao geral do projeto](README.md)
- [Padrao de desenvolvimento](PADRAO_DESENVOLVIMENTO.md)
- [Configuracao do ambiente](CONFIGURACAO_AMBIENTE.md)
- [Materiais de estudo](MATERIAIS_ESTUDO.md)
- [Documentacao tecnica](DOCUMENTACAO_TECNICA.md)
- [Configuracao do Supabase](SUPABASE.md)
- [Notas rapidas de continuidade](AGENTS.md)
- [README do front-end](nona-front/README.md)

## Nesta pagina

- [1. O que precisa estar instalado](#1-o-que-precisa-estar-instalado)
- [1.1. Java 25 local para o VS Code](#11-java-25-local-para-o-vs-code)
- [2. Perfil do IntelliJ IDEA](#2-perfil-do-intellij-idea)
- [3. Perfil do Visual Studio Code](#3-perfil-do-visual-studio-code)
- [4. Configuracao do XAMPP](#4-configuracao-do-xampp)
- [5. Rodando pelo IntelliJ IDEA](#5-rodando-pelo-intellij-idea)
- [6. Rodando pelo Visual Studio Code](#6-rodando-pelo-visual-studio-code)
- [7. Rodando pelo terminal](#7-rodando-pelo-terminal)
- [8. Testes rapidos depois de subir o sistema](#8-testes-rapidos-depois-de-subir-o-sistema)
- [9. Problemas comuns](#9-problemas-comuns)
- [10. Referencias oficiais usadas](#10-referencias-oficiais-usadas)

## 1. O que precisa estar instalado

Instale estes itens antes de rodar o projeto:

- Git
- Java 25, preferencialmente Amazon Corretto 25
- IntelliJ IDEA
- Visual Studio Code
- XAMPP, usando MySQL/MariaDB na porta `3306`

O Maven nao precisa ser instalado separadamente, porque o projeto usa Maven Wrapper:

```text
nona-back/mvnw.cmd
```

### 1.1. Java 25 local para o VS Code

Para rodar pelo Visual Studio Code, nao basta instalar as extensoes Java. O computador tambem precisa ter o JDK instalado localmente.

Neste projeto, o padrao atual e:

```text
Amazon Corretto 25
```

No Windows:

1. Baixe o instalador `.msi` do Amazon Corretto 25.
2. Execute o instalador e conclua a instalacao.
3. Configure a variavel de ambiente `JAVA_HOME` apontando para a pasta do JDK instalado.
4. Adicione `%JAVA_HOME%\bin` ao `PATH` do Windows.
5. Feche e abra novamente o terminal ou o VS Code.
6. Rode o comando abaixo para confirmar:

```powershell
java --version
```

A resposta deve mostrar Java 25 e Amazon Corretto. Se esse comando nao funcionar no terminal, o VS Code tambem nao conseguira rodar o back-end corretamente.

## 2. Perfil do IntelliJ IDEA

O IntelliJ trabalha com dois tipos de configuracao:

- configuracao pessoal da IDE, como tema, atalhos, fontes, conta JetBrains e conta GitHub;
- configuracao do projeto, como JDK, Maven e plugins obrigatorios.

No Git, versionamos apenas a parte do projeto. Isso evita colocar no repositorio qualquer dado pessoal da sua maquina.

### 2.1. Perfil versionado no projeto

O arquivo usado pelo IntelliJ para avisar sobre plugins obrigatorios fica aqui:

```text
.idea/externalDependencies.xml
```

No projeto Cantina da Nonna, esse arquivo registra os plugins necessarios para abrir e rodar o back-end Java/Maven:

- Java
- Maven

Esses dois plugins sao suficientes para importar o `pom.xml`, compilar o projeto, rodar testes e iniciar a classe `NonaBackApplication`.

### 2.2. Plugins recomendados no IntelliJ

Para uma experiencia melhor, mantenha habilitados:

- Java
- Maven
- Git
- GitHub
- Spring, quando estiver usando IntelliJ IDEA Ultimate
- Spring Boot, quando estiver usando IntelliJ IDEA Ultimate
- Database Tools and SQL, quando quiser consultar o banco pela propria IDE

Spring e Spring Boot ajudam bastante, mas nao devem ser tratados como obrigatorios neste projeto, porque o objetivo e manter compatibilidade tambem com ambientes mais simples.

### 2.3. Como salvar manualmente um perfil pessoal do IntelliJ

Quando quiser guardar suas preferencias pessoais do IntelliJ em um arquivo ZIP:

1. Abra o IntelliJ IDEA.
2. Clique em `File`.
3. Acesse `Manage IDE Settings`.
4. Clique em `Export Settings`.
5. Escolha os itens que deseja exportar.
6. Salve o ZIP fora do Git, por exemplo em uma pasta pessoal de backups.

Cuidado: esse ZIP pode incluir configuracoes pessoais. Antes de compartilhar, confira se ele nao leva contas, tokens, servidores, senhas ou caminhos privados.

### 2.4. Como configurar plugins obrigatorios pelo IntelliJ

Se quiser editar a lista pela propria IDE:

1. Abra o projeto pela raiz `nonna`.
2. Pressione `Ctrl + Alt + S`.
3. Acesse `Appearance & Behavior`.
4. Abra `Required Plugins`.
5. Adicione os plugins realmente necessarios.
6. Clique em `Apply` e depois em `OK`.

O IntelliJ salva essa lista em `.idea/externalDependencies.xml`.

## 3. Perfil do Visual Studio Code

O projeto ja possui dois arquivos de perfil do VS Code na raiz:

```text
extensions-visual-studio-java.code-profile
java.code-profile
```

Tambem existe um arquivo com extensoes recomendadas para o back-end:

```text
nona-back/.vscode/extensions.json
```

As extensoes recomendadas ate agora sao:

- Extension Pack for Java
- Maven for Java
- Spring Boot Extension Pack
- Spring Boot Tools
- Spring Boot Dashboard
- Spring Initializr Java Support

Importante: essas extensoes ajudam o VS Code a trabalhar com Java, mas elas nao substituem o JDK instalado no computador. Primeiro instale o Amazon Corretto 25, depois importe o perfil ou aceite as recomendacoes.

Para importar um perfil no VS Code:

1. Abra o Visual Studio Code.
2. Acesse `File > Preferences > Profiles`.
3. Clique em `Import Profile`.
4. Escolha um dos arquivos `.code-profile` da raiz do projeto.
5. Confirme a importacao e deixe o VS Code instalar as extensoes.

Para usar as recomendacoes do projeto:

1. Abra a raiz `nonna` no VS Code.
2. Entre na aba de extensoes.
3. Aceite as recomendacoes exibidas pelo arquivo `extensions.json`.

## 4. Configuracao do XAMPP

O perfil local usa MySQL/MariaDB pelo XAMPP.

### 4.1. Subir o banco

1. Abra o XAMPP Control Panel.
2. Inicie o servico `MySQL`.
3. Confirme que ele esta usando a porta `3306`.
4. Se quiser usar o phpMyAdmin, inicie tambem o `Apache`.

O Apache nao e necessario para o Spring Boot. Ele so ajuda se voce quiser abrir o phpMyAdmin pelo navegador.

### 4.2. Criar o banco local

No phpMyAdmin ou em um cliente SQL, crie o banco:

```sql
CREATE DATABASE IF NOT EXISTS `nona-db`
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;
```

O projeto esta configurado para usar por padrao:

```text
host: 127.0.0.1
porta: 3306
banco: nona-db
usuario: root
senha: vazia
```

Se o seu MySQL tiver senha, nao altere o codigo. Use variaveis de ambiente:

```powershell
$env:DB_USERNAME="root"
$env:DB_PASSWORD="SUA_SENHA_LOCAL"
```

### 4.3. Tabelas e dados iniciais

No perfil local, o Spring Boot executa automaticamente:

```text
nona-back/src/main/resources/db/schema.sql
nona-back/src/main/resources/db/data.sql
```

Por isso, depois de criar o banco `nona-db`, basta iniciar o back-end. As tabelas e os dados iniciais sao preparados pela aplicacao.

## 5. Rodando pelo IntelliJ IDEA

1. Abra o IntelliJ IDEA.
2. Clique em `File > Open`.
3. Selecione a pasta raiz:

```text
C:\Users\Jose Tavares\Desktop\dev\nonna
```

4. Confirme que existe apenas um mapeamento Git para a raiz `nonna`.
5. Aguarde o IntelliJ importar o Maven pelo arquivo:

```text
nona-back/pom.xml
```

6. Abra `File > Project Structure`.
7. Em `Project SDK`, selecione `corretto-25` ou outro JDK 25 instalado.
8. Abra a classe:

```text
nona-back/src/main/java/br/com/nona_back/NonaBackApplication.java
```

9. Clique no botao de executar ao lado da classe ou do metodo `main`.

Para rodar com XAMPP, nenhuma variavel e obrigatoria se o banco estiver com usuario `root` e senha vazia.

Para rodar com Supabase, use as variaveis explicadas em [SUPABASE.md](SUPABASE.md).

## 6. Rodando pelo Visual Studio Code

1. Confirme que o Amazon Corretto 25 esta instalado localmente.
2. No terminal do VS Code, rode `java --version` e confirme que aparece Java 25.
3. Abra a pasta raiz `nonna`.
4. Instale as extensoes recomendadas ou importe um dos perfis `.code-profile`.
5. Confirme que o XAMPP esta com `MySQL` ativo.
6. Abra a aba `Run and Debug`.
7. Selecione:

```text
Spring Boot-NonaBackApplication<nona-back>
```

8. Clique em executar.

O arquivo `nona-back/.vscode/launch.json` ja contem as variaveis locais para o banco XAMPP:

```text
DB_URL
DB_USERNAME
DB_PASSWORD
```

## 7. Rodando pelo terminal

No PowerShell:

```powershell
cd C:\Users\Jose Tavares\Desktop\dev\nonna\nona-back
.\mvnw.cmd spring-boot:run
```

Para rodar os testes:

```powershell
cd C:\Users\Jose Tavares\Desktop\dev\nonna\nona-back
.\mvnw.cmd test
```

Para forcar o perfil local:

```powershell
.\mvnw.cmd "-Dspring.profiles.active=local" spring-boot:run
```

Para forcar o perfil Supabase:

```powershell
.\mvnw.cmd "-Dspring.profiles.active=supabase" spring-boot:run
```

## 8. Testes rapidos depois de subir o sistema

Com o back-end rodando, abra no navegador:

```text
http://localhost:8080/
http://localhost:8080/health-check/liveness
http://localhost:8080/health-check/database
http://localhost:8080/health-check/status
http://localhost:8080/produtos
```

Respostas esperadas:

```text
Servidor Web Online
conexao com banco de dados efetuada com sucesso
```

O site deve abrir em:

```text
http://localhost:8080/
```

Nao use `/public` na URL. O Spring Boot ja entrega `nona-front/public` como raiz do site.

## 9. Problemas comuns

### 9.1. Porta 3306 ocupada

Se o MySQL do XAMPP nao iniciar, veja se outro MySQL ja esta usando a porta `3306`.

### 9.2. Porta 8080 ocupada

Se o Spring Boot nao subir, veja se outra aplicacao ja esta usando a porta `8080`.

### 9.3. IntelliJ mostra dois repositarios Git

Deixe apenas o mapeamento da raiz:

```text
C:\Users\Jose Tavares\Desktop\dev\nonna
```

Remova mapeamentos separados para `nona-back` ou `nona-front`, porque o Git correto fica na raiz do projeto.

### 9.4. Erro de JDK

Confirme que o projeto esta usando JDK 25. No IntelliJ, veja `File > Project Structure`. No terminal, rode:

```powershell
java --version
```

### 9.5. Erro de banco

Confira:

- se o MySQL do XAMPP esta ativo;
- se o banco `nona-db` existe;
- se usuario e senha batem com a configuracao;
- se o perfil ativo e `local` para XAMPP ou `supabase` para Supabase.

## 10. Referencias oficiais usadas

- [JetBrains: instalar e gerenciar plugins no IntelliJ IDEA](https://www.jetbrains.com/help/idea/managing-plugins.html)
- [JetBrains: backup, sincronizacao, exportacao e importacao de configuracoes da IDE](https://www.jetbrains.com/help/idea/sharing-your-ide-settings.html)
- [JetBrains: suporte Maven no IntelliJ IDEA](https://www.jetbrains.com/help/idea/maven-support.html)
- [JetBrains: suporte Spring Boot no IntelliJ IDEA](https://www.jetbrains.com/help/idea/spring-boot.html)
- [Amazon Corretto 25: downloads oficiais](https://docs.aws.amazon.com/corretto/latest/corretto-25-ug/downloads-list.html)
- [Amazon Corretto 25: instalacao no Windows](https://docs.aws.amazon.com/corretto/latest/corretto-25-ug/windows-install.html)

[Voltar ao topo](#configuracao-do-ambiente---cantina-da-nonna)