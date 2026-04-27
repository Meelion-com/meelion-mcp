# Meelion MCP

O **Meelion MCP** (Model Context Protocol) liga assistentes de IA e clientes automáticos aos dados estruturados da [**Meelion**](https://www.meelion.com/): plataforma brasileira para **pesquisa, comparação e acompanhamento** de investimentos, com foco em **renda fixa**, **indicadores** (Selic, CDI, IPCA, poupança) e **cotações** (dólar, euro, ouro, prata, Bitcoin).

A IA consulta a API em **JSON-RPC** (sem depender de scraping ou HTML), recebendo payloads prontos para explicar **CDB, LCI, LCA, CRI, CRA, debêntures** e contexto de taxas e inflação.

> **Endpoint (API):** `POST` para o host de MCP publicado (ex.: `https://mcp.meelion.com/`).  
> **Site (utilizadores):** links devolvidos no JSON (comparador, ficha do produto) apontam para **`https://www.meelion.com`**, conforme [modos e limites](docs/mcp-modes.md).

## Para quem procura isto (descoberta)

| Se procura | O Meelion MCP oferece |
| --- | --- |
| API de renda fixa Brasil, taxas CDB, ranking de investimentos | Tool `get_best_investments` com filtros por tipo, banco/corretora, prazo |
| Selic hoje, CDI, IPCA, indicadores Banco Central | `get_financial_indicators` |
| Cotação dólar euro ouro Bitcoin Hoje | `get_quotes` |
| Detalhe de um título / slug do produto | `get_investment_details` |
| MCP para ChatGPT, Cursor, Claude, agregador de tools | JSON-RPC `initialize`, `tools/list`, `tools/call` |

**Palavras-chave (PT):** renda fixa, melhores investimentos, comparador, Meelion, corretora, indexador, pré-fixado, pós-fixado.  
**Keywords (EN):** Brazilian fixed income, investment comparison, CDI, savings bond equivalents, Model Context Protocol.

## Sobre a Meelion

A [Meelion](https://www.meelion.com/) organiza **dados de produtos**, **instituições**, **rentabilidades** e conteúdo educativo para apoiar comparação de **renda fixa** e decisões com mais contexto. A Meelion **não** é instituição financeira e **não** presta consultoria personalizada; o MCP replica essa natureza informativa.

## O que o MCP permite fazer

- Indicadores financeiros brasileiros: Selic, CDI/DI, IPCA, poupança e referências alinhadas ao [painel do site](https://www.meelion.com).
- Cotações: dólar, euro, ouro, prata, Bitcoin.
- **Melhores oportunidades** de renda fixa (ranking) com filtros.
- **Detalhe** de um investimento por `id` ou `slug`.
- Respostas com **`structuredContent`** e texto JSON para *LLMs*.

O comportamento de **limites** (quantos itens no ranking) e de **autenticação** depende da implantação: [Modos, limites e URLs públicas](docs/mcp-modes.md) e [Acesso ao MCP](docs/authentication.md).

## Acesso e segurança

- Em **modo aberto** (padrão de documento de produto), o serviço pode ser chamado **sem Bearer**, com amostra curta de rankings; ver [mcp-modes](docs/mcp-modes.md).
- Em **modo Pro**, pode ser exigido **token** e *gates* para dados completos. Ver [authentication](docs/authentication.md).

Nunca trate a saída como **recomendação de investimento** individualizada.

## Endpoint

```text
POST https://mcp.meelion.com/
Content-Type: application/json
```

(O host exato segue o ambiente: produção, *staging* ou *preview*.)

## Tools disponíveis

| Tool | Resumo | Descoberta rápida |
| --- | --- | --- |
| `get_financial_indicators` | Indicadores macro e de referência para renda fixa | Selic, CDI, IPCA, juros, inflação |
| `get_quotes` | Cotações USD, EUR, ouro, prata, BTC | Câmbio, commodities, cripto |
| `get_best_investments` | Ranking de renda fixa com filtros | Melhores CDB/LCI, por prazo, por corretora |
| `get_investment_details` | Ficha de um título | Slug, emissor, vencimento, indexador |

Referência completa: [docs/tools.md](docs/tools.md).

## Exemplo rápido (JSON-RPC)

CDBs da XP, até 1 ano (o `limit` eficaz segue o [modo do servidor](docs/mcp-modes.md)):

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

- [Modos, limites e URLs públicas](docs/mcp-modes.md)
- [Acesso ao MCP (incl. Pro e token)](docs/authentication.md)
- [Referência das tools](docs/tools.md)
- [Exemplos de uso](docs/examples.md)
- [Configuração de clientes](docs/client-configuration.md)

## Aviso

As informações têm finalidade **informativa e comparativa**, não **recomendação**, **consultoria** ou **oferta** de valores mobiliários. Confirme condições na instituição antes de investir.
