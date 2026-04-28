# Exemplos

- **`get-best-investments.json`**: corpo JSON-RPC para `tools/call` → `get_best_investments`. O `limit` pedido é **cortado** no modo aberto (máx. 5) e respeitado no modo Pro até o teto; ver [../docs/mcp-modes.md](../docs/mcp-modes.md).
- Os filtros `investment_types` e `distributors` aparecem como `string` no schema anunciado; use virgulas para informar mais de um valor. Arrays legados continuam aceitos pelo servidor.
- **`get-investment-details.json`**: corpo JSON-RPC para `tools/call` → `get_investment_details`, usando o `slug` retornado por `get_best_investments`.
- **`curl.sh`**: `POST` para `MEELION_MCP_URL` (padrão `https://mcp.meelion.com/`) com o arquivo acima.

Mais *curl* completos: [../docs/examples.md](../docs/examples.md).
