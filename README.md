# terminal-visuals

A skill for agents whose replies are read in a terminal: which visual shape answers which question (checklist, tree, flow, bar chart, timeline, 2x2, before/after, table), an example of each, and a script that renders flow diagrams as boxes and arrows so they are never miscounted by hand.

The idea: a visual is a map. Labels only inside it, explanation in text below it, so the reader orients before reading.

## Install

```
npx skills add Yuncun/terminal-visuals            # Copilot, Codex, Cursor, Claude Code
/plugin install terminal-visuals@yuncun            # Claude Code, via Yuncun/yuncun-marketplace
go install github.com/AlexanderGrooff/mermaid-ascii@latest   # for flow.sh
```

## License

MIT
