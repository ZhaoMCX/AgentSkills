# Skills

[English](README.md) | [简体中文](README.zh-CN.md)

Personal Codex skills maintained as a single repository with lightweight, Matt Pocock-style skill folders.

## Layout

```text
skills/<category>/<skill-name>/
  SKILL.md
  references/
  scripts/
```

Only `SKILL.md` is required. Categories organize source files only; installed skills are copied directly into the local Codex skills directory by skill name.

## Skills

### Dev

- [Git Commit](skills/dev/git-commit) - Guide atomic Git commits, staging checks, commit message conventions, and pre-commit confirmation.

### Game

- [Game Structure](skills/game/game-structure) - Place gameplay logic into Module, Data, State, Rule, Ability, UseCase, Result, Surface, and Adapter responsibilities.

### Ops

- [Server Operation Guardrails](skills/ops/server-operation-guardrails) - Apply safety rules for SSH, production/staging servers, Nginx/TLS, databases, firewalls, deployments, and other remote operations.

### RuoYi

- [RuoYi Framework](skills/ruoyi/ruoyi-framework) - Work on classic RuoYi monolith projects with Spring Boot, Shiro, Thymeleaf, MyBatis XML, Druid, Quartz, and the built-in code generator.
- [RuoYi Vue](skills/ruoyi/ruoyi-vue) - Work on RuoYi Vue2 front/back separated projects with Spring Security/JWT backends and Vue2/Element UI frontends.
- [RuoYi Vue3](skills/ruoyi/ruoyi-vue3) - Work on standalone RuoYi Vue3 frontends with Vite, Element Plus, Pinia, dynamic routes, and permission directives.
- [RuoYi Cloud](skills/ruoyi/ruoyi-cloud) - Work on RuoYi microservice projects with Gateway, Auth, Nacos, Feign, Redis, Sentinel, Seata, and multi-module services.
- [RuoYi App](skills/ruoyi/ruoyi-app) - Work on RuoYi mobile app templates with uni-app Vue2, token login, request wrappers, navigation guards, and backend integration.

### Unity

- [Unity DOTween](skills/unity/unity-dotween) - Implement, review, and debug Unity DOTween animation safely.
- [Unity FishNet](skills/unity/unity-fishnet) - Implement, review, and debug FishNet networking.
- [Unity Odin](skills/unity/unity-odin) - Work with Odin Inspector and Sirenix Serializer.
- [Unity Steamworks.NET](skills/unity/unity-steamworks-net) - Integrate and debug Steamworks.NET in Unity.
- [Unity TapTap SDK](skills/unity/unity-taptap-sdk) - Integrate and debug TapTap SDK in Unity.

### UniApp

- [UniApp Development](skills/uniapp/uniapp-development) - Work on uni-app, uni-app x, DCloud, H5, app, and mini-program projects.

### WeChat

- [WeChat Mini Program DevTools](skills/wechat/wechat-miniprogram-devtools) - Use official WeChat DevTools CLI and miniprogram-automator workflows.

## Sync

Use these scripts for the two common sync directions.

Sync repository skills to the local global Codex skills directory:

```powershell
.\scripts\sync-to-global.ps1
```

Sync global skills back into this repository for skills that already exist in the repository:

```powershell
.\scripts\sync-from-global.ps1
```

`sync-from-global.ps1` skips Agent-specific `agents/` metadata by default so the repository stays cross-agent. Pass `-IncludeAgentMetadata` only when a skill intentionally stores Agent-specific UI metadata.

Sync one category:

```powershell
.\scripts\sync-to-global.ps1 -Category unity
.\scripts\sync-from-global.ps1 -Category unity
```

Sync one skill:

```powershell
.\scripts\sync-to-global.ps1 -Skill game-structure
.\scripts\sync-from-global.ps1 -Skill game-structure
```

## Install

Install all skills into the local Codex skills directory:

```powershell
.\scripts\install.ps1
```

Install one category:

```powershell
.\scripts\install.ps1 -Category unity
```

Install one skill:

```powershell
.\scripts\install.ps1 -Skill game-structure
```

`install.ps1` is kept as the backward-compatible name for repository-to-global sync. Prefer `sync-to-global.ps1` for new routine usage.

## Validate

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\validate-skills.ps1
```

## Notes

Unity `.meta` files are intentionally excluded. This repository packages Codex skills, not Unity assets.
