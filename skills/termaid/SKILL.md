---
name: termaid
description: Explain the current discussion or a specific question with a locally rendered Termaid diagram.
disable-model-invocation: true
---

# Termaid

Explain the subject under discussion visually. The subject is not Termaid itself unless that is what the user asked about.

## Find the question

Use the request following `/termaid` when supplied. Otherwise, use the latest relevant topic and the relationship the user is trying to understand. Ask for a subject only when the conversation does not identify one.

For code, systems, or a PR, inspect the relevant implementation, configuration, or diff. Distinguish current behavior from a proposed change. Draw supported relationships; identify any material uncertainty outside the diagram.

If there is no useful relationship to show, give the direct answer rather than putting a sentence in a box.

## Choose the view

Choose by the relationship that answers the question, not by a topic keyword:

| Relationship | View |
|---|---|
| Steps, decisions, connected components | Flowchart |
| Messages between participants over time | Sequence |
| States and transitions of one thing | State |
| Types, interfaces, ownership, inheritance | Class |
| Data entities and their relationships | ER |

Start with one focused view. Add another only when it explains a different relationship needed for the answer. This command focuses on these core diagrams, not numerical charts.

Use nesting when it carries meaning: flowchart subgraphs for system boundaries, composite states for substates, sequence frames for alternatives and loops. Show enough surrounding structure to locate the part being discussed. For a PR, make the changed relationship and whether the view is before or after the change clear.

Keep labels to names, actions, events, and short conditions. Include only the class members or entity fields needed for the question. Preserve meaningful domain terms instead of inventing abbreviations. Put explanations, caveats, and detailed conditions below the diagram; refer to a node by its label when annotating it.

## Render locally

For an inline reply, pipe the chosen Mermaid source directly to the installed Termaid CLI. Create diagram files only when the user requests saved artifacts. A compact starting point is:

```bash
termaid --width 100 --padding-x 1 --padding-y 0 --gap 4
```

Choose the executable before piping the source: use `termaid` when installed, or `uvx termaid` when only `uvx` is available. Otherwise, report the missing renderer. A rendering error calls for fixing the source, not switching executables. Render work content locally, not in a hosted playground.

Use `termaid --help` for options and the [Termaid gallery](https://termaid.com/examples.html) for syntax examples when needed.

## Inspect and explain

Read the actual rendered output against the intended diagram. Check essential nodes, arrow direction, branch and message labels, and nesting. A successful command can still produce clipped labels or misleading connections.

Adjust orientation, spacing, or labels and render again when needed. If a nested or crowded view cannot be shown clearly, use a labeled overview and a separate detail view. Preserve the relationships rather than forcing unsupported notation; disclose a renderer limitation if it prevents a faithful view.

Paste the renderer's output unchanged into a plain text code fence in the reply. Put a short title identifying the focus above the fence. Add only the annotations and source citations the diagram cannot convey; do not repeat every step in prose. Return Mermaid source or saved artifacts only when requested.
