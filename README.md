# Android themes

Current theme: **Living Midnight**, a living navy-and-blue appearance built around the existing SaravLabs operator.

- [Setup and rebuilding](themes/future-operator/README.md)
- [Verification](themes/future-operator/verification.md)

The local delivery files are `themes/living-midnight.zip` and `themes/future-operator/saravlabs-living-midnight-debug.apk`. Generated APK/ZIP packages are excluded from Git; rebuild the APK with the helper in the setup guide.

Assistant source changes are in [saravlabs-andorid, commit 8bd4f5f](https://github.com/saravanakumarvelayutham/saravlabs-andorid/commit/8bd4f5f), rebased onto main commit `165812c`. The complete repository verify gate passed, including 256 app tests. The assistant and icon pack are installed on the Pixel, with live home/lock wallpaper, Smart Launcher, operator widget, blue system colors, slate keyboard, and custom sound defaults configured. See verification for remaining behavioral checks.

The earlier Matrix artwork is retained under `themes/matrix` as the initial design; Living Midnight is the selected direction.
