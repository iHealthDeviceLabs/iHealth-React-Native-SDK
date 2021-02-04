package com.ihealth.ihealthlibrary;

import android.text.TextUtils;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.Bg1Control;
import com.ihealth.communication.control.Bg1Profile;
import com.ihealth.communication.utils.Log;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Nullable;

/**
 * Created by zhaoyongguang on 29/11/2016.
 */
@ReactModule(name = "BG1Module")
public class BG1Module extends iHealthBaseModule {
    private static final String TAG = BG1Module.class.getSimpleName();
    private static final String moduleName = BG1Module.class.getSimpleName();
    private static final String EVENT_NOTIFY = "event_notify_bg1";

    public BG1Module(ReactApplicationContext reactContext) {
        super(TAG, reactContext);
    }

    @Override
    public String getName() {
        return moduleName;
    }

//    @ReactMethod
//    public void init(String userName, int filter, boolean showUI) {
//        //Bg1Control.getInstance().init(getReactApplicationContext(), userName, filter, showUI);
//    }
//
//    @ReactMethod
//    public void connect() {
//        //Bg1Control.getInstance().connect();
//    }
//
//    @ReactMethod
//    public void disconnect() {
//        //Bg1Control.getInstance().disconnect();
//    }

    @ReactMethod
    public void sendCode(String QRCode, int stripType, int measureType) {
        Bg1Control.getInstance().sendCode(QRCode, stripType, measureType);
    }

    @ReactMethod
    public void getBottleInfoFromQR(String QRCode) {
        String result = Bg1Control.getBottleInfoFromQR(QRCode);
        Log.v(TAG, "code info = " + result);

        JSONObject resultJsonStr = new JSONObject();

        try {
            JSONArray jsonArray = new JSONObject(result).getJSONArray("bottleInfo");
            resultJsonStr.put("strip_num", ((JSONObject) jsonArray.get(0)).getString("stripNum"));
            resultJsonStr.put("expire_time", ((JSONObject) jsonArray.get(0)).getString("overDate"));
            resultJsonStr.put("bottle_id", ((JSONObject) jsonArray.get(0)).getString("bottleId"));

        } catch (JSONException e) {
            try {
                resultJsonStr.put("description","QRCode format error");
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
        Log.v(TAG, "action ----> " + action );
        Log.v(TAG, "message ----> " + message );
    }

    /**
     * @return a map of constants this module exports to JS. Supports JSON types.
     */
    @Nullable
    @Override
    public Map<String, Object> getConstants() {
        final Map<String, Object> constants = new HashMap<>();
        constants.put("Event_Notify", EVENT_NOTIFY);

        return constants;
    }
}
