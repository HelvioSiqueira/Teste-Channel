package com.example.teste_plugin

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** TestePlugin */
class TestePlugin : FlutterPlugin, MethodCallHandler {

    private lateinit var channelHealthRate: MethodChannel
    private lateinit var channelLocation: MethodChannel
    private lateinit var healthServiceManager: HealthServiceManager

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channelHealthRate = MethodChannel(flutterPluginBinding.binaryMessenger, "teste_plugin")
        channelLocation = MethodChannel(flutterPluginBinding.binaryMessenger, "getLocationToHealth")
        channelHealthRate.setMethodCallHandler(this)
        channelLocation.setMethodCallHandler(this)

        healthServiceManager = HealthServiceManager(flutterPluginBinding.applicationContext)
        healthServiceManager.registerCallbacks()
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {

        when (call.method) {

            "getPlatformVersion" -> {
                result.success(healthServiceManager.getHeatRateData().toString())
            }

            "getLocation" -> {
                result.success(healthServiceManager.getLocationDataMap())
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channelHealthRate.setMethodCallHandler(null)
    }
}
