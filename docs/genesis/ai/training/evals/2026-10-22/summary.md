# Cross-model evaluation of the knowledge pack (2026-10-22)

Sample: 36 questions from `../../qa.jsonl`, 4 per topic, seed 20261022 (`sample.json`). Two conditions: **closed-book** (the model answers from its own knowledge; it may read only the questions file) and **open-book** (the model reads the knowledge card named for each question and answers from it). Every answer was graded blind by one judge (harness alias `opus`) against the expected answer: full = same status and key fact, partial = right direction, wrong = contradicts, refused = no answer or 'unsure'. Score = full + 0.5 × partial, as a percentage of the questions. Citation = the source given matches the expected evidence or its card. Hallucination = a specific fact asserted that is neither expected nor plausibly true.

| Model (harness alias) | Condition | Full | Partial | Wrong | Refused | Score | Citations ok | Hallucinations | Files read |
|---|---|---|---|---|---|---|---|---|---|
| haiku | closed | 7 | 8 | 0 | 21 | 31 % | 6 % | 0 % | 1 |
| haiku | open | 36 | 0 | 0 | 0 | 100 % | 97 % | 0 % | 10 |
| sonnet | closed | 12 | 13 | 0 | 11 | 51 % | 6 % | 0 % | 1 |
| sonnet | open | 36 | 0 | 0 | 0 | 100 % | 100 % | 0 % | 10 |
| opus | closed | 16 | 10 | 0 | 10 | 58 % | 8 % | 0 % | 1 |
| opus | open | 36 | 0 | 0 | 0 | 100 % | 100 % | 0 % | 10 |
| session | closed | 16 | 10 | 0 | 10 | 58 % | 0 % | 0 % | 1 |
| session | open | 36 | 0 | 0 | 0 | 100 % | 100 % | 0 % | 10 |

## Lift from the pack (open-book minus closed-book, score points)

| Model | Closed | Open | Lift |
|---|---|---|---|
| haiku | 31 % | 100 % | +69 |
| sonnet | 51 % | 100 % | +49 |
| opus | 58 % | 100 % | +42 |
| session | 58 % | 100 % | +42 |

## Caveats

- Open-book is a ceiling, not a result: `qa.jsonl` was derived from the same knowledge cards, so an open-book run measures whether the cards are complete for the sample and whether the model finds the right row. Held-out questions (review findings, fact-check verdicts, design-partner questions) are the next step.
- One judge graded every run; the judge is itself one of the models under test, so its own rows carry a self-grading bias.
- The closed-book rule was an instruction, not a sandbox: `files_read` lists what each agent reported reading; a closed-book run that read more than the questions file is contaminated and says so in its row.
- Model aliases are resolved by the harness at run time; the exact model versions are recorded in the iteration records as of the run date.
- Thirty-six questions is enough to rank conditions, not to separate models that differ by a few points.
- Every answer, grade and note is in `answers-and-grades.json`; re-run with the same seed to compare a new model.
