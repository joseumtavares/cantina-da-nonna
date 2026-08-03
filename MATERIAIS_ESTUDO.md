# Materiais de estudo - Cantina da Nonna

Este arquivo organiza os materiais de leitura, pratica e consulta usados durante os estudos da Cantina da Nonna. A ordem abaixo acompanha o caminho que fez mais sentido no projeto: primeiro entender a web, depois HTML, CSS, Bootstrap, JavaScript, Git, Java, Spring Boot e banco de dados.

Nem todo link precisa ser estudado de uma vez. Alguns sao para aula, outros sao para consulta rapida, e alguns ficam melhor quando revisitados depois de praticar um pouco.

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

- [1. Fundamentos da web](#1-fundamentos-da-web)
- [2. HTML](#2-html)
- [3. CSS](#3-css)
- [4. CSS com jogos e pratica guiada](#4-css-com-jogos-e-pratica-guiada)
- [5. Bootstrap e bibliotecas de interface](#5-bootstrap-e-bibliotecas-de-interface)
- [6. JavaScript](#6-javascript)
- [7. Git](#7-git)
- [8. Java](#8-java)
- [9. Spring Boot](#9-spring-boot)
- [10. Banco de dados e ferramentas](#10-banco-de-dados-e-ferramentas)
- [11. Leituras para evoluir depois](#11-leituras-para-evoluir-depois)
- [12. Como usar esta trilha](#12-como-usar-esta-trilha)

## 1. Fundamentos da web

Antes de entrar nas tags e nos estilos, vale entender como a web funciona por baixo: navegador, servidor, protocolo, padroes e documentacao oficial.

- [Video: How Does the Internet Work?](https://www.youtube.com/watch?v=TNQsmPf24go) - bom para abrir a conversa sobre internet, servidores e navegadores.
- [W3C](https://www.w3.org/) - organizacao que participa da criacao e manutencao de padroes da web.
- [HTML Living Standard - WHATWG](https://html.spec.whatwg.org/) - especificacao tecnica viva do HTML.

## 2. HTML

Comece pelo basico e depois use as referencias oficiais quando tiver duvida sobre uma tag especifica.

- [W3Schools HTML Tutorial](https://www.w3schools.com/html/) - bom para primeiro contato, exemplos rapidos e exercicios.
- [MDN: elemento `p`](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/p) - exemplo de como consultar uma tag HTML com mais profundidade.
- [HTML Living Standard - WHATWG](https://html.spec.whatwg.org/) - referencia tecnica completa para estudar quando quiser entender o comportamento real do HTML.

Ordem sugerida nesta fase:

1. Estrutura basica com `html`, `head` e `body`.
2. Titulos, paragrafos, listas e links.
3. Imagens, tabelas e formularios.
4. Semantica com `header`, `nav`, `main`, `section`, `article` e `footer`.
5. Validacao e organizacao do codigo.

## 3. CSS

Depois do HTML, o CSS entra para controlar cores, fontes, espacamentos, layout e responsividade.

- [CSS-Tricks Guides](https://css-tricks.com/guides/) - guias visuais e explicacoes praticas sobre CSS.
- [Josh W. Comeau](https://www.joshwcomeau.com/) - artigos muito bons para entender CSS moderno, animacoes, layouts e detalhes de interface.

Ordem sugerida nesta fase:

1. Seletores, classes e ids.
2. Cores, fontes, margens, bordas e espacamentos.
3. Box model.
4. Flexbox.
5. Grid Layout.
6. Responsividade.
7. Organizacao de arquivos CSS.

## 4. CSS com jogos e pratica guiada

Estes jogos ajudam a treinar sem deixar o estudo pesado. A ordem abaixo vai do mais basico para layouts mais completos.

- [CSS Diner](https://flukeout.github.io/) - jogo para praticar seletores CSS.
- [Flexbox Froggy](https://flexboxfroggy.com/) - jogo para aprender alinhamento com Flexbox.
- [Flexbox Defense](http://www.flexboxdefense.com/) - jogo para reforcar Flexbox com outro tipo de desafio.
- [CSS Grid Garden](https://cssgridgarden.com/) - jogo para aprender CSS Grid.

## 5. Bootstrap e bibliotecas de interface

Quando HTML e CSS ja comecam a fazer sentido, frameworks ajudam a ganhar velocidade e padronizar telas.

- [Bootstrap](https://getbootstrap.com/) - usado no projeto para containers, grid, cards, botoes, formularios e navbar responsiva.
- [daisyUI](https://daisyui.com/) - biblioteca de componentes para Tailwind CSS; fica como referencia para comparar estilos e componentes.
- [Material UI: How to customize](https://mui.com/material-ui/customization/how-to-customize/) - referencia para entender customizacao em bibliotecas de componentes mais robustas.

Ordem sugerida nesta fase:

1. Containers.
2. Grid responsivo.
3. Botoes e formularios.
4. Navbar.
5. Cards.
6. Ajustes visuais e responsividade.

## 6. JavaScript

Esta fase esta em andamento no nivelamento da turma pela FreeCodeCamp. A prioridade agora e consolidar logica, variaveis, funcoes, arrays, objetos e manipulacao basica.

- [freeCodeCamp](https://www.freecodecamp.org/) - curso atual de nivelamento em JavaScript e base de pratica continua.
- [CheckiO](https://checkio.org/) - desafios de programacao para treinar logica.
- [CodeCombat](https://codecombat.com/) - jogo de programacao que ajuda a treinar logica de forma mais visual.

Ordem sugerida nesta fase:

1. Variaveis e tipos de dados.
2. Condicionais.
3. Loops.
4. Funcoes.
5. Arrays e objetos.
6. Manipulacao do DOM.
7. Eventos.
8. Consumo de API, quando a base estiver mais firme.

## 7. Git

Git deve ser praticado junto com o projeto, porque ele acompanha qualquer mudanca real de codigo.

- [Learn Git Branching](https://learngitbranching.js.org/?locale=pt_BR) - jogo em portugues para praticar commits, branches, merge e rebase.

Ordem sugerida nesta fase:

1. `git status`.
2. `git add`.
3. `git commit`.
4. `git log`.
5. `git push`.
6. Branches e merges.

## 8. Java

Java entra como base para o back-end do projeto. Aqui o foco e entender a linguagem antes de depender do Spring Boot.

- [Oracle Java Downloads](https://www.oracle.com/br/java/technologies/downloads/) - pagina oficial de downloads Java da Oracle.
- [Amazon Corretto 25 no GitHub](https://github.com/corretto/corretto-25) - referencia do JDK usado no projeto atualmente.

Ordem sugerida nesta fase:

1. Instalar JDK localmente.
2. Entender classe, metodo `main` e pacotes.
3. Tipos, variaveis e operadores.
4. Condicionais e repeticoes.
5. Classes, objetos, atributos e metodos.
6. Listas e colecoes.
7. Tratamento de erros.

## 9. Spring Boot

Depois da base de Java, o Spring Boot organiza a API, as rotas, a injecao de dependencias e a comunicacao com o banco.

- [Spring Boot](https://spring.io/projects/spring-boot) - pagina oficial do projeto Spring Boot.
- [Spring Initializr](https://start.spring.io/) - ferramenta para criar projetos Spring Boot com dependencias iniciais.

Ordem sugerida nesta fase:

1. Entender `Controller`.
2. Entender `Service`.
3. Entender `Repository`.
4. Criar endpoints simples.
5. Conectar com banco via JDBC.
6. Criar testes basicos.
7. Separar perfis `local` e `supabase`.

## 10. Banco de dados e ferramentas

Nesta etapa entram banco local, cliente visual, drivers e banco em nuvem.

- [DBeaver Community Download](https://dbeaver.io/download/) - ferramenta visual para conectar em bancos como MySQL, MariaDB e PostgreSQL.
- [Supabase](https://supabase.com/) - plataforma usada como banco PostgreSQL em nuvem para publicacao futura.
- [PostgreSQL JDBC Driver](https://jdbc.postgresql.org/) - driver JDBC usado para conectar Java/Spring Boot ao PostgreSQL/Supabase.

Ordem sugerida nesta fase:

1. Criar banco local no XAMPP.
2. Entender tabelas, colunas e chave primaria.
3. Rodar scripts SQL.
4. Conectar pelo DBeaver.
5. Conectar o Spring Boot no banco local.
6. Criar perfil Supabase.
7. Proteger senhas com variaveis de ambiente.

## 11. Leituras para evoluir depois

Estes materiais ficam melhores depois que a base de HTML, CSS, JavaScript e back-end ja estiver mais confortavel.

- [Patterns.dev Book](https://www.patterns.dev/book/) - leitura sobre padroes de arquitetura, componentes e desenvolvimento web moderno.
- [Josh W. Comeau](https://www.joshwcomeau.com/) - tambem vale revisitar depois para aprofundar CSS, animacoes e detalhes de front-end.
- [CSS-Tricks Guides](https://css-tricks.com/guides/) - bom para revisao e consulta quando surgirem problemas reais de layout.

## 12. Como usar esta trilha

Sugestao pratica para estudar sem se perder:

1. Leia um pequeno bloco.
2. Faca um exemplo no projeto.
3. Comente o codigo com uma explicacao curta.
4. Teste no navegador ou no terminal.
5. Registre no Git quando a mudanca estiver funcionando.

O objetivo nao e decorar todos os links. O objetivo e saber onde procurar, praticar no projeto e voltar aos materiais quando aparecer uma duvida real.

[Voltar ao topo](#materiais-de-estudo---cantina-da-nonna)