# Acesso ao MCP

O Meelion MCP usa **JSON-RPC 2.0** sobre **HTTP POST** (`Content-Type: application/json`). O nível de **acesso a dados** (público, autenticado, completo vs. redigido) depende da **configuração do servidor** e de **política de produto** (plano, *gate*, *preview*).

## Endpoint

```text
POST https://mcp.meelion.com/
Content-Type: application/json
```

(Ajuste o host conforme o ambiente.)

## Dois eixos: autenticação e modo Pro

1. **Modo de implantação** (`MCP.meelion_pro` no *backend*): controla padrões de `limit` em `get_best_investments`, se rankings curtos forçam CTA para o site, e se a API exige análise de *Bearer*. Resumo: [mcp-modes.md](mcp-modes.md).

2. **Identidade do cliente** (opcional em alguns *deploys*):
   - **Sem `Authorization`**: acesso de leitor público, com possíveis **redações** (campos líquidos, listas longas) conforme o servidor.
   - **`Authorization: Bearer <token>`** (quando o modo Pro está ativo): o token identifica um usuário; o servidor pode expor **dados completos** se o *feature gate* **mcp_full_data_access** (ou equivalente) for concedido a esse usuário.
   - Token inválido ou em falta quando a política exige: resposta de erro apropriada (ex. **401** e cabeçalho `WWW-Authenticate` com *realm* `meelion-mcp` em implementações que sigam a API HTTP do projeto).

> Em **modo aberto** (`meelion_pro = 0`), a documentação de *preview* muitas vezes descreve acesso **sem** credenciais, com amostra curta de listagens; confirme no *deploy* real.

## O que a API pode retornar (visão geral)

- **Indicadores e cotações** formatados.
- **Rankings** de renda fixa; **fichas** de produto; **`updatedAt`** nos payloads.
- Metadado **`access`** (ou similares) a indicar se houve *tier* de dados.
- **URLs** do site: sempre a base pública (por padrão `https://www.meelion.com`), nunca o host *mcp* para páginas humanas — ver [mcp-modes.md](mcp-modes.md) § Links.

## Boas práticas

- Só `POST` com corpo JSON válido; trate erres JSON-RPC (`error.code`, `error.message`).
- Não trate a saída como **recomendação** ou **assessoria**; não envie PII desnecessária nos *arguments*.
- *Cache* no cliente quando fizer sentido; respeite a volatilidade de taxas e cotações.

## Segurança e reporte

Questões de segurança: [../SECURITY.md](../SECURITY.md) (e-mail de contato, sem *secrets* em *issues* públicas).
