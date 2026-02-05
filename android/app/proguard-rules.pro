# Add project specific ProGuard rules here.
# Flutter specific rules
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }

# SharedPreferences
-keep class io.flutter.plugins.sharedpreferences.** { *; }
-keep class androidx.datastore.** { *; }

# Keep native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep Parcelables
-keepclassmembers class * implements android.os.Parcelable {
    static ** CREATOR;
}

# Don't warn about missing classes
-dontwarn io.flutter.**
-dontwarn android.**
-dontwarn androidx.**

# Keep annotation
-keepattributes *Annotation*

# Prevent R8 from stripping interfaces
-keep,allowobfuscation interface * {
    <methods>;
}
