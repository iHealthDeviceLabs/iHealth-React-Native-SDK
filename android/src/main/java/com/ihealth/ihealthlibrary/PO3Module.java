package com.ihealth.ihealthlibrary;

import android.text.TextUtils;
import android.util.Log;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.Po3Control;
import com.ihealth.communication.manager.iHealthDevicesManager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by lixuesong on 2016/11/21.
 */
@ReactModule(name = "PO3Module")
public class PO3Module extends iHealthBaseModule {
    private static final String modelName = "PO3Module";
    private static final String TAG = "PO3Module";

    private static final String EVENT_NOTIFY = "event_notify_po3";

    public PO3Module(ReactApplicationContext reactContext) {
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

    private static Po3Control getControl(String mac) {
        return iHealthDevicesManager.getInstance().getPo3Control(mac);
    }

    @ReactMethod
    public void getBattery(String mac) {
        Po3Control po3Control = getControl(mac);
        if (po3Control != null) {
            po3Control.getBattery();
        } else {
            Log.e(TAG, "Can not find PO3 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void startMeasure(String mac) {
        Po3Control po3Control = getControl(mac);
        if (po3Control != null) {
            po3Control.startMeasure();
        } else {
            Log.e(TAG, "Can not find PO3 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void getHistoryData(String mac) {
        Po3Control po3Control = getControl(mac);
        if (po3Control != null) {
            po3Control.getHistoryData();
        } else {
            Log.e(TAG, "Can not find PO3 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void disconnect(String mac) {
        Po3Control po3Control = getControl(mac);
        if (po3Control != null) {
            po3Control.disconnect();
        } else {
            Log.e(TAG, "Can not find PO3 Control mac:" + mac);
        }
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
        List<String> devices = iHealthDevicesManager.getInstance().getPo3Devices();
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
