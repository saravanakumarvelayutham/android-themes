# Verification

## Completed

- Widget refinement 65e4264, integrated with remote main 7654de7: full verify passed; 267 app tests with zero failures/errors. Installed via compatible update and visually verified. Smart Search was removed through the launcher UI; the compact neural console was centered and its tap opened the existing assistant conversation.

- `gradlew :app:compileDebugKotlin :app:testDebugUnitTest --tests '*AppNavTest' :app:ktlintCheck -PincludeDevDefaults=false`: passed.
- Repository `gradlew verify -PincludeDevDefaults=false`: passed after fixing the Windows host persistence fixtures. Includes Android lint, APK assembly, formatting, Android-module unit tests, and included-core checks.
- Final app unit tests after integrating remote main `165812c`: **256 tests, zero failures/errors**.
- `git diff --check`: passed before committing. Installation and on-phone validation remain separate from source publication.
- APK signature verification: passed. The package certificate matches the assistant currently installed on the connected Pixel 11 Pro. An update can preserve its app storage; no uninstall is needed for signing compatibility.
- APK manifest inspection: the built artifact includes LivingWallpaperService and OperatorWidgetProvider, with their wallpaper/widget metadata.
- Generated BuildConfig has empty DEV_AI_API_KEY, DEV_AI_BASE_URL and DEV_AI_MODEL. Local model defaults are excluded from this delivered debug package.
- Icons: twelve native SVGs parse; matching PNG contact sheet visually inspected.
- Original WAVs: PCM16, mono, 44.1kHz; zero clipped samples; zero-valued endpoints.
- Build helper PowerShell syntax: passed.

## Windows fixture repair

Three existing storage tests initially failed at the first write because the Android DataStore file backend uses File.renameTo to replace an existing target. A separate Java probe reproduced that replacement failure on this Windows host. Merely changing the factory's file/path syntax would still select the same backend; its installed bytecode was inspected before choosing a fix.

The JVM fixtures now use DataStore's public OkioStorage and PreferencesSerializer, exercising real disk persistence and the same repository APIs. Only tests and a test-scoped dependency changed. Phone production storage, serialization semantics, and action policy were not modified. The targeted storage tests and final full verify passed.

## Phone setup verified

On 2026-10-13, the assistant APK was installed with `adb install -r` successfully. Normal launcher startup and the operator intent completed; no current-process crash was observed. Existing assistant conversations and model configuration remained available.

- Android wallpaper state confirms `LivingWallpaperService` with `mWhich=3`, covering home and lock screens. Motion was observed between screenshots.
- HOME role holder is `ginlemon.flowerfree` (Smart Launcher). Its sample promotional page was removed.
- `dumpsys appwidget` confirms OperatorWidgetProvider bound to Smart Launcher. It was added through the normal widget picker, resized, and tapped to open the existing conversation.
- Living Midnight Icons installed successfully. Custom icons were visually verified on home and in the app drawer. Unmapped apps retain original icons on this launcher configuration.
- Wallpaper & style saved the first home-wallpaper palette with `TONAL_SPOT`, applying it to both screens. Dark appearance remains enabled.
- Gboard's slate gray theme with blue action key was selected and applied through its Theme screen.
- Read-back sound defaults resolve to `midnight-ringtone`, `midnight-notification`, and `midnight-alarm`. Existing alarm schedules and volume levels were preserved.
- Icon pack `assembleDebug` and `lintDebug` passed, with four resource-reference warnings for files consumed by external launchers. It requests no permissions and has no runtime libraries. APK signature verification passed.

## Remaining behavioral checks

Still to verify: 30-second settling, touch wake, screen-off behavior, Remove animations, enlarged text and both appearances, and a normal operator request with any required approval and recorded outcome. No assistant request was submitted merely to test theme setup. Measure battery use before making efficiency claims. Sound defaults are configured; loudness at the user's usual alarm volume remains a user experience check.

## Artifact identity

APK SHA-256: `d9786090303f67c08d7de8f68d7cc23120aa4a54da9cb5df3433e198032ab8f4`

Signing certificate SHA-256: `4209138a13c2bc0ce0c02370931405b15d90ba46121d5a98f93e0031082dc463`
