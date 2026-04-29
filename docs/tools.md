# Referência das tools

Documentação das ferramentas **JSON-RPC** do Meelion MCP (`tools/call`). Pensada para **desenvolvedores**, **integradores de IA** e **catalogação** (*discoverability*) em repositórios e motores de busca.

**Índice:** [Indicadores](#get_financial_indicators) · [Cotações](#get_quotes) · [Melhores investimentos](#get_best_investments) · [Detalhe do investimento](#get_investment_details)

---

## Campos Comuns De Resposta

Todas as tools retornam dados em `structuredContent` e incluem estes campos no topo da resposta:

```json
{
  "source": {
    "name": "Meelion",
    "url": "https://www.meelion.com/"
  },
  "disclaimer": "Dados informativos e sujeitos a alteracao. Confirme taxas, disponibilidade, riscos e condicoes diretamente com a instituicao financeira antes de investir."
}
```

Clientes e LLMs devem citar a Meelion como fonte, incluir links retornados pelas tools quando disponiveis e preservar o carater informativo dos dados.

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
        "type": "string"
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

- `investments[]`: `position`, `id`, `slug`, `name`, `investmentType`, `issuer`, `distributor`, indexador, mínimo, vencimento, taxas conforme acesso.
- `id` e `slug` identificam o produto na Meelion e podem ser usados em `get_investment_details`.
- `detailUrl`: **URL pública** na base **`https://www.meelion.com`** (não o host do MCP), path `/renda-fixa/investimento/{slug}/`.
- Com acesso ampliado: campos líquidos, projeções, `top_three_assets` onde aplicável.
- **Modo aberto:** `seeMoreOnSite` com `message` + `url` do comparador (`/renda-fixa/comparar-investimentos/`).
- A resposta não expõe `offer_link`, `raw`, site do distribuidor, URL de cadastro ou links externos.

### Argumentos

| Campo | Tipo | Obrigatório | Descrição |
| --- | --- | --- | --- |
| `investment_types` | `string` | Não | IDs, nomes ou slugs, separados por virgula quando houver mais de um: CDB, LCI, LCA, CRI, CRA, debentures, etc. |
| `distributors` | `string` | Não | Distribuidores, separados por virgula quando houver mais de um: XP, Itau, BTG, Banco Inter, etc. |
| `prazo` | `string` | Não | Slug ou ID da faixa (ver tabela abaixo). |
| `limit` | `integer` | Não | Teto depende do modo: ver [mcp-modes.md](mcp-modes.md) (até 5 aberto; Pro até 10 ou 200). |

> Compatibilidade: o schema anunciado para clientes MCP usa `string` nesses filtros para maior compatibilidade com validadores de function calling. O servidor ainda aceita arrays legados enviados por clientes antigos.

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
    "investment_types": "CDB",
    "distributors": "XP Investimentos",
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
    "distributors": "Banco Inter",
    "limit": 5
  }
}
```

### Exemplo de item retornado

```json
{
  "position": 1,
  "id": 2572531,
  "slug": "cra-minerva-cdi-mais-06-2036-12-24",
  "name": "CRA Minerva CDI + 0,6%",
  "investmentType": "CRA",
  "issuer": "MINERVA",
  "distributor": "Banco Inter",
  "financialIndex": "PRE-FIXADO",
  "minimumInvestment": 1044.16,
  "maturityDate": "2036-12-24",
  "grossAnnualRate": 60,
  "detailUrl": "https://www.meelion.com/renda-fixa/investimento/cra-minerva-cdi-mais-06-2036-12-24/",
  "netAnnualRate": 60,
  "netMonthlyRate": 3.9944,
  "netProjectedValue": 1498510.58,
  "grossProjectedValue": 1498510.58
}
```

---

## `get_investment_details`

Ficha de **um** investimento por **`id`** ou **`slug`**: nomes de tipo, emissor, distribuidor e indexador, rentabilidade, vencimento, segurança, descrição do produto e análise de risco quando disponíveis.

### Descoberta (quando usar)

- Aprofundar um item vindo de **`get_best_investments`**.
- *English:* fixed income security details, CDB fact sheet, Brazil bond slug.

### Links

- `detailUrl` no objeto `investment` usa a base pública **`MCP.public_base_url`** (padrão `https://www.meelion.com`).
- A resposta não retorna `offer_link`, `raw`, site do distribuidor, URL de cadastro ou links externos.

### Argumentos

| Campo | Tipo | Obrigatório | Descrição |
| --- | --- | --- | --- |
| `id` | `integer` | Condicional | ID interno do produto. |
| `slug` | `string` | Condicional | Slug da URL `/renda-fixa/investimento/.../`. |

Informe **`id` ou `slug`**, mas não ambos na mesma chamada.

> O schema anunciado não usa `oneOf`, `anyOf` nem `required: []` para manter compatibilidade com clientes como GPT, Cursor, Gemini e Claude. A regra "id ou slug, mas não ambos" é validada na execução da tool.

```json
{
  "type": "object",
  "properties": {
    "id": { "type": "integer" },
    "slug": { "type": "string" }
  },
  "additionalProperties": false
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

### Resposta (exemplo)

```json
{
  "found": true,
  "investment": {
    "id": 2572518,
    "slug": "antecipacao-salarial-e208c1-2026-08-11",
    "name": "Antecipacao Salarial - E208/C1",
    "investmentType": "Recebiveis",
    "issuer": "Antecipacao Salarial - E208/C1",
    "distributor": "Hurst Capital S.A.",
    "financialIndex": "PRE-FIXADO",
    "minimumInvestment": 10000,
    "maturityDate": "2026-08-11",
    "description": "",
    "riskAnalysis": "Analise de risco do emissor quando disponivel.",
    "security": {
      "level": "Nao Avaliado",
      "rating": "No Rating",
      "hasFgc": false,
      "guarantee": "Sem Garantia",
      "guaranteeDescription": "Investimento sem garantia especifica",
      "below250k": "Reduzida",
      "above250k": "Reduzida"
    },
    "profitability": {
      "level": "Alta",
      "grossAnnualRate": 21,
      "financialIndex": "PRE-FIXADO",
      "rateValue": 21,
      "grossUpRate": 0,
      "vsDi": 8.8852,
      "vsDiGrossUp": 0,
      "netAnnualRate": 17.6661,
      "netMonthlyRate": 1.3649,
      "netProjectedValue": 10475.77,
      "grossProjectedValue": 10559.73
    },
    "detailUrl": "https://www.meelion.com/renda-fixa/investimento/antecipacao-salarial-e208c1-2026-08-11/"
  },
  "updatedAt": "2026-04-28T13:59:26-03:00"
}
```

### Campos de destaque

- `id` e `slug`: identificadores do produto na Meelion.
- `investmentType`, `issuer`, `distributor`, `financialIndex`: nomes/textos, não IDs relacionais.
- `description`: conteúdo dinâmico do produto, com fallback para a descrição cadastral.
- `riskAnalysis`: análise de risco do emissor/instituição, quando disponível.
- `security`: nível de segurança, rating, FGC/garantia e classificação para valores abaixo/acima de R$ 250 mil.
- `profitability`: bloco de rentabilidade bruta e, conforme acesso, rentabilidade líquida/projeções.

---

## Tools planejadas

- `search_financial_products` (busca mais ampla)
- `compare_fixed_income` (lado a lado)
- `calculate_yield` (simuladores, se houver alinhamento com o site)
