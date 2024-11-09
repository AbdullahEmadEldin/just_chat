-dontwarn com.google.devtools.build.android.desugar.runtime.ThrowableExtension
# Keep rules for Agora
-keep class io.agora.** { *; }
-dontwarn io.agora.**

# Keep rules for awesome_notifications or other plugins
-keep class me.carda.awesome_notifications.** { *; }
-dontwarn me.carda.awesome_notifications.**

# General keep rules (if needed)
-keep class com.google.** { *; }
-dontwarn com.google.**
