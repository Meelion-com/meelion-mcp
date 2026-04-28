# Modos de implantação, limites e URLs públicas

Este documento descreve o comportamento do servidor Meelion MCP em relação a **modo aberto vs. Pro**, **quantos itens** as tools de investimentos retornam e **para onde apontam os links** no JSON (site canônico).

> **Resumo:** o **endpoint** do MCP pode ser `https://mcp.meelion.com/` (ou outro host de API). As **URLs de páginas** enviadas nas respostas (comparador, ficha do investimento) usam sempre a base pública **`https://www.meelion.com`**, nunca o host do endpoint MCP.

## Configuração no servidor (referência)

| Chave / variável | Significado |
| --- | --- |
| `MCP.meelion_pro` (`0` ou `1`) | `0` = modo **aberto** (sem exigir token para acessar o MCP, conforme política do deploy). `1` = modo **Pro** (autenticação opcional ou obrigatória conforme implementação; gates para dados completos). |
| `MCP.public_base_url` / `MCP_PUBLIC_BASE_URL` | Base URL do **site** para links em respostas. Padrão: `https://www.meelion.com`. Evita que `detailUrl` e CTAs usem `mcp.meelion.com` ou o host de desenvolvimento. |

## Modo aberto (`meelion_pro = 0`)

- **`get_best_investments`**: retorna no máximo **5** itens (o parâmetro `limit` não ultrapassa 5).
- O payload pode incluir **`seeMoreOnSite`**: mensagem + **URL do comparador** na Meelion (`/renda-fixa/comparar-investimentos/`) na base pública.
- Adequado para integrações em que o ranking é uma amostra e o usuário é encaminhado ao site para lista completa e filtros.

## Modo Pro (`meelion_pro = 1`)

- **`get_best_investments`**:
  - Com **acesso completo** a dados (usuário com permissão adequada): padrão **10** resultados; `limit` pode ir até **200**.
  - Com **acesso limitado** (sem permissão completa): padrão **5** resultados; `limit` pode ir até **10**.
- Campos sensíveis (ex.: rentabilidade líquida, links de oferta) podem ser omitidos ou redigidos conforme o perfil; ver [Acesso ao MCP](authentication.md).

## Links nas respostas (`detailUrl`, comparador)

- **`detailUrl`** em `get_best_investments` e **`get_investment_details`**: caminhos sob a base **`MCP.public_base_url`** (por padrão `https://www.meelion.com`), por exemplo:
  - `https://www.meelion.com/renda-fixa/investimento/{slug}/`
  - `https://www.meelion.com/renda-fixa/comparar-investimentos/` (em `seeMoreOnSite` no modo aberto)
- Isso mantém **descoberta e compartilhamento** corretos: motores de busca e usuários devem chegar ao site principal, não ao host da API.

## Palavras-chave (descoberta)

Para indexação e descoberta em catálogos de MCP e motores: *Meelion MCP, renda fixa Brasil, CDB, LCI, LCA, Selic, CDI, IPCA, cotação dólar, Bitcoin, comparador de investimentos, API MCP JSON-RPC, assistente de investimentos*.

English: *Brazilian fixed income, bank deposit rates, XP, BTG, Banco Inter, investment ranking, Model Context Protocol*.
