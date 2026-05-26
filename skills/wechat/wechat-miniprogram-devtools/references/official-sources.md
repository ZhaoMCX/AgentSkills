# Official Sources

Use installed WeChat DevTools behavior first for local commands, then official WeChat documentation. CLI flags, automator capabilities, preview/upload options, and screenshot behavior can vary by DevTools version.

## Primary Docs

- DevTools docs: https://developers.weixin.qq.com/miniprogram/dev/devtools/devtools.html
- DevTools CLI: https://developers.weixin.qq.com/miniprogram/dev/devtools/cli.html
- Automated testing quick start: https://developers.weixin.qq.com/miniprogram/dev/devtools/auto/quick-start.html
- DevTools automation API: https://developers.weixin.qq.com/miniprogram/dev/devtools/auto/
- Mini Program configuration: https://developers.weixin.qq.com/miniprogram/dev/reference/configuration/app.html
- `web-view`: https://developers.weixin.qq.com/miniprogram/dev/component/web-view.html

## Source Policy

- Locate the installed DevTools CLI and run its help/version output before using uncommon flags.
- Use the target project's `project.config.json`, `app.json`, generated `project.private.config.json`, and package lock files before generic examples.
- For `miniprogram-automator`, prefer the version installed in the project. Add it only when the task permits dependency changes.
- Treat screenshots, window focus, cache cleanup, login, appid permissions, and preview QR generation as environment-sensitive operations that require local verification.
- Use community posts only as troubleshooting hints after official docs and installed-tool behavior are checked.
