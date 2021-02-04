package com.ihealth.ihealthlibrary;

import android.text.TextUtils;
import android.util.Log;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.ECG3Profile;
import com.ihealth.communication.control.ECG3USBControl;
import com.ihealth.communication.manager.iHealthDevicesManager;
import com.facebook.react.bridge.Callback;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import static com.ihealth.ihealthlibrary.ECGProfileModule.ACTION_FILTER;
import static com.ihealth.ihealthlibrary.ECGProfileModule.ACTION_SPLICE;
import static com.ihealth.ihealthlibrary.ECGProfileModule.ACTION_GET_CACHE;
import static com.ihealth.ihealthlibrary.ECGProfileModule.ACTION_SYNCDATAINFO_ECGUSB;
import static com.ihealth.ihealthlibrary.ECGProfileModule.ACTION_SYNCDATAPROGRESS_ECGUSB;
import static com.ihealth.ihealthlibrary.ECGProfileModule.DATAINFO;
import static com.ihealth.ihealthlibrary.ECGProfileModule.GET_CACHE_DATA;
import static com.ihealth.ihealthlibrary.ECGProfileModule.FILTER_DATA;
import static com.ihealth.ihealthlibrary.ECGProfileModule.SPLICE_DATA;
import static com.ihealth.ihealthlibrary.ECGProfileModule.PROGRESS;
import static com.ihealth.ihealthlibrary.ECGProfileModule.FILEPATH;


/**
 * Created by zhaoyongguang on 2018/1/22.
 */
@ReactModule(name = "ECGUSBModule")
public class ECGUSBModule extends iHealthBaseModule {
    private static final String modelName = "ECGUSBModule";
    private static final String TAG = "ECGUSBModule";
    private static final String mac = "000000000000";
    private static final String EVENT_NOTIFY = "event_notify_ecg3_usb";

    public ECGUSBModule(ReactApplicationContext reactContext) {
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
        if (action.equals(ECG3Profile.ACTION_SYNC_OFFLINE_DATA)){
            WritableMap params = Arguments.createMap();
            try {
                JSONObject jsonObject = new JSONObject(message);
                //split progress
                if (jsonObject.getBoolean(ECG3Profile.OFFLINE_DATA_SYNC_FINISH)) {
                    WritableMap paramsFinish = Arguments.createMap();
                    paramsFinish.putString("action", ACTION_SYNCDATAPROGRESS_ECGUSB);
                    paramsFinish.putDouble(PROGRESS, 100);
                    paramsFinish.putString("mac", mac);
                    paramsFinish.putString("type", deviceType);
                    sendEvent(EVENT_NOTIFY, paramsFinish);


                    params.putString("action", ACTION_SYNCDATAINFO_ECGUSB);
                    params.putArray(DATAINFO, Utils.getWritableArrayFromJSONArray(jsonObject.getJSONArray(ECG3Profile.OFFLINE_DATAS)));
                    params.putString("mac", mac);
                    params.putString("type", deviceType);
//                    params.putString(FILEPATH, jsonObject.getString(ECG3Profile.FILE_PATH));
                    sendEvent(EVENT_NOTIFY, params);
                } else {
                    params.putString("action", ACTION_SYNCDATAPROGRESS_ECGUSB);
                    params.putDouble(PROGRESS, jsonObject.getDouble(ECG3Profile.OFFLINE_DATA_SYNC_PROGRESS));
                    params.putString("mac", mac);
                    params.putString("type", deviceType);
                    sendEvent(EVENT_NOTIFY, params);
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

            return;
        }
       if (action.equals(ECG3Profile.ACTION_SPLICING_DATA)) {
           WritableMap params = Arguments.createMap();
           try {
               JSONObject jsonObject = new JSONObject(message);
               params.putString("action", ACTION_SPLICE);
               params.putMap(SPLICE_DATA, Utils.getMapFromJSONObject(jsonObject.getJSONObject(ECG3Profile.GET_SPLICING_DATA)));
               params.putString("mac", mac);
               params.putString("type", deviceType);
               params.putString(FILEPATH, jsonObject.getString(ECG3Profile.FILE_PATH));
               sendEvent(EVENT_NOTIFY, params);
           } catch (Exception e) {
               e.printStackTrace();
           }

           return;
       }
       if (action.equals(ECG3Profile.ACTION_GET_CACHE_DATA))
       {
           WritableMap params = Arguments.createMap();
           try {
               JSONObject jsonObject = new JSONObject(message);
               params.putString("action", ACTION_GET_CACHE);
               params.putArray(GET_CACHE_DATA, Utils.getWritableArrayFromJSONArray(jsonObject.getJSONArray(GET_CACHE_DATA)));
               params.putString("mac", mac);
               params.putString("type", deviceType);
               params.putString(FILEPATH, jsonObject.getString(ECG3Profile.FILE_PATH));
               sendEvent(EVENT_NOTIFY, params);
           } catch (
                   Exception e)
           {
               e.printStackTrace();
           }

           return;
       }
       if (action.equals(ECG3Profile.ACTION_GET_FILTER_FILES))
       {
           WritableMap params = Arguments.createMap();
           try {
               JSONObject jsonObject = new JSONObject(message);
               params.putString("action", ACTION_FILTER);
               params.putArray(FILTER_DATA, Utils.getWritableArrayFromJSONArray(jsonObject.getJSONArray(ECG3Profile.GET_FILTER_DATA)));
               params.putString("mac", mac);
               params.putString("type", deviceType);
               params.putString(FILEPATH, jsonObject.getString(ECG3Profile.FILE_PATH));
               sendEvent(EVENT_NOTIFY, params);
           } catch (
                   Exception e)
           {
               e.printStackTrace();
           }

           return;
       }
        if (action.equals(ECG3Profile.ACTION_GET_IDPS)){
            WritableMap params = Arguments.createMap();
            params.putString("action", action);
            params.putString("mac", mac);
            params.putString("type", deviceType);
            try {
                params.putMap("idps", Utils.getMapFromJSONObject(new JSONObject(message)));
            } catch (JSONException e) {
                e.printStackTrace();
            }
            sendEvent(EVENT_NOTIFY, params);
            return;
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

    /**
     * @return the name of this module. This will be the name used to {@code require()} this module
     * from javascript.
     */
    @Override
    public String getName() {
        return modelName;
    }

    private static ECG3USBControl getControl() {
        return iHealthDevicesManager.getInstance().getECG3USBControl(mac);
    }

    @ReactMethod
    public void syncData() {
        ECG3USBControl control = getControl();
        if (control != null) {
            control.syncData();
        } else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid", 400);
            sendEvent("Error", params);
        }
    }

    @ReactMethod
    public void getIdps() {
        ECG3USBControl control = getControl();
        if (control != null) {
            control.getIdps();
        } else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid", 400);
            sendEvent("Error", params);
        }
    }

    @ReactMethod
    public void deleteData() {
        ECG3USBControl control = getControl();
        if (control != null) {
            control.deleteAll();
        } else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid", 400);
            sendEvent("Error", params);
        }
    }

    @ReactMethod
    public void getAllConnectedDevices() {
        List<String> devices = iHealthDevicesManager.getInstance().getECG3USBDevices();
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
    public void spliceData(ReadableArray filesNames) {
        ECG3USBControl control = getControl();
        if (control != null && filesNames != null) {

            String[] files = new String[filesNames.size()];
            for (int x = 0; x < filesNames.size(); x++) {
                files[x] = filesNames.getString(x);
            }
            control.spliceWithFileNames(files);
        } else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid", 400);
            sendEvent("Error", params);
        }
    }

    @ReactMethod
    public void getCache() {
        ECG3USBControl control = getControl();
        if (control != null) {
            control.getCacheData();
        } else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid", 400);
            sendEvent("Error", params);
        }
    }

    @ReactMethod
    public void deleteCacheData() {
        ECG3USBControl control = getControl();
        if (control != null) {
            control.deleteCacheData();
        } else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid", 400);
            sendEvent("Error", params);
        }
    }

    @ReactMethod
    public void getFilterDataByFileName(String dataFileName,String markFileName) {
        ECG3USBControl control = getControl();
        if (control != null) {
            control.getFilterDataByFileName(dataFileName,markFileName);
        } else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid", 400);
            sendEvent("Error", params);
        }
    }

}
