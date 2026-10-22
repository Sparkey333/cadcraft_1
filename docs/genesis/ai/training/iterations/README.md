# Iteration records

One JSON object per line, one file per date and topic, one record per AI run (a worker, a
fact-checker, a reviewer, an in-app assistant session). Keep records per model so each AI's track
record is separable; `comparisons.md` lines the models up on the same tasks.

Schema: `schema.json`. Required: `date`, `provider`, `model`, `role`, `task`, `outcome`.
Recommended: `inputs` (what it was given), `tool_uses`, `duration_s`, `tokens`, `cost_usd`,
`citations_ok` (did every claim carry a source), `corrections` (what the fact-check changed),
`lessons` (what to do differently), `caveats` (budget exhausted, hosts blocked).

Procedure after each iteration:

1. Append the records (never edit old ones; add a correcting record instead).
2. Fold corrections into `../../knowledge/*.md` and `../qa.jsonl`.
3. Re-run the sample in `../evals/<date>/sample.json` (or a new one with a recorded seed) against each configured model, grade it blind, and add a row to `comparisons.md`; the 2026-10-22 run is the template.
4. Append a block to `../../learnings-log.md`.
