---
name: unity-taptap-sdk
description: Guides Unity TapTap SDK/TapSDK integration with package selection, initialization, adapters, platform setup, PC validation, compliance, IAP, and migration safety. Use when integrating, reviewing, debugging, upgrading, or planning TapTap SDK/TapSDK in Unity projects, including UPM/package manifests, TapTap login, compliance/anti-addiction, cloud save, achievements, leaderboards, IAP, license validation, TapTap PC startup validation, Android/iOS/Windows builds, or migrations from TapSDK v2/v3 to v4.
---

# TapTap SDK For Unity

## Overview

Use the current official TapTap Unity SDK path for new integrations unless the target project is already pinned to an older generation. Treat official TapTap docs and the installed package source as authority, then wrap SDK calls behind a thin game-owned adapter.

## Read First

Before adding or changing TapSDK behavior:

1. Inspect existing packages, `Packages/manifest.json`, imported assets, asmdefs, platform targets, and any project wrapper.
2. Identify the installed generation and module set before mixing v2/v3/v4 package names or APIs.
3. Inspect local `Packages/com.taptap.sdk.*`, package cache source, `Assets/TapSDK*`, or `Assets/Plugins/TapSDK*` for exact public APIs and versions.
4. Re-check official docs before locking versions; package versions, native dependencies, PC rules, IAP, and compliance behavior are version-sensitive.
5. Read `references/tapsdk-v4.md` only for the relevant module, platform, migration, or failure-mode detail.

## Integration Workflow

1. Choose only the modules required by the product feature: login, compliance, cloud save, achievements, leaderboards, friends/relation, moments, online battle, IAP, or TapTap PC.
2. Install through Unity Package Manager when possible; keep all TapSDK modules on compatible versions.
3. Resolve native dependencies and platform settings before feature code:
   - Android: dependency resolution and merged manifest.
   - iOS/macOS: plist, URL/query schemes, Swift/CocoaPods settings, and resource bundles.
   - Windows PC: public key, startup validation, and release-package hygiene.
4. Initialize once at game startup before module calls, including module option objects when required by the installed SDK.
5. Put SDK calls behind a project-owned service/facade so gameplay, UI, save, and platform systems depend on game interfaces.
6. Guard every async SDK call against Unity object lifetime, cancellation, account switches, network errors, and scene transitions.
7. Validate on the actual target platform; Editor compilation is not enough for mobile native dependencies, IAP, iOS post-processing, or TapTap PC flows.

## Project Rules

- Do not invent TapSDK method names; check local package source or `references/tapsdk-v4.md`.
- Do not log or commit TapTap credentials, access tokens, receipts, compliance tokens, or personally identifiable user data.
- Keep initialization idempotent from the game side and avoid scene-local repeated initialization.
- For TapTap PC, validate launch state before protected business calls and handle client state changes when the feature depends on the client staying online.
- For China compliance, tie startup, callbacks, payment checks, and exit to the account/session lifecycle required by the current project and region.
- For IAP, preserve the project receipt/order validation and verify platform support in the installed SDK and official docs.
- For legacy migrations, prove identity, saved data, achievements, compliance behavior, and rollback/read compatibility with real legacy accounts.
- Keep editor-only code, platform post-processors, and runtime assemblies separated through folders/asmdefs.
- Do not edit vendor package files unless the user explicitly asks to patch TapSDK itself.
- Finish Unity work with compilation/build verification appropriate to the repo and inspect Console/build logs for native dependency failures.

## Review Checklist

- Package install method and versions are explicit and compatible across modules.
- Required third-party Unity dependencies and native dependency resolution are present for the target platform.
- Initialization happens once before module calls and passes required module options.
- Platform URL schemes, manifests, plist entries, resources, and build post-processors are preserved.
- TapTap PC, compliance, login, cloud save, leaderboard, online battle, and IAP flows handle failure states and UI lifetime.
- Legacy migrations preserve account and data continuity.
- No credentials, tokens, receipts, or user data are logged or committed.
