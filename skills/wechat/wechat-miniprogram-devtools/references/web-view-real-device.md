# Web-View And Real Device

## Web-View Pitfalls

- A remote H5 page inside `web-view` is a separate deployment surface. Changing the mini program bundle does not update remote map/search code unless that H5 asset is also deployed and fetched from the public URL used by the mini program.
- Before issuing a real-device preview QR after web-view changes, verify both the generated `web-view src` and the remote H5 content/version that the real device will load.
- `postMessage` from H5 to mini program is not a reliable sole mechanism for immediate real-device navigation. For embedded H5 actions such as "view task" or "start handling", prefer the official `wx.miniProgram.navigateTo` bridge when available, and keep messages for compatibility/logging evidence.
- `web-view` content may not forward browser console/network logs to the mini-program AppService stream. Use an explicit H5-to-mini-program bridge, local H5 browser testing, DevTools local logs, or deeper DevTools integration when needed.

## Maps, Location, And Input

- Location and keyboard behavior can differ between simulator and phone. Include checks for permission failure feedback, input focus, suggestion selection, and blur-on-map-tap behavior when those flows changed.
- Avoid competing location sources between the embedded H5 page and the mini program parent. If the parent owns native location polling, H5 should request intent and consume parent `showCurrentLocation` updates.
- Do not use URL/current-location cache as the final answer for "my location" taps if the parent can provide a fresh native location.
- Search boxes in map web-views should not hide map markers or jump the viewport while typing unless that is explicitly product behavior.

## Release Surface Split

- Remote H5 assets, backend permissions, and the mini program bundle may each need separate deployment or verification.
- If the change touches only remote `web-view` H5, verify remote public content separately; a new mini program QR does not update the remote page by itself.
