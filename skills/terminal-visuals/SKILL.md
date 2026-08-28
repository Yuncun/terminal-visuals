---
name: terminal-visuals
description: Draw a visual in a chat reply or markdown doc that is read in a terminal. Use when a reply needs a flow diagram, tree, bar chart, timeline, 2x2, checklist, or before/after, and when choosing between those and a table.
allowed-tools: Bash(${CLAUDE_SKILL_DIR}/scripts/*)
---

# Terminal visuals

A visual is a map: it shows the shape of the answer so the reader can orient before reading. Labels only inside it; explanation goes in text below. If a cell or box needs a full sentence, the content has leaked into the map.

## Pick the shape by the question

```
what got done?                       checklist
what contains what?                  tree
what order do things happen in?      flow (boxes and arrows)
how big is each, relative?           bar chart
when did things happen?              timeline rows
where does each option sit?          2x2
what changed?                        before / after
how do N items compare on M things?  table, and only then
```

Two or three facts with one attribute each are a sentence, not a table.

## Flow diagrams: render, do not hand-draw

Hand-drawn boxes miscount widths. Run `${CLAUDE_SKILL_DIR}/scripts/flow.sh` with Mermaid text and paste the output in a code fence:

```bash
scripts/flow.sh 'graph LR; A[edit] --> B[commit] --> C[push] --> D[work: pull]'
scripts/flow.sh 'graph TD; Q[question] --> W[web search]; Q --> H[HN / Reddit]; W --> R[report]; H --> R'
```

One short label per box; `LR` for pipelines, `TD` for branching.

## Examples

Checklist: plain ASCII marks render in every terminal.

```
[x] skill published
[x] CLAUDE.md rewritten
[ ] evals run
```

Tree: names only, no annotations.

```
~/.claude/
├─ CLAUDE.md
├─ skills/
│  ├─ browsing
│  └─ research-evidence
└─ plugins/
```

Bar chart: proportional bars, value at the end.

```
superpowers        ████████████████████  279k
mattpocock/skills  █████████████████     239k
anthropics/skills  ████████████          172k
last30days         ████                   60k
```

Timeline: date, then a label.

```
2026-04-20  superpowers installed
2026-07-31  browsing skill
2026-08-27  research-evidence published
```

2x2: axis labels at the arrow tips, one label per quadrant.

```
                 shareable
                    ▲
   plugin           │        npx skills add
                    │
 ───────────────────┼─────────────────▶ works in Copilot
                    │
   output style     │        CLAUDE.md
                    │
```

Before / after: the shape of the change, not the text of it.

| before | after |
|---|---|
| "don't X; do Y" | "do Y" |

Table: only when items have several attributes to compare.

| Route | Claude Code | Copilot |
|---|---|---|
| plugin | yes | no |
| npx skills | yes | yes |
