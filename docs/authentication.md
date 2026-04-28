# Acesso ao MCP

O Meelion MCP usa **JSON-RPC 2.0** sobre **HTTP POST** (`Content-Type: application/json`).

Neste momento, a API MCP está aberta e funciona **sem autenticação**. Não é necessário enviar API key, bearer token ou qualquer outro tipo de credencial para usar as ferramentas disponíveis.

## Endpoint

```text
POST https://mcp.meelion.com/
Content-Type: application/json
```

## Como Chamar

Liste as ferramentas disponíveis:

```bash
curl -X POST https://mcp.meelion.com/ \
  -H "Content-Type: application/json" \
  -d '{
    "jsonrpc": "2.0",
    "id": 1,
    "method": "tools/list",
    "params": {}
  }'
```

Execute uma ferramenta:

```bash
curl -X POST https://mcp.meelion.com/ \
  -H "Content-Type: application/json" \
  -d '{
    "jsonrpc": "2.0",
    "id": 2,
    "method": "tools/call",
    "params": {
      "name": "get_quotes",
      "arguments": {
        "assets": ["usd", "eur", "btc"]
      }
    }
  }'
```

## O Que A API Pode Retornar

- Indicadores financeiros brasileiros, como Selic, CDI/DI, IPCA e poupança.
- Cotações de dólar, euro, ouro, prata e Bitcoin.
- Rankings de ativos de renda fixa.
- Detalhes de investimentos específicos por `id` ou `slug`.
- URLs públicas da Meelion para páginas de produtos e comparador.

## Boas Práticas

- Use sempre `POST` com corpo JSON válido.
- Trate erros pelo padrão JSON-RPC (`error.code`, `error.message`).
- Não envie dados pessoais ou sensíveis nos argumentos das ferramentas.
- Use cache no cliente quando fizer sentido, respeitando que taxas e cotações podem mudar.

## Segurança

Questões de segurança devem seguir as orientações em [../SECURITY.md](../SECURITY.md). Não publique segredos, dados de usuários ou payloads privados em issues públicas.
