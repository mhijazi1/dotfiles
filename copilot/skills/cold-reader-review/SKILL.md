---
name: cold-reader-review
description: Runs an isolated comprehension gate over architecture, design, and implementation-plan documents. Use when the user asks for a cold reader review, says “teach this design back,” asks whether a document is understandable or implementation-ready, or needs sequencing validated without project context.
triggers:
  - cold reader review
  - cold review
  - teach this design back
  - is this architecture understandable
  - is this plan executable
  - validate this document for a new engineer
---

# Cold-reader review

This is a comprehension gate, not a correctness review. It tests whether a document lets a fresh reader reconstruct the stated model. A clear but wrong design may pass; a correct but implicit design should fail. Validate normative correctness separately against owners, requirements, and code.

The standard gate uses the global `cold-reader` agent with fresh context.

There is no fallback to a generic or project-context agent.

## Required inputs

Agree before launch:

1. **Candidate document** — exact file and version under review.
2. **Comprehension questions** — what a new engineer must answer; mark each required or optional.
3. **Pass threshold** — allowed `clear`, `inferred`, and `unanswered` mix plus blocking findings.

If questions or threshold are missing, customize the defaults below and get owner agreement before creating the packet.

## Isolation packet

Create one neutral temporary review packet containing only:

1. reviewer protocol;
2. agreed questions and required/optional status;
3. pass threshold;
4. complete candidate document.

Do not include conversation, repository context, project instructions, memory, related documents, code, issue/PR text, owner explanation, intended answers, or parent conclusions. Do not follow links from the candidate. The packet is a review artifact, never the canonical plan or architecture.

## Agent preflight

Before every gate:

1. Confirm that `cold-reader` is available as a custom agent.
2. Verify that the agent has:
   - `defaultContext: fresh`;
   - `inheritProjectContext: false`;
   - `inheritSkills: false`;
   - tools: `read` only;
   - `acceptanceRole: read-only`.
3. Use a neutral packet directory as explicit `cwd`.
4. If the agent or any isolation property is unavailable, report `context-contaminated` and do not substitute a generic agent, project reviewer, or forked child.

## Reviewer protocol

The reader:

1. Reads the entire packet and teaches the system back in its own words: purpose, boundaries, components, flow, state, failure behavior, outputs, and guarantees.
2. Answers every question with exactly one status:
   - `clear` — explicitly answered;
   - `inferred` — requires an unstated inference, which must be named;
   - `unanswered` — no defensible answer from the document.
3. Cites a section heading or paragraph for every status. For absent answers, cites the nearest section and states what is missing.
4. Audits undefined terms, circular definitions, hidden assumptions, contradictions, current-vs-future ambiguity, ordering/state gaps, and claims requiring project knowledge.
5. Reports clarity problems with category, section, what is understandable, and what remains unknowable.
6. Does not repair the document, invent architecture, or silently fill gaps.
7. Keep the complete response under 2,500 words, the teach-back between 300 and 500 words, one compact row per question, and at most eight clarity findings. Always finish with the gate result.

## Execution

After the user explicitly approves the gate, launch `cold-reader` with:

- the packet path and neutral task wording;
- `context: "fresh"`;
- explicit neutral `cwd`;
- no project/source edits;
- no links or extra reads.

## Parent collation

Keep pedagogical evidence separate from normative correctness.

1. Assess each teach-back for material boundary or flow mismatch.
2. Collate every question using these status priorities:
   - `context-contaminated` overrides all;
   - `unanswered` overrides `inferred` and `clear`;
   - `inferred` overrides `clear`.
3. Record the reader's citations.
4. Present assessed findings before changing the document.
5. The owner decides what to revise and supplies missing facts.
6. Rerun the same packet questions with a fresh reader after revision.

Default pass threshold:

- the reader returns `PASS`;
- every required question is `clear`;
- the teach-back has no material boundary or flow mismatch;
- no unresolved clarity finding blocks a required answer.

Any required `inferred` or `unanswered` answer fails.

## Default comprehension questions

Customize and mark required/optional:

1. **Input** — What enters, who provides it, and what preconditions apply?
2. **Transformations** — What stages change the input, in what sequence, and who owns each?
3. **State and lifetime** — What state exists, where, under whose ownership, and for how long?
4. **Ordering** — What ordering or concurrency guarantees exist and where are they enforced?
5. **Atomicity** — What is the indivisible work/visibility unit and which partial effects are possible?
6. **Batching** — What is grouped, what defines a boundary, and what triggers flush/backpressure?
7. **Failure and recovery** — How are failures detected, retried, resumed, or made idempotent?
8. **Outputs** — What is produced, when is it visible, where does it go, and who consumes it?
9. **Key invariants** — What must remain true across stages, retries, and ownership boundaries?

Omit generic questions that do not apply; replace them with design-specific required questions rather than forcing irrelevant answers.

## Evaluation scenarios

1. Review an architecture document whose current and future flows are mixed; the reader should fail the boundary question.
2. Review a plan with two competing phase/stage taxonomies; sequencing questions should fail even if the target architecture is understandable.
3. Deliberately configure one reader to inherit project context; preflight should stop and label the gate context-contaminated without launch.
4. Review a clear but factually incorrect design; the gate may pass comprehension while the parent reports normative verification separately.
