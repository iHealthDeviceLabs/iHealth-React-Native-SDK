package com.ihealth.ihealthlibrary;

import android.text.TextUtils;
import android.util.Log;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.Bg1sControl;
import com.ihealth.communication.manager.iHealthDevicesManager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@ReactModule(name = "BG1SModule")
public class BG1SModule extends iHealthBaseModule {

    private static final String moduleName = "BG1SModule";
    private static final String TAG = "BG1SModule";
    private static final String EVENT_NOTIFY = "event_notify_bg1s";

    public BG1SModule(ReactApplicationContext reactContext) {
        super(TAG, reactContext);
    }

    @Override
    public String getName() {
        return moduleName;
    }

    @Override
    public Map<String, Object> getConstants() {
        Map<String, Object> map = new HashMap<>();
        map.put("Event_Notify", EVENT_NOTIFY);
        return map;
    }

    @ReactMethod
    public void getFunction(String mac) {
        Bg1sControl Bg1sControl = getBg1sControl(mac);
        if (Bg1sControl != null) {
            Bg1sControl.getDeviceStatus();
        }
    }

    @ReactMethod
    public void measure(String mac,int measureMode) {
        Bg1sControl Bg1sControl = getBg1sControl(mac);
        if (Bg1sControl != null) {
            Bg1sControl.setMeasureMode(measureMode);
        }
    }

    @ReactMethod
    public void disconnect(String mac) {
        Bg1sControl Bg1sControl = getBg1sControl(mac);
        if (Bg1sControl != null) {
            Bg1sControl.disconnect();
        }
    }

    private void senErrMessage(int errId) {
        WritableMap params = Arguments.createMap();
        params.putInt("errorid", errId);
        sendEvent(EVENT_NOTIFY, params);
    }

    private Bg1sControl getBg1sControl(String mac) {
        Bg1sControl Bg1sControl = iHealthDevicesManager.getInstance().getBg1sControl(mac);
        if (Bg1sControl == null) {
            senErrMessage(400);
        }
        return Bg1sControl;
    }

    @Override
    public void handleNotify(String mac, String deviceType, String action, String message) {
        WritableMap params = Arguments.createMap();
        params.putString("action", action);
        params.putString("mac", mac);
        params.putString("type", deviceType);
        if (!TextUtils.isEmpty(message)) {
            Utils.jsonToMap(message, params);
        }
        sendEvent(EVENT_NOTIFY, params);
    }

    @ReactMethod
    public void getAllConnectedDevices() {
        List<String> devices = iHealthDevicesManager.getInstance().getBg1sDevices();
        WritableMap params = Arguments.createMap();
        if (devices.size() > 0) {
            WritableArray array = Arguments.createArray();
            for (String device : devices) {
                array.pushString(device);
            }
            params.putArray("devices", array);
            params.putString("action", ACTION_GET_ALL_CONNECTED_DEVICES);
        }
        sendEvent(EVENT_NOTIFY, params);
    }
}
