package com.ihealth.ihealthlibrary;

import android.text.TextUtils;
import android.util.Log;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.Hs2Control;
import com.ihealth.communication.manager.iHealthDevicesManager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by lixuesong on 16/10/20.
 */
@ReactModule(name = "HS2Module")
public class HS2Module extends iHealthBaseModule {
    private static final String modelName = "HS2Module";
    private static final String TAG = "HS2Module";

    private static final String EVENT_NOTIFY = "event_notify_hs2";

    public HS2Module(ReactApplicationContext reactContext) {
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

    private static Hs2Control getControl(String mac) {
        return iHealthDevicesManager.getInstance().getHs2Control(mac);
    }

    @ReactMethod
    public void getOfflineData(String mac) {
        Hs2Control control = getControl(mac);
        if (control != null) {
            control.getOfflineData();
        } else {
            Log.e(TAG, "Can not find HS2 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void measureOnline(String mac, int unit, int userId) {
        Hs2Control control = getControl(mac);
        if (control != null) {
            control.measureOnline(unit, userId);
        } else {
            Log.e(TAG, "Can not find HS2 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void disconnect(String mac) {
        Hs2Control hs2Control = getControl(mac);
        if (hs2Control != null) {
            hs2Control.disconnect();
        } else {
            Log.e(TAG, "Can not find HS2 Control mac:" + mac);
        }
    }

    @ReactMethod
    public void getBattery(String mac) {
        Hs2Control hs2Control = getControl(mac);
        if (hs2Control != null) {
            hs2Control.getBattery();
        } else {
            Log.e(TAG, "Can not find HS2 Control mac:" + mac);
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
        List<String> devices = iHealthDevicesManager.getInstance().getHs2Devices();
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
