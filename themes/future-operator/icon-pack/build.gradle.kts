buildscript {
    // AGP includes Kotlin tooling even for this Java-only app. Match the already cached toolchain.
    configurations.all {
        resolutionStrategy.eachDependency {
            if (requested.group == "org.jetbrains.kotlin" && requested.version == "2.2.10" &&
                !requested.name.startsWith("kotlin-stdlib") && requested.name != "kotlin-reflect"
            ) {
                useVersion("2.4.21")
            }
        }
    }
}

plugins {
    id("com.android.application") version "9.4.0" apply false
}
