# Referência Das Tools

Esta página descreve as ferramentas disponíveis no Meelion MCP e exemplos práticos de uso por assistentes de IA.

## `get_financial_indicators`

Retorna indicadores financeiros atualizados do Brasil acompanhados pela Meelion, incluindo Selic, CDI/DI, IPCA, poupança e projeções relevantes quando disponíveis.

### Quando Usar

Use esta tool quando a IA precisar responder perguntas como:

- "Qual é a Selic atual?"
- "Quais indicadores financeiros a Meelion acompanha?"
- "Mostre os principais indicadores de mercado para renda fixa."
- "Qual é o contexto de juros e inflação para investir em renda fixa?"

### Dados Retornados

A resposta pode incluir:

- Nome do indicador.
- Valor atual ou mais recente.
- Data de referência.
- Descrição curta.
- URL pública relacionada no site da Meelion.

### Argumentos

Nenhum argumento obrigatório.

### Exemplo

```json
{
  "name": "get_financial_indicators",
  "arguments": {}
}
```

## `get_quotes`

Retorna cotações atualizadas de ativos e moedas acompanhados pela Meelion, como dólar, euro, ouro, prata e Bitcoin.

### Quando Usar

Use esta tool quando a IA precisar consultar:

- Dólar.
- Euro.
- Ouro.
- Prata.
- Bitcoin.

### Argumentos

| Campo | Tipo | Obrigatório | Descrição |
| --- | --- | --- | --- |
| `assets` | array | Não | Lista opcional de ativos desejados. Aceita `usd`, `eur`, `gold`, `silver`, `btc`. |

Se `assets` não for informado, a tool retorna todos os ativos suportados.

### Exemplo

```json
{
  "name": "get_quotes",
  "arguments": {
    "assets": ["usd", "btc"]
  }
}
```

### Schema De Entrada

```json
{
  "type": "object",
  "properties": {
    "assets": {
      "type": "array",
      "items": {
        "type": "string",
        "enum": ["usd", "eur", "gold", "silver", "btc"]
      },
      "description": "Lista opcional de ativos desejados. Valores aceitos: usd, eur, gold, silver, btc. Se omitido, retorna todas as cotações disponíveis."
    }
  }
}
```

## `get_best_investments`

Busca as melhores oportunidades de renda fixa disponíveis na Meelion, com filtros por tipo de investimento, distribuidor, instituição, prazo e limite de resultados.

### Quando Usar

Use esta tool quando a IA precisar responder perguntas como:

- "Quais são os melhores CDBs hoje?"
- "Quais investimentos do Banco Inter aparecem com maior rentabilidade?"
- "Liste LCIs com prazo de até 1 ano."
- "Compare oportunidades por distribuidor."
- "Onde meu dinheiro pode render mais hoje?"
- "Quais são os melhores investimentos por corretora ou banco?"

### Dados Retornados

A resposta pode incluir:

- Posição no ranking.
- Nome do ativo.
- Tipo de investimento.
- Emissor.
- Distribuidor.
- Indexador.
- Investimento mínimo.
- Data de vencimento.
- Taxa bruta quando disponível.
- Taxa líquida anual.
- Taxa líquida mensal.
- Valor líquido projetado.
- Valor bruto projetado.
- `top_three_assets`.
- Link público de detalhe na Meelion.
- Dados brutos e metadados adicionais quando disponíveis.

### Argumentos

| Campo | Tipo | Obrigatório | Descrição |
| --- | --- | --- | --- |
| `investment_types` | array/string | Não | IDs, nomes ou slugs dos tipos de investimento. Ex.: `CDB`, `LCI`, `LCA`, `CRI`, `CRA`, `debêntures`. |
| `distributors` | array/string | Não | IDs, nomes ou slugs dos distribuidores, corretoras ou instituições. Ex.: `XP Investimentos`, `Itaú`, `BTG Pactual`, `Banco Inter`. |
| `prazo` | string | Não | Slug ou ID da faixa de prazo. Ex.: `prazo-ate-1-ano`, `prazo-1-a-2-anos`, `prazo-2-a-3-anos`. |
| `limit` | integer | Não | Número máximo de resultados a retornar, entre 1 e 50. Use valores menores para respostas rápidas e valores maiores para comparações mais amplas. |

Os dados são indicativos e podem mudar. O usuário deve confirmar as condições na instituição financeira antes de investir.

### Prazos Aceitos

| Slug | Descrição |
| --- | --- |
| `prazo-ate-1-ano` | Até 1 ano |
| `prazo-1-a-2-anos` | 1 a 2 anos |
| `prazo-2-a-3-anos` | 2 a 3 anos |
| `prazo-3-a-4-anos` | 3 a 4 anos |
| `prazo-acima-4-anos` | Acima de 4 anos |

### Exemplo: CDBs Da XP Em Até 1 Ano

```json
{
  "name": "get_best_investments",
  "arguments": {
    "investment_types": ["CDB"],
    "distributors": ["XP Investimentos"],
    "prazo": "prazo-ate-1-ano",
    "limit": 10
  }
}
```

### Exemplo: Todos Os Tipos, Apenas Banco Inter

```json
{
  "name": "get_best_investments",
  "arguments": {
    "distributors": ["Banco Inter"],
    "limit": 5
  }
}
```

## `get_investment_details`

Retorna detalhes completos de um investimento específico da Meelion a partir do ID ou slug, incluindo informações como tipo, emissor, distribuidor, rentabilidade, prazo, vencimento, garantias, riscos e demais campos disponíveis.

### Quando Usar

Use esta tool quando a IA já tem um ativo retornado pelo ranking e precisa aprofundar a explicação.

Exemplos:

- "Explique melhor este CDB."
- "Mostre os detalhes deste investimento."
- "Qual é o emissor, vencimento e indexador deste ativo?"

### Argumentos

| Campo | Tipo | Obrigatório | Descrição |
| --- | --- | --- | --- |
| `id` | integer | Condicional | ID interno do investimento na Meelion. |
| `slug` | string | Condicional | Slug público do investimento na Meelion, normalmente presente na URL do produto. |

Informe `id` ou `slug`.

O schema de entrada usa `anyOf` para indicar que pelo menos um dos dois campos deve ser informado:

```json
{
  "type": "object",
  "properties": {
    "id": {
      "type": "integer",
      "description": "ID interno do investimento na Meelion."
    },
    "slug": {
      "type": "string",
      "description": "Slug público do investimento na Meelion, normalmente presente na URL do produto."
    }
  },
  "anyOf": [
    { "required": ["id"] },
    { "required": ["slug"] }
  ]
}
```

### Exemplo

```json
{
  "name": "get_investment_details",
  "arguments": {
    "slug": "cdb-exemplo-2027-01-01"
  }
}
```

## Tools Planejadas

As seguintes funcionalidades estão planejadas para versões futuras:

- `search_financial_products`
- `compare_fixed_income`
- `calculate_yield`
