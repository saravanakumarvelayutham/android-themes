# Verification

## Completed

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

## Still to check on the phone

The build task did not install the APK or apply wallpaper/settings. The connected phone was inspected only for its installed package, signing compatibility, and display size (1080 × 2410). Its temporary APK copy was deleted immediately after checking the certificate.

After installation: preview/apply the live wallpaper; verify motion, 30-second settling, touch wake, screen-off behavior, and Remove animations; add/resize the widget and confirm it opens conversation without executing anything; inspect enlarged text and both appearances; exercise a normal operator request, any required approval, and the recorded outcome. Measure battery use before making efficiency claims. Test sound loudness and icon readability on the phone.

## Artifact identity

APK SHA-256: `c693862e5e4f6d8ecbdd6feec9804dc0152fd2b9a24203ac6d0c2e92f937c66a`

Signing certificate SHA-256: `4209138a13c2bc0ce0c02370931405b15d90ba46121d5a98f93e0031082dc463`
