# Exemplos de uso

Reúne exemplos de **`curl`** e corpos **JSON-RPC** alinhados ao [endpoint de cliente](client-configuration.md) e à [referência de tools](tools.md).

> **Nota:** em **modo aberto**, `get_best_investments` retorna no máximo **5** itens; em **Pro**, o `limit` eficaz pode ir até **200** ou **10** conforme o acesso. Ver [mcp-modes.md](mcp-modes.md).

## Inicializar sessão MCP

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

## Listar tools disponíveis

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

## Consultar indicadores financeiros

Cobre perguntas como: “Qual a Selic?”, “E o CDI?”, *Brazilian interest rates*.

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

## Consultar cotações (dólar, euro, Bitcoin)

*Keywords:* câmbio, USD, EUR, BTC, ouro, prata.

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
        "assets": ["usd", "eur", "btc"]
      }
    }
  }'
```

## Melhores investimentos (CDB, exemplo)

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

A resposta pode incluir `seeMoreOnSite` com a URL do **comparador** no site (base `www.meelion.com`).

## Melhores investimentos com vários filtros

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

## Detalhes de um investimento (slug)

Use o `slug` (ou `id`) retornado pelo ranking.

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

O campo `detailUrl` aponta para a ficha pública em **`https://www.meelion.com/renda-fixa/...`**.

## Chamada com Bearer (modo Pro, quando aplicável)

```bash
curl -X POST https://mcp.meelion.com/ \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer SEU_TOKEN_AQUI" \
  -d '{
    "jsonrpc": "2.0",
    "id": 8,
    "method": "tools/call",
    "params": {
      "name": "get_best_investments",
      "arguments": { "limit": 20 }
    }
  }'
```

Detalhes: [authentication.md](authentication.md).
