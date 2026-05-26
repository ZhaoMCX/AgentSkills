# Preview Upload

## Preview QR Checklist

Before handing a QR to a tester:

1. Confirm the generated mini program output is current for the intended source changes.
2. Run the required simulator regression, not only a quick smoke gate, when the change affects navigation, role visibility, forms, maps, web-view, or writes.
3. If the change affects remote H5 inside `web-view`, verify the public remote asset/version separately.
4. Generate the preview using image QR output when supported by the installed CLI.
5. Open/decode the generated QR image and report dimensions, byte size, and path. A terminal text QR saved as `.png`/`.jpg` is a broken artifact.
6. Tell the user when the QR is a preview artifact with limited validity; regenerate after expiry.

## Upload And Release Safety

- Treat preview/upload as user-visible release work. Preview may require login; upload affects the mini program management workflow.
- Confirm appid, version, description, target project, and account permission before upload.
- Keep preview QR artifacts and uploaded package metadata out of repo-tracked files unless the project has a clear artifact convention.
- If a QR is expired, regenerate it from the current verified build. Do not reuse old QR paths.

## Common Release Mistakes

- Publishing a QR code before rerunning simulator smoke for the changed flows.
- Treating a quick prepreview gate as proof that every role page, subpage, web-view action, and write path works.
- Handing over a QR file without validating that it is a real readable image.
- Forgetting that remote H5 assets, backend permissions, and the mini program bundle may each need separate deployment or verification.
