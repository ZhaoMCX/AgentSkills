---
name: unity-steamworks-net
description: Guides Unity Steamworks.NET integration with lifecycle ownership, callback/CallResult handling, native binaries, service boundaries, and troubleshooting. Use when integrating, reviewing, debugging, or planning Steamworks.NET in Unity projects, especially SteamManager lifecycle, callbacks, achievements, stats, leaderboards, lobbies, auth, cloud, FishySteamworks coexistence, Steam DLL/IL2CPP builds, SteamAPI.Init failures, or overlay issues.
---

# Steamworks.NET

## Overview

Use Steamworks.NET as the Unity-facing C# wrapper for Valve Steamworks APIs. Treat the local Unity package/source as the first source of truth, then confirm behavior with official Steamworks.NET docs and Valve docs when wrapper semantics mirror Valve's API.

## Reference Map

- `references/integration-guide.md`: installation, lifecycle, callbacks, API areas, FishySteamworks boundary, and runtime checks.
- `references/service-patterns.md`: project-owned service boundaries, sample interfaces, achievements/stats, leaderboards, lobbies, auth, cloud, and FishNet/FishySteamworks integration patterns.
- `references/troubleshooting.md`: symptom-based diagnosis for init failures, missing DLLs, overlay, callbacks, achievements, stats, leaderboard, lobby, FishySteamworks, IL2CPP, and local multiplayer issues.
- `references/source-map.md`: source layout, important files, generated wrapper map, SteamManager behavior, official source links, and useful searches.

## When Not To Use

- Facepunch-only projects unless the task is migration or conflict review.
- Pure Valve Web API/backend work with no Unity/Steamworks.NET client.
- Non-Unity Steam SDK work unless Steamworks.NET source mapping is still relevant.

## Read First

Before adding or changing Steamworks.NET behavior:

1. Identify how Steamworks.NET is installed: UPM package, imported `.unitypackage`, embedded package, or vendor folder.
2. Inspect local source for exact signatures and version markers before writing code.
3. Find the active Steam lifecycle owner; a Unity project should have one initialization path and one callback pump.
4. Start bug reports with `references/troubleshooting.md`.
5. Use online docs only when local files do not answer the question or the task asks for current version guidance.

## Decision Rules

| Situation | Default choice |
| --- | --- |
| Unity project needs Steam APIs and FishNet transport uses FishySteamworks | Use Steamworks.NET as the Steam wrapper and FishySteamworks as transport only. |
| Project already uses Facepunch.Steamworks | Do not add Steamworks.NET casually; use a Facepunch-compatible transport or plan a migration. |
| Multiple Steam managers exist | Consolidate to one lifecycle owner before adding features. |
| Callback does not fire | Verify `RunCallbacks`, callback field lifetime, callback type, and Steam initialization. |
| Steam API signature is uncertain | Inspect local autogen/types files and Valve docs for semantics. |
| Steam cannot run locally | Keep graceful failure paths and report runtime verification as outstanding. |

## Review Checklist

- There is exactly one Steam initialization/shutdown owner and one callback pump.
- Steamworks.NET and Facepunch.Steamworks are not both active without an explicit migration/coexistence plan.
- Callback and CallResult objects are stored as live fields or pending-operation objects.
- Stats/achievements persist intentionally and async APIs check `EResult`, failure flags, and invalid handles.
- Editor and local builds have the intended App ID setup; shipping behavior is deliberate.
- Platform native binaries match the target build and IL2CPP settings.
- Steam APIs fail gracefully when Steam is unavailable or initialization fails.
- Lobby, matchmaking, transport, and backend auth boundaries are clear.
- Unity Console, a real Steam client run, and at least one player build verify the integration path when feasible.
