package com.ihealth.ihealthlibrary;

import android.text.TextUtils;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.Bp3lControl;
import com.ihealth.communication.control.BpProfile;
import com.ihealth.communication.manager.iHealthDevicesManager;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by zhangxu on 16/11/14.
 */
@ReactModule(name = "BP3LModule")
public class BP3LModule extends iHealthBaseModule {
    private String modelName = "BP3LModule";
    private static final String TAG = "BP3LModule";

    private static final String EVENT_NOTIFY = "event_notify_bp3l";

    public BP3LModule(ReactApplicationContext reactContext) {
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
    public void startMeasure(String mac) {
        Bp3lControl bp3lControl = iHealthDevicesManager.getInstance().getBp3lControl(mac);
        if (bp3lControl != null) {
            bp3lControl.startMeasure();
        } else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid",400);
            sendEvent("Error", params);
        }
    }


    @ReactMethod
    public void stopMeasure(String mac) {
        Bp3lControl bp3lControl = iHealthDevicesManager.getInstance().getBp3lControl(mac);
        if (bp3lControl != null) {
            bp3lControl.interruptMeasure();
        } else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid",400);
            sendEvent("Error", params);
        }
    }

    @ReactMethod
    public void getBattery(String mac) {
        Bp3lControl bp3lControl = iHealthDevicesManager.getInstance().getBp3lControl(mac);
        if (bp3lControl != null) {
            bp3lControl.getBattery();
        }else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid",400);
            sendEvent("Error",params);
        }
    }

    @ReactMethod
    public void disconnect(String mac) {
        Bp3lControl bp3lControl = iHealthDevicesManager.getInstance().getBp3lControl(mac);
        if (bp3lControl != null) {
            bp3lControl.disconnect();
        }else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid",400);
            sendEvent("Error",params);
        }
    }

    @Override
    public void handleNotify(String mac, String deviceType, String action, String message) {
        if (action.equals(BpProfile.ACTION_ONLINE_RESULT_BP)) {
            try {
                JSONObject jsonObject = new JSONObject(message);
                jsonObject.remove(BpProfile.MEASUREMENT_HSD_BP);
                message = jsonObject.toString();
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }
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
        List<String> devices = iHealthDevicesManager.getInstance().getBp3lDevices();
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
