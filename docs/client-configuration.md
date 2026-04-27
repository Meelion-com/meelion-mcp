# Configuração De Clientes MCP

Este repositório documenta o endpoint remoto do Meelion MCP:

```text
https://mcp.meelion.com/
```

Cada cliente MCP pode usar nomes diferentes para configurar servidores remotos. Quando houver suporte a MCP remoto via HTTP, use:

- URL: `https://mcp.meelion.com/`
- Transport: HTTP
- Header opcional: `Authorization: Bearer <sua_api_key>`

## Exemplo Genérico

```json
{
  "mcpServers": {
    "meelion": {
      "type": "http",
      "url": "https://mcp.meelion.com/",
      "headers": {
        "Authorization": "Bearer ${MEELION_MCP_API_KEY}"
      }
    }
  }
}
```

## Sem API Key

Para uso público, omita o header `Authorization`.

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

