pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }

    val flutterSdkPath: String = run {
        val properties = java.util.Properties()
        file(path = "local.properties").inputStream().use { properties.load(it) }
        val flutterSdkPath = properties.getProperty("flutter.sdk")
        require(value = flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
        return@run "$flutterSdkPath/packages/flutter_tools/gradle"
    }

    includeBuild(flutterSdkPath)
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "9.1.0" apply false
    id("org.jetbrains.kotlin.android") version "2.3.20" apply false
    id("org.gradle.toolchains.foojay-resolver-convention") version "1.0.0"
}

rootProject.name = "freefeos_example"
include(":app")
