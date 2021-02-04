package com.ihealth.ihealthlibrary;

import android.text.TextUtils;
import android.util.Log;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.Bp5Control;
import com.ihealth.communication.control.BpProfile;
import com.ihealth.communication.manager.iHealthDevicesManager;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by jing on 16/10/24.
 */
@ReactModule(name = "BP5Module")
public class BP5Module extends iHealthBaseModule {

    private static final String modelName = "BP5Module";
    private static final String TAG = "BP5Module";
    private static final String EVENT_NOTIFY = "event_notify_bp5";

    public BP5Module(ReactApplicationContext reactContext) {
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
        Bp5Control bp5Control = iHealthDevicesManager.getInstance().getBp5Control(mac);
        if (bp5Control != null) {
            bp5Control.startMeasure();
        } else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid",400);
            sendEvent("Error", params);
        }
    }

    @ReactMethod
    public void stopMeasure(String mac) {
        Bp5Control bp5Control = iHealthDevicesManager.getInstance().getBp5Control(mac);
        if (bp5Control != null) {
            bp5Control.interruptMeasure();
        } else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid",400);
            sendEvent("Error", params);
        }
    }
    @ReactMethod
    public void getBattery(String mac) {
        Bp5Control bp5Control = iHealthDevicesManager.getInstance().getBp5Control(mac);
        if (bp5Control != null) {
            bp5Control.getBattery();
        }else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid",400);
            sendEvent("Error", params);
        }
    }
    @ReactMethod
    public void enbleOffline(String mac) {
        Bp5Control bp5Control = iHealthDevicesManager.getInstance().getBp5Control(mac);
        if (bp5Control != null) {
            bp5Control.enbleOffline();
        }else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid",400);
            sendEvent("Error", params);
        }
    }
    @ReactMethod
    public void disableOffline(String mac) {
        Bp5Control bp5Control = iHealthDevicesManager.getInstance().getBp5Control(mac);
        if (bp5Control != null) {
            bp5Control.disableOffline();
        }else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid",400);
            sendEvent("Error", params);
        }
    }
    @ReactMethod
    public void isEnableOffline(String mac) {
        Bp5Control bp5Control = iHealthDevicesManager.getInstance().getBp5Control(mac);
        if (bp5Control != null) {
            bp5Control.isEnableOffline();
        }else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid",400);
            sendEvent("Error", params);
        }
    }
    
    @ReactMethod
    public void getOfflineNum(String mac) {
        Bp5Control bp5Control = iHealthDevicesManager.getInstance().getBp5Control(mac);
        if (bp5Control != null) {
            bp5Control.getOfflineNum();
        }else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid",400);
            sendEvent("Error", params);
        }
    }
    @ReactMethod
    public void getOfflineData(String mac) {
        Bp5Control bp5Control = iHealthDevicesManager.getInstance().getBp5Control(mac);
        if (bp5Control != null) {
            bp5Control.getOfflineData();
        }else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid",400);
            sendEvent("Error", params);
        }
    }

    @ReactMethod
    public void disconnect(String mac) {
        Bp5Control bp5Control = iHealthDevicesManager.getInstance().getBp5Control(mac);
        if (bp5Control != null) {
            bp5Control.disconnect();
        }else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid",400);
            sendEvent("Error",params);
        }
    }

    @ReactMethod
    public void Logger(String tag, String msg) {
        Log.e(TAG, msg);
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
        List<String> devices = iHealthDevicesManager.getInstance().getBp5Devices();
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
