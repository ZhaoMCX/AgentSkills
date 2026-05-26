# Small-Step Commit Mode

Small-step commits are optional, not the default. Use this mode only when the user explicitly asks for small-step commits, incremental commits, frequent commits, progress commits, or automatic commits after each committable unit.

After finishing each committable unit, check whether it should become a commit now. A small-step commit must be complete, atomic, independently understandable, revertible, and verifiable when practical.

## Rules

- Do not enable small-step commit mode unless explicitly asked.
- Do not commit unfinished work just to record activity.
- Do not bypass staging review, diff review, secret checks, generated-file checks, or atomicity.
- When enabled, commit each finished unit after reviewing the staged diff, then report hash, message, and whether uncommitted changes remain.
- If the user authorized automatic small-step commits, commit each finished unit without asking again and immediately report the result.
- If requested pacing conflicts with safety or atomicity, prefer safety and explain the tradeoff.
