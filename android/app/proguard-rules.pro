# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in /usr/local/Cellar/android-sdk/24.3.3/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.## For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html
# https://articles.wesionary.team/use-of-proguard-in-the-flutter-app-289cd7b31a18

# Add any project specific keep options here:
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-keep class io.flutter.plugin.editing.** { *; }

# Firebase
-keep class com.google.firebase.** { *; }
-keep class com.firebase.** { *; }
-keep class org.apache.** { *; }
-keepnames class com.fasterxml.jackson.** { *; }
-keepnames class javax.servlet.** { *; }
-keepnames class org.ietf.jgss.** { *; }

-keep class com.google.android.play.** { *; }
-keepclassmembers class * {
    @com.google.j2objc.annotations.ReflectionSupport *;
}
-keep class com.google.common.util.concurrent.AbstractFuture { *; }

-dontwarn org.w3c.dom.**
-dontwarn org.joda.time.**
-dontwarn org.shaded.apache.**
-dontwarn org.ietf.jgss.**
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes EnclosingMethod
-keepattributes InnerClasses
-keep class androidx.lifecycle.DefaultLifecycleObserver { *; }

# Keep the classes referenced by com.google.common.util.concurrent.AbstractFuture
-keep class com.google.j2objc.annotations.ReflectionSupport$Level { *; }
-keep class com.google.j2objc.annotations.ReflectionSupport { *; }