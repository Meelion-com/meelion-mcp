# Referência Das Tools

Esta página descreve as ferramentas disponíveis no Meelion MCP e exemplos práticos de uso por assistentes de IA.

## `get_financial_indicators`

Retorna indicadores financeiros acompanhados pela Meelion.

### Quando Usar

Use esta tool quando a IA precisar responder perguntas como:

- "Qual é a Selic atual?"
- "Quais indicadores financeiros a Meelion acompanha?"
- "Mostre os principais indicadores de mercado para renda fixa."

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

Retorna cotações acompanhadas pela Meelion.

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
| `assets` | array/string | Não | Lista de ativos. Aceita `DOLAR`, `EURO`, `OURO`, `PRATA`, `BTC`. |

Se `assets` não for informado, a tool retorna todos os ativos suportados.

### Exemplo

```json
{
  "name": "get_quotes",
  "arguments": {
    "assets": ["DOLAR", "BTC"]
  }
}
```

## `get_best_investments`

Retorna ranking de investimentos disponíveis nos dados da Meelion.

### Quando Usar

Use esta tool quando a IA precisar responder perguntas como:

- "Quais são os melhores CDBs hoje?"
- "Quais investimentos do Banco Inter aparecem com maior rentabilidade?"
- "Liste LCIs com prazo de até 1 ano."
- "Compare oportunidades por distribuidor."

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
| `investment_types` | array/string | Não | Tipo de investimento por nome, slug ou ID. Ex.: `CDB`, `LCI`, `CRA`, `CRI`. |
| `distributors` | array/string | Não | Distribuidor por nome ou ID. Ex.: `XP Investimentos`, `Banco Inter`, `Itaú`. |
| `prazo` | string/int | Não | Faixa de prazo por slug ou ID. |
| `limit` | integer | Não | Quantidade máxima de resultados. |

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

Retorna detalhes de um investimento específico.

### Quando Usar

Use esta tool quando a IA já tem um ativo retornado pelo ranking e precisa aprofundar a explicação.

Exemplos:

- "Explique melhor este CDB."
- "Mostre os detalhes deste investimento."
- "Qual é o emissor, vencimento e indexador deste ativo?"

### Argumentos

| Campo | Tipo | Obrigatório | Descrição |
| --- | --- | --- | --- |
| `id` | integer | Condicional | ID interno do investimento. |
| `slug` | string | Condicional | Slug público do investimento. |

Informe `id` ou `slug`.

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
