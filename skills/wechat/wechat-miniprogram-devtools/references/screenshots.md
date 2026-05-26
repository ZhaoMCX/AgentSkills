# Screenshot Reliability

`miniProgram.screenshot()` calls DevTools protocol `App.captureScreenshot`. On some Windows DevTools sessions it can hang even when selectors, text, size, route, API calls, and `web-view` attributes all work.

Do not treat screenshot timeout alone as proof that the page failed to render. If repeated attempts confirm persistent timeout and the root cause is not discoverable from logs or DevTools state, use OS/window capture as the default screenshot path for that environment instead of retrying protocol screenshots.

## When Screenshot Calls Hang

1. Keep functional checks in `miniprogram-automator`: route, required selector, element size, text, form input, API result, `web-view src`.
2. Wrap screenshot calls with a timeout and report them separately from functional failures.
3. For visual QA, use OS/window capture. On Windows, `PrintWindow` can capture the WeChat DevTools main window and avoid `App.captureScreenshot`; crop the simulator area for review. `CopyFromScreen` is less reliable because foreground windows can cover DevTools.
4. Keep DevTools visible and foreground before capture. If the DevTools window is offscreen, minimized, blank, or covered in a way that prevents verification, restore or foreground it first; move/resize only as a last resort.

If the repo already provides a helper such as `scripts/capture-wechat-simulator.ps1` or `scripts/wechat-visual-os.mjs`, prefer that over rewriting capture code.

## Common Mistakes

- Failing a test solely because `miniProgram.screenshot()` timed out while route, selector, size, and API assertions passed.
- Assuming `web-view` H5 logs are available through mini-program `console` events.
