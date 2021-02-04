package com.ihealth.ihealthlibrary;

import android.text.TextUtils;
import android.util.Log;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.HS6Control;
import com.ihealth.communication.manager.iHealthDeviceHs6Callback;
import com.ihealth.communication.manager.iHealthDevicesManager;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by lixuesong on 16/10/20.
 */
@ReactModule(name = "HS6Module")
public class HS6Module extends iHealthBaseModule {
    private static final String modelName = "HS6Module";
    private static final String TAG = "HS6Module";

    private static final String EVENT_NOTIFY = "event_notify_hs6";
    private ReactApplicationContext mContext;
    private HS6Control mHS6control;

    public HS6Module(ReactApplicationContext reactContext) {
        super(TAG, reactContext);
        this.mContext = reactContext;
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
    public void init(String userName) {
        mHS6control = new HS6Control(userName, mContext, iHealthDevicesManager.TYPE_HS6, mIHealthDeviceHs6Callback);
    }

    @ReactMethod
    public void setWifi(String ssid, String password) {
        if (mHS6control != null) {
            mHS6control.setWifi(ssid, password);
        } else {
            Log.e(TAG, "Please call init(String username) method first");
        }
    }

    @ReactMethod
    public void bindDeviceHS6(String birthday, float weight, int height, int isSporter, int gender, String serialNumber) {
        if (mHS6control != null) {
            mHS6control.bindDeviceHS6(birthday, weight, height, isSporter, gender, serialNumber);
        } else {
            Log.e(TAG, "Please call init(String username) method first");
        }
    }

    @ReactMethod
    public void unBindDeviceHS6(String serialNumber) {
        if (mHS6control != null) {
            mHS6control.unBindDeviceHS6(serialNumber);
        } else {
            Log.e(TAG, "Please call init(String username) method first");
        }
    }

    @ReactMethod
    public void getToken(String clientId, String clientSecret, String username, String clientPara) {
        if (mHS6control != null) {
            mHS6control.getToken(clientId, clientSecret, username, clientPara);
        } else {
            Log.e(TAG, "Please call init(String username) method first");
        }
    }

    @ReactMethod
    public void setUnit(String username, int unitType) {
        if (mHS6control != null) {
            mHS6control.setUnit(username, unitType);
        } else {
            Log.e(TAG, "Please call init(String username) method first");
        }
    }

    @ReactMethod
    public void getCloudData(String clientId, String clientSecret, String username, double downloadTS, double pageSize) {
        if (mHS6control != null) {
            mHS6control.getDataByMeasuretimeFromCloud(clientId, clientSecret, username, (long) downloadTS, (long) pageSize);
        } else {
            Log.e(TAG, "Please call init(String username) method first");
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

    private iHealthDeviceHs6Callback mIHealthDeviceHs6Callback = new iHealthDeviceHs6Callback() {
        public void setWifiNotify(String deviceType, String action, String message) {
            WritableMap params = Arguments.createMap();
            params.putString("action", action);
            params.putString("deviceType", deviceType);
            if (!TextUtils.isEmpty(message)) {
                Utils.jsonToMap(message, params);
            }
            sendEvent(EVENT_NOTIFY, params);
        }

        public void onNotify(String mac, String deviceType, String action, String message) {
            handleNotify(mac, deviceType, action, message);
        }
    };
}
