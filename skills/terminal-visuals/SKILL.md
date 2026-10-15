---
name: terminal-visuals
description: Use when explaining architecture, dependencies, processes, comparisons, quantities, or change; when the user asks to step back or remains confused; or when asked to visualize information in a chat reply or markdown doc.
allowed-tools: Bash(${CLAUDE_SKILL_DIR}/scripts/*)
---

# Terminal visuals

Use a visual whenever it makes the explanation easier to understand, without waiting to be asked. Choose by the relationship the reader needs to understand, then render it with Termaid.

Consider a visual on the first explanation, not just after a follow-up. When the user remains confused, simplify or redraw around the missing relationship instead of adding more prose.

## Choose by meaning

1. Identify the question the reader needs answered and the distinction the explanation must make.
2. Identify the relationship in the evidence: process, interaction, state change, hierarchy, connection, comparison, or quantity. Choose the relationship that answers the question, not a diagram associated with the subject.
3. Match the relationship to an established visual form. Preserve its conventional meaning: steps are different from states, ancestry from borrowing, and sequence from causation. When the choice is unfamiliar or ambiguous, consult [Mermaid's diagram definitions](https://mermaid.js.org/intro/) for diagrams, or the [Royal Statistical Society's selection guide](https://royal-statistical-society.github.io/datavisguide/docs/choosing.html) for data charts. The latter points to FT Visual Vocabulary for relationships and Data to Viz for data types.
4. Check the [Termaid gallery](https://termaid.com/examples.html) for a supported rendering of that form. If it cannot show the relationship readably, use a simpler faithful diagram, table, or sentence. A direct sentence is enough when a visual adds nothing.

## Render

Run `scripts/flow.sh` from this skill's base directory with Mermaid source as its argument or on stdin. In Claude Code, the base directory is `${CLAUDE_SKILL_DIR}`; in Copilot, use the base directory supplied when the skill loads.

```bash
scripts/flow.sh 'graph LR; A[Source] --> B[Destination]'
```

Paste the rendered text into a plain code fence in the reply. Termaid renders locally; use the public playground only for public examples. Consult `termaid --help` for installed capabilities.

## Check the result

Read the rendered output before sending it. Adjust it if labels, connections, or proportions are misleading or hard to read. Preserve the evidence and mark uncertainty; a diagram must not make an assumption look like a fact.

Let the visual carry the structure. Keep labels brief and use prose for necessary explanation; remove prose that merely repeats the visual.
