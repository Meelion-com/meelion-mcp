#!/usr/bin/env bash
# Chama a API MCP (jsonrpc). Ajuste MEELION_MCP_URL para o seu ambiente.
# Links "humanos" (comparador, ficha) vêm no JSON com base www.meelion.com; ver docs/mcp-modes.md
set -euo pipefail

MEELION_MCP_URL="${MEELION_MCP_URL:-https://mcp.meelion.com/}"

curl -X POST "$MEELION_MCP_URL" \
  -H "Content-Type: application/json" \
  --data-binary @examples/get-best-investments.json
