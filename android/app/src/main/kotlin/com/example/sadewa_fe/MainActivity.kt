package com.example.sadewa_fe

import io.flutter.embedding.android.FlutterActivity
import android.location.Location
import android.location.LocationManager
import android.os.Bundle
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "mock_location_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "isMockLocation") {
                val locationManager = getSystemService(LOCATION_SERVICE) as LocationManager
                val providers = locationManager.getProviders(true)

                var isMock = false
                if (providers != null) {
                    for (provider in providers) {
                        val location = locationManager.getLastKnownLocation(provider)
                        if (location != null && location.isFromMockProvider) {
                            isMock = true
                            break
                        }
                    }
                }
                result.success(isMock)
            } else {
                result.notImplemented()
            }
        }
    }
}
