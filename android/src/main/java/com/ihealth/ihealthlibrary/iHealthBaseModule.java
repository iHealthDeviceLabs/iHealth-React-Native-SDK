package com.ihealth.ihealthlibrary;

import android.util.Log;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.module.annotations.ReactModule;
import com.facebook.react.modules.core.DeviceEventManagerModule;

/**
 * Created by Jeepend on 21/11/2016.
 * Base class for iHealth Modules, provide sendEvent method for you.
 */
@ReactModule(name = "iHealthBaseModule")
public abstract class iHealthBaseModule extends ReactContextBaseJavaModule {

    private final String TAG;
    private DeviceEventManagerModule.RCTDeviceEventEmitter mEmitter = null;
    public static final String ACTION_GET_ALL_CONNECTED_DEVICES = "action_get_all_connected_devices";

    public iHealthBaseModule(String tag, ReactApplicationContext reactContext) {
        super(reactContext);
        TAG = tag;
    }

    void sendEvent(String eventName, WritableMap data) {
        if (mEmitter == null) {
            mEmitter = getReactApplicationContext().getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class);
        }
        if (mEmitter != null) {
            mEmitter.emit(eventName, data);
        } else {
            Log.e(TAG, "mEmitter is null, can't send event.");
        }
    }

    public abstract void handleNotify(String mac, String deviceType, String action, String message);
}
