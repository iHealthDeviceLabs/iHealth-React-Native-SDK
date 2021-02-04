package com.ihealth.ihealthlibrary;

import android.text.TextUtils;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.NT13BControl;
import com.ihealth.communication.manager.iHealthDevicesManager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@ReactModule(name = "NT13BModule")
public class NT13BModule extends iHealthBaseModule{

    private static final String modelName = "NT13BModule";
    private static final String TAG = "NT13BModule";

    private static final String EVENT_NOTIFY = "event_notify_nt13b";

    public NT13BModule(ReactApplicationContext reactContext) {
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
    public void measure(String mac) {
        NT13BControl nt13bControl = getNt13bControl(mac);
        if (nt13bControl != null) {
            nt13bControl.getMeasurement();
        }
    }

    @ReactMethod
    public void disconnect(String mac) {
        NT13BControl nt13bControl = getNt13bControl(mac);
        if (nt13bControl != null) {
            nt13bControl.disconnect();
        }
    }

    private NT13BControl getNt13bControl(String mac) {
        NT13BControl nt13bControl = iHealthDevicesManager.getInstance().getNT13BControl(mac);
        if (nt13bControl == null) {
            senErrMessage(400);
        }
        return nt13bControl;
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
        List<String> devices = iHealthDevicesManager.getInstance().getNT13BDevices();
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
