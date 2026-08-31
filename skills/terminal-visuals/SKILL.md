---
name: terminal-visuals
description: Draw a visual in a chat reply or markdown doc that is read in a terminal. Use when a reply needs a flow diagram, tree, bar chart, timeline, 2x2, checklist, or before/after, and when choosing between those and a table.
allowed-tools: Bash(${CLAUDE_SKILL_DIR}/scripts/*)
---

# Terminal visuals

A visual is a map: it shows the shape of the answer so the reader can orient before reading. Labels only inside it; explanation goes in text below. A comma, semicolon, or clause inside a cell or box is content that leaked into the map.

## Pick the shape by the question

```
what got done?                       checklist
what contains what?                  tree
what order do things happen in?      flow (boxes and arrows)
how big is each, relative?           bar chart
when did things happen?              timeline rows
how did it change over time?         bar per period, or sparkline
what is X made of?                   indented breakdown
where does each option sit?          2x2
what changed?                        before / after
what is in each part?                titled boxes
how do N items compare on M things?  table, and only then
why did it happen?                   a sentence, no visual
```

Two or three facts with one attribute each are a sentence, not a table.

One visual per point; never two shapes of the same content.

## Flow diagrams: render, do not hand-draw

Hand-drawn boxes miscount widths. Run `${CLAUDE_SKILL_DIR}/scripts/flow.sh` with Mermaid text and paste the output in a code fence:

```bash
scripts/flow.sh 'graph LR; A[edit] --> B[commit] --> C[push] --> D[work: pull]'
scripts/flow.sh 'graph LR; A[push to main] --> B[build]; P[push preview branch] --> B; B --> C[upload]; C --> D[serve prod]; C --> E[serve staging]'
```

The third call is how a second path is drawn: same graph, extra nodes, one render.

One short verb phrase per box (steps, not nouns); `LR` for pipelines, `TD` for branching. Decision nodes `B{cached?}` and edge labels `-->|yes|` render fine. Render even a three-box one-liner. One render per diagram: branches and alternate paths go in the same graph, never a second render stacked under the first.

## Examples

Checklist: `[✔]` and `[ ]` keep the same width. The bare box characters `☐ ☑` fail to render in some terminals.

```
[✔] skill published
[✔] CLAUDE.md rewritten
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

Change over time: one bar per period; a sparkline when there are many points.

```
Apr  ████             12
May  ████████         25
Jun  ██████████████   41
Jul  ████████████     36
```

```
stars/week  ▁▂▂▃▅▇▇█▆  peak Jul
```

Composition: indented breakdown with shares.

```
context per turn  100%
├─ system prompt   42%
├─ CLAUDE.md        6%
├─ skills           9%
└─ conversation    43%
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

Titled boxes: the name above the box, one-word contents inside, the relation on the arrow. Hand-drawn, so keep it to two or three boxes.

```
CLAUDE.md                  terminal-visuals
┌─────────┐   points to   ┌────────────────┐
│ rules   ├──────────────►│ examples       │
│         │               │ flow.sh        │
└─────────┘               └────────────────┘
```

Before / after: the shape of the change, not the text of it.

| before | after |
|---|---|
| "don't X; do Y" | "do Y" |

Table: only when items have several attributes to compare. Cells are one or two words; the reason goes under the table.

Leaked:

| | pnpm | bun |
|---|---|---|
| Azure SWA | detects lockfile, works | not detected; needs a prebuilt dist or custom step |

Fixed:

| | pnpm | bun |
|---|---|---|
| Azure SWA | yes | manual build |

Oryx reads `pnpm-lock.yaml` but not `bun.lock`, so bun needs its own build step.

## When not to draw

A "why" question is an explanation. Answer in two or three sentences; no flow of the failure, no table of fixes unless there are several fixes with several attributes each.

Q: why does the build say `window is not defined`?

A: Astro runs the component in Node at build time, and the chart library reads `window` when imported. Import it inside `onMount`, or mark the island `client:only`.
