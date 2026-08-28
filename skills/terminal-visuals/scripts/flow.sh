#!/usr/bin/env bash
# Render a Mermaid flowchart as boxes and arrows for a terminal or markdown code fence.
# usage: flow.sh 'graph LR; A[edit] --> B[commit] --> C[push]'      (or pipe mermaid on stdin)
# needs: mermaid-ascii  (go install github.com/AlexanderGrooff/mermaid-ascii@latest)
set -euo pipefail
bin=$(command -v mermaid-ascii || ls "$HOME/go/bin/mermaid-ascii" 2>/dev/null || true)
[ -n "$bin" ] || { echo "mermaid-ascii not installed: go install github.com/AlexanderGrooff/mermaid-ascii@latest" >&2; exit 1; }
if [ $# -gt 0 ]; then printf '%s\n' "$1" | tr ';' '\n'; else cat; fi | "$bin" -p 0 -x 3 -y 1
