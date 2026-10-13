# Living Midnight

Approved by Sarav on 2026-10-12, following the interactive Midnight preview and motion demo.

## Appearance

Navy `#142036`, slate surfaces `#20304A` / `#2A3D59`, readable pale text `#E5EDF9`, muted `#AAB9CE`, and blue `#A5C7FF` accents. Soft periwinkle and blue illumination replaces the saturated black/green Matrix draft. The coordinated light counterpart uses pearl `#F1F3F7`, ink `#202D44`, and accent `#4469C8`. Existing verified green, decision amber, and failure red keep their meanings.

The existing operator orb follows the real listening, thinking, replying, acting, needs-you, and completion states. Ready motion is a subtle breath, with no fake telemetry or simulated outcomes. The Today screen shows the same operator presence and real status text. Conversations, confirmations, missions, skills, and permissions retain their existing behavior.

## Motion and lifecycle

The live wallpaper is decorative: a drifting blue atmosphere and sculpted orbital core. It neither observes the assistant nor implies a task is running. It draws only while visible on a valid surface, at most 20 frames per second, and settles after 30 seconds. Touch or renewed visibility wakes it. Remove animations freezes motion and settings changes take effect without restart.

The in-app orb and ambient light use lifecycle-aware clocks. Ready/ambient motion settles after 30 seconds; active operator states continue while the activity is resumed. Reduced motion retains labels and colors. Phone battery cost remains a measurement to make on a real device, not an efficiency claim.

## Entry and setup

Settings includes Android's live-wallpaper preview and a system-confirmed widget pin request. The widget has no periodic work or fabricated status. It opens the conversation through a known launch action, without submitting requests, starting the microphone, or granting permissions.

Wallpaper setup goes through Android's preview/apply UI. System colors, keyboard, and launcher icon appearance remain user-controlled platform or launcher settings; installing this app does not globally reskin third-party apps or Quick Settings. External styling instructions ship alongside the APK.

## Delivery

Build a debug package without local model secrets using `./gradlew :app:assembleDebug -PincludeDevDefaults=false`. Existing settings entered in the installed app still take precedence. Validate navigation tests, lint, formatting, APK resources, and the repository's verify gate. Device wallpaper/widget/action workflows remain an explicit on-device check if no phone is connected.
