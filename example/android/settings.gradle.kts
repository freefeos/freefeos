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
    id("com.android.application") version "8.12.0" apply false
    id("org.jetbrains.kotlin.android") version "2.2.0" apply false
}

rootProject.name = "freefeos_example"
include(":app")
