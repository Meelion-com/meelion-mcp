# Meelion MCP

O Meelion MCP conecta assistentes de IA aos dados estruturados da [Meelion](https://www.meelion.com/), uma plataforma brasileira para pesquisa, comparação e acompanhamento de investimentos, com foco inicial em renda fixa, indicadores financeiros e oportunidades disponíveis no mercado.

Com o MCP, uma IA compatível pode consultar dados da Meelion diretamente, sem precisar navegar pelo site, raspar páginas ou interpretar HTML.

> Status: preview privado. O endpoint planejado é `https://mcp.meelion.com/`.

## Sobre A Meelion

A [Meelion](https://www.meelion.com/) ajuda investidores a encontrar, comparar e entender oportunidades de investimento de forma mais clara. A plataforma reúne dados de produtos financeiros, indicadores de mercado, instituições, distribuidores, rentabilidades projetadas e informações educacionais para apoiar análises de renda fixa.

A Meelion não é uma instituição financeira, não distribui produtos financeiros diretamente e não oferece recomendação personalizada. O objetivo é organizar informação, facilitar comparação e dar mais contexto para decisões de investimento.

## O Que O MCP Permite Fazer

O Meelion MCP expõe funcionalidades pensadas para uso por IAs:

- Consultar indicadores financeiros brasileiros, como Selic, IPCA, DI e poupança.
- Consultar cotações de dólar, euro, ouro, prata e Bitcoin.
- Listar os melhores investimentos disponíveis segundo os dados da Meelion.
- Filtrar investimentos por tipo, distribuidor e prazo.
- Buscar detalhes de um ativo específico por `id` ou `slug`.
- Receber respostas estruturadas, próprias para análise e geração de texto por assistentes.

## Acesso

O MCP pode ser usado sem autenticação. Nesta fase de preview, basta enviar chamadas JSON-RPC para o endpoint público.

As respostas foram pensadas para assistentes de IA: dados estruturados, campos estáveis e informações suficientes para explicar indicadores, cotações e oportunidades de investimento disponíveis na Meelion.

## Endpoint

```text
POST https://mcp.meelion.com/
Content-Type: application/json
```

## Tools Disponíveis

| Tool | O que faz |
| --- | --- |
| `get_financial_indicators` | Retorna indicadores financeiros do Brasil acompanhados pela Meelion, como Selic, CDI/DI, IPCA, poupança e referências para renda fixa. |
| `get_quotes` | Retorna cotações de dólar, euro, ouro, prata e Bitcoin em formato estruturado. |
| `get_best_investments` | Busca oportunidades de renda fixa com filtros por tipo, distribuidor, instituição, prazo e limite de resultados. |
| `get_investment_details` | Retorna detalhes de um investimento específico por `id` ou `slug`, útil para aprofundar itens do ranking. |

## Exemplo Rápido

Buscar CDBs distribuídos pela XP Investimentos com vencimento em até 1 ano:

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

- [Acesso ao MCP](docs/authentication.md)
- [Referência das Tools](docs/tools.md)
- [Exemplos de Uso](docs/examples.md)
- [Configuração de Clientes MCP](docs/client-configuration.md)

## Aviso

As informações retornadas pelo Meelion MCP têm finalidade informativa e comparativa. Elas não constituem recomendação de investimento, consultoria financeira, análise individualizada de perfil ou oferta de compra e venda de valores mobiliários.
