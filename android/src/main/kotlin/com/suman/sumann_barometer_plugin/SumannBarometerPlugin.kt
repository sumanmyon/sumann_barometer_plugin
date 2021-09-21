package com.suman.sumann_barometer_plugin

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.util.Log
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** SumannBarometerPlugin */
class SumannBarometerPlugin : FlutterPlugin, MethodCallHandler, SensorEventListener {
  private val TAG = "BarometerPlugin"
  private lateinit var channel: MethodChannel
  private lateinit var mRegistrar: FlutterPlugin.FlutterPluginBinding
  private var mLatestReading: Float = 0f

  //barometer
  private lateinit var sensorManager: SensorManager
  private var mBarometer: Sensor? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    mRegistrar = flutterPluginBinding
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "sumann_barometer_plugin")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if (call.method.equals("initializeBarometer")) {
      val init = initializeBarometer()
      result.success(init)
    } else if (call.method.equals("getBarometer")) {
      val reading = getBarometer()
      result.success(reading)
    } else {
      result.notImplemented()
    }
    return
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  fun initializeBarometer(): Boolean {
    Log.d(TAG, "BarometerPlugin----------> initializeBarometer")
    sensorManager = mRegistrar.applicationContext.getSystemService(Context.SENSOR_SERVICE) as SensorManager
    mBarometer = sensorManager.getDefaultSensor(Sensor.TYPE_PRESSURE)
    mBarometer?.also { baro ->
      sensorManager.registerListener(this, baro, SensorManager.SENSOR_DELAY_NORMAL)
    }

    return true
  }

  fun getBarometer(): Float {
    Log.d(TAG, "BarometerPlugin----------> getBarometer")
    return mLatestReading
  }

  override fun onSensorChanged(event: SensorEvent?) {
    mLatestReading = event!!.values[0]
  }

  override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {
  }

}
