# Living Midnight assets

Original assets in a navy, slate and pale-blue palette. No film samples or copied app logos.

## Icons

`icons/` contains 12 editable SVG drawings and matching transparent 256px PNG files:
assistant, browser, calendar, camera, files, mail, maps, messages, music, phone, photos and settings.
`icons-preview.png` shows the complete set.

Use the PNGs with a launcher that supports selecting an individual image for an app icon.
These files are artwork, not an installable Android icon-pack APK. They do not replace icons in
notifications, Android Settings, the lock screen or apps themselves. Keep app labels visible so the
generic artwork remains easy to identify. SVGs are editable source assets rather than Android
VectorDrawable resources.

## Sounds

All WAV files are original additive synthesis, mono PCM16 at 44,100Hz:

| File | Duration | Character | Peak |
|---|---:|---|---:|
| `midnight-notification.wav` | 0.5 seconds | Restrained three-note glass chime | 28% |
| `midnight-ringtone.wav` | 12 seconds | Soft repeating blue-hour melody | 32% |
| `midnight-alarm.wav` | 12 seconds | Same melody with a gradual rise in intensity | 32% |

Note and file envelopes soften attacks and releases. All files begin and end at zero; the ringtone
has a silent seam for looping. Checked decoded PCM samples: no clipping in any file.

Copy sounds to the phone and select them through its ringtone, notification and alarm pickers.
The phone and each app control volume, repetition and supported sound selection. These assets
are not installed automatically. Preview the gentle alarm at your normal phone volume before
relying on it to wake you.

## Reproduce

`generate-assets.ps1` uses PowerShell, built-in .NET additive synthesis, and Windows System.Drawing.
It needs no extra packages and regenerates the icon SVGs/PNGs and WAVs beside itself.
The preview contact sheet is a delivered visual reference; the generator regenerates individual
icons and sounds. File parsing and sample checks verify structure, not perceived loudness on a phone.
