---
name: git-commit
description: Guides agents to create clean, atomic Git commits with consistent commit messages, reporting, optional confirmation, and optional small-step workflows. Use when the user asks to commit changes, prepare a Git commit, write a commit message, split commits, use incremental or small-step commits, or follow Git commit conventions.
---

# Git Commit

Use this skill when preparing local Git commits. It covers commit scope, atomicity, optional small-step commit workflows, staging, commit messages, optional confirmation, and completion reports. It does not cover push, pull requests, releases, or platform-specific workflows.

## First Move

Inspect before staging or committing:

```bash
git status --short
git diff
git diff --cached
```

Identify which changes belong to the user's current request. Treat existing unrelated changes as user-owned: do not revert, restage, or include them unless the user explicitly asks.

## Small-Step Commit Mode

Small-step commits are an optional development mode, not the default. Use this mode only when the user explicitly asks for small-step commits, incremental commits, frequent commits, progress commits, or automatic commits after each committable unit.

In small-step commit mode, after finishing each committable unit, check whether it should become a commit now. A small-step commit is a complete, atomic unit that is independently understandable, revertible, and verifiable when practical.

Use small-step commits to make commit history useful as development progress, development documentation, and a user-visible control surface for pacing the work when the user wants that workflow.

- Do not enable small-step commit mode unless the user explicitly asks for it.
- Do not commit unfinished work just to record activity.
- Do not use small-step commits to bypass staging review, diff review, secret checks, generated-file checks, or the atomic commit rule.
- When small-step commit mode is enabled, commit each finished unit after reviewing the staged diff, then report the commit hash, commit message, and whether uncommitted changes remain.
- If the user explicitly authorizes automatic small-step commits, commit each finished unit without asking again, then immediately report the commit hash, commit message, and whether uncommitted changes remain.
- If the user's requested pace conflicts with atomicity or repository safety, prefer atomicity and safety, then explain the tradeoff.

## Atomic Commit Rule

One commit should express one intent:

- It should be independently understandable.
- It should be independently revertible.
- It should be independently verifiable when practical.
- It should not mix features, fixes, refactors, formatting, dependency changes, tests, and docs unless they are inseparable.
- If changes must exist together to compile or pass tests, keep them in the same commit.
- If changes can be explained or reverted separately, split them into separate commits.

When commit-ready content contains multiple intents, split it into separate commits by default. Pause only when the correct split is ambiguous, the requested scope is unclear, or committing would risk including unrelated user-owned changes.

## Staging Rules

- Stage only files related to the current task.
- Prefer narrow staging over broad commands when unrelated changes exist.
- Review `git diff --cached` after staging.
- Never use destructive cleanup, reset, checkout, or restore commands to remove user changes unless the user explicitly requests that exact action.
- Do not commit generated, temporary, debug, credential, or environment files unless they are intentional project artifacts.

## Commit Message Format

Default format:

```text
<type>: <summary>
```

Optional scope:

```text
<type>(<scope>): <summary>
```

Allowed types:

- `feat`: user-facing feature or capability
- `fix`: bug fix
- `refactor`: behavior-preserving code restructuring
- `docs`: documentation-only change
- `test`: tests or test infrastructure
- `chore`: maintenance task that does not fit another type
- `style`: formatting or stylistic change without behavior change
- `perf`: performance improvement
- `build`: build system, dependency, or packaging change
- `ci`: CI configuration or pipeline change
- `revert`: revert a previous commit

Summary rules:

- Keep the type prefix in English.
- Match the summary language to the user conversation or explicit user request.
- In Chinese conversations, a Chinese summary is fine, for example `fix: 修复登录状态丢失`.
- Describe the result, not the process.
- Keep it one line, concise, and without a trailing period.
- Avoid vague summaries such as `update`, `misc`, `changes`, or `优化代码`.

## Commit Execution and Optional Confirmation

When the user asks to commit, stage only the relevant files, split commit-ready changes into atomic units, create the commit or commits, and report the result. Do not stop for confirmation by default.

Ask for confirmation before committing only when:

- The user asks to review or confirm before committing.
- The commit scope is ambiguous.
- The staged or unstaged changes mix current-task changes with unrelated user-owned work and cannot be separated safely.
- The commit would include generated, temporary, credential, environment, or unusually large files whose intent is unclear.

When asking for confirmation, show:

```text
Files to commit:
- <path>

Commit message:
<type>: <summary>
```

If the user already supplied an exact commit message and asked to commit, use that message for the relevant commit unless it conflicts with atomicity or the staged content.

## Completion Report

After a successful commit, report:

- commit hash
- commit message
- whether uncommitted changes remain

Do not push or create a pull request from this skill.
