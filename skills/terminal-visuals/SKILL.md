---
name: terminal-visuals
description: Draw a visual in a chat reply or markdown doc that is read in a terminal. Use when a reply needs a flow diagram, sequence, tree, bar chart, timeline, 2x2, checklist, or before/after, and when choosing between those and a table.
allowed-tools: Bash(${CLAUDE_SKILL_DIR}/scripts/*)
---

# Terminal visuals

A visual shows the shape of the answer. The reader looks at the visual first. Then the reader reads the text.

The visual adds to the text answer. It does not replace the text answer.

Write only labels in a cell or a box. Use known terms. Do not invent short terms.

Write each explanation in the text below the visual.

A comma, a semicolon, or a clause in a cell is an explanation. Move it to the text.

## Pick the shape by the question

```
what got done?                       checklist
what contains what?                  tree
what order do things happen in?      flow (boxes and arrows)
who calls whom, in what order?       sequence
what states can it be in?            state
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

## Boxes and arrows: render, do not hand-draw

Hand-drawn boxes miscount widths. Render anything where boxes are joined by arrows. Write plain text rows by hand: a checklist, a tree, a timeline, a bar chart, and a 2x2 have no widths to align.

Run `${CLAUDE_SKILL_DIR}/scripts/flow.sh` with Mermaid text and paste the output in a code fence:

```bash
scripts/flow.sh 'graph LR; A[edit] --> B[commit] --> C[push] --> D[work: pull]'
scripts/flow.sh 'graph LR; A[push to main] --> B[build]; P[push preview branch] --> B; B --> C[upload]; C --> D[serve prod]; C --> E[serve staging]'
```

The second call is how a second path is drawn: same graph, extra nodes, one render.

`LR` for pipelines, `TD` for branching. Render even a three-box one-liner. One render per diagram: branches and alternate paths go in the same graph, never a second render stacked under the first.

A diagram with its own line syntax goes in on stdin:

```bash
printf 'sequenceDiagram\n Client->>API: POST /login\n API-->>Client: token\n' | scripts/flow.sh
printf 'stateDiagram-v2\n [*] --> Idle\n Idle --> Running: start\n Running --> Idle: stop\n' | scripts/flow.sh
```

The renderer reads Mermaid, so it also draws class, ER, and git diagrams. Those answer questions that are rare in a reply. Reach for one only when the question above has no shape for it.

### Label a step, a decision, and an exit

From BPMN Method and Style (Bruce Silver). The BPMN specification itself says nothing about labels.

- A step is verb then object: `Approve request`. Not `Approval`. Not `Request approval process`.
- A decision is a question: `Request valid?`
- An exit carries the end state of the step before it: `Valid` and `Invalid`. Write `yes` and `no` only when the decision is a yes-or-no check.
- A parallel split has no labels on its exits.
- Two steps in one diagram do not share a name.

```bash
scripts/flow.sh 'graph LR; A[Validate request] --> B{Request valid?}; B -->|Valid| C[Charge card]; B -->|Invalid| D[Return error]'
```

### Label a box that is a thing, not a step

From the C4 model (Simon Brown).

- A box that is a thing carries its name and its type: `Postgres [database]`.
- Label every line with the relation it shows. Do not write `uses` or `calls`.

C4 also puts a one-line description inside each box. In a chat reply that makes the diagram tall, so write the description in the text below.

## Examples

Checklist: `[✔]` and `[ ]` keep the same width.

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

From ISO 24896:2026 (business reporting notation): name the measure and its unit, and let the heading say what the chart shows, not what it means. `Stars` is a heading. `Superpowers is winning` is not.

```
Stars
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

Titled boxes: a flow with one edge label. Render it; do not hand-draw it.

```bash
scripts/flow.sh 'graph LR; A[CLAUDE.md] -->|points to| B[terminal-visuals]'
```

```
┌──────────┐points to ┌─────────────────┐
│CLAUDE.md ├─────────►│terminal-visuals │
└──────────┘          └─────────────────┘
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
