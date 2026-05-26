---
name: unity-fishnet
description: Guides Unity multiplayer work with FishNet by separating authority, lifecycle, communication, synchronization, spawning, scenes, prediction, and transport concerns. Use when implementing, reviewing, debugging, or migrating Unity code that uses FishNet/Fish-Networking, including NetworkManager setup, NetworkObject/NetworkBehaviour lifecycle, RPCs, SyncTypes, broadcasts, ownership, observers, Addressables, prediction, transports, serializers, or Mirror-to-FishNet migration.
---

# FishNet

## Overview

Use FishNet as the networking layer for client-server Unity multiplayer features: startup, authentication, object lifecycle, object-bound communication, persistent state synchronization, spawning, ownership, observer visibility, scene management, Addressables, prediction, and transport configuration.

Always inspect the target project's installed FishNet package/source, `package.json`, release notes, and wrappers first. FishNet APIs move quickly; local source wins over reference snapshots and memory.

## Read First

Before adding or changing FishNet behavior:

1. Locate the install: UPM package/cache, `Assets/FishNet`, imported asset, or Git URL package.
2. Inspect package version, release notes, asmdefs, project wrappers, and project networking conventions.
3. Inspect the scene or prefab with `NetworkManager`; it must not be a `NetworkObject` or parented under one.
4. Inspect child managers: server, client, transport, time, prediction, scene, observer, object pool, and authenticator.
5. Inspect affected prefabs for `NetworkObject`, `NetworkBehaviour`, observer, transform/animator, prediction, ownership, global, despawn, and pooling settings.
6. Confirm network prefab registration; Addressables/runtime prefabs must be registered consistently on server and clients before use.
7. Read only the reference files needed for the task.

## Reference Map

| Task or symptom | Read |
| --- | --- |
| Setup, namespaces, lifecycle, source anchors, review checklist | `references/quick-reference.md` |
| RPCs, SyncTypes, broadcasts, auth, connection events, interactables | `references/communication-and-state.md` |
| Spawning, despawning, pooling, ownership, observers, scenes | `references/spawning-scenes-observers.md` |
| NetworkTransform, NetworkAnimator, prediction, smoothing, motion | `references/prediction-and-motion.md` |
| Addressables network prefabs or addressable scenes | `references/addressables-and-prefabs.md` |
| Mirror conversion, old API upgrades, RPC/property mapping | `references/mirror-migration.md` |
| Serializers, transports, dedicated servers, warnings, verification | `references/serialization-transports-debugging.md` |

## Implementation Workflow

1. Classify the networking need: RPC, SyncType, broadcast, spawn/despawn, observer visibility, scene membership, or predicted movement.
2. Decide authority first: server authoritative, owner input with server validation, or server-owned/no-owner object.
3. Put FishNet-specific code in `NetworkBehaviour` only when it needs FishNet lifecycle, RPCs, SyncTypes, ownership, observers, prediction, or managers.
4. Use FishNet callbacks for network initialization and teardown: `OnStartNetwork`, `OnStopNetwork`, `OnStartServer`, `OnStartClient`, and per-observer spawn hooks.
5. Choose communication deliberately: `ServerRpc`, `ObserversRpc`, `TargetRpc`, SyncTypes, or broadcasts.
6. Verify with host plus a separate client for ownership, observers, prediction, scenes, authentication, Addressables, or transport behavior.

## Project Rules

- Use the SyncType API supported by the installed FishNet version; do not copy obsolete attribute patterns without checking local source.
- Prefer current initialized/started/controller properties from local source over obsolete ownership/server/client aliases.
- Do not read owner/controller state in early Unity lifecycle unless the installed FishNet docs/source say it is initialized there.
- Only the server spawns, despawns, grants ownership, and mutates server-synchronized state in the normal authoritative path.
- Treat ownership-bypassing RPCs and unauthenticated broadcasts as security surfaces; validate the caller `NetworkConnection`.
- Use SyncTypes, buffered behavior, or explicit restore paths when late joiners or respawns need current gameplay truth.
- Keep replicated fields self-contained; do not rely on receive order between unrelated SyncTypes.
- Do not let prediction, `NetworkTransform`, and manual writes independently author the same transform without a clear authority split.
- Preserve observer and scene conditions until scene membership and visibility are understood.
- For Addressables, use deterministic nonzero collection ids and register/load bundles on both sides before server spawns.
- Finish Unity work with compilation, Console checks, and multi-client or headless verification when user-facing networking changes.

## Review Checklist

- Authority is explicit for every mutation and request path.
- Startup/teardown uses FishNet lifecycle rather than Unity lifecycle guessing.
- RPC direction, ownership requirement, caller validation, channel, and late-join behavior are correct.
- SyncTypes are initialized once, changed by the correct side, and not treated as current truth after teardown.
- Spawned objects are registered `NetworkObject` prefabs and spawned/despawned only through the intended server path.
- Observer and scene membership explain which clients can see each object.
- Prediction runs from the installed version's supported callbacks and always reconciles.
- Custom serializers read in exactly the same order they write.
