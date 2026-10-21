# Onboard AI knowledge pack (data only)

> **Last reviewed:** 2026-10-21 · **Last updated:** 2026-10-21 · **Change:** major (first version)

This folder holds what CADCraft's onboard AI (today: any agent driving the app over MCP or the
control channel; tomorrow: an in-app assistant, see `docs/gaps.md` A2) should **know**, kept as
data so that it can be loaded, indexed, retrieved or used as training material without changing
the application. Nothing in here changes CADCraft's behaviour, commands, prompts or its existing
agent instructions (`AGENTS.md`, `CLAUDE.md`); those stay as they are until the owner decides.

| Path | What it is | Use |
|---|---|---|
| `knowledge/*.md` | Knowledge cards: measured CADCraft facts and behaviour, competitor facts, user pain points, land-development domain knowledge, open-data endpoints, the Genesis design decisions | Paste into a system prompt, or index for retrieval |
| `training/facts.jsonl` | One checkable fact per line with source, date and (where run) the fact-check verdict | Retrieval corpus; evaluation set for "does the assistant cite correctly" |
| `training/qa.jsonl` | Instruction/response pairs derived from the facts, every answer citing its source | Fine-tuning or few-shot material; evaluation set |
| `byok.md` | Bring your own key: providers, where to get keys, endpoints, a `providers.toml` proposal, privacy rules, for CADCraft (via MCP clients) and Genesis (in-app) | Users and the assistant implementation |
| `training/iterations/` | One record per AI run, per model, plus `comparisons.md` for cross-model scoring | Review after every iteration |
| `integration.md` | How to wire the pack into the onboard AI without code changes, and what a later code integration could look like | Owner decision |
| `learnings-log.md` | Append-only log of what each iteration learned about the repo, the tooling and the data | Keep appending |

Regenerated from `../research/*.json` by the same generator as `../comparison.html`. Every row
carries its source URL and the date it was read; nothing is presented as current without one.

Rules for anyone (human or agent) extending this pack:

- Data only: markdown and JSONL. No code, no prompts that change the app's behaviour.
- Every fact gets a source and a date; a correction keeps the old row and adds the verdict.
- Clean-room: no Autodesk or Bricsys text beyond short paraphrases, no screenshots, no assets.
- Prefer measured facts (built, run, read in source) over vendor claims over reviews.
