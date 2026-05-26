---
name: git-commit
description: Guides agents to create clean, atomic Git commits with consistent commit messages, staging review, optional confirmation, and completion reporting. Use when the user asks to commit changes, prepare a Git commit, write a commit message, split commits, use incremental or small-step commits, or follow Git commit conventions.
---

# Git Commit

Use this skill when preparing local Git commits. It covers commit scope, atomicity, staging, commit messages, optional confirmation, small-step commit mode, and completion reports. It does not cover push, pull requests, releases, or platform-specific workflows.

## First Move

Inspect before staging or committing:

```bash
git status --short
git diff
git diff --cached
```

Identify which changes belong to the user's current request. Treat unrelated changes as user-owned: do not revert, restage, or include them unless explicitly asked.

## Reference Map

- `references/commit-message.md`: type prefixes, summary rules, language choice, and examples.
- `references/small-step-commits.md`: optional incremental commit workflow.
- `references/confirmation.md`: when to ask before committing and what to show.

## Atomic Commit Rule

One commit should express one intent:

- independently understandable, revertible, and verifiable when practical
- not mixing features, fixes, refactors, formatting, dependency changes, tests, and docs unless inseparable
- split by default when commit-ready content contains multiple unrelated intents

Pause only when the correct split is ambiguous, scope is unclear, or committing would risk including unrelated user-owned changes.

## Staging Rules

- Stage only files related to the current task.
- Prefer narrow staging over broad commands when unrelated changes exist.
- Review `git diff --cached` after staging.
- Never use destructive cleanup, reset, checkout, or restore commands to remove user changes unless explicitly requested.
- Do not commit generated, temporary, debug, credential, or environment files unless they are intentional project artifacts.

## Commit Execution

When the user asks to commit, stage only relevant files, split commit-ready changes into atomic units, create the commit or commits, and report the result. Do not stop for confirmation by default.

Ask before committing only when the user requested review, scope is ambiguous, unrelated changes cannot be separated safely, or the commit would include generated, temporary, credential, environment, or unusually large files whose intent is unclear.

If the user supplied an exact commit message, use it for the relevant commit unless it conflicts with atomicity or staged content.

## Completion Report

After a successful commit, report:

- commit hash
- commit message
- whether uncommitted changes remain

Do not push or create a pull request from this skill.
