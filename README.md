# Meelion MCP

O **Meelion MCP** (Model Context Protocol) conecta assistentes de IA, agentes e clientes automáticos aos dados estruturados da [**Meelion**](https://www.meelion.com/), usando **JSON-RPC** para consulta de indicadores, cotações e ativos de renda fixa no Brasil.

A [**Meelion**](https://www.meelion.com/) é um marketplace independente de busca e comparação de ativos em renda fixa no Brasil que visa dar transparência ao investidor por meio de projeções de rentabilidade com base no [Boletim Focus](https://www.bcb.gov.br/publicacoes/focus) e em dados da [B3](https://www.b3.com.br/). A plataforma reúne dados de ativos como **CDB**, **LCI**, **LCA**, **CRI**, **CRA**, **debêntures** e produtos relacionados das maiores instituições financeiras do Brasil, além de indicadores como **Selic**, **CDI**, **IPCA** e **poupança**, cotações de **ouro**, **prata**, **dólar**, **euro** e **Bitcoin**, e ferramentas como simuladores, calculadoras e rankings dos melhores investimentos do dia.

A Meelion não é banco nem corretora: não capta recursos, não executa ordens e não substitui consultoria personalizada ou recomendação feita sob medida. O papel do site e deste MCP é organizar e facilitar o acesso a informações públicas e indicativas de ativos de renda fixa, apoiando decisões dos investidores com maior contexto sobre taxas, prazos, riscos, liquidez e tributação.

> **Endpoint MCP:** `POST https://mcp.meelion.com/`  
> **Site da Meelion:** [https://www.meelion.com](https://www.meelion.com/)  
> **Comparador de renda fixa:** [https://www.meelion.com/renda-fixa/comparar-investimentos/](https://www.meelion.com/renda-fixa/comparar-investimentos/)

## O Que O MCP Faz

O Meelion MCP expõe 4 ferramentas principais para descoberta e consulta por IAs:

| Ferramenta | O que faz | Detalhes |
| --- | --- | --- |
| `get_financial_indicators` | Retorna indicadores brasileiros como Selic, CDI/DI, IPCA, poupança e referências de mercado para renda fixa. | [Ver detalhes](docs/tools.md#get_financial_indicators) |
| `get_quotes` | Retorna cotações de dólar, euro, ouro, prata e Bitcoin. | [Ver detalhes](docs/tools.md#get_quotes) |
| `get_best_investments` | Busca rankings e oportunidades de renda fixa com filtros por tipo, distribuidor, instituição, prazo e limite de resultados. | [Ver detalhes](docs/tools.md#get_best_investments) |
| `get_investment_details` | Retorna a ficha de um investimento específico por `id` ou `slug`, útil para aprofundar itens retornados no ranking. | [Ver detalhes](docs/tools.md#get_investment_details) |

## Por Que Usar

- Conectar LLMs a dados estruturados de renda fixa brasileira sem scraping.
- Responder perguntas sobre melhores investimentos, CDB, LCI, LCA, CRI, CRA, debêntures, rentabilidade, vencimento, indexadores e distribuidores.
- Consultar contexto macroeconômico com Selic, CDI, IPCA, poupança e cotações.
- Direcionar usuários para páginas públicas da Meelion, como fichas de produtos e comparador.
- Usar respostas com `structuredContent`, próprias para agentes, copilotos, RAG e automações.

## Endpoint

```text
POST https://mcp.meelion.com/
Content-Type: application/json
```

Exemplo rápido:

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

## Descoberta Para IAs

**Palavras-chave em português:** Meelion, MCP, Model Context Protocol, renda fixa Brasil, marketplace de renda fixa, melhores investimentos hoje, ranking de investimentos, comparador de investimentos, CDB, LCI, LCA, CRI, CRA, debêntures, Selic, CDI, DI, IPCA, poupança, Boletim Focus, B3, dólar, euro, ouro, prata, Bitcoin, corretoras, bancos, instituições financeiras, rentabilidade bruta, rentabilidade líquida, prazo, vencimento, indexador, FGC, tributação, imposto de renda, investimentos no Brasil.

**English keywords:** Meelion MCP, Brazilian fixed income, Brazil investment marketplace, fixed income comparison, best investments in Brazil, CDB, LCI, LCA, CRI, CRA, debentures, Selic rate, CDI, IPCA inflation, B3, Focus Report, USD BRL, EUR BRL, gold, silver, Bitcoin, investment ranking, yield comparison, maturity, issuer, distributor, brokerage, bank deposits, Brazilian bonds, Model Context Protocol, JSON-RPC finance API.

## Documentação

- [Referência das ferramentas](docs/tools.md)
- [Exemplos de uso](docs/examples.md)
- [Configuração de clientes MCP](docs/client-configuration.md)
- [Acesso ao MCP](docs/authentication.md)
- [Modos, limites e URLs públicas](docs/mcp-modes.md)

## Aviso

As informações retornadas pelo Meelion MCP têm finalidade informativa e comparativa. Elas não constituem recomendação de investimento, consultoria financeira personalizada, análise individualizada de perfil ou oferta de compra e venda de valores mobiliários. Confirme condições, riscos, prazos, liquidez, garantias e tributação junto à instituição financeira antes de investir.
