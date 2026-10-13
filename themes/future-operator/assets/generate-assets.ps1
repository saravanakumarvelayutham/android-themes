$ErrorActionPreference = 'Stop'
$assetRoot = $PSScriptRoot
$iconsRoot = Join-Path $assetRoot 'icons'
$soundsRoot = Join-Path $assetRoot 'sounds'
New-Item -ItemType Directory -Force -Path $iconsRoot, $soundsRoot | Out-Null
Add-Type -AssemblyName System.Drawing

# Original line drawings share one coordinate system for both SVG and PNG output.
# Paths use only M/L/C/Z so the native renderer stays small and transparent.
$icons = [ordered]@{
    phone = @{ paths = @('M80,62 L104,87 L91,106 C105,130 122,147 148,160 L168,146 L194,172 C175,205 147,198 121,182 C92,163 70,139 59,111 C51,88 56,72 80,62 Z') }
    messages = @{ paths = @('M64,70 L192,70 L192,164 L115,164 L78,190 L78,164 L64,164 Z','M92,106 L164,106 M92,132 L144,132') }
    camera = @{ paths = @('M60,92 L93,92 L104,74 L152,74 L163,92 L196,92 L196,180 L60,180 Z'); circles = @(,@(128,134,27)) }
    browser = @{ paths = @('M62,128 L194,128 M128,62 C95,92 95,164 128,194 C161,164 161,92 128,62 Z'); circles = @(,@(128,128,66)) }
    maps = @{ paths = @('M128,194 C105,164 77,131 77,107 C77,79 100,60 128,60 C156,60 179,79 179,107 C179,131 151,164 128,194 Z'); circles = @(,@(128,106,18)) }
    music = @{ paths = @('M108,166 L108,88 L178,70 L178,148 M108,112 L178,94'); circles = @(@(89,166,19),@(159,148,19)) }
    calendar = @{ paths = @('M64,80 L192,80 L192,190 L64,190 Z M64,110 L192,110 M92,62 L92,94 M164,62 L164,94 M92,140 L108,140 M148,140 L164,140 M92,166 L108,166') }
    settings = @{ paths = @('M128,56 L142,80 L170,78 L178,106 L202,128 L178,150 L170,178 L142,176 L128,200 L114,176 L86,178 L78,150 L54,128 L78,106 L86,78 L114,80 Z'); circles = @(,@(128,128,25)) }
    assistant = @{ paths = @('M54,144 C82,166 169,113 199,98 M54,144 C39,126 88,96 106,88 M199,98 C216,111 184,141 154,155'); circles = @(@(128,128,39),@(190,100,5)) }
    files = @{ paths = @('M60,80 L112,80 L128,100 L196,100 L196,184 L60,184 Z M60,116 L196,116') }
    mail = @{ paths = @('M60,80 L196,80 L196,178 L60,178 Z M60,80 L128,134 L196,80 M60,178 L103,135 M196,178 L153,135') }
    photos = @{ paths = @('M60,64 L196,64 L196,192 L60,192 Z M60,170 L101,124 L128,150 L153,119 L196,166'); circles = @(,@(151,96,11)) }
}
foreach ($entry in $icons.GetEnumerator()) {
    $svg = '<svg xmlns="http://www.w3.org/2000/svg" width="256" height="256" viewBox="0 0 256 256"><defs><linearGradient id="bg" x2="1" y2="1"><stop stop-color="#2A3E58"/><stop offset="1" stop-color="#142136"/></linearGradient></defs><rect x="8" y="8" width="240" height="240" rx="60" fill="url(#bg)" stroke="#45607D" stroke-width="2"/><g fill="none" stroke="#C9E1F7" stroke-width="10" stroke-linecap="round" stroke-linejoin="round">'
    $bitmap = New-Object System.Drawing.Bitmap 256,256
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
    $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $graphics.Clear([System.Drawing.Color]::Transparent)
    $background = New-Object System.Drawing.Drawing2D.GraphicsPath
    $background.AddArc(8,8,120,120,180,90); $background.AddArc(128,8,120,120,270,90)
    $background.AddArc(128,128,120,120,0,90); $background.AddArc(8,128,120,120,90,90); $background.CloseFigure()
    $gradient = New-Object System.Drawing.Drawing2D.LinearGradientBrush ([System.Drawing.Point]::new(8,8)),([System.Drawing.Point]::new(248,248)),([System.Drawing.ColorTranslator]::FromHtml('#2A3E58')),([System.Drawing.ColorTranslator]::FromHtml('#142136'))
    $border = New-Object System.Drawing.Pen ([System.Drawing.ColorTranslator]::FromHtml('#45607D')),2
    $pen = New-Object System.Drawing.Pen ([System.Drawing.ColorTranslator]::FromHtml('#C9E1F7')),10
    $pen.StartCap = $pen.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
    $pen.LineJoin = [System.Drawing.Drawing2D.LineJoin]::Round
    $graphics.FillPath($gradient,$background); $graphics.DrawPath($border,$background)
    foreach ($path in $entry.Value.paths) {
        $svg += '<path d="' + $path + '"/>'
        $outline = New-Object System.Drawing.Drawing2D.GraphicsPath
        $x = 0; $y = 0
        foreach ($part in [regex]::Matches($path,'([MLCZ])([^MLCZ]*)')) {
            $numbers = @([regex]::Matches($part.Groups[2].Value,'-?\d+(?:\.\d+)?') | ForEach-Object { [float]$_.Value })
            switch ($part.Groups[1].Value) {
                'M' { $outline.StartFigure(); $x = $numbers[0]; $y = $numbers[1] }
                'L' { $outline.AddLine($x,$y,$numbers[0],$numbers[1]); $x=$numbers[0]; $y=$numbers[1] }
                'C' { $outline.AddBezier($x,$y,$numbers[0],$numbers[1],$numbers[2],$numbers[3],$numbers[4],$numbers[5]); $x=$numbers[4]; $y=$numbers[5] }
                'Z' { $outline.CloseFigure() }
            }
        }
        $graphics.DrawPath($pen,$outline); $outline.Dispose()
    }
    foreach ($circle in $entry.Value.circles) {
        $cx = $circle[0]; $cy = $circle[1]; $radius = $circle[2]
        $svg += "<circle cx=`"$cx`" cy=`"$cy`" r=`"$radius`"/>"
        $graphics.DrawEllipse($pen, [float]($cx-$radius), [float]($cy-$radius), [float](2*$radius), [float](2*$radius))
    }
    $svg += '</g></svg>'
    [System.IO.File]::WriteAllText((Join-Path $iconsRoot ($entry.Key + '.svg')), $svg)
    $bitmap.Save((Join-Path $iconsRoot ($entry.Key + '.png')), [System.Drawing.Imaging.ImageFormat]::Png)
    $pen.Dispose(); $border.Dispose(); $gradient.Dispose(); $background.Dispose(); $graphics.Dispose(); $bitmap.Dispose()
}

# Additive synthesis creates original tones, with envelopes at every note and file boundary.
Add-Type @'
using System;
using System.IO;
public static class MidnightSounds {
    const int Rate = 44100;
    static double Bell(double t, double f, double length) {
        if (t < 0 || t >= length) return 0;
        double attack = Math.Min(1, t / .018);
        double release = Math.Min(1, (length-t) / .12);
        return attack * release * Math.Exp(-t * 3.8) *
            (Math.Sin(2*Math.PI*f*t) + .22*Math.Sin(2*Math.PI*f*2*t) + .07*Math.Sin(2*Math.PI*f*3*t));
    }
    public static string Make(string path, string kind, double length) {
        int count = (int)(length*Rate);
        var samples = new double[count]; double peak=0;
        double[] notes = {293.6648, 440, 587.3295, 659.2551, 587.3295, 440, 329.6276, 293.6648};
        for (int i=0; i<count; i++) {
            double t=i/(double)Rate, value=0;
            if (kind=="notification") {
                value=Bell(t,587.3295,.5)+.65*Bell(t-.12,880,.38)+.35*Bell(t-.23,1174.659,.27);
            } else {
                for(int n=0;n<8;n++) {
                    double start=n*1.5+.15;
                    value += Bell(t-start,notes[n],1.2);
                    value += .28*Bell(t-start-.12,notes[n]*1.5,1.0);
                }
                if(kind=="alarm") value *= .15+.85*t/length;
            }
            value *= Math.Min(1,t/.025)*Math.Min(1,(length-t)/.25);
            samples[i]=value; peak=Math.Max(peak,Math.Abs(value));
        }
        double target=kind=="alarm"?.32:(kind=="ringtone"?.32:.28);
        short max=0;
        using(var writer=new BinaryWriter(File.Create(path))) {
            writer.Write(System.Text.Encoding.ASCII.GetBytes("RIFF")); writer.Write(36+count*2);
            writer.Write(System.Text.Encoding.ASCII.GetBytes("WAVEfmt ")); writer.Write(16);
            writer.Write((short)1); writer.Write((short)1); writer.Write(Rate); writer.Write(Rate*2);
            writer.Write((short)2); writer.Write((short)16);
            writer.Write(System.Text.Encoding.ASCII.GetBytes("data")); writer.Write(count*2);
            foreach(var sample in samples) {
                short pcm=(short)Math.Round(sample/peak*target*32767);
                max=(short)Math.Max(max,Math.Abs(pcm)); writer.Write(pcm);
            }
        }
        return kind+": "+length+"s, mono PCM16/44100Hz, peak="+max+"/32767, clipped=0";
    }
}
'@
[MidnightSounds]::Make((Join-Path $soundsRoot 'midnight-notification.wav'),'notification',.5)
[MidnightSounds]::Make((Join-Path $soundsRoot 'midnight-ringtone.wav'),'ringtone',12)
[MidnightSounds]::Make((Join-Path $soundsRoot 'midnight-alarm.wav'),'alarm',12)
Get-ChildItem $iconsRoot -Filter '*.svg' | ForEach-Object { $parsed=[xml](Get-Content -LiteralPath $_.FullName -Raw) }
Write-Output "Validated $($icons.Count) SVG files; generated matching 256px PNGs."
