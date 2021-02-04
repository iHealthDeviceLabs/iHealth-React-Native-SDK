package com.ihealth.ihealthlibrary;

import android.text.TextUtils;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.ECG3Control;
import com.ihealth.communication.control.ECG3Profile;
import com.ihealth.communication.manager.iHealthDevicesManager;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.ihealth.communication.control.ECG3Profile.ONLINE_DATA;
import static com.ihealth.communication.control.ECG3Profile.ONLINE_HR;
import static com.ihealth.ihealthlibrary.ECGProfileModule.MEASURE_WAVEData;
import static com.ihealth.ihealthlibrary.ECGProfileModule.MEASURE_ECGPulse;

/**
 * Created by zhaoyongguang on 2018/1/22.
 */
@ReactModule(name = "ECGModule")
public class ECGModule extends iHealthBaseModule {
    private static final String modelName = "ECGModule";
    private static final String TAG = "ECGModule";

    private static final String EVENT_NOTIFY = "event_notify_ecg3";

    public ECGModule(ReactApplicationContext reactContext) {
        super(TAG, reactContext);
    }

    @Override
    public Map<String, Object> getConstants() {
        Map<String, Object> map = new HashMap<>();
        map.put("Event_Notify", EVENT_NOTIFY);
        return map;
    }

    @Override
    public void handleNotify(String mac, String deviceType, String action, String message) {
        WritableMap params = Arguments.createMap();

        if (action.equals(ECG3Profile.ACTION_SYNC_ONLINE_DATA)) {
            params.putString("action", ECGProfileModule.ACTION_MEASURE_WAVEData);
            try {
                JSONObject jsonObject = new JSONObject(message);
                params.putArray(MEASURE_WAVEData, Utils.getWritableArrayFromJSONArray(jsonObject.getJSONArray(ONLINE_DATA)));

                //split pulse
                if (jsonObject.getInt(MEASURE_ECGPulse) > 0) {
                    WritableMap paramsHR = Arguments.createMap();
                    paramsHR.putString("action", ECGProfileModule.ACTION_MEASURE_ECGPulse);
                    paramsHR.putInt(MEASURE_ECGPulse, jsonObject.getInt(ONLINE_HR));
                    paramsHR.putString("mac", mac);
                    paramsHR.putString("type", deviceType);
                    sendEvent(EVENT_NOTIFY, paramsHR);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            params.putString("action", action);
            if (!TextUtils.isEmpty(message)) {
                Utils.jsonToMap(message, params);
            }
        }
        params.putString("mac", mac);
        params.putString("type", deviceType);

        sendEvent(EVENT_NOTIFY, params);
    }


    private static ECG3Control getControl(String mac) {
        return iHealthDevicesManager.getInstance().getECG3Control(mac);
    }

    /**
     * @return the name of this module. This will be the name used to {@code require()} this module
     * from javascript.
     */
    @Override
    public String getName() {
        return modelName;
    }

    @ReactMethod
    public void getAllConnectedDevices() {
        List<String> devices = iHealthDevicesManager.getInstance().getECG3Devices();
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

    @ReactMethod
    public void sysTime(String mac) {
        ECG3Control control = getControl(mac);
        if (control != null) {
            control.setTime();
        } else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid", 400);
            sendEvent("Error", params);
        }
    }

    @ReactMethod
    public void getBattery(String mac) {
        ECG3Control control = getControl(mac);
        if (control != null) {
            control.getBattery();
        } else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid", 400);
            sendEvent("Error", params);
        }
    }

    @ReactMethod
    public void startMeasure(String mac) {
        ECG3Control control = getControl(mac);
        if (control != null) {
            control.startMeasure();
        } else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid", 400);
            sendEvent("Error", params);
        }
    }

    @ReactMethod
    public void stopMeasure(String mac) {
        ECG3Control control = getControl(mac);
        if (control != null) {
            control.stopMeasure();
        } else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid", 400);
            sendEvent("Error", params);
        }
    }
}
