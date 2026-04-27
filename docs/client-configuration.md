# Configuração De Clientes MCP

Este repositório documenta o endpoint remoto do Meelion MCP:

```text
https://mcp.meelion.com/
```

Cada cliente MCP pode usar nomes diferentes para configurar servidores remotos. Quando houver suporte a MCP remoto via HTTP, use:

- URL: `https://mcp.meelion.com/`
- Transport: HTTP
- Autenticação: não necessária durante o preview público

## Exemplo Genérico

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

## Chamada Direta

```bash
curl -X POST https://mcp.meelion.com/ \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}'
```
