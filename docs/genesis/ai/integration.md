# Integrating the knowledge pack into the onboard AI

> **Last reviewed:** 2026-10-21 · **Last updated:** 2026-10-21 · **Change:** major (first version)

CADCraft already has the plumbing an onboard AI needs: an MCP server (`cadcraft-cli mcp`), a JSON
control channel (`--control PORT`) and a command registry whose JSON form never opens dialogs
(`docs/mcp.md`, `docs/control-protocol.md`). What it lacks is knowledge: an agent driving it today
knows the command catalogue (`list_commands`) but not how the app behaves on edge cases, what the
competing products do, or what a site designer needs. This pack supplies that. The steps below go
from "no code change" to "small, optional code change", in that order; only the first two are
done by this pack.

## 1. Use today, no code change

- **System prompt.** Give the agent `knowledge/cadcraft-facts.md` and
  `knowledge/cadcraft-referencing.md` with the MCP tool list. Both are measured facts about this
  codebase, so the agent stops guessing what happens on a missing xref, a hostile DXF or a concurrent
  save. For site work add `knowledge/landdev-domain.md` and `knowledge/open-data.md`.
- **Retrieval.** Index `training/facts.jsonl` (one JSON object per line, fields `fact`/`feature`/
  `dataset`, `source`, `date`, `checked`, `refuted`, `correction`). A retrieval step before each
  answer lets the assistant cite the row it used.
- **Evaluation.** `training/qa.jsonl` pairs an instruction with the expected cited answer; run the
  assistant over it and score citation presence and status agreement (full/partial/none).

## 2. Train, when a model is chosen

`training/qa.jsonl` is in the plain `instruction`/`response` form most fine-tuning tools accept
(convert to chat format with a one-line script if needed). It is small on purpose: it teaches the
assistant to answer with a status and a source, not to memorise prices. Prices and ratings carry a
date; a trained model must be told to treat them as stale and to re-check.

## 3. Later, with the owner's approval (not done here)

- Expose the pack as an MCP resource (for example `cadcraft://knowledge`) next to the existing
  `cadcraft://drawing` and `cadcraft://commands`, read from a `knowledge/` folder in the settings
  directory so the app binary stays unchanged and the data can be updated independently.
- Add a `help`-style command that answers "how do I" questions from the pack through the same
  retrieval step, reachable from the command line and from MCP like every other command.
- Keep the pack's generator in the sibling `craftrules` repository (shared learnings), and
  regenerate it in CI whenever `docs/genesis/research/*.json` changes.

## What not to do

- Do not paste competitor documentation into prompts: the cards hold short paraphrases with URLs,
  which is what the clean-room rule allows.
- Do not let the assistant present a price, rating or version as current without the date from the
  row it came from.
