# Exemplos De Uso

Os exemplos abaixo usam JSON-RPC, o formato esperado pelo endpoint MCP remoto da Meelion.

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

## Listar Tools Disponíveis

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

## Consultar Indicadores Financeiros

Perguntas que uma IA poderia responder com este exemplo:

- "Qual é a Selic?"
- "Quais indicadores financeiros estão disponíveis?"
- "Mostre um panorama rápido dos principais indicadores."

```bash
curl -X POST https://mcp.meelion.com/ \
  -H "Content-Type: application/json" \
  -d '{
    "jsonrpc": "2.0",
    "id": 3,
    "method": "tools/call",
    "params": {
      "name": "get_financial_indicators",
      "arguments": {}
    }
  }'
```

## Consultar Cotações

```bash
curl -X POST https://mcp.meelion.com/ \
  -H "Content-Type: application/json" \
  -d '{
    "jsonrpc": "2.0",
    "id": 4,
    "method": "tools/call",
    "params": {
      "name": "get_quotes",
      "arguments": {
        "assets": ["DOLAR", "EURO", "BTC"]
      }
    }
  }'
```

## Melhores Investimentos

Este exemplo busca CDBs disponíveis nos dados da Meelion.

```bash
curl -X POST https://mcp.meelion.com/ \
  -H "Content-Type: application/json" \
  -d '{
    "jsonrpc": "2.0",
    "id": 5,
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

## Melhores Investimentos Com Filtros

```bash
curl -X POST https://mcp.meelion.com/ \
  -H "Content-Type: application/json" \
  -d '{
    "jsonrpc": "2.0",
    "id": 6,
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

## Detalhes De Um Investimento

Use o `id` ou `slug` retornado por `get_best_investments`.

```bash
curl -X POST https://mcp.meelion.com/ \
  -H "Content-Type: application/json" \
  -d '{
    "jsonrpc": "2.0",
    "id": 7,
    "method": "tools/call",
    "params": {
      "name": "get_investment_details",
      "arguments": {
        "slug": "cdb-exemplo-2027-01-01"
      }
    }
  }'
```
