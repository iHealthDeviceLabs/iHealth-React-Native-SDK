package com.ihealth.ihealthlibrary;

import android.text.TextUtils;
import android.util.Log;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.BtmControl;
import com.ihealth.communication.manager.iHealthDevicesManager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by lixuesong on 2016/11/21.
 */
@ReactModule(name = "BTMModule")
public class BTMModule extends iHealthBaseModule {
    private static final String modelName = "BTMModule";
    private static final String TAG = "BTMModule";

    private static final String EVENT_NOTIFY = "event_notify_btm";

    public BTMModule(ReactApplicationContext reactContext) {
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

    private static BtmControl getControl(String mac) {
        return iHealthDevicesManager.getInstance().getBtmControl(mac);
    }

    @ReactMethod
    public void getBattery(String mac) {
        BtmControl btmControl = getControl(mac);
        if (btmControl != null) {
            btmControl.getBattery();
        } else {
            Log.e(TAG, "Can not find BTM Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setStandbyTime(String mac, int hour, int minute, int second) {
        BtmControl btmControl = getControl(mac);
        if (btmControl != null) {
            btmControl.setStandbyTime(hour, minute, second);
        } else {
            Log.e(TAG, "Can not find BTM Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setTemperatureUnit(String mac, int unit) {
        BtmControl btmControl = getControl(mac);
        if (btmControl != null) {
            btmControl.setTemperatureUnit((byte) unit);
        } else {
            Log.e(TAG, "Can not find BTM Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setMeasuringTarget(String mac, int target) {
        BtmControl btmControl = getControl(mac);
        if (btmControl != null) {
            btmControl.setMeasuringTarget((byte) target);
        } else {
            Log.e(TAG, "Can not find BTM Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setOfflineTarget(String mac, int target) {
        BtmControl btmControl = getControl(mac);
        if (btmControl != null) {
            btmControl.setOfflineTarget((byte) target);
        } else {
            Log.e(TAG, "Can not find BTM Control mac:" + mac);
        }
    }

    @ReactMethod
    public void getMemoryData(String mac) {
        BtmControl btmControl = getControl(mac);
        if (btmControl != null) {
            btmControl.getMemoryData();
        } else {
            Log.e(TAG, "Can not find BTM Control mac:" + mac);
        }
    }

    @ReactMethod
    public void disconnect(String mac) {
        BtmControl btmControl = getControl(mac);
        if (btmControl != null) {
            btmControl.disconnect();
        } else {
            Log.e(TAG, "Can not find BTM Control mac:" + mac);
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
        List<String> devices = iHealthDevicesManager.getInstance().getBTMDevices();
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
