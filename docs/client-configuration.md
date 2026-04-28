# Configuração de clientes MCP

Este documento mostra como apontar clientes MCP para o endpoint público da Meelion.

## URL do serviço MCP

```text
https://mcp.meelion.com/
```

Esta é a URL para chamadas MCP via HTTP/JSON-RPC, como `initialize`, `tools/list` e `tools/call`. Ela não é a página inicial para usuários; links de comparador e ficha de produto retornados no JSON apontam para [https://www.meelion.com](https://www.meelion.com/).

## Exemplo genérico

Alguns clientes aceitam configuração HTTP direta:

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

## Claude Desktop

Para servidores MCP remotos, a recomendação atual do Claude Desktop é cadastrar o endpoint em **Settings > Connectors / Custom Connectors**, usando:

```text
https://mcp.meelion.com/
```

Se você estiver usando `claude_desktop_config.json`, use um bridge local como `mcp-remote`:

```json
{
  "mcpServers": {
    "meelion": {
      "command": "cmd",
      "args": [
        "/c",
        "npx",
        "-y",
        "mcp-remote@latest",
        "https://mcp.meelion.com/",
        "--transport",
        "http-only"
      ]
    }
  }
}
```

Depois de alterar o arquivo, feche e abra novamente o Claude Desktop.

## Chamada direta com curl

```bash
curl -X POST https://mcp.meelion.com/ \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}'
```

## Variável de ambiente para scripts

```bash
export MEELION_MCP_URL="https://mcp.meelion.com/"
```

O arquivo `examples/curl.sh` usa `MEELION_MCP_URL` com o mesmo padrão.

## Descoberta em marketplaces de tools

- **Nome:** Meelion MCP
- **Domínio API:** `mcp.meelion.com`
- **Site para usuários:** [https://www.meelion.com](https://www.meelion.com/)
- **Categorias sugeridas:** finanças, Brasil, renda fixa, câmbio, investimentos
- **Integração:** Model Context Protocol, JSON-RPC, ferramentas listadas em [tools.md](tools.md)

## Autenticação

Neste momento, o endpoint público funciona sem autenticação. Não é necessário enviar API key ou Bearer token; ver [authentication.md](authentication.md).
