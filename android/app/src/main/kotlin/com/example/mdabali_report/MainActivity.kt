package com.example.mdabali_report
import android.os.Bundle
import android.provider.Settings
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity(){
    private val CHANNEL_ANDROID_ID = "device_channel/android_id"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL_ANDROID_ID
        ).setMethodCallHandler { call, result ->
            if (call.method == "getAndroidId") {
                val androidId = Settings.Secure.getString(
                    contentResolver,
                    Settings.Secure.ANDROID_ID
                )
                result.success(androidId)
            } else {
                result.notImplemented()
            }
        }
    }
}
