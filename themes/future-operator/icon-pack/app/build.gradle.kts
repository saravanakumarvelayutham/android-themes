plugins {
    id("com.android.application")
}
android {
    namespace = "com.saravlabs.midnight.icons"
    compileSdk = 37
    defaultConfig {
        applicationId = "com.saravlabs.midnight.icons"
        minSdk = 31
        targetSdk = 37
        versionCode = 1
        versionName = "1.0"
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
    lint {
        abortOnError = true
        // The toolchain is pinned and cached; version advice is not an actionable defect.
        disable += setOf("GradleDependency", "NewerVersionAvailable", "AndroidGradlePluginVersion")
    }
}
