# Cross-model comparisons

Same task, different models, same scoring. Add one row per task per model; keep the scoring
columns identical so rows can be compared. Scores: `citations` = share of claims with a source;
`status_agree` = share of feature statuses matching `../facts.jsonl`; `halluc` = unsupported
statements found by the fact-check; `time_s`; `cost_usd`.

| Date | Task | Provider / model | citations | status_agree | halluc | time_s | cost_usd | Notes |
|---|---|---|---|---|---|---|---|---|
| 2026-10-21 | Research + fact-check + review of the four-way CAD comparison (9 research workers, 6 verify runs, 1 review run) | anthropic / claude-fable-5-1 (session model; subagents inherited it) | high: every table row carries a URL or file path | n/a (first measurement) | 4 refuted of 54 claims checked (Flex minimum price outdated; Releases tab wrongly reported empty; TrustRadius score was the category average; V26 maintenance figure a rendering error) | about 8,400 s wall clock for research | not metered in this session | Only one model family was used, so there is no cross-model row yet. Next: run `../qa.jsonl` through a second provider from `../../byok.md` and add its row |
| 2026-10-21 | Page review: 4 lenses over the generated HTML, each finding adversarially verified | anthropic / claude-fable-5-1 | n/a (findings cite page lines and research.json) | n/a | 1 of 69 verified findings was wrong | about 1,900 s wall clock | not metered | 90 findings raised, 69 verified (two-agent cap in a 4-vCPU container); 68 applied in the second iteration |
| 2026-10-22 | Knowledge-pack Q&A sample, 36 questions, closed-book (`training/evals/2026-10-22/`) | anthropic / haiku (alias) | 6 % | 31 % (full+½partial) | 0 % of answers | not metered | not metered | 21 refused; judge opus; same seed for every model |
| 2026-10-22 | Knowledge-pack Q&A sample, 36 questions, open-book (`training/evals/2026-10-22/`) | anthropic / haiku (alias) | 97 % | 100 % (full+½partial) | 0 % of answers | not metered | not metered | 0 refused; judge opus; same seed for every model |
| 2026-10-22 | Knowledge-pack Q&A sample, 36 questions, closed-book (`training/evals/2026-10-22/`) | anthropic / sonnet (alias) | 6 % | 51 % (full+½partial) | 0 % of answers | not metered | not metered | 11 refused; judge opus; same seed for every model |
| 2026-10-22 | Knowledge-pack Q&A sample, 36 questions, open-book (`training/evals/2026-10-22/`) | anthropic / sonnet (alias) | 100 % | 100 % (full+½partial) | 0 % of answers | not metered | not metered | 0 refused; judge opus; same seed for every model |
| 2026-10-22 | Knowledge-pack Q&A sample, 36 questions, closed-book (`training/evals/2026-10-22/`) | anthropic / opus (alias) | 8 % | 58 % (full+½partial) | 0 % of answers | not metered | not metered | 10 refused; judge opus; same seed for every model |
| 2026-10-22 | Knowledge-pack Q&A sample, 36 questions, open-book (`training/evals/2026-10-22/`) | anthropic / opus (alias) | 100 % | 100 % (full+½partial) | 0 % of answers | not metered | not metered | 0 refused; judge opus; same seed for every model |
| 2026-10-22 | Knowledge-pack Q&A sample, 36 questions, closed-book (`training/evals/2026-10-22/`) | anthropic / session (alias) | 0 % | 58 % (full+½partial) | 0 % of answers | not metered | not metered | 10 refused; judge opus; same seed for every model |
| 2026-10-22 | Knowledge-pack Q&A sample, 36 questions, open-book (`training/evals/2026-10-22/`) | anthropic / session (alias) | 100 % | 100 % (full+½partial) | 0 % of answers | not metered | not metered | 0 refused; judge opus; same seed for every model |

Rules: never compare models on different tasks; record the prompt hash or file so a run can be
repeated; a model that refuses a task gets a row too (`outcome: refused`), because refusals are
part of fitness for the role.
