package com.ihealth.ihealthlibrary;

import android.text.TextUtils;
import android.util.Log;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.Bg5Profile;
import com.ihealth.communication.control.Bg5sControl;
import com.ihealth.communication.manager.iHealthDevicesManager;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.ihealth.communication.control.Bg5Profile.ACTION_HISTORICAL_DATA_BG;

/**
 * @author chenxuewei
 * @date   04/19/2019
 */
@ReactModule(name = "BG5SModule")
public class BG5SModule extends iHealthBaseModule {

    private static final String TAG = BG5SModule.class.getName();

    private static final String ModelName = "BG5SModule";
    private static final String EVENT_NOTIFY = "event_notify_bg5s";

    public BG5SModule(ReactApplicationContext reactContext) {
        super(TAG, reactContext);
    }

    @Override
    public String getName() {
        return ModelName;
    }

    @Override
    public Map<String, Object> getConstants() {
        Map<String, Object> map = new HashMap<>();
        map.put("Event_Notify", EVENT_NOTIFY);
        return map;
    }

    @ReactMethod
    public void getStatusInfo(String mac) {
        Bg5sControl bg5sControl = getBg5sControl(mac);
        if (bg5sControl != null) {
            bg5sControl.getStatusInfo();
        }
    }

    @ReactMethod
    public void setTime(String mac, String date, float timezone) {
        Bg5sControl bg5sControl = getBg5sControl(mac);
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
            Date temp = formatter.parse(date);
            if (bg5sControl != null) {
                bg5sControl.setTime(temp, timezone);
            }
        } catch (ParseException e) {
            Log.i(TAG, "time format need yyyy-MM-dd HH:mm:ss");
        }

    }

    @ReactMethod
    public void setUnit(String mac, int unitType) {
        Bg5sControl bg5sControl = getBg5sControl(mac);
        if (bg5sControl != null) {
            bg5sControl.setUnit(unitType);
        }
    }

    @ReactMethod
    public void deleteUsedStrip(String mac) {
        Bg5sControl bg5sControl = getBg5sControl(mac);
        if (bg5sControl != null) {
            bg5sControl.deleteUsedStrip();
        }
    }

    @ReactMethod
    public void deleteOfflineData(String mac) {
        Bg5sControl bg5sControl = getBg5sControl(mac);
        if (bg5sControl != null) {
            bg5sControl.deleteOfflineData();
        }
    }

    @ReactMethod
    public void getOfflineData(String mac) {
        Bg5sControl bg5sControl = getBg5sControl(mac);
        if (bg5sControl != null) {
            bg5sControl.getOfflineData();
        }
    }

    @ReactMethod
    public void startMeasure(String mac, int measureType) {
        Bg5sControl bg5sControl = getBg5sControl(mac);
        if (bg5sControl != null) {
            bg5sControl.startMeasure(measureType);
        }
    }

    @ReactMethod
    public void adjustOfflineData(String mac, String timeString, String originData) {
        Bg5sControl bg5sControl = getBg5sControl(mac);
        if (bg5sControl != null) {
            String offlineData = bg5sControl.adjustOfflineData(timeString, originData);
            WritableMap params = Arguments.createMap();
            params.putString(Bg5Profile.HISTORICAL_DATA_BG, offlineData);
            params.putString("action", "action_get_offline_data");
            sendEvent(EVENT_NOTIFY, params);
        }
    }

    @ReactMethod
    public void disconnect(String mac) {
        Bg5sControl bg5sControl = getBg5sControl(mac);
        if (bg5sControl != null) {
            bg5sControl.disconnect();
        }
    }

    @ReactMethod
    public void getAllConnectedDevices() {
        List<String> devices = iHealthDevicesManager.getInstance().getBg5sDevices();
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

    private void senErrMessage(int errId) {
        WritableMap params = Arguments.createMap();
        params.putInt("errorid", errId);
        sendEvent(EVENT_NOTIFY, params);
    }

    private Bg5sControl getBg5sControl(String mac) {
        Bg5sControl bg5sControl = iHealthDevicesManager.getInstance().getBg5sControl(mac);
        if (bg5sControl == null) {
            senErrMessage(400);
        }
        return bg5sControl;
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
}
