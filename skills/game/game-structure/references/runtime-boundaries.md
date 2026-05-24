# Runtime Boundaries

Game systems often fail when runtime objects become the place where every responsibility lives. Classify runtime code before editing.

## Default Mapping

| Runtime artifact | Default role | Notes |
| --- | --- | --- |
| Scene object / MonoBehaviour / Node / Actor | Surface | Receives input, presents state, forwards timing/callbacks. |
| UI widget / HUD / Control | Surface | Presents and requests; does not own gameplay truth. |
| Animation callback | Surface | Timing signal only; not a business decision. |
| Physics callback | Surface or Adapter | Reports contact/query result; Rule decides outcome. |
| Network callback / RPC handler | Adapter or Surface | Transports request/fact; does not calculate gameplay truth. |
| Save/load service | Adapter | Persists and restores State; does not invent State transitions. |
| Data asset / config table / Resource / ScriptableObject / DataAsset | Data | Static definition by default. |
| Plain class/struct | State, Rule, UseCase, Result | Preferred home for testable gameplay core. |

## Lifecycle Rules

- Keep initialization, binding, and cleanup separate from gameplay decisions.
- Do not rely on frame callbacks as the only way to test a Rule.
- Use runtime objects to bridge engine events into UseCases or Rules.
- Store current runtime facts in State or runtime instances, not shared Data assets.
- Emit Results or Events when gameplay core finishes; let Surfaces and Adapters react.

## Engine Vocabulary Examples

These examples are anchors, not engine-specific rules. Local project conventions win.

| Role | Unity examples | Godot examples | Unreal examples |
| --- | --- | --- | --- |
| Surface | `MonoBehaviour`, UI component, Animator event | `Node`, `Control`, signal bridge | `Actor`, `Widget`, animation notify |
| Data | `ScriptableObject`, config table | `Resource`, config table | `DataAsset`, data table |
| State | Plain C# instance, runtime component field | Plain GDScript/C# object, runtime node field | Plain object/struct, runtime component field |
| Rule | Plain C# service/function | Plain script object/function | Plain object/function, subsystem function |
| UseCase | Application/gameplay service | Gameplay script/service | Gameplay service/subsystem |
| Adapter | Addressables, SDK, save/network wrapper | file/network/resource wrapper | subsystem/API/save/network wrapper |

## Red Flags

- A UI/scene object owns a gameplay invariant.
- An animation, physics, or network callback directly changes score, damage, cooldown, quest progress, or rewards.
- A Data asset stores per-player or per-entity current values.
- A save/network adapter validates gameplay eligibility.
- A lifecycle method is the only place a core behavior can run.
