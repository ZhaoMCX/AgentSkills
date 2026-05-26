# Skills

[English](README.md) | [简体中文](README.zh-CN.md)

个人 Codex 技能仓库，使用轻量级的 Matt Pocock 风格技能目录统一维护。

## 目录结构

```text
skills/<category>/<skill-name>/
  SKILL.md
  references/
  scripts/
```

只有 `SKILL.md` 是必需的。分类目录只用于组织仓库源码；安装时技能会按技能名直接复制到本地 Codex 全局技能目录。

## 技能

### Dev

- [Git Commit](skills/dev/git-commit) - 指导原子化 Git 提交、暂存检查、提交信息规范、可选确认和可选小步提交工作流。

### Game

- [Game Structure](skills/game/game-structure) - 将玩法逻辑放入 Module、Data、State、Rule、Ability、UseCase、Result、Surface 和 Adapter 等职责边界。

### Ops

- [Server Operation Guardrails](skills/ops/server-operation-guardrails) - 为 SSH、生产/预发服务器、Nginx/TLS、数据库、防火墙、部署和其它远程操作应用安全规则。

### RuoYi

- [RuoYi Framework](skills/ruoyi/ruoyi-framework) - 处理经典若依单体项目，覆盖 Spring Boot、Shiro、Thymeleaf、MyBatis XML、Druid、Quartz 和内置代码生成器。
- [RuoYi Vue](skills/ruoyi/ruoyi-vue) - 处理若依前后端分离 Vue2 项目族，覆盖 Spring Security/JWT 后端和 Vue2/Element UI 前端。
- [RuoYi Vue3](skills/ruoyi/ruoyi-vue3) - 处理若依 Vue3 独立前端项目，覆盖 Vite、Element Plus、Pinia、动态路由和权限指令。
- [RuoYi Cloud](skills/ruoyi/ruoyi-cloud) - 处理若依微服务项目族，覆盖 Gateway、Auth、Nacos、Feign、Redis、Sentinel、Seata 和多模块服务。
- [RuoYi App](skills/ruoyi/ruoyi-app) - 处理若依移动端 App 模板，覆盖 uni-app Vue2、token 登录、请求封装、导航拦截和后端对接。

### Unity

- [Unity DOTween](skills/unity/unity-dotween) - 安全地实现、审查和调试 Unity DOTween 动画。
- [Unity FishNet](skills/unity/unity-fishnet) - 实现、审查和调试 FishNet 网络功能。
- [Unity Odin](skills/unity/unity-odin) - 使用 Odin Inspector 和 Sirenix Serializer。
- [Unity Steamworks.NET](skills/unity/unity-steamworks-net) - 在 Unity 中集成和调试 Steamworks.NET。
- [Unity TapTap SDK](skills/unity/unity-taptap-sdk) - 在 Unity 中集成和调试 TapTap SDK。

### UniApp

- [UniApp Development](skills/uniapp/uniapp-development) - 处理 uni-app、uni-app x、DCloud、H5、App 和小程序项目。

### WeChat

- [WeChat Mini Program DevTools](skills/wechat/wechat-miniprogram-devtools) - 使用官方微信开发者工具 CLI 和 miniprogram-automator 工作流。

## 同步

使用这些脚本处理两个常见同步方向。

将仓库技能同步到本地 Codex 全局技能目录：

```powershell
.\scripts\sync-to-global.ps1
```

将全局技能同步回本仓库中已经存在的技能：

```powershell
.\scripts\sync-from-global.ps1
```

`sync-from-global.ps1` 默认跳过 Agent 专属的 `agents/` 元数据，让仓库保持跨 Agent 可用。只有当某个技能有意保存 Agent 专属 UI 元数据时，才传入 `-IncludeAgentMetadata`。

同步一个分类：

```powershell
.\scripts\sync-to-global.ps1 -Category unity
.\scripts\sync-from-global.ps1 -Category unity
```

同步一个技能：

```powershell
.\scripts\sync-to-global.ps1 -Skill game-structure
.\scripts\sync-from-global.ps1 -Skill game-structure
```

## 安装

安装所有技能到本地 Codex 技能目录：

```powershell
.\scripts\install.ps1
```

安装一个分类：

```powershell
.\scripts\install.ps1 -Category unity
```

安装一个技能：

```powershell
.\scripts\install.ps1 -Skill game-structure
```

`install.ps1` 保留为“仓库同步到全局技能目录”的向后兼容名称。日常新用法优先使用 `sync-to-global.ps1`。

## 校验

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\validate-skills.ps1
```

## 备注

Unity `.meta` 文件会被有意排除。本仓库打包的是 Codex 技能，不是 Unity 资源。
