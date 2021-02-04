package com.ihealth.ihealthlibrary;

import android.text.TextUtils;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.Po1Control;
import com.ihealth.communication.control.Pt3sbtControl;
import com.ihealth.communication.manager.iHealthDevicesManager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@ReactModule(name = "PO1Module")
public class PO1Module extends iHealthBaseModule {

    private static final String modelName = PO1Module.class.getSimpleName();
    private static final String TAG = PO1Module.class.getSimpleName();

    private static final String EVENT_NOTIFY = "event_notify_po1";

    public PO1Module(ReactApplicationContext reactContext) {
        super(TAG, reactContext);
    }

    @Override
    public String getName() {
        return modelName;
    }

    @Override
    public Map<String, Object> getConstants() {
        Map<String, Object> map = new HashMap<>();
        map.put("Event_Notify", EVENT_NOTIFY);
        return map;
    }

    @ReactMethod
    public void getBattery(String mac) {
        Po1Control po1Control = getPo1Control(mac);
        if (po1Control != null) {
            po1Control.getBattery();
        }
    }

    @ReactMethod
    public void disconnect(String mac) {
        Po1Control po1Control = getPo1Control(mac);
        if (po1Control != null) {
            po1Control.disconnect();
        }
    }

    private Po1Control getPo1Control(String mac) {
        Po1Control po1Control = iHealthDevicesManager.getInstance().getPo1Device(mac);
        if (po1Control == null) {
            senErrMessage(400);
        }
        return po1Control;
    }

    private void senErrMessage(int errId) {
        WritableMap params = Arguments.createMap();
        params.putInt("errorid", errId);
        sendEvent(EVENT_NOTIFY, params);
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
        List<String> devices = iHealthDevicesManager.getInstance().getPo1Devices();
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
