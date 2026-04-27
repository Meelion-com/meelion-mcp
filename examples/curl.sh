#!/usr/bin/env bash
set -euo pipefail

MEELION_MCP_URL="${MEELION_MCP_URL:-https://mcp.meelion.com/}"

curl -X POST "$MEELION_MCP_URL" \
  -H "Content-Type: application/json" \
  --data-binary @examples/get-best-investments.json
