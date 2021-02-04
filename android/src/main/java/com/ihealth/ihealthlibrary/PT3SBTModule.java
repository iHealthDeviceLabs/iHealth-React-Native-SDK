package com.ihealth.ihealthlibrary;

import android.text.TextUtils;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.Pt3sbtControl;
import com.ihealth.communication.control.Pt3sbtProfile;
import com.ihealth.communication.control.TS28BControl;
import com.ihealth.communication.manager.iHealthDevicesManager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@ReactModule(name = "PT3SBTModule")
public class PT3SBTModule extends iHealthBaseModule {

    private static final String modelName = PT3SBTModule.class.getSimpleName();
    private static final String TAG = PT3SBTModule.class.getSimpleName();

    private static final String EVENT_NOTIFY = "event_notify_pt3sbt";

    public PT3SBTModule(ReactApplicationContext reactContext) {
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
    public void setTime(String mac) {
        Pt3sbtControl pt3sbtControl = getPt3sbtControl(mac);
        if (pt3sbtControl != null) {
            pt3sbtControl.setTime();
        }
    }

    @ReactMethod
    public void getBattery(String mac) {
        Pt3sbtControl pt3sbtControl = getPt3sbtControl(mac);
        if (pt3sbtControl != null) {
            pt3sbtControl.getBattery();
        }
    }

    @ReactMethod
    public void setUnit(String mac, int unit) {
        Pt3sbtControl pt3sbtControl = getPt3sbtControl(mac);
        if (pt3sbtControl != null) {
            if (unit == 1) {
                pt3sbtControl.setUnit(Pt3sbtProfile.PT3SBT_UNIT.Centigrade);
            } else {
                pt3sbtControl.setUnit(Pt3sbtProfile.PT3SBT_UNIT.Fahrenheit);
            }
        }
    }

    @ReactMethod
    public void getUnit(String mac) {
        Pt3sbtControl pt3sbtControl = getPt3sbtControl(mac);
        if (pt3sbtControl != null) {
            pt3sbtControl.getUnit();
        }
    }

    @ReactMethod
    public void getHistoryCount(String mac) {
        Pt3sbtControl pt3sbtControl = getPt3sbtControl(mac);
        if (pt3sbtControl != null) {
            pt3sbtControl.getHistoryCount();
        }
    }

    @ReactMethod
    public void getHistoryData(String mac) {
        Pt3sbtControl pt3sbtControl = getPt3sbtControl(mac);
        if (pt3sbtControl != null) {
            pt3sbtControl.getHistoryData();
        }
    }

    @ReactMethod
    public void deleteHistory(String mac) {
        Pt3sbtControl pt3sbtControl = getPt3sbtControl(mac);
        if (pt3sbtControl != null) {
            pt3sbtControl.deleteHistory();
        }
    }

    @ReactMethod
    public void disconnect(String mac) {
        Pt3sbtControl pt3sbtControl = getPt3sbtControl(mac);
        if (pt3sbtControl != null) {
            pt3sbtControl.disconnect();
        }
    }

    private Pt3sbtControl getPt3sbtControl(String mac) {
        Pt3sbtControl pt3sbtControl = iHealthDevicesManager.getInstance().getPt3sbtDevice(mac);
        if (pt3sbtControl == null) {
            senErrMessage(400);
        }
        return pt3sbtControl;
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
        List<String> devices = iHealthDevicesManager.getInstance().getPt3Devices();
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
