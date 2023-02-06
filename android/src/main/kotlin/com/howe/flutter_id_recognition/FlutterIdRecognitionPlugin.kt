package com.howe.flutter_id_recognition

import android.app.Activity
import android.content.Context
import android.graphics.Bitmap
import androidx.annotation.NonNull
import com.huawei.hms.mlplugin.card.icr.cn.MLCnIcrCapture
import com.huawei.hms.mlplugin.card.icr.cn.MLCnIcrCaptureConfig
import com.huawei.hms.mlplugin.card.icr.cn.MLCnIcrCaptureFactory
import com.huawei.hms.mlplugin.card.icr.cn.MLCnIcrCaptureResult

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterIdRecognitionPlugin */
class FlutterIdRecognitionPlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
    MLCnIcrCapture.CallBack {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private var idNum: String = ""
    private var idName: String = ""
    private lateinit var result: Result
    private lateinit var context: Context
    private lateinit var activity: Activity


    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_id_recognition")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        this.result = result
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }
            "getIDNum" -> {
                startCaptureActivity(this, isFront = true, isRemote = false)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun startCaptureActivity(
        callback: MLCnIcrCapture.CallBack,
        isFront: Boolean,
        isRemote: Boolean
    ) {
        val config: MLCnIcrCaptureConfig = MLCnIcrCaptureConfig.Factory()
            // 设置识别身份证的正反面。
            // true：正面。
            // false：反面。
            .setFront(true)
            // 设置是否使用云侧能力进行识别。
            // true：云侧。
            // false：端侧。
//            .setRemote(false)
            .create()

        val icrCapture: MLCnIcrCapture =
            MLCnIcrCaptureFactory.getInstance().getIcrCapture(config)
        icrCapture.capture(callback, activity)
    }

    override fun onSuccess(captureResult: MLCnIcrCaptureResult?) {
        idName = captureResult?.name ?: ""
        idNum = captureResult?.idNum ?: ""
        // 向Flutter回调执行结果
        if (idNum != null) {
            result.success(mapOf("name" to idName, "idNum" to idNum))
        } else {
            result.error("1111", "失败", null)
        }
    }

    override fun onCanceled() {

    }

    override fun onFailure(p0: Int, p1: Bitmap?) {

    }

    override fun onDenied() {

    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        TODO("Not yet implemented")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        TODO("Not yet implemented")
    }

    override fun onDetachedFromActivity() {
        TODO("Not yet implemented")
    }
}
