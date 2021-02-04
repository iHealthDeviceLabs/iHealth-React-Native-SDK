package com.ihealth.ihealthlibrary;

import android.text.TextUtils;
import android.util.Log;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.Bg5Control;
import com.ihealth.communication.control.Bg5Profile;
import com.ihealth.communication.manager.iHealthDevicesManager;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * Created by gyl on 2016/11/15.
 */

@ReactModule(name = "BG5Module")
public class BG5Module extends iHealthBaseModule {

    private static final String modelName = "BG5Module";
    private static final String TAG = modelName;

    private static final String EVENT_NOTIFY = "event_notify_bg5";

    public BG5Module(ReactApplicationContext reactContext) {
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
    public void holdLink(String mac) {
        Bg5Control bg5Control = iHealthDevicesManager.getInstance().getBg5Control(mac);
        if (bg5Control != null) {
            Log.v("aa", "bg5Control != null ");
            bg5Control.holdLink();
        } else {
            Log.v("aa", "bg5Control == null ");
            WritableMap params = Arguments.createMap();
            params.putInt("errorid", 400);
            sendEvent(EVENT_NOTIFY, params);
        }
    }

    @ReactMethod
    public void setTime(String mac) {
        Bg5Control bg5Control = iHealthDevicesManager.getInstance().getBg5Control(mac);
        if (bg5Control != null) {
            bg5Control.setTime();
        } else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid", 400);
            sendEvent(EVENT_NOTIFY, params);
        }
    }

    @ReactMethod
    public void setUnit(String mac, double type) {
        Bg5Control bg5Control = iHealthDevicesManager.getInstance().getBg5Control(mac);
        if (bg5Control != null) {
            bg5Control.setUnit((int) type);
        } else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid", 400);
            sendEvent(EVENT_NOTIFY, params);
        }
    }

    @ReactMethod
    public void getBattery(String mac) {
        Bg5Control bg5Control = iHealthDevicesManager.getInstance().getBg5Control(mac);
        if (bg5Control != null) {
            bg5Control.getBattery();
        } else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid", 400);
            sendEvent(EVENT_NOTIFY, params);
        }
    }

    @ReactMethod
    public void startMeasure(String mac, double type) {
        Bg5Control bg5Control = iHealthDevicesManager.getInstance().getBg5Control(mac);
        if (bg5Control != null) {
            bg5Control.startMeasure((int) type);
        } else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid", 400);
            sendEvent(EVENT_NOTIFY, params);
        }
    }

    @ReactMethod
    public void getOfflineData(String mac) {
        Bg5Control bg5Control = iHealthDevicesManager.getInstance().getBg5Control(mac);
        if (bg5Control != null) {
            bg5Control.getOfflineData();
        } else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid", 400);
            sendEvent(EVENT_NOTIFY, params);
        }
    }

    @ReactMethod
    public void deleteOfflineData(String mac) {
        Bg5Control bg5Control = iHealthDevicesManager.getInstance().getBg5Control(mac);
        if (bg5Control != null) {
            bg5Control.deleteOfflineData();
        } else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid", 400);
            sendEvent(EVENT_NOTIFY, params);
        }
    }

//    @ReactMethod
//    public void setBottleMessage(String mac, String QRCode) {
//        Bg5Control bg5Control = iHealthDevicesManager.getInstance().getBg5Control(mac);
//        if (bg5Control != null) {
//            bg5Control.setBottleMessage(QRCode);
//        } else {
//            WritableMap params = Arguments.createMap();
//            params.putInt("errorid", 400);
//            sendEvent(EVENT_NOTIFY, params);
//        }
//    }

//    @ReactMethod
//    public void setBottleMessage(String mac , String QRCode, final int stripNum, final String overDate) {
//        Bg5Control bg5Control = iHealthDevicesManager.getInstance().getBg5Control(mac);
//        if (bg5Control != null) {
//            bg5Control.setBottleMessage(QRCode, stripNum, overDate);
//        } else {
//            WritableMap params = Arguments.createMap();
//            params.putInt("errorid", 400);
//            iHealthDeviceManagerModule.sendEvent("Error", params);
//        }
//    }

    @ReactMethod
    public void setBottleMessageWithInfo(String mac, int stripType, int measureType, String QRCode, int stripNum, String overDate) {
        Bg5Control bg5Control = iHealthDevicesManager.getInstance().getBg5Control(mac);
        if (bg5Control != null) {
            bg5Control.setBottleMessageWithInfo(stripType, measureType, QRCode, stripNum, overDate);
        } else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid", 400);
            sendEvent(EVENT_NOTIFY, params);
        }
    }

    @ReactMethod
    public void getBottleMessage(String mac) {
        Bg5Control bg5Control = iHealthDevicesManager.getInstance().getBg5Control(mac);
        if (bg5Control != null) {
            bg5Control.getBottleMessage();
        } else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid", 400);
            sendEvent(EVENT_NOTIFY, params);
        }
    }

    @ReactMethod
    public void setBottleId(String mac, String bottleID) {
        long bottleId = 0;
        try {
            bottleId = Long.parseLong(bottleID);
        } catch (NumberFormatException e) {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid", 400);
            sendEvent(EVENT_NOTIFY, params);
            return;
        }
        Bg5Control bg5Control = iHealthDevicesManager.getInstance().getBg5Control(mac);
        if (bg5Control != null) {
            bg5Control.setBottleId(bottleId);
        } else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid", 400);
            sendEvent(EVENT_NOTIFY, params);
        }
    }

    @ReactMethod
    public void getBottleId(String mac) {
        Bg5Control bg5Control = iHealthDevicesManager.getInstance().getBg5Control(mac);
        if (bg5Control != null) {
            bg5Control.getBottleId();
        } else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid", 400);
            sendEvent(EVENT_NOTIFY, params);
        }
    }

    @ReactMethod
    public void disConnect(String mac) {
        Bg5Control bg5Control = iHealthDevicesManager.getInstance().getBg5Control(mac);
        if (bg5Control != null) {
            bg5Control.disconnect();
        } else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid", 400);
            sendEvent(EVENT_NOTIFY, params);
        }
    }

    @ReactMethod
    public void Logger(String tag, String msg) {
        Log.e(TAG, msg);
    }

    @ReactMethod
    public void getBottleInfoFromQR(String QRCode) {
        String result = Bg5Control.getBottleInfoFromQR(QRCode);
        Log.v(TAG, "code info = " + result);

        JSONObject resultJsonStr = new JSONObject();

        try {
            JSONArray jsonArray = new JSONObject(result).getJSONArray("bottleInfo");
            resultJsonStr.put("strip_num", ((JSONObject) jsonArray.get(0)).getString("stripNum"));
            resultJsonStr.put("expire_time", ((JSONObject) jsonArray.get(0)).getString("overDate"));
            resultJsonStr.put("bottle_id", ((JSONObject) jsonArray.get(0)).getString("bottleId"));

        } catch (JSONException e) {
            try {
                resultJsonStr.put("description", "QRCode format error");
            } catch (JSONException e1) {
                e1.printStackTrace();
            }
        }


        WritableMap params = Arguments.createMap();
        params.putString("action", "action_code_analysis");
        if (!TextUtils.isEmpty(resultJsonStr.toString())) {
            Utils.jsonToMap(resultJsonStr.toString(), params);
        }
        sendEvent(EVENT_NOTIFY, params);
    }

    @ReactMethod
    public void getAllConnectedDevices() {
        List<String> devices = iHealthDevicesManager.getInstance().getBg5Devices();
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

    @Override
    public void handleNotify(String mac, String deviceType, String action, String message) {
        WritableMap params = Arguments.createMap();
        params.putString("action", action);
        params.putString("mac", mac);
        params.putString("type", deviceType);
        switch (action) {

            //只需要Action就代表成功
            case Bg5Profile.ACTION_KEEP_LINK:
            case Bg5Profile.ACTION_SET_TIME:
            case Bg5Profile.ACTION_SET_UNIT:
            case Bg5Profile.ACTION_START_MEASURE:
            case Bg5Profile.ACTION_DELETE_HISTORICAL_DATA:
            case Bg5Profile.ACTION_SET_BOTTLE_ID_SUCCESS:
            case Bg5Profile.ACTION_STRIP_IN:
            case Bg5Profile.ACTION_STRIP_OUT:
            case Bg5Profile.ACTION_GET_BLOOD:

                sendEvent(EVENT_NOTIFY, params);
                break;

            case Bg5Profile.ACTION_BATTERY_BG:
            case Bg5Profile.ACTION_HISTORICAL_NUM_BG:
            case Bg5Profile.ACTION_HISTORICAL_DATA_BG:
            case Bg5Profile.ACTION_SET_BOTTLE_MESSAGE_SUCCESS:
            case Bg5Profile.ACTION_GET_CODEINFO:
            case Bg5Profile.ACTION_GET_BOTTLEID:
            case Bg5Profile.ACTION_ERROR_BG:
            case Bg5Profile.ACTION_ONLINE_RESULT_BG:

                if (!TextUtils.isEmpty(message)) {
                    Utils.jsonToMap(message, params);
                }
                sendEvent(EVENT_NOTIFY, params);
                break;

            default:
                break;
        }
    }
}
