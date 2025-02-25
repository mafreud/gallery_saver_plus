package carnegietechnologies.gallery_saver

import android.app.Activity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

class GallerySaverPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

    private lateinit var channel: MethodChannel
    private var activity: Activity? = null
    private var gallerySaver: GallerySaver? = null

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "gallery_saver")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        when (call.method) {
            "saveImage" -> gallerySaver?.checkPermissionAndSaveFile(call, result, MediaType.image)
            "saveVideo" -> gallerySaver?.checkPermissionAndSaveFile(call, result, MediaType.video)
            else -> result.notImplemented()
        }
    }

    override fun onAttachedToActivity(@NonNull binding: ActivityPluginBinding) {
        this.activity = binding.activity
        gallerySaver = GallerySaver(activity!!)
        binding.addRequestPermissionsResultListener(gallerySaver!!)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        println("onDetachedFromActivityForConfigChanges")
    }

    override fun onReattachedToActivityForConfigChanges(@NonNull binding: ActivityPluginBinding) {
        this.activity = binding.activity
        println("onReattachedToActivityForConfigChanges")
    }

    override fun onDetachedFromActivity() {
        this.activity = null
        gallerySaver = null
        println("onDetachedFromActivity")
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}