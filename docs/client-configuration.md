# Configuração de clientes MCP

Este documento mostra como usar o endpoint público da Meelion em clientes compatíveis com MCP remoto.

## URL do serviço MCP

```text
https://mcp.meelion.com/
```

Esta é a URL para chamadas MCP via HTTP/JSON-RPC, como `initialize`, `tools/list` e `tools/call`. Ela não é a página inicial para usuários; links de comparador e ficha de produto retornados no JSON apontam para [https://www.meelion.com](https://www.meelion.com/).

## Claude Desktop

No **Claude Desktop**, use o recurso de conectores remotos:

```text
Settings > Connectors > Custom Connectors
```

Cadastre a URL:

```text
https://mcp.meelion.com/
```

Depois de salvar, o Claude Desktop deve listar as ferramentas da Meelion:

- `get_financial_indicators`
- `get_quotes`
- `get_best_investments`
- `get_investment_details`

Observação: o arquivo `claude_desktop_config.json` é voltado principalmente a servidores MCP locais via `command`/`args`, como pacotes Python ou Node rodando por stdio. Para o Meelion MCP, que é um servidor remoto HTTP, o fluxo recomendado é usar **Custom Connectors**.

## Claude Code

Quando o cliente aceitar MCP remoto HTTP, use a configuração abaixo:

```json
{
  "mcpServers": {
    "meelion": {
      "type": "http",
      "url": "https://mcp.meelion.com/"
    }
  }
}
```

Se estiver usando comandos do Claude Code para adicionar MCPs, use o equivalente a um servidor remoto HTTP apontando para:

```text
https://mcp.meelion.com/
```

## Testar Com Inspector

Você pode validar a listagem das ferramentas com o Inspector oficial:

```bash
npx -y @modelcontextprotocol/inspector \
  --cli https://mcp.meelion.com/ \
  --transport http \
  --method tools/list
```

## Chamada Direta Com Curl

```bash
curl -X POST https://mcp.meelion.com/ \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}'
```

## Variável De Ambiente Para Scripts

```bash
export MEELION_MCP_URL="https://mcp.meelion.com/"
```

O arquivo `examples/curl.sh` usa `MEELION_MCP_URL` com o mesmo padrão.

## Descoberta Em Marketplaces De Tools

- **Nome:** Meelion MCP
- **Domínio API:** `mcp.meelion.com`
- **Site para usuários:** [https://www.meelion.com](https://www.meelion.com/)
- **Categorias sugeridas:** finanças, Brasil, renda fixa, câmbio, investimentos
- **Integração:** Model Context Protocol, JSON-RPC, ferramentas listadas em [tools.md](tools.md)

## Autenticação

Neste momento, o endpoint público funciona sem autenticação. Não é necessário enviar API key ou Bearer token; ver [authentication.md](authentication.md).
