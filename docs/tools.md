# Referência das tools

Documentação das ferramentas **JSON-RPC** do Meelion MCP (`tools/call`). Pensada para **desenvolvedores**, **integradores de IA** e **catalogação** (*discoverability*) em repositórios e motores de busca.

**Índice:** [Indicadores](#get_financial_indicators) · [Cotações](#get_quotes) · [Melhores investimentos](#get_best_investments) · [Detalhe do investimento](#get_investment_details)

---

## `get_financial_indicators`

Retorna indicadores financeiros do Brasil acompanhados pela Meelion: **Selic**, **CDI/DI**, **IPCA**, **poupança** e referências úteis para **renda fixa** e contexto macro.

### Descoberta (quando usar)

- Perguntas sobre **taxa Selic hoje**, **CDI**, **DI**, **inflação IPCA**, **poupança**.
- Contexto de **juros reais** e benchmarks para **CDB**, **LCI**, **Tesouro**.
- *English:* Brazilian Central Bank rates, policy rate, consumer price index, fixed income reference rates.

### Dados retornados (típico)

- Nome e valor (ou último valor conhecido), referência de data, texto curto.
- Estrutura alinhada ao site; campo `updatedAt` na resposta do MCP.

### Argumentos

Nenhum.

### Exemplo

```json
{
  "name": "get_financial_indicators",
  "arguments": {}
}
```

---

## `get_quotes`

Cotações de **dólar**, **euro**, **ouro**, **prata** e **Bitcoin** em formato estruturado (alinhado ao painel Meelion).

### Descoberta (quando usar)

- **USD/BRL**, **EUR/BRL**, câmbio, **XAU**, **XAG**, **BTC**.
- *English:* FX quotes, gold silver spot, Bitcoin price BRL.

### Argumentos

| Campo | Tipo | Obrigatório | Descrição |
| --- | --- | --- | --- |
| `assets` | `string[]` | Não | Valores: `usd`, `eur`, `gold`, `silver`, `btc`. Se omitido, retorna o conjunto suportado. |

### Exemplo

```json
{
  "name": "get_quotes",
  "arguments": {
    "assets": ["usd", "btc"]
  }
}
```

### Schema de entrada (resumo)

```json
{
  "type": "object",
  "properties": {
    "assets": {
      "type": "array",
      "items": {
        "type": "string",
        "enum": ["usd", "eur", "gold", "silver", "btc"]
      }
    }
  }
}
```

---

## `get_best_investments`

Lista as **melhores oportunidades de renda fixa** nos dados Meelion: **ranking** com filtros por **tipo** (CDB, LCI, LCA, CRI, CRA, etc.), **distribuidor** (corretora, banco), **prazo** e `limit`.

### Descoberta (quando usar)

- “**Melhores CDBs hoje**”, “**o que rende mais**”, “**LCI Banco Inter**”, “**até 1 ano**”, “**XP Investimentos**”.
- Comparar **pós-fixado CDI+**, **prefixado**, **inflação+** quando os dados suportarem.
- *English:* best Brazilian fixed income yields, bank deposit, brokerage ranking, maturity filter.

> **Limites e modo:** o número padrão e o máximo de itens dependem de **`MCP.meelion_pro`** e do nível de acesso. Ver [mcp-modes.md](mcp-modes.md). Em **modo aberto**, a lista é curta (até **5** itens) e pode vir **`seeMoreOnSite`** com o **comparador** em `www.meelion.com`.

### Dados retornados (típico)

- `investments[]`: `position`, `id`, `name`, `investmentType`, `issuer`, `distributor`, indexador, mínimo, vencimento, taxas conforme acesso.
- `detailUrl`: **URL pública** na base **`https://www.meelion.com`** (não o host do MCP), path `/renda-fixa/investimento/{slug}/`.
- Com acesso ampliado: campos líquidos, projeções, `top_three_assets` onde aplicável.
- **Modo aberto:** `seeMoreOnSite` com `message` + `url` do comparador (`/renda-fixa/comparar-investimentos/`).

### Argumentos

| Campo | Tipo | Obrigatório | Descrição |
| --- | --- | --- | --- |
| `investment_types` | `array` ou `string` | Não | IDs, nomes ou slugs: CDB, LCI, LCA, CRI, CRA, debêntures, etc. |
| `distributors` | `array` ou `string` | Não | Distribuidores: XP, Itaú, BTG, Banco Inter, etc. |
| `prazo` | `string` | Não | Slug ou ID da faixa (ver tabela abaixo). |
| `limit` | `integer` | Não | Teto depende do modo: ver [mcp-modes.md](mcp-modes.md) (até 5 aberto; Pro até 10 ou 200). |

### Prazos aceitos (slugs comuns)

| Slug | Descrição |
| --- | --- |
| `prazo-ate-1-ano` | Até 1 ano |
| `prazo-1-a-2-anos` | 1 a 2 anos |
| `prazo-2-a-3-anos` | 2 a 3 anos |
| `prazo-3-a-4-anos` | 3 a 4 anos |
| `prazo-acima-4-anos` | Acima de 4 anos |

### Exemplo: CDBs da XP até 1 ano

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

### Exemplo: filtro por distribuidor

```json
{
  "name": "get_best_investments",
  "arguments": {
    "distributors": ["Banco Inter"],
    "limit": 5
  }
}
```

---

## `get_investment_details`

Ficha de **um** investimento por **`id`** ou **`slug`**: tipo, emissor, distribuidor, rentabilidade, vencimento, etc., conforme disponível e acesso.

### Descoberta (quando usar)

- Aprofundar um item vindo de **`get_best_investments`**.
- *English:* fixed income security details, CDB fact sheet, Brazil bond slug.

### Links

- `detailUrl` no objeto `investment` usa a base pública **`MCP.public_base_url`** (padrão `https://www.meelion.com`).

### Argumentos

| Campo | Tipo | Obrigatório | Descrição |
| --- | --- | --- | --- |
| `id` | `integer` | Condicional | ID interno do produto. |
| `slug` | `string` | Condicional | Slug da URL `/renda-fixa/investimento/.../`. |

Informe **`id` ou `slug`**.

```json
{
  "type": "object",
  "properties": {
    "id": { "type": "integer" },
    "slug": { "type": "string" }
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

---

## Tools planejadas

- `search_financial_products` (busca mais ampla)
- `compare_fixed_income` (lado a lado)
- `calculate_yield` (simuladores, se houver alinhamento com o site)
