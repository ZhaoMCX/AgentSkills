---
name: unity-odin
description: Guides Unity Odin Inspector and Sirenix Serializer work with safe attribute choice, serialization boundaries, editor tooling, drawers, processors, and asmdef separation. Use when implementing, reviewing, debugging, or refactoring Odin attributes, SerializedMonoBehaviour/SerializedScriptableObject data, Odin editor windows, OdinMenuEditorWindow tools, custom Odin drawers, AttributeProcessors, ValueResolver/ActionResolver usage, table/list inspectors, asset selectors, validation attributes, or Sirenix asmdef/API integration.
---

# Odin

## Overview

Use Odin Inspector for richer Unity serialized data editing, ScriptableObject inspectors, editor windows, menu-tree tools, validation, custom drawers, and editor-only workflows.

Always inspect the target project's installed Sirenix/Odin files, XML docs, demos, asmdefs, and config assets first. Local source and package version win over reference notes.

## Read First

Before adding or changing Odin behavior:

1. Inspect the target runtime/editor script and asmdef references.
2. Locate installed Sirenix files, commonly under `Assets/Plugins/Sirenix` or a package/vendor equivalent.
3. Check local XML docs for exact attributes, editor APIs, serialization APIs, and utility APIs.
4. Inspect local demos before writing drawers, AttributeProcessors, menu trees, or editor windows.
5. Read `references/quick-reference.md` for attribute choices, serialization rules, editor extension patterns, and demo path maps.

## Implementation Workflow

1. Choose the smallest Odin feature that solves the problem:
   - Inspector layout only: attributes on fields/properties/methods.
   - Persistence of non-Unity data: Odin serialized base class plus `[OdinSerialize]`.
   - Reusable data editor: serialized ScriptableObject assets with layout and validation attributes.
   - Custom rendering: value, attribute, or group drawers.
   - Global or conditional attribute injection: `OdinAttributeProcessor<T>`.
   - Tool window: `OdinEditorWindow` or `OdinMenuEditorWindow`.
2. Keep runtime and editor code separated through folders, asmdefs, or `#if UNITY_EDITOR`.
3. Preserve data semantics: `[ShowInInspector]` displays data but does not serialize it.
4. Prefer declarative attributes over custom drawers until a drawer removes real complexity.
5. Use Odin APIs for multi-object editing and property mutation instead of direct target-object reflection where possible.
6. Validate with Unity compilation, Console checks, and the repository's Unity completion gate when available.

## Project Rules

- Do not edit vendor files unless the user explicitly asks to patch Odin/Sirenix itself.
- Do not place `UnityEditor`, Odin editor drawers/windows, or `Sirenix.OdinInspector.Editor` references in runtime-only assemblies.
- Use the correct Sirenix base class before relying on Odin serialization for dictionaries, interfaces, polymorphism, or private data.
- If an asmdef cannot see Odin, add explicit references deliberately; do not move scripts only to hide the reference issue.
- Preserve existing linker and AOT policy for IL2CPP-sensitive changes.
- Check project Odin config assets before changing global drawer, validation, or inspector behavior.

## Review Checklist

- Odin attributes improve presentation or editing rather than hiding missing ownership or validation.
- Serialized data uses the correct Sirenix base class and does not assume `[ShowInInspector]` persists values.
- Editor-only APIs are isolated from runtime builds and asmdefs.
- Custom drawers draw next/children deliberately and mutate values through Odin-supported APIs.
- AttributeProcessors have clear scope and do not accidentally affect unrelated types.
- Editor windows rebuild menus intentionally and use search/toolbars where useful.
- Unity Console has no compile errors after changes.
