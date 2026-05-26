---
name: unity-dotween
description: Guides Unity DOTween animation work with lifecycle-safe tween ownership, module selection, settings checks, and review gates. Use when implementing, reviewing, debugging, or refactoring tween animations with DG.Tweening, including Transform, UI, CanvasGroup, Image, SpriteRenderer, Material, AudioSource, Rigidbody/Rigidbody2D, Sequences, async waits, DOTween settings, or Unity UI effects.
---

# DOTween

## Overview

Use DOTween for code-driven runtime movement, UI transitions, feedback animation, fades, punches, shakes, material values, and `Sequence` composition.

Always inspect the target Unity project's installed DOTween files and settings before relying on memory or this reference. Local XML, modules, settings, asmdefs, and package/vendor layout are the source of truth.

## Read First

Before adding or changing DOTween behavior:

1. Locate DOTween in the target project, commonly under `Assets/Plugins/Demigiant/DOTween`, an embedded package, or a package cache.
2. Inspect `DOTweenSettings.asset` for defaults, module toggles, Safe Mode, AutoPlay, AutoKill, recycling, and capacity policy.
3. Inspect local XML and `Modules/*.cs` for exact API signatures, enabled shortcuts, and conditional compile symbols.
4. Check whether the target asmdef can reference `DG.Tweening`; adjust asmdef references deliberately if needed.
5. Confirm whether DOTween Pro components exist before using `DOTweenAnimation`, `DOTweenPath`, or visual tween authoring.

## Reference Map

- `references/quick-reference.md`: settings interpretation, module map, lifecycle patterns, sequence rules, recipes, async waits, performance, and validation.
- Local project files win over reference notes whenever signatures, settings, or enabled modules differ.

## Implementation Workflow

1. Identify the animated target type: `Transform`, `RectTransform`, `CanvasGroup`, `Graphic/Image/Text`, `SpriteRenderer`, `Material`, `AudioSource`, `Rigidbody`, custom value, or mixed sequence.
2. Pick the narrowest available shortcut, such as `DOAnchorPos` for UI layout, `DOFade` for alpha, `DOScale` for scale, or `DOTween.To` for custom values.
3. Decide ownership and lifetime before writing the tween: component field, panel sequence, reusable feedback method, or presentation-only adapter.
4. Add fluent settings in a stable order: ease, delay, loops, update mode, linking/lifetime, callbacks.
5. Validate behavior in Play Mode or tests when it depends on Unity update timing, disable/enable, destruction, layout rebuilds, physics, or pause state.

## Project Rules

- Always add `using DG.Tweening;`.
- Prefer code-driven tweens unless DOTween Pro scene authoring is confirmed and needed by the prefab workflow.
- Use `SetLink(gameObject)` or explicit `Kill` for GameObject-owned tweens; control nested tweens through the owning `Sequence`.
- Store a field for any tween that can overlap with itself, then kill, rewind, complete, or restart intentionally before creating another one.
- Do not override shortcut tween targets with `SetTarget` unless target-based operations and grouping are understood; prefer `SetId` for feature grouping.
- Use independent update for UI that must animate while `Time.timeScale == 0`; use fixed update intentionally for physics-aligned Rigidbody tweens.
- Avoid allocating tweens every frame and avoid mutating shared materials unless the shared asset is intentionally animated globally.
- Specify user-facing animation duration, ease, loop, update behavior, and lifecycle cleanup explicitly.
- Finish Unity work with compilation, Console checks, and the repository's Unity completion gate when available.

## Review Checklist

- The target exists for the entire tween lifetime or is linked/killed safely.
- Repeated calls cannot stack unintended duplicate tweens.
- Disable, destroy, and panel close/open races are handled.
- Time-scale behavior matches gameplay and UX needs.
- Sequence target and lifetime are controlled at the sequence level.
- Physics and material tweens use the intended update path and asset ownership.
- UI layout tweens use UI-specific targets when layout matters.
- Callbacks cannot mutate stale state after the owner is disabled or destroyed.
