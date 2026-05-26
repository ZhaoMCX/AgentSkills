# Automation Pipeline

## Stable Pipeline Pattern

- Split slow GUI startup from fast gates. Use a DevTools warm/open step once, then run healthcheck, smoke, map/web-view checks, and visual capture against the already-open project when possible.
- Do not put DevTools cold start, login prompts, preview upload, or full visual capture inside a tight unit-test timeout. Give GUI steps their own timeout and clear failure category.
- On Windows, DevTools simulator automation is not reliable when the IDE is only a background/minimized process. Before route assertions, web-view checks, or OS screenshots, restore the main DevTools window, move/size it predictably, bring it to the foreground, and wait briefly for repaint.
- When starting from an unknown DevTools state, run the official CLI `quit` first, then clean leftover DevTools install-directory processes only as a fallback. A stale visible main window can cause automator to connect to a wrong or half-stale session.
- Open the generated mini program project window before enabling `auto`; for uni-app this means the compiled `mp-weixin` output. Then connect automator to the intended port.
- Avoid repeatedly killing or closing DevTools during a regression run. After automator checks, prefer `miniProgram.disconnect()` and leave the warmed DevTools session available for the next check.
- Do not default to `miniProgram.close()` or CLI `close` at the end of automation; DevTools can show close-confirm dialogs or hang on shutdown. Close only when the user asks, or when cache clearing requires it.
- When a test appears to wait forever, first add bounded waits around the operation that can hang: DevTools connection, route load, selector wait, `web-view` readiness, screenshot, preview generation, and close/quit.
- Report timeouts by stage. A DevTools startup timeout, app route timeout, screenshot timeout, and backend/API timeout imply different fixes.
- Treat cleanup steps after the main assertion as best-effort unless cleanup is the feature being tested.

## Automator Pattern

Use `miniprogram-automator` from the project when available. If it is missing and automation is needed, ask before adding it as a dev dependency unless the task already permits dependency installation. Confirm the installed package API before copying examples.

```javascript
const automator = require('miniprogram-automator');

const miniProgram = await automator.connect({
  wsEndpoint: 'ws://127.0.0.1:<port>'
});

const page = await miniProgram.reLaunch('/pages/index/index');
await page.waitFor(500);
await page.screenshot({ path: 'tmp/wechat-index.png' });
await miniProgram.disconnect();
```

Adapt selectors and routes to the real project. Prefer waiting for a selector or route state over sleeping; use fixed waits only as a small fallback after navigation or animation.

## Commands And Logs

Do not rely on memory for exact DevTools CLI flags. Run the local CLI help and then use the installed version's syntax.

```powershell
& "<path-to-cli.bat>" --help
& "<path-to-cli.bat>" version
```

Common operation names to look for in help output: `open`, `preview`, `upload`, `build-npm`, automation/auto test startup, and project path arguments.

- `miniprogram-automator` can subscribe to AppService logs with `miniProgram.on("console", ...)` and runtime errors with `miniProgram.on("exception", ...)`. Save these into the test report when possible.
- DevTools CLI stdout/stderr is useful for project-level state: startup port, selected AppID, cache cleanup, preview/upload errors, and login/permission blockers.
- A clean report should distinguish functional assertion failures, screenshot/capture failures, AppService console messages, AppService exceptions, DevTools CLI output, and web-view/H5 diagnostics.
- For regression runs with real backend writes, record run ID, record prefix, role, endpoint, returned or looked-up backend IDs, created time, and cleanup status.
- For role-based simulator regressions, reuse prepared fixture accounts and cached role tokens when the project provides them.
