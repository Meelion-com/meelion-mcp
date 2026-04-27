# Meelion MCP

Servidor MCP da Meelion para consultar indicadores financeiros, cotacoes e oportunidades de renda fixa diretamente em assistentes de IA compatíveis com Model Context Protocol.

> Status: preview privado. O endpoint público planejado é `https://mcp.meelion.com/`.

## O Que Ele Faz

O Meelion MCP permite que IAs consultem dados estruturados da Meelion sem navegar pelo site:

- Indicadores financeiros brasileiros.
- Cotacoes de moedas, metais e Bitcoin.
- Ranking de melhores investimentos do dia.
- Detalhes de um investimento por `id` ou `slug`.
- Filtros por tipo de investimento, distribuidor e prazo.

## Acesso

O MCP pode ser usado sem autenticação para respostas públicas.

Para dados premium, envie uma API key no header:

```http
Authorization: Bearer meelion_mcp_...
```

Sem token, a resposta não inclui dados líquidos, dados brutos, links sensíveis ou ranking completo de ativos. Com token premium válido, esses campos são liberados conforme o plano do usuário.

## Endpoint

```text
POST https://mcp.meelion.com/
Content-Type: application/json
```

Ambiente local de desenvolvimento:

```text
POST http://meelion.localhost/mcp/
```

## Tools Disponíveis

| Tool | Descrição |
| --- | --- |
| `get_financial_indicators` | Retorna indicadores financeiros usados pela Meelion. |
| `get_quotes` | Retorna cotacoes de DOLAR, EURO, OURO, PRATA e BTC. |
| `get_best_investments` | Retorna melhores investimentos com filtros. |
| `get_investment_details` | Retorna detalhes de um investimento por `id` ou `slug`. |

## Exemplo Rápido

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "method": "tools/call",
  "params": {
    "name": "get_best_investments",
    "arguments": {
      "investment_types": ["CDB"],
      "distributors": ["XP Investimentos"],
      "prazo": "prazo-ate-1-ano",
      "limit": 10
    }
  }
}
```

## Documentação

- [Autenticação](docs/authentication.md)
- [Referência das Tools](docs/tools.md)
- [Exemplos de Uso](docs/examples.md)
- [Configuração de Clientes MCP](docs/client-configuration.md)

## Aviso

A Meelion não é uma instituição financeira e não oferece recomendação personalizada de investimentos. Os dados retornados pelo MCP têm finalidade informativa e comparativa.

