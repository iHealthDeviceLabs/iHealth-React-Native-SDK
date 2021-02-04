package com.ihealth.ihealthlibrary;

import android.text.TextUtils;
import android.util.Log;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.Bp5sControl;
import com.ihealth.communication.control.BpProfile;
import com.ihealth.communication.manager.iHealthDevicesManager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@ReactModule(name = "BP5SModule")
public class BP5SModule extends iHealthBaseModule {

    private static final String moduleName = "BP5SModule";
    private static final String TAG = "BP5SModule";
    private static final String EVENT_NOTIFY = "event_notify_bp5s";

    public BP5SModule(ReactApplicationContext reactContext) {
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
    public void getBattery(String mac) {
        Bp5sControl bp5sControl = getBp5sControl(mac);
        if (bp5sControl != null) {
            bp5sControl.getBattery();
        }
    }

    @ReactMethod
    public void getOffLineNum(String mac) {
        Bp5sControl bp5sControl = getBp5sControl(mac);
        if (bp5sControl != null) {
            bp5sControl.getOfflineDataNum();
        }
    }

    @ReactMethod
    public void getOffLineData(String mac) {
        Bp5sControl bp5sControl = getBp5sControl(mac);
        if (bp5sControl != null) {
            bp5sControl.getOfflineData();
        }
    }

    @ReactMethod
    public void getFunctionInfo(String mac) {
        Bp5sControl bp5sControl = getBp5sControl(mac);
        if (bp5sControl != null) {
            bp5sControl.getFunctionInfo();
        }
    }

    @ReactMethod
    public void startMeasure(String mac) {
        Bp5sControl bp5sControl = getBp5sControl(mac);
        if (bp5sControl != null) {
            bp5sControl.startMeasure();
        }
    }

    @ReactMethod
    public void stopMeasure(String mac) {
        Bp5sControl bp5sControl = getBp5sControl(mac);
        if (bp5sControl != null) {
            bp5sControl.interruptMeasure();
        }
    }

    @ReactMethod
    public void enbleOffline(String mac, int mode) {
        Bp5sControl bp5sControl = getBp5sControl(mac);
        if (bp5sControl != null) {
            bp5sControl.setMode(mode);
        }
    }

    @ReactMethod
    public void deleteData(String mac) {
        Bp5sControl bp5sControl = getBp5sControl(mac);
        if (bp5sControl != null) {
            bp5sControl.deleteMemoryData();
        }
    }

    @ReactMethod
    public void disconnect(String mac) {
        Bp5sControl bp5sControl = getBp5sControl(mac);
        if (bp5sControl != null) {
            bp5sControl.disconnect();
        }
    }

    private void senErrMessage(int errId) {
        WritableMap params = Arguments.createMap();
        params.putInt("errorid", errId);
        sendEvent(EVENT_NOTIFY, params);
    }

    private Bp5sControl getBp5sControl(String mac) {
        Bp5sControl bp5sControl = iHealthDevicesManager.getInstance().getBp5sControl(mac);
        if (bp5sControl == null) {
            senErrMessage(400);
        }
        return bp5sControl;
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
        List<String> devices = iHealthDevicesManager.getInstance().getBp5sDevices();
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
