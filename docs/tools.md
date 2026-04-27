# Referência Das Tools

## `get_financial_indicators`

Retorna indicadores financeiros estruturados.

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

Retorna cotacoes de ativos acompanhados pela Meelion.

### Argumentos

| Campo | Tipo | Obrigatório | Descrição |
| --- | --- | --- | --- |
| `assets` | array/string | Não | Lista de ativos. Aceita `DOLAR`, `EURO`, `OURO`, `PRATA`, `BTC`. |

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

Retorna ranking de melhores investimentos.

### Argumentos

| Campo | Tipo | Obrigatório | Descrição |
| --- | --- | --- | --- |
| `investment_types` | array/string | Não | Tipo de investimento por nome, slug ou ID. Ex.: `CDB`, `LCI`, `CRA`. |
| `distributors` | array/string | Não | Distribuidor por nome ou ID. Ex.: `XP Investimentos`, `Banco Inter`. |
| `prazo` | string/int | Não | Faixa de prazo por slug ou ID. |
| `limit` | integer | Não | Quantidade de resultados. |

### Prazos

| Slug | Descrição |
| --- | --- |
| `prazo-ate-1-ano` | Até 1 ano |
| `prazo-1-a-2-anos` | 1 a 2 anos |
| `prazo-2-a-3-anos` | 2 a 3 anos |
| `prazo-3-a-4-anos` | 3 a 4 anos |
| `prazo-acima-4-anos` | Acima de 4 anos |

### Exemplo

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

## `get_investment_details`

Retorna detalhes de um investimento específico.

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

## TODO

Tools planejadas para uma próxima fase:

- `search_financial_products`
- `compare_fixed_income`
- `calculate_yield`

