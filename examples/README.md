# Exemplos

- **`get-best-investments.json`**: corpo JSON-RPC para `tools/call` → `get_best_investments`. O `limit` pedido é **cortado** no modo aberto (máx. 5) e respeitado no modo Pro até ao teto; ver [../docs/mcp-modes.md](../docs/mcp-modes.md).
- **`curl.sh`**: `POST` para `MEELION_MCP_URL` (padrão `https://mcp.meelion.com/`) com o ficheiro acima.

Mais *curl* completos: [../docs/examples.md](../docs/examples.md).
