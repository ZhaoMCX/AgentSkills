# Cache And DevTools State

## Generated Output Freshness

- Confirm which `manifest.json` the build actually uses. Some uni-app projects keep both root `manifest.json` and `src/manifest.json`; the generated `project.config.json` can fall back to `touristappid` if the active source manifest has an empty `mp-weixin.appid`.
- Treat `VITE_*` mini-program values as build-time inputs. If a helper injects values such as map URL/TK, rerun that prepare/build step after any normal command that regenerates `dist/build/mp-weixin`.
- If generated files contain the expected env/config but the simulator still shows old UI, suspect DevTools compile cache before changing app code.

## Cache Cleanup

Use the installed CLI help as authority before running exact cache commands. Prefer the smallest cleanup that addresses the stale state.

Example shape, verify with local `--help` first:

```powershell
& "<path-to-cli.bat>" quit
& "<path-to-cli.bat>" cache --clean compile --project "<path-to-dist/build/mp-weixin>"
```

Avoid `cache --clean all`, `auth`, or `storage` unless the user explicitly accepts losing local DevTools state.

## Common State Mistakes

- Opening a uni-app repo root in DevTools when the generated `mp-weixin` output is the actual mini program project.
- Assuming the CLI is globally available as `cli`; locate the installed `cli.bat` or equivalent first.
- Using automator before DevTools has opened the project and enabled automation.
- Trusting stale DevTools simulator output after env/AppID changes; clear the minimum cache and reopen the generated output first.
- Hiding DevTools login, appid, or permission blockers. Report them and ask the user to complete the interactive step.
