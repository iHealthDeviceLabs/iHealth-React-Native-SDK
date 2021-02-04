package com.ihealth.ihealthlibrary;

import android.text.TextUtils;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.Bp7sControl;
import com.ihealth.communication.control.BpProfile;
import com.ihealth.communication.manager.iHealthDevicesManager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by zhangxu on 16/11/20.
 */
@ReactModule(name = "BP7SModule")
public class BP7SModule extends iHealthBaseModule {

    private static final String moduleName = "BP7SModule";
    private static final String TAG = "BP7SModule";

    private static final String EVENT_NOTIFY = "event_notify_bp7s";

    public BP7SModule(ReactApplicationContext reactContext) {
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
        Bp7sControl bp7sControl = iHealthDevicesManager.getInstance().getBp7sControl(mac);
        if (bp7sControl != null) {
            bp7sControl.getBattery();
        }else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid",400);
            sendEvent("Error", params);
        }
    }

    @ReactMethod
    public void getOffLineNum(String mac) {
        Bp7sControl bp7sControl = iHealthDevicesManager.getInstance().getBp7sControl(mac);
        if (bp7sControl != null) {
            bp7sControl.getOfflineNum();
        }else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid",400);
            sendEvent("Error", params);
        }
    }
    @ReactMethod
    public void getOffLineData(String mac) {
        Bp7sControl bp7sControl = iHealthDevicesManager.getInstance().getBp7sControl(mac);
        if (bp7sControl != null) {
            bp7sControl.getOfflineData();
        }else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid",400);
            sendEvent("Error", params);
        }
    }
    @ReactMethod
    public void setUnit(String mac, int unit) {
        Bp7sControl bp7sControl = iHealthDevicesManager.getInstance().getBp7sControl(mac);
        if (bp7sControl != null) {
            bp7sControl.setUnit(unit);
        }else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid",400);
            sendEvent("Error", params);
        }
    }
    @ReactMethod
    public void angleSet(String mac, int leftUpper,int leftLow, int rightUpper, int rightLow) {
        Bp7sControl bp7sControl = iHealthDevicesManager.getInstance().getBp7sControl(mac);
        if (bp7sControl != null) {
            bp7sControl.angleSet((byte)leftUpper,(byte)leftLow,(byte)rightUpper,(byte)rightLow);
        }else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid",400);
            sendEvent("Error", params);
        }
    }
    @ReactMethod
    public void getFunctionInfo(String mac) {
        Bp7sControl bp7sControl = iHealthDevicesManager.getInstance().getBp7sControl(mac);
        if (bp7sControl != null) {
            bp7sControl.getFunctionInfo();
        }else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid",400);
            sendEvent("Error", params);
        }
    }

    @ReactMethod
    public void disconnect(String mac) {
        Bp7sControl bp7sControl = iHealthDevicesManager.getInstance().getBp7sControl(mac);
        if (bp7sControl != null) {
            bp7sControl.disconnect();
        }else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid",400);
            sendEvent("Error",params);
        }
    }


    public void handleNotify(String mac, String deviceType, String action, String message) {
        switch (action) {
            case BpProfile.ACTION_BATTERY_BP:

                break;
            case BpProfile.ACTION_ZOREING_BP:

                break;
            case BpProfile.ACTION_ZOREOVER_BP:

                break;
            case BpProfile.ACTION_ONLINE_PRESSURE_BP:

                break;
            case BpProfile.ACTION_ONLINE_PULSEWAVE_BP:

                break;
            case BpProfile.ACTION_ONLINE_RESULT_BP:

                break;
            default:
                break;
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
