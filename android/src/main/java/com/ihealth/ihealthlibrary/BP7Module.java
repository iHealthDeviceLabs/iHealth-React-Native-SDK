package com.ihealth.ihealthlibrary;

import android.text.TextUtils;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.Bp7Control;
import com.ihealth.communication.control.BpProfile;
import com.ihealth.communication.control.Po1Control;
import com.ihealth.communication.manager.iHealthDevicesManager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@ReactModule(name = "BP7Module")
public class BP7Module extends iHealthBaseModule {

    private static final String moduleName = BP7Module.class.getSimpleName();
    private static final String TAG = BP7Module.class.getSimpleName();

    private static final String EVENT_NOTIFY = "event_notify_bp7";

    public BP7Module(ReactApplicationContext reactContext) {
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

    private void senErrMessage(int errId) {
        WritableMap params = Arguments.createMap();
        params.putInt("errorid", errId);
        sendEvent(EVENT_NOTIFY, params);
    }

    private Bp7Control getBp7Control(String mac) {
        Bp7Control bp7Control = iHealthDevicesManager.getInstance().getBp7Control(mac);
        if (bp7Control == null) {
            senErrMessage(400);
        }
        return bp7Control;
    }

    @ReactMethod
    public void getBattery(String mac) {
        Bp7Control bp7Control = getBp7Control(mac);
        if (bp7Control != null) {
            bp7Control.getBattery();
        }
    }

    @ReactMethod
    public void startMeasure(String mac) {
        Bp7Control bp7Control = getBp7Control(mac);
        if (bp7Control != null) {
            bp7Control.startMeasure();
        }
    }

    @ReactMethod
    public void stopMeasure(String mac) {
        Bp7Control bp7Control = getBp7Control(mac);
        if (bp7Control != null) {
            bp7Control.interruptMeasure();
        }
    }

    @ReactMethod
    public void enableOfflineMeasurement(String mac) {
        Bp7Control bp7Control = getBp7Control(mac);
        if (bp7Control != null) {
            bp7Control.enableOffline();
        }
    }

    @ReactMethod
    public void getOfflineNum(String mac) {
        Bp7Control bp7Control = getBp7Control(mac);
        if (bp7Control != null) {
            bp7Control.getOfflineNum();
        }
    }

    @ReactMethod
    public void getOfflineData(String mac) {
        Bp7Control bp7Control = getBp7Control(mac);
        if (bp7Control != null) {
            bp7Control.getOfflineData();
        }
    }

    @ReactMethod
    public void conformAngle(String mac) {
        Bp7Control bp7Control = getBp7Control(mac);
        if (bp7Control != null) {
            bp7Control.conformAngle();
        }
    }

    @ReactMethod
    public void disconnect(String mac) {
        Bp7Control bp7Control = getBp7Control(mac);
        if (bp7Control != null) {
            bp7Control.disconnect();
        }
    }

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
        List<String> devices = iHealthDevicesManager.getInstance().getBp7sDevices();
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
