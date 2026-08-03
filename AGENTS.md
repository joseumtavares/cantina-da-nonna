# Notas rápidas para continuidade

Este arquivo é curto de propósito. Ele serve como primeiro lembrete antes de mexer na Cantina da Nonna, principalmente quando alguém abre o projeto depois de algum tempo sem acompanhar o histórico.

Antes de alterar código ou configuração, leia estes arquivos na raiz do repositório:

1. `README.md`
2. `PADRAO_DESENVOLVIMENTO.md`
3. `DOCUMENTACAO_TECNICA.md`
4. `SUPABASE.md`, quando a mudança envolver banco em nuvem

Pontos que não devem ser esquecidos:

- Preserve a arquitetura MVC do back-end.
- Mantenha o projeto compatível com VS Code e IntelliJ IDEA.
- Use comentários apenas quando eles explicarem intenção, regra ou contexto.
- Não coloque SQL em Controller nem regra de negócio em Repository.
- Não adicione dependências ou refatorações grandes sem necessidade real.
- Não envie senhas, tokens, chaves ou arquivos `.env` reais para o Git.
- Rode os testes Maven quando mexer em Java, Spring, banco ou configuração.
- Atualize a documentação quando mudar arquitetura, API, banco, instalação, deploy ou regra importante.
- Mantenha apenas um repositório Git na raiz `nonna`.

A regra simples é: cada alteração deve deixar o projeto mais claro do que estava antes.