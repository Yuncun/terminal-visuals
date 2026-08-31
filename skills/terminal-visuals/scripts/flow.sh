#!/usr/bin/env bash
# Render a Mermaid flowchart as boxes and arrows for a terminal or markdown code fence.
# usage: flow.sh 'graph LR; A[edit] --> B[commit] --> C[push]'      (or pipe mermaid on stdin)
# needs: termaid (https://github.com/fasouto/termaid) — runs via uvx, or pip install termaid
set -euo pipefail
run() {
  if command -v termaid >/dev/null 2>&1; then termaid "$@"
  elif command -v uvx >/dev/null 2>&1; then uvx termaid "$@"
  elif [ -x "$HOME/.local/bin/uvx" ]; then "$HOME/.local/bin/uvx" termaid "$@"
  else echo "termaid not available: install uv (https://docs.astral.sh/uv/) or pip install termaid" >&2; exit 1; fi
}
if [ $# -gt 0 ]; then printf '%s\n' "$1" | tr ';' '\n'; else cat; fi | run --width 100 --padding-x 1 --padding-y 0 --gap 4
