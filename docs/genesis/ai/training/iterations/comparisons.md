# Cross-model comparisons

Same task, different models, same scoring. Add one row per task per model; keep the scoring
columns identical so rows can be compared. Scores: `citations` = share of claims with a source;
`status_agree` = share of feature statuses matching `../facts.jsonl`; `halluc` = unsupported
statements found by the fact-check; `time_s`; `cost_usd`.

| Date | Task | Provider / model | citations | status_agree | halluc | time_s | cost_usd | Notes |
|---|---|---|---|---|---|---|---|---|
| 2026-10-21 | Research + fact-check + review of the four-way CAD comparison (9 research workers, 6 verify runs, 1 review run) | anthropic / claude-fable-5-1 (session model; subagents inherited it) | high: every table row carries a URL or file path | n/a (first measurement) | 2 refuted of 27 claims checked so far (Flex minimum price outdated; Releases tab wrongly reported empty) | about 8,400 s wall clock for research | not metered in this session | Only one model family was used, so there is no cross-model row yet. Next: run `../qa.jsonl` through a second provider from `../../byok.md` and add its row |

Rules: never compare models on different tasks; record the prompt hash or file so a run can be
repeated; a model that refuses a task gets a row too (`outcome: refused`), because refusals are
part of fitness for the role.
