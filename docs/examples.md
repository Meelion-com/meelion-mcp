# Exemplos De Uso

## Inicializar Sessão MCP

```bash
curl -X POST https://mcp.meelion.com/ \
  -H "Content-Type: application/json" \
  -d '{
    "jsonrpc": "2.0",
    "id": 1,
    "method": "initialize",
    "params": {}
  }'
```

## Listar Tools

```bash
curl -X POST https://mcp.meelion.com/ \
  -H "Content-Type: application/json" \
  -d '{
    "jsonrpc": "2.0",
    "id": 2,
    "method": "tools/list",
    "params": {}
  }'
```

## Melhores Investimentos Sem Token

```bash
curl -X POST https://mcp.meelion.com/ \
  -H "Content-Type: application/json" \
  -d '{
    "jsonrpc": "2.0",
    "id": 3,
    "method": "tools/call",
    "params": {
      "name": "get_best_investments",
      "arguments": {
        "investment_types": ["CDB"],
        "limit": 5
      }
    }
  }'
```

## Melhores Investimentos Com Token Premium

```bash
curl -X POST https://mcp.meelion.com/ \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $MEELION_MCP_API_KEY" \
  -d '{
    "jsonrpc": "2.0",
    "id": 4,
    "method": "tools/call",
    "params": {
      "name": "get_best_investments",
      "arguments": {
        "investment_types": ["CDB", "LCI"],
        "distributors": ["XP Investimentos", "Banco Inter"],
        "prazo": "prazo-ate-1-ano",
        "limit": 10
      }
    }
  }'
```

