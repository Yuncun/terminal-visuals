---
name: terminal-visuals
description: Use when explaining architecture, dependencies, processes, comparisons, quantities, or change; when the user asks to step back or remains confused; or when asked to visualize information in a chat reply or markdown doc.
allowed-tools: Bash(${CLAUDE_SKILL_DIR}/scripts/*)
---

# Terminal visuals

Use a visual whenever it makes the explanation easier to understand, without waiting to be asked. Choose an established diagram type that fits the information, render it with Termaid, and keep the accompanying explanation brief.

Consider a visual on the first explanation, not just after a follow-up. When the user remains confused, simplify or redraw around the missing relationship instead of adding more prose.

## Choose and render

Use established diagram conventions and your judgment to choose the type, layout, and labels. Consult the [Termaid gallery](https://termaid.com/examples.html) for supported types and syntax examples rather than limiting yourself to flowcharts.

Run `scripts/flow.sh` from this skill's base directory with Mermaid source as its argument or on stdin. In Claude Code, the base directory is `${CLAUDE_SKILL_DIR}`; in Copilot, use the base directory supplied when the skill loads.

```bash
scripts/flow.sh 'graph LR; A[Source] --> B[Destination]'
```

Paste the rendered text into a plain code fence in the reply. Termaid renders locally; use the public playground only for public examples. Consult `termaid --help` for installed capabilities.

## Check the result

Read the rendered output before sending it. Adjust it if labels, connections, or proportions are misleading or hard to read. Preserve the evidence and mark uncertainty; a diagram must not make an assumption look like a fact.

Let the visual carry the structure and use prose for what it cannot show. A direct sentence is enough when a visual adds nothing.
