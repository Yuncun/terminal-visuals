# terminal-visuals

A skill for agents to draw charts, tables, flow charts, etc. as part of their replies.

Supports:
(checklist, tree, flow, bar chart, timeline, 2x2, before/after, table)

## /termaid

An opt-in command for explaining the current discussion with a diagram:

```text
/termaid
/termaid can you show me how our CI/CD checks work right now?
```

With no argument, it uses the conversation's current topic. With a question, it focuses on that question. It chooses a flowchart, sequence, state, class, or ER diagram, including meaningful nesting, and puts explanations outside the shapes. It renders locally and includes the result in the reply rather than handing back a file.

This skill is user-invoked only. The existing `terminal-visuals` skill and global presentation preferences are unchanged. Numerical charts and automatic invocation are outside this command's scope.

Install just this command:

```bash
npx skills add Yuncun/terminal-visuals --skill termaid
```

In an interactive Copilot CLI chat, run `/skills reload` after installation, then use `/termaid`. The command needs `termaid` or `uvx` on PATH.

Use the interactive command rather than scripted `copilot -p` prompts: the latter did not load this manual-only skill in CLI 1.0.99-0. See [Copilot CLI issue #4438 - manual-only skill invocation](https://github.com/github/copilot-cli/issues/4438).

## Install

```
npx skills add Yuncun/terminal-visuals --skill terminal-visuals
/plugin install terminal-visuals@yuncun            # Claude Code, via Yuncun/yuncun-marketplace
# flow.sh renders via termaid (https://github.com/fasouto/termaid): uses uvx, or pip install termaid
```

## License

MIT
