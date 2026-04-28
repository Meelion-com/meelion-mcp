# Configuração de clientes MCP

Este repositório documenta como apontar **clientes** (Cursor, *IDEs*, *CLI*, agregadores) para o **endpoint** da API Meelion **MCP**.

## URL do serviço MCP (JSON-RPC)

```text
https://mcp.meelion.com/
```

- **Isto** é a URL para **`POST`** JSON-RPC (`initialize`, `tools/list`, `tools/call`).
- **Isto não** é, por si só, a página inicial para usuários. As **páginas** a abrir no navegador (comparador, ficha) vêm no JSON com base **`https://www.meelion.com`**; ver [mcp-modes.md](mcp-modes.md).

## Exemplo genérico

```json
{
  "mcpServers": {
    "meelion": {
      "type": "http",
      "url": "https://mcp.meelion.com/"
    }
  }
}
```

(A sintaxe exata depende do cliente: alguns usam `url` + MCP via HTTP, outros usam um *wrapper*.)

## Variável de ambiente para *scripts*

```bash
export MEELION_MCP_URL="https://mcp.meelion.com/"
```

O arquivo `examples/curl.sh` usa `MEELION_MCP_URL` com o mesmo padrão.

## Chamada direta (*curl*)

```bash
curl -X POST https://mcp.meelion.com/ \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}'
```

## *Discoverability* para *marketplaces* de tools

- **Nome:** Meelion MCP
- **Domínio API (típico):** `mcp.meelion.com`
- **Site para usuários:** `https://www.meelion.com`
- **Categorias sugeridas:** finanças, Brasil, renda fixa, câmbio, investimentos
- **Integração:** Model Context Protocol, JSON-RPC, ferramentas listadas em [tools.md](tools.md)

## Autenticação no cliente

Em *deploys* **Pro**, pode ser necessário enviar o **Bearer**; ver [authentication.md](authentication.md). O *preview* documental pode descrever acesso anónimo; valide com o fornecedor.
