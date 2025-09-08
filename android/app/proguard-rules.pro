# Keep `Companion` object fields of serializable classes.
# This avoids serializer lookup through `getDeclaredClasses` as done for named companion objects.
-if @kotlinx.serialization.Serializable class **
-keepclassmembers class <1> {
    static <1>$Companion Companion;
}

# Keep `serializer()` on companion objects (both default and named) of serializable classes.
-if @kotlinx.serialization.Serializable class ** {
    static **$* *;
}
-keepclassmembers class <2>$<3> {
    kotlinx.serialization.KSerializer serializer(...);
}

# Keep all fields of Entry class to use in ImagePicker
-keep class androidx.core.app.** { *; }
-keep class com.google.android.gms.** { *; }
-keep class com.google.android.material.** { *; }

# Image Picker specific rules
-keep class io.flutter.plugins.imagepicker.** { *; }
-keep class android.media.** { *; }
-keep class androidx.lifecycle.** { *; }
-keep class androidx.fragment.app.** { *; }
