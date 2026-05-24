# Module Contract

Use a module contract when a gameplay system crosses multiple files, runtime objects, or other systems. Keep it short enough to read before editing.

## Identity

```md
Module:
Purpose:
Owns language:
Owns state:
Owns invariants:
Does not own:
```

## Public Interaction

| Interaction | Use When | Example |
| --- | --- | --- |
| Command | Ask another Module to change its own State | `ApplyBuff`, `GrantItem`, `StartQuest` |
| Query | Read another Module's public facts | `GetCurrentHealth`, `CanEquip`, `GetQuestProgress` |
| Event | React to a fact that already happened | `DamageApplied`, `ItemCollected`, `AreaEntered` |
| Surface composition | UI/scene combines multiple Modules without moving logic | HUD shows Combat and Inventory |
| Shared kernel | Tiny stable shared concept | `EntityId`, `GameTime`, `Result`, `StatId` |

## Boundary Questions

- Which Module owns the domain words used by this change?
- Which Module owns the source-of-truth State?
- Which Module must protect the invariant?
- Is another Module being asked to change its own State, or are we reaching into internals?
- Can the interaction be expressed as Command, Query, Event, or Surface composition?

## Public API Rule

Other Modules should use public commands, queries, events, or shared-kernel values. They should not import internal State containers, mutate fields directly, or depend on scene/prefab wiring as a module API.

## Enforcement Hints

Prefer mechanical checks when the project supports them:

- Unity: asmdef dependencies, namespace conventions, EditMode tests, PlayMode tests, prefab validation.
- Godot: scene/resource conventions, script paths, signal naming, headless tests when available.
- C#: analyzers or architecture tests for namespace/module dependencies.
