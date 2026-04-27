#!/usr/bin/env bash
set -euo pipefail

MEELION_MCP_URL="${MEELION_MCP_URL:-https://mcp.meelion.com/}"

curl -X POST "$MEELION_MCP_URL" \
  -H "Content-Type: application/json" \
  ${MEELION_MCP_API_KEY:+-H "Authorization: Bearer $MEELION_MCP_API_KEY"} \
  --data-binary @examples/get-best-investments.json

