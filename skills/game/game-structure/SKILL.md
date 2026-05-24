---
name: game-structure
description: Decide where gameplay logic should live by separating game Module, Data, State, Rule, Ability, UseCase, Result, Surface, and Adapter responsibilities. Use when creating, refactoring, or reviewing game systems; when gameplay rules are mixed with UI, animation, physics, networking, save/load, engine callbacks, or SDK code; or when a game module needs clear responsibility boundaries.
---

# Game Structure

Use this skill to place gameplay responsibilities before writing or refactoring game code. It is a responsibility-placement skill, not a framework generator.

## First Move

Inspect the project before inventing structure:

- Engine/runtime: Unity, Godot, Unreal, custom, or unknown.
- Gameplay Module: combat, buff, ability, inventory, quest, movement, save, networking, or another system.
- Existing project conventions, tests, asmdefs/modules, scenes/prefabs/resources, and domain docs.

Use engine-specific skills only when placement depends on engine APIs or framework behavior.

## Placement Table

| Writing | Role |
| --- | --- |
| Stable gameplay ownership boundary | Module |
| Static tuning, config, content, table, asset definition | Data |
| Runtime mutable facts and current game truth | State |
| Can/cannot, calculation, validation, transition | Rule |
| Start/update/cancel/complete action lifecycle | Ability |
| Multi-object or cross-module gameplay flow | UseCase |
| Structured success/failure and failure reason | Result |
| Input, UI, view, scene object, animation/physics callback | Surface |
| Engine, network, save/load, SDK, filesystem, resource access | Adapter |

## Pre-Code Check

Before editing gameplay code, state:

```md
Game Structure Check:
- Module:
- Role:
- Why here:
- Must not live in:
- Engine/external boundary:
- Verification:
```

## Extraction Rule

Keep behavior local unless one is true:

- Reused by more than one caller.
- Hard to test where it is.
- Crosses Modules or runtime objects.
- Touches engine, network, save/load, SDK, filesystem, or resource loading.
- Hides a gameplay invariant.
- Likely to be extended by designers, content, AI, or networking.

Do not split every feature into all roles by default.

## Defaults

Module owns. Data configures. State records. Rule decides. Ability performs. UseCase orchestrates. Result explains. Surface presents or receives. Adapter integrates.

## Common Misplacements

- Bad: UI button directly changes health. Good: UI Surface calls a UseCase; Rule changes State.
- Bad: Network RPC calculates damage. Good: Network Adapter passes request; Combat UseCase validates and resolves.
- Bad: ScriptableObject or Resource stores current cooldown. Good: Data stores cooldown duration; State stores remaining cooldown.
- Bad: Animation event applies gameplay truth directly. Good: Animation Surface emits timing signal; UseCase/Rule owns outcome.
- Bad: Physics callback decides scoring. Good: Physics Surface/Adapter reports contact; Rule decides score.

## Hand Off When

- Terms or design intent are unclear: use `grill-with-docs`.
- The user asks for red-green implementation: use `tdd`.
- There is broken gameplay behavior: use `diagnose`.
- The issue is engine/API-specific: use the relevant Unity, Godot, Unreal, networking, tweening, or SDK skill.

## References

- For module ownership and cross-module interaction, read `references/module-contract.md`.
- For runtime object and lifecycle boundaries, read `references/runtime-boundaries.md`.
