# Matrix Operator — whole-phone design proposal

Status: superseded by the futuristic Pearl / Midnight proposal; the user rejected the black-and-green direction. Assistant baseline: `saravlabs-andorid`, clean `main`, commit `3f45942`, fetched 2026-10-12.

## Visual direction

Deep black, faint code at the edges, luminous emerald accents, pale mint text, and restrained monospace labels. Use regular readable text for conversation and decisions. Put atmosphere behind content; never put moving glyphs behind body text. The existing operator orb becomes an emerald code core. Actual operating states drive animation, with reduced-motion support and idle/screen-off pauses.

## Phone surfaces

- Lock: existing cinematic wallpaper, simple mint clock, normal Android notification cards. Preserve the platform lock and authentication flow.
- Home: existing sparse wallpaper, circular green icons, one SaravLabs entry, and a compact operator widget. The widget opens the app to ask for work; it does not execute a mission from the launcher.
- Launcher drawer: dark background and a consistent green icon treatment. Use Smart Launcher and Icon Pack Studio for full app-list coverage; included individual icon artwork is optional and is not an APK icon pack.
- System: Android dark mode and a green Wallpaper & style color palette. Quick Settings and notifications retain Android geometry. A launcher cannot replace these system interfaces.
- Keyboard: Gboard dark background and matching accents where its theme controls allow them. No unsupported promise of exact recoloring inside third-party apps.
- Audio: original restrained digital notification, ringtone, and alarm. No film audio samples.

## Existing assistant integration

The assistant is `com.saravlabs.app`, not Gemini. Its existing Today, Agents, Activity, conversation, people, skills, settings, and permission routes remain the functional foundation.

Change the shared `OperatorColors` tokens and Material theme mapping rather than hand-coloring individual screens. Keep confirmations amber and failures red; a green-only UI must not obscure their meaning. Keep verified and unchecked outcomes explicitly labeled.

Home widget proposal: add an Android AppWidgetProvider to the existing app, showing a neutral **Open operator** button. Route through MainActivity and AppNav to the conversation screen. Opening never grants permissions, executes a task, starts the microphone, or submits a request. Do not fabricate live ready/running states: either derive them from a supported shared state source or omit them. First widget version should be a launcher shortcut with a styled surface, not a second agent runtime.

The existing saved agent profiles share a model, conversation, and policy. Do not present them as independently running workers. Mission selection prepares a request for review through the existing operator. Preserve approval, cancellation, retries, and verification behavior.

## Validation after approval

Inspect local repository instructions and the latest theme consumers before changes. Compile the app, run relevant AppNav tests for widget routing and input handling, and run Android lint for the manifest/widget resources. Verify widget tap -> conversation -> request -> confirmation -> action -> recorded outcome through the real phone workflow when a device is available. Inspect confirmation/failure colors, enlarged text, reduced motion, and light-mode behavior. Use the repository's `gradlew verify` as the broader integration gate.

The preview is an interactive design simulation. It executes no phone actions and displays no live phone telemetry. The phone has not been connected to this session, and no APK has been installed.

## Sources

- Pixel wallpaper and colors: https://support.google.com/pixelphone/answer/7289143?hl=en
- Smart Launcher customization: https://www.smartlauncher.net/features
- Icon Pack Studio recommendation from its developer: https://www.smartlauncher.net/blog/how-to-create-the-perfect-setup-with-smart-launcher
- Existing assistant design approval rule: `C:/projects/saravlabs-andorid/docs/design/README.md`.
