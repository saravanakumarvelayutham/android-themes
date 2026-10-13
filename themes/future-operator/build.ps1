param(
    [string]$AssistantRepository = 'C:/projects/saravlabs-andorid',
    [switch]$Verify
)

$ErrorActionPreference = 'Stop'
$themePreviousJava = $env:JAVA_HOME
$themeJavaOptions = @($env:JAVA_HOME)
if (Test-Path -LiteralPath "$env:LOCALAPPDATA/Java") {
    $themeJavaOptions += Get-ChildItem -LiteralPath "$env:LOCALAPPDATA/Java" -Directory |
        Where-Object { $_.Name -like 'jdk-17*' } |
        Sort-Object Name -Descending |
        Select-Object -ExpandProperty FullName
}
$themeJava = $themeJavaOptions | Where-Object { $_ -and (Test-Path -LiteralPath (Join-Path $_ 'bin/java.exe')) } | Select-Object -First 1
if (-not $themeJava) { throw 'Java 17 is required. Set JAVA_HOME to a valid JDK installation.' }
if (-not (Test-Path -LiteralPath (Join-Path $AssistantRepository 'gradlew.bat'))) { throw 'Assistant repository Gradle wrapper was not found.' }

Push-Location -LiteralPath $AssistantRepository
try {
    $env:JAVA_HOME = $themeJava
    $themeTask = if ($Verify) { 'verify' } else { ':app:assembleDebug' }
    & ./gradlew.bat $themeTask '-PincludeDevDefaults=false' '--console=plain'
    if ($LASTEXITCODE -ne 0) { throw "Gradle failed with exit code $LASTEXITCODE" }
    Copy-Item -LiteralPath (Join-Path $AssistantRepository 'app/build/outputs/apk/debug/app-debug.apk') -Destination (Join-Path $PSScriptRoot 'saravlabs-living-midnight-debug.apk')
} finally {
    $env:JAVA_HOME = $themePreviousJava
    Pop-Location
}
