# Living Midnight Icons

An installable Android icon pack containing the 12 original icons in `../assets/icons`.
Package: `com.saravlabs.midnight.icons`. App label: **Living Midnight Icons**.

The app requests no permissions, contains no libraries or network access, and shows a small
framework-only Java gallery. It does not apply itself or submit assistant actions. Apply it through
your launcher's normal icon-pack selection screen.

## Compatibility and coverage

`appfilter.xml` maps 22 activity components to the 12 icons. The Google app components and
WhatsApp component were verified on the target Pixel; additional browser, dialer, camera, calendar,
file and music components are compatibility aliases. Component names can change with app updates.
`drawable.xml` exposes all 12 drawings to compatible launchers' manual icon selection.
Identical XML files are supplied as both Android resources and assets for launcher compatibility.

Smart Launcher, Nova and ADW/Lawnchair discovery intents are declared. Smart Launcher's supported
themed fallback uses navy/pale-blue colors for apps without custom mappings, when those apps have
compatible monochrome icons. This is not guaranteed for every app. The icons are static artwork;
live motion comes from the separate SaravLabs wallpaper and assistant presence.

This pack affects launcher icons only, not notification icons, lock-screen affordances or app UI.
The Calendar drawing is static and does not claim dynamic date support.

## Build and check

Requirements: JDK 17, Android SDK 37 and Gradle's cached plugin dependencies (or network access).

```powershell
$env:JAVA_HOME = 'C:\Users\sarav\AppData\Local\Java\jdk-17.0.20.1+1'
$env:ANDROID_HOME = 'C:\Users\sarav\AppData\Local\Android\Sdk'
.\gradlew.bat --offline --no-daemon :app:assembleDebug :app:lintDebug
```

AGP is pinned to 9.4.0. It includes Kotlin build tooling even for Java-only applications; the root
build aligns that tooling with the existing cached Kotlin 2.4.21 version while keeping runtime
compatibility artifacts at their requested versions. The app itself has no Kotlin source or runtime
dependency. The Gradle wrapper and its checksum are copied from the existing assistant project.

Debug APK output: `app/build/outputs/apk/debug/app-debug.apk`. This is a locally signed debug build,
not a published store release. Keep this source and the matching signing key for future updates.

## Format references

- [Smart Launcher icon-pack documentation](https://docs.smartlauncher.net/work-with-smart-launcher/icon-packs)
- [Lawnchair icon-pack specification](https://github.com/LawnchairLauncher/docs/blob/main/developers/concepts/icon-packs.md)
- [Nova's documented example](https://github.com/teslacoil/Example_NovaTheme)
