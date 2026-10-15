---
name: terminal-visuals
description: Use when explaining architecture, dependencies, data movement, or a multi-step process; when the user asks to step back or is still confused about how parts connect; or when drawing or choosing a flow, sequence, tree, chart, timeline, checklist, before/after, or table in a chat reply or markdown doc.
allowed-tools: Bash(${CLAUDE_SKILL_DIR}/scripts/*)
---

# Terminal visuals

A visual shows the shape of the answer. The reader looks at the visual first. Then the reader reads the text.

The visual adds to the text answer. It does not replace the text answer.

Write only labels in a cell or a box. Use terms the reader already knows.

Write each explanation in the text below the visual. A comma, a semicolon, or a clause in a cell is an explanation. Move it to the text.

## Explain connections with a diagram

On the first explanation of how components connect, depend on each other, or pass something along, lead with a small rendered diagram. An architecture or process question is enough to trigger it; the user need not ask to "draw".

1. Identify the parts and relationships needed to answer the question. Use a flow for dependencies and handoffs, a sequence for calls over time, or a tree for containment.
2. Render the smallest diagram that preserves those relationships. Label what each arrow means. Mark uncertain or proposed connections as such.
3. Put the diagram before the supporting explanation. Explain the one point the picture cannot show in a short paragraph.

When the user asks to step back, says they still do not understand, or asks again how the parts connect, simplify or redraw the same map around the missing relationship. Keep familiar names and add only the detail needed for that question.

## Pick the shape by the question

```
what got done?                       checklist
what contains what?                  tree
how do these parts connect?          flow with labeled relationships
what depends on what?                flow with labeled dependencies
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
where does the process break?        flow with the failing step marked
```

Two or three independent facts with one attribute each are a sentence, not a table. Connected parts still benefit from a diagram, even when there are only two or three.

One visual per point; one shape per piece of content.

## Boxes and arrows: render them

Hand-drawn boxes miscount widths. Render anything where boxes are joined by arrows. Write plain text rows by hand: a checklist, a tree, a timeline, a bar chart, and a 2x2 have no widths to align.

Run `${CLAUDE_SKILL_DIR}/scripts/flow.sh` with Mermaid text and paste the output in a code fence:

Use the skill's supplied base directory to resolve `scripts/flow.sh` in clients without `CLAUDE_SKILL_DIR`, including Copilot. The examples below use paths relative to that directory. Termaid produces plain text; the reply displays that output, not a Mermaid code block requiring a separate renderer.

```bash
scripts/flow.sh 'graph LR; A[edit] --> B[commit] --> C[push] --> D[work: pull]'
scripts/flow.sh 'graph LR; A[push to main] --> B[build]; P[push preview branch] --> B; B --> C[upload]; C --> D[serve prod]; C --> E[serve staging]'
```

The second call is how a second path is drawn: same graph, extra nodes, one render.

`LR` for pipelines, `TD` for branching. Render even a three-box one-liner. One render per diagram: branches and alternate paths go in the same graph.

A diagram with its own line syntax goes in on stdin:

```bash
printf 'sequenceDiagram\n Client->>API: POST /login\n API-->>Client: token\n' | scripts/flow.sh
printf 'stateDiagram-v2\n [*] --> Idle\n Idle --> Running: start\n Running --> Idle: stop\n' | scripts/flow.sh
```

For specialized diagrams, consult the [Termaid examples](https://termaid.com/examples.html) and check the installed renderer with `termaid --help`. Use its local renderer for work content; the public playground is for public examples.

### Label a step, a decision, and an exit

From BPMN Method and Style (Bruce Silver). The BPMN specification itself says nothing about labels.

- A step is verb then object: `Approve request`.
- A decision is a question: `Request valid?`
- An exit carries the end state of the step before it: `Valid` and `Invalid`. Write `yes` and `no` when the decision is a yes-or-no check.
- A parallel split leaves its exits bare.
- Each step in one diagram carries its own name.

```bash
scripts/flow.sh 'graph LR; A[Validate request] --> B{Request valid?}; B -->|Valid| C[Charge card]; B -->|Invalid| D[Return error]'
```

### Label a box that is a thing, not a step

From the C4 model (Simon Brown).

- A box that is a thing carries its name and its type: `Postgres [database]`.
- Label every line with the relation it shows: `reads from`, `publishes to`, `authenticates with`.

C4 also puts a one-line description inside each box. In a chat reply that makes the diagram tall, so write the description in the text below.

## Examples

Checklist: `[✔]` and `[ ]` keep the same width.

```
[✔] schema migrated
[✔] endpoint deployed
[ ] load test run
```

Tree: names only, no annotations.

```
src/
├─ config.ts
├─ handlers/
│  ├─ orders
│  └─ payments
└─ lib/
```

Bar chart: proportional bars, value at the end.

From ISO 24896:2026 (business reporting notation): name the measure and its unit, and let the heading say what the chart shows rather than what it means. `Requests [thousands]` is a heading. `Checkout is winning` reads as a conclusion, so it belongs in the text below.

```
Requests [thousands]
checkout   ████████████████████  240
search     █████████████████     205
cart       ████████████          145
login      ████                   50
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
request time  100%
├─ auth         12%
├─ database     54%
├─ rendering    26%
└─ logging       8%
```

Timeline: date, then a label.

```
2026-04-20  schema v2 shipped
2026-07-31  read replica added
2026-08-27  cache layer live
```

2x2: axis labels at the arrow tips, one label per quadrant.

```
                  managed
                    ▲
   container        │        serverless
                    │
 ───────────────────┼─────────────────▶ scales to zero
                    │
   bare metal       │        edge worker
                    │
```

Titled boxes: a flow with one edge label. Render it.

```bash
scripts/flow.sh 'graph LR; A[Order service] -->|publishes to| B[Event bus]'
```

```
┌──────────────┐publishes to ┌──────────┐
│Order service ├────────────►│Event bus │
└──────────────┘             └──────────┘
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

## When prose is enough

Use a sentence for a definition, a single fact, or a direct correction with no useful relationship to show. For a "why" question involving several components or steps, draw the relevant path and explain the cause below it. Choose by the relationships in the answer, not by whether the question starts with "why".
