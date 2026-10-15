# terminal-visuals

A skill for agents to draw charts, tables, flow charts, etc. as part of their replies.

Encourages visuals proactively, especially when explaining something unfamiliar or revisiting an explanation. The agent identifies the reader's question and the relationship in the evidence, chooses an established visual form, then checks how Termaid can render it. Selection follows diagram definitions and data-visualisation guidance rather than a topic-to-shape mapping.

## Install

```
npx skills add Yuncun/terminal-visuals            # Copilot, Codex, Cursor, Claude Code
/plugin install terminal-visuals@yuncun            # Claude Code, via Yuncun/yuncun-marketplace
# flow.sh renders via termaid (https://github.com/fasouto/termaid): uses uvx, or pip install termaid
```

The agent writes Mermaid syntax, `scripts/flow.sh` renders it locally with Termaid, and the agent includes the resulting text in its reply. This works in Copilot and Claude Code; it does not depend on Ghostty or native Mermaid rendering in the chat client.

Browse [Termaid's diagram gallery](https://termaid.com/examples.html) for the supported shapes and public examples.

## License

MIT
