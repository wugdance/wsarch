---
name: proofread
description: Proofreads for typos, grammar slips, punctuation, terminology consistency, jargon, and structure.
disable-model-invocation: true
---

# Proofreading

Take a file content from "understandable" to "publishable."
Proofread only — never rewrite content. Flag suspected factual errors; do not
silently fix them.

## Workflow

1. **Read for tone first**: Read the whole file and identify its type
   (tutorial / API reference / blog post / README). Tutorials tolerate a
   conversational voice; API references must be precise.
2. **Build a terminology list**: Scan for key terms (e.g. "callback" vs
   "callback function", "sign in" vs "log in") and check whether one concept is
   named several ways. Standardize on the most frequent form and note it in the
   checklist.
3. **Check paragraph by paragraph**, but only for these seven categories — do
   not drift into "is this paragraph well written":
   - Typos and spelling: transposed letters, doubled words ("the the"),
     commonly confused pairs ("affect/effect", "its/it's",
     "complement/compliment").
   - Grammar: subject-verb agreement, verb tense consistency within a
     procedure, dangling modifiers, missing articles before singular countable
     nouns.
   - Punctuation: consistent serial (Oxford) comma usage; hyphens in compound
     adjectives ("command-line tool"); no double spaces after periods;
     consistent use of em dashes vs parentheses.
   - Terminology consistency: one concept, one name — flag every variant of a
     term from the step 2 list and name the form to unify on.
   - Inline code and proper nouns: inline code, commands, file names, and paths
     in backticks; proper nouns in their official casing (`GitHub`, not
     `github`; `JavaScript`, not `Javascript`).
   - Sentence style: prefer active voice ("The system calls the function" over
     "The function is called by the system"); cut filler ("basically",
     "simply", "just", "very"); one idea per sentence.
   - Structure: headings in parallel form; lists use parallel items; steps in a
     procedure are imperative and numbered; acronyms are expanded on first use.
4. **Output the checklist**: list items as "Original → Suggestion → Reason",
   with line numbers or short quotes. Mark uncertain items `[verify]` instead
   of forcing a change. Put uncertain items separetly. It helps with 
   clearly identify what needs attention.
5. **Close with statistics**: N items total, broken down by the categories
   above (list only categories that have items) — so the author sees the
   distribution at a glance.

## Rules

- Fix language, not facts. A suspected factual error becomes
  `[verify] This contradicts the usual definition — please confirm`, never a
  silent "correction."
- Do not rewrite whole paragraphs. Even a wordy paragraph gets only specific,
  fixable sentences flagged; keep the author's voice.
- One pass only. Do not keep "polishing another round" — the deliverable is a
  "no-defects" checklist, not a perfect text.

## Minimal example

Output checklist:

```text
#                      1
Category               Punctuation
Lines                  3, 42
Original → Suggestion  locally - no interview; restructure - but → use em dashes
Reason                 Matches the em dashes used elsewhere in the document.
───────────────────────────────────────────────────────────────────────────────────────
#                      2
Category               Style
Lines                  23–24
Original → Suggestion  it should have been broken into sub-project specs → break it
                       into sub-project specs
Reason                 Active voice is more direct.
───────────────────────────────────────────────────────────────────────────────────────
#                      3
Category               Structure
Lines                  16
Original → Suggestion  DRY. YAGNI. TDD. → expand each acronym on first use
Reason                 Follows the document’s acronym-expansion convention.
───────────────────────────────────────────────────────────────────────────────────────
#                      4
Category               Grammar
Lines                  128, 140
Original → Suggestion  Run test → Run the test
Reason                 Missing article before a singular countable noun.
───────────────────────────────────────────────────────────────────────────────────────
#                      5
Category               Code & proper nouns
Lines                  110–112, 130, 142, 148
Original → Suggestion  mixed path placeholders → use one consistent placeholder style
Reason                 Keeps the template internally consistent.
───────────────────────────────────────────────────────────────────────────────────────
#                      6
Category               Terminology
Lines                  80 vs. 117, 158, 165
Original → Suggestion  executors → implementers
Reason                 Unifies the term for the person carrying out the plan.
───────────────────────────────────────────────────────────────────────────────────────

Uncertain items:

1. [verify] Line 50 — fresh reviewer's gate: confirm whether this means a dedicated
 review checkpoint; if so, review gate may be clearer.

2. [verify] Lines 152–153 — prefix of the current task number: confirm whether this
 means a ticket/task ID prefix such as SDMT-12345 and whether it is extracted from
 the branch name.


Statistics: 5 items — style 2, terminology 1, grammar 1, code & proper nouns 1.
```

## Anti-patterns

- Turning proofreading into rewriting: tearing a paragraph down so the
  author's voice and structure are lost.
- Hallucinated "corrections": changing an uncertain technical statement as if
  it were a typo, introducing a factual error.
- Typos-only checks: inconsistent terminology and sloppy structure are the
  real defects in technical docs.
- Endless iteration: the user says "polish it once more" and it never ends —
  the deliverable is the checklist, not a perfect text.
