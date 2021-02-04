package com.ihealth.ihealthlibrary;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.text.TextUtils;
import android.util.Log;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.LifecycleEventListener;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.Bg1Control;
import com.ihealth.communication.control.Bg1Profile;
import com.ihealth.communication.manager.DiscoveryTypeEnum;
import com.ihealth.communication.manager.iHealthDevicesCallback;
import com.ihealth.communication.manager.iHealthDevicesManager;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Nullable;

/**
 * Created by jing on 16/10/20.
 */
@ReactModule(name = "iHealthDeviceManagerModule")
public class iHealthDeviceManagerModule extends iHealthBaseModule implements LifecycleEventListener {

    private static final String modelName = "iHealthDeviceManagerModule";
    private static final String TAG = "iHealthModel";

    private final static String AM3S  = "AM3S";
    private final static String AM4   = "AM4";
    private final static String PO3   = "PO3";
    private final static String BP5   = "BP5";
    private final static String BP5S  = "BP5S";
    private final static String BP3L  = "BP3L";
    private final static String BP7   = "BP7";
    private final static String BP7S  = "BP7S";
    private final static String KN550 = "KN550";
    private final static String HS2   = "HS2";
    private final static String HS2S  = "HS2S";
    private final static String HS4   = "HS4";
    private final static String HS4S  = "HS4S";
    //    private final static String HS6 = "HS6";
    private final static String BG1  = "BG1";
    private final static String BG1S = "BG1S";
    private final static String BG5  = "BG5";
    private final static String BG5S = "BG5S";
    private final static String BG5L = "BG5L";
    private final static String BTM  = "BTM";
    private final static String ECG3 = "ECG3";
    private final static String ECG3USB = "ECG3USB";

    private final static String PT3SBT = "PT3SBT";
    private final static String TS28B = "TS28B";
    private final static String NT13B = "NT13B";
    private final static String PO1 = "PO1";
     

    private final static String Event_Scan_Device = "event_scan_device";
    private final static String Event_Scan_Finish = "event_scan_finish";
    private final static String Event_Device_Connected = "event_device_connected";
    private final static String Event_Device_Connect_Failed = "event_device_connect_failed";
    private final static String Event_Device_Disconnect = "event_device_disconnect";
    private final static String Event_Authenticate_Result = "event_authenticate_result";

    private static int callbackId;
    private ReactApplicationContext mContext;
    private String userName;
    private String mac = "";//macAddressForBg1
    private static final String DESCRIPTION = "description";
    private static final String IDPS = "idps";
    private String idps = "";

    public iHealthDeviceManagerModule(ReactApplicationContext reactContext) {
        super(TAG, reactContext);
        mContext = reactContext;
        reactContext.addLifecycleEventListener(this);

       /* iHealthDevicesManager.getInstance().init(mContext, Log.VERBOSE, Log.WARN);
        Bg1Control.getInstance().init(mContext, "", 0, true);*/

    }

    private iHealthDevicesCallback miHealthDevicesCallback = new iHealthDevicesCallback() {

        @Override
        public void onScanDevice(String mac, String deviceType, int rssi, Map manufactorData) {
          WritableMap params = Arguments.createMap();
          params.putString("mac", mac);
          if (deviceType.equals("ECGUSB")) {
              params.putString("type", "ECG3USB");

          } else if (deviceType.equals("KN-550BT")) {
              params.putString("type", "KN550");

          } else {
              params.putString("type", deviceType);
          }
          params.putInt("rssi", rssi);
          sendEvent(Event_Scan_Device, params);
        }

        @Override
        public void onDeviceConnectionStateChange(String mac, String deviceType, int status, int errorID, Map manufactorData) {
            String eventName = null;
            if (status == iHealthDevicesManager.DEVICE_STATE_CONNECTED) {
                eventName = Event_Device_Connected;
            } else if (status == iHealthDevicesManager.DEVICE_STATE_CONNECTIONFAIL) {
                eventName = Event_Device_Connect_Failed;
            } else if (status == iHealthDevicesManager.DEVICE_STATE_DISCONNECTED) {
                eventName = Event_Device_Disconnect;
            }
            if (eventName != null) {
              WritableMap params = Arguments.createMap();
              params.putString("mac", mac);
              if (deviceType.equals("ECGUSB")) {
                  params.putString("type", "ECG3USB");

              } else if (deviceType.equals("KN-550BT")) {
                  params.putString("type", "KN550");

              } else {
                  params.putString("type", deviceType);
              }
              params.putInt("errorid", errorID);
              sendEvent(eventName, params);
            }
        }

        @Override
        public void onUserStatus(String username, int userStatus) {
            WritableMap params = Arguments.createMap();
            params.putInt("authen", userStatus);
            sendEvent(Event_Authenticate_Result, params);
        }

        @Override
        public void onDeviceNotify(String mac, String deviceType, String action, String message) {
            commandHandleDeviceNotify(mac, deviceType, action, message);
        }

        @Override
        public void onScanFinish() {
            sendEvent(Event_Scan_Finish, null);
        }

    };

    private void commandHandleDeviceNotify(String mac, String deviceType, String action, String message) {
        //为了与iOS返回值保持一致，需要进行二次加工
        iHealthBaseModule module = null;
        switch (deviceType) {
            case iHealthDevicesManager.TYPE_BP5:
                module = getReactApplicationContext().getNativeModule(BP5Module.class);
                break;

            case iHealthDevicesManager.TYPE_BP5S:
                module = getReactApplicationContext().getNativeModule(BP5SModule.class);
                break;

            case iHealthDevicesManager.TYPE_BP3L:
                module = getReactApplicationContext().getNativeModule(BP3LModule.class);
                break;

            case iHealthDevicesManager.TYPE_550BT:
                module = getReactApplicationContext().getNativeModule(BP550BTModule.class);
                break;

            case iHealthDevicesManager.TYPE_BP7:
                module = getReactApplicationContext().getNativeModule(BP7Module.class);
                break;

            case iHealthDevicesManager.TYPE_BP7S:
                module = getReactApplicationContext().getNativeModule(BP7SModule.class);
                break;

            case iHealthDevicesManager.TYPE_AM3S:
                module = getReactApplicationContext().getNativeModule(AM3SModule.class);
                break;

            case iHealthDevicesManager.TYPE_AM4:
                module = getReactApplicationContext().getNativeModule(AM4Module.class);
                break;

            case iHealthDevicesManager.TYPE_PO3:
                module = getReactApplicationContext().getNativeModule(PO3Module.class);
                break;

            case iHealthDevicesManager.TYPE_HS2:
                module = getReactApplicationContext().getNativeModule(HS2Module.class);
                break;

            case iHealthDevicesManager.TYPE_HS2S:
                module = getReactApplicationContext().getNativeModule(HS2SModule.class);
                break;

                case iHealthDevicesManager.TYPE_HS4:
            case iHealthDevicesManager.TYPE_HS4S:
                module = getReactApplicationContext().getNativeModule(HS4SModule.class);
                break;

            case iHealthDevicesManager.TYPE_HS6:
                break;

            case iHealthDevicesManager.TYPE_BG1:
                break;

            case iHealthDevicesManager.TYPE_BG1S:
                module = getReactApplicationContext().getNativeModule(BG1SModule.class);
                break;

            case iHealthDevicesManager.TYPE_BG5:
                module = getReactApplicationContext().getNativeModule(BG5Module.class);
                break;

            case iHealthDevicesManager.TYPE_BG5S:
                module = getReactApplicationContext().getNativeModule(BG5SModule.class);
                break;

            case iHealthDevicesManager.TYPE_FDIR_V3:
                module = getReactApplicationContext().getNativeModule(BTMModule.class);
                break;

            case iHealthDevicesManager.TYPE_ECG3:
                module = getReactApplicationContext().getNativeModule(ECGModule.class);
                break;

            case iHealthDevicesManager.TYPE_ECG3_USB:
                module = getReactApplicationContext().getNativeModule(ECGUSBModule.class);
                break;

            case iHealthDevicesManager.TYPE_PT3SBT:
                module = getReactApplicationContext().getNativeModule(PT3SBTModule.class);
                break;

            case iHealthDevicesManager.TYPE_TS28B:
                module = getReactApplicationContext().getNativeModule(TS28BModule.class);
                break;

            case iHealthDevicesManager.TYPE_NT13B:
                module = getReactApplicationContext().getNativeModule(NT13BModule.class);
                break;

            case iHealthDevicesManager.TYPE_PO1:
                module = getReactApplicationContext().getNativeModule(PO1Module.class);
                break;

            default:
                module = null;
                break;
        }
        if (module != null) {
            module.handleNotify(mac, deviceType, action, message);
        } else {
            Log.e(TAG, "We do not support this type: " + deviceType);
        }
    }

    @Nullable
    @Override
    public Map<String, Object> getConstants() {
        final Map<String, Object> constants = new HashMap<>();
        constants.put(AM3S, iHealthDevicesManager.DISCOVERY_AM3S);
        constants.put(AM4, iHealthDevicesManager.DISCOVERY_AM4);
        constants.put(PO3, iHealthDevicesManager.DISCOVERY_PO3);
        constants.put(BP5, iHealthDevicesManager.DISCOVERY_BP5);
        constants.put(BP5S, iHealthDevicesManager.DISCOVERY_BP5S);
        constants.put(BP3L, iHealthDevicesManager.DISCOVERY_BP3L);
        constants.put(BP7, iHealthDevicesManager.DISCOVERY_BP7);
        constants.put(BP7S, iHealthDevicesManager.DISCOVERY_BP7S);
        constants.put(KN550, iHealthDevicesManager.DISCOVERY_BP550BT);
        constants.put(HS2, iHealthDevicesManager.DISCOVERY_HS2);
        constants.put(HS2S, iHealthDevicesManager.DISCOVERY_HS2S);
        constants.put(HS4, iHealthDevicesManager.DISCOVERY_HS4);
        constants.put(HS4S, iHealthDevicesManager.DISCOVERY_HS4S);
        constants.put(BG1, (double) 110);
        constants.put(BG1S, iHealthDevicesManager.DISCOVERY_BG1S);
        constants.put(BG5, iHealthDevicesManager.DISCOVERY_BG5);
        constants.put(BG5S, iHealthDevicesManager.DISCOVERY_BG5S);
        constants.put(BTM, iHealthDevicesManager.DISCOVERY_FDIR_V3);
        constants.put(ECG3, iHealthDevicesManager.DISCOVERY_ECG3);
        constants.put(ECG3USB, iHealthDevicesManager.DISCOVERY_ECG3_USB);
        constants.put(PT3SBT, iHealthDevicesManager.DISCOVERY_PT3SBT);
        constants.put(TS28B, iHealthDevicesManager.DISCOVERY_TS28B);
        constants.put(NT13B, iHealthDevicesManager.DISCOVERY_NT13B);
        constants.put(PO1, iHealthDevicesManager.DISCOVERY_PO1);
        constants.put(PO3, iHealthDevicesManager.DISCOVERY_PO3);

        constants.put("Event_Scan_Device", Event_Scan_Device);
        constants.put("Event_Scan_Finish", Event_Scan_Finish);
        constants.put("Event_Device_Connected", Event_Device_Connected);
        constants.put("Event_Device_Connect_Failed", Event_Device_Connect_Failed);
        constants.put("Event_Device_Disconnect", Event_Device_Disconnect);
        constants.put("Event_Authenticate_Result", Event_Authenticate_Result);

        return constants;
    }

    @Override
    public String getName() {
        return modelName;
    }


    @Override
    public void onHostResume() {
        if (callbackId == 0) {
            iHealthDevicesManager.getInstance().init(getCurrentActivity().getApplication(), Log.VERBOSE, Log.VERBOSE);
            Bg1Control.getInstance().init(mContext, "", 0, true);
            callbackId = iHealthDevicesManager.getInstance().registerClientCallback(miHealthDevicesCallback);
        }
    }

    @Override
    public void onHostPause() {
        Log.i(TAG, "onHostPause");
    }

    @Override
    public void onHostDestroy() {
        Log.e(TAG, "onHostDestroy");

        if (mBroadcastReceiverRegistered) {
            unRegisterReceiver();
        }
        callbackId = 0;
        iHealthDevicesManager.getInstance().unRegisterClientCallback(callbackId);
        iHealthDevicesManager.getInstance().destroy();
    }

    private DiscoveryTypeEnum getDiscoveryType(String type) {

        switch (type) {
            case "AM3S":
                return DiscoveryTypeEnum.AM3S;

            case "AM4":
                return DiscoveryTypeEnum.AM4;

            case "BG1S":
                return DiscoveryTypeEnum.BG1S;

            case "BG5":
                return DiscoveryTypeEnum.BG5;

            case "BG5S":
                return DiscoveryTypeEnum.BG5S;

            case "BP3L":
                return DiscoveryTypeEnum.BP3L;

            case "BP5":
                return DiscoveryTypeEnum.BP5;

            case "BP5S":
                return DiscoveryTypeEnum.BP5S;

            case "BP7":
                return DiscoveryTypeEnum.BP7;

            case "KN550":
                return DiscoveryTypeEnum.BP550BT;

            case "HS2":
                return DiscoveryTypeEnum.HS2;

            case "HS2S":
                return DiscoveryTypeEnum.HS2S;

            case "HS4":
                return DiscoveryTypeEnum.HS4;

            case "HS4S":
                return DiscoveryTypeEnum.HS4S;

            case "PO1":
                return DiscoveryTypeEnum.PO1;

            case "PO3":
                return DiscoveryTypeEnum.PO3;

            case "PT3SBT":
                return DiscoveryTypeEnum.PT3SBT;

            case "NT13B":
                return DiscoveryTypeEnum.NT13B;

            case "TS28B":
                return DiscoveryTypeEnum.TS28B;

            default:
                return DiscoveryTypeEnum.All;

        }
    }

    @ReactMethod
    public void startDiscovery(String type) {
        if (type.equals("BG1")) {
            registerReceiver();//scan BG1
        } else {
            iHealthDevicesManager.getInstance().startDiscovery(getDiscoveryType(type));
        }
    }

    @ReactMethod
    public void stopDiscovery() {
        iHealthDevicesManager.getInstance().stopDiscovery();
    }

    @ReactMethod
    public void connectDevice(String mac, String type) {
        if (type.equals(BG1)) {
            Bg1Control.getInstance().connect();
        } else if (type.equals(iHealthDevicesManager.TYPE_FDIR_V3)) {
            connectTherm(this.userName, mac, type, 1, 1, 2, 0, 1, 0);
        } else {
            if (type.equals("KN550")) {
                iHealthDevicesManager.getInstance().connectDevice(this.userName, mac, iHealthDevicesManager.TYPE_550BT);
            } else {
                iHealthDevicesManager.getInstance().connectDevice(this.userName, mac, type);
            }
            
        }
    }

    @ReactMethod
    public void connectTherm(String userName, String mac, String type, int unit, int measureTarget,
                             int functionTarget, int hour, int minute, int second) {
        iHealthDevicesManager.getInstance().connectTherm(userName, mac, type,
                unit, measureTarget, functionTarget, hour, minute, second);
    }

    @ReactMethod
    public void authenConfigureInfo(String userName, String clientID, String clientSecret) {
        this.userName = userName;
        iHealthDevicesManager.getInstance().sdkUserInAuthor(mContext, userName, clientID, clientSecret, callbackId);
    }

    @ReactMethod
    public void authenAppSecret(String appSecret, Callback callback) {
        boolean authenResult = iHealthDevicesManager.getInstance().sdkAuthWithAppSecret(mContext, appSecret);
        callback.invoke(authenResult);
    }

    @ReactMethod
    public void getDevicesIDPS(String mac, Callback callback) {
        String idpsInfo = iHealthDevicesManager.getInstance().getDevicesIDPS(mac);
        WritableMap writableMap = Arguments.createMap();
        Utils.jsonToMap(idpsInfo, writableMap);
        callback.invoke(writableMap);
    }

    @Override
    public void handleNotify(String mac, String deviceType, String action, String message) {
        //Do nothing
    }


    private void registerReceiver() {
        IntentFilter intentFilter = new IntentFilter();
        intentFilter.addAction(Intent.ACTION_HEADSET_PLUG);
        intentFilter.addAction(Bg1Profile.ACTION_BG1_CONNECT_RESULT);
        intentFilter.addAction(Bg1Profile.ACTION_BG1_SENDCODE_RESULT);
        intentFilter.addAction(Bg1Profile.ACTION_BG1_MEASURE_ERROR);
        intentFilter.addAction(Bg1Profile.ACTION_BG1_MEASURE_STANDBY);
        intentFilter.addAction(Bg1Profile.ACTION_BG1_MEASURE_RESULT);
        intentFilter.addAction(Bg1Profile.ACTION_BG1_MEASURE_STRIP_IN);
        intentFilter.addAction(Bg1Profile.ACTION_BG1_MEASURE_GET_BLOOD);
        intentFilter.addAction(Bg1Profile.ACTION_BG1_MEASURE_STRIP_OUT);
        intentFilter.addAction(Bg1Profile.ACTION_BG1_IDPS);
        mContext.registerReceiver(broadcastReceiver, intentFilter);
        mBroadcastReceiverRegistered = true;
    }

    synchronized private void unRegisterReceiver() {
        mContext.unregisterReceiver(broadcastReceiver);
        mBroadcastReceiverRegistered = false;
    }

    private boolean mBroadcastReceiverRegistered = false;
    private BroadcastReceiver broadcastReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            if (!TextUtils.isEmpty(intent.getAction())) {
                iHealthBaseModule module = getReactApplicationContext().getNativeModule(BG1Module.class);
                WritableMap params = Arguments.createMap();
                params.putString("action", intent.getAction());
                params.putString("mac", mac);
                params.putString("type", BG1);
                try {
                    JSONObject jsonObject = new JSONObject();
                    switch (intent.getAction()) {
                        case Intent.ACTION_HEADSET_PLUG:
                            Log.e(TAG, "headset state -----> " + intent.getExtras().getInt("state"));
                            Log.e(TAG, "has microphone ----> " + intent.getExtras().getInt("microphone"));
                            Log.e(TAG, "headset name ------> " + intent.getExtras().getString("name"));

                            jsonObject.put("state", intent.getExtras().getInt("state"));
                            Utils.jsonToMap(jsonObject.toString(), params);

                            if (intent.getExtras().getInt("state") == 1) {
                                if (intent.getExtras().getInt("microphone") == 1) {//1 if headset has a microphone, 0 otherwise
                                    sendEvent(Event_Scan_Device, params);
                                } else {
                                    Log.e(TAG, "headSet has no microphone");
                                }

                            } else {
                                sendEvent(Event_Device_Disconnect, params);
                                Bg1Control.getInstance().disconnect();
                                module.handleNotify(mac, BG1, Event_Device_Disconnect, jsonObject.toString());

                            }
                            sendEvent(Event_Scan_Finish, null);

                            break;
                        case Bg1Profile.ACTION_BG1_CONNECT_RESULT:
                            int connectFlag = intent.getIntExtra(Bg1Profile.BG1_CONNECT_RESULT, -1);
                            jsonObject.put(Bg1Profile.BG1_CONNECT_RESULT, connectFlag);
                            jsonObject.put(DESCRIPTION, getErrorDescription(Bg1Profile.ACTION_BG1_CONNECT_RESULT, connectFlag));
                            if (formatIdps(idps) != null) {
                                jsonObject.put(IDPS, formatIdps(idps));
                            }
                            Utils.jsonToMap(jsonObject.toString(), params);
                            if (connectFlag == 0) {
                                sendEvent(Event_Device_Connected, params);
                            } else {
                                sendEvent(Event_Device_Connect_Failed, params);
                            }
                            break;
                        case Bg1Profile.ACTION_BG1_SENDCODE_RESULT:
                            int sendCodeFlag = intent.getIntExtra(Bg1Profile.BG1_SENDCODE_RESULT, -1);
                            jsonObject.put(Bg1Profile.BG1_SENDCODE_RESULT, sendCodeFlag);
                            jsonObject.put(DESCRIPTION, getErrorDescription(Bg1Profile.ACTION_BG1_SENDCODE_RESULT, sendCodeFlag));
                            //Utils.jsonToMap(jsonObject.toString(), params);

                            module.handleNotify(mac, BG1, Bg1Profile.ACTION_BG1_SENDCODE_RESULT, jsonObject.toString());
                            break;
                        case Bg1Profile.ACTION_BG1_MEASURE_ERROR:
                            int errorNumber = intent.getIntExtra(Bg1Profile.BG1_MEASURE_ERROR, -1);
                            jsonObject.put(Bg1Profile.BG1_MEASURE_ERROR, errorNumber);
                            jsonObject.put(DESCRIPTION, getErrorDescription(Bg1Profile.ACTION_BG1_MEASURE_ERROR, errorNumber));
                            module.handleNotify(mac, BG1, Bg1Profile.ACTION_BG1_MEASURE_ERROR, jsonObject.toString());
                            break;

                        case Bg1Profile.ACTION_BG1_MEASURE_RESULT:
                            int measureResult = intent.getIntExtra(Bg1Profile.BG1_MEASURE_RESULT, -1);
                            jsonObject.put(Bg1Profile.BG1_MEASURE_RESULT, measureResult);
                            module.handleNotify(mac, BG1, Bg1Profile.ACTION_BG1_MEASURE_RESULT, jsonObject.toString());
                            break;
                        case Bg1Profile.ACTION_BG1_IDPS:
                            idps = intent.getStringExtra(Bg1Profile.BG1_IDPS);
                            mac = getMacFromIdps(idps);
                            // module.handleNotify(mac, BG1, Bg1Profile.ACTION_BG1_IDPS, intent.getStringExtra(Bg1Profile.BG1_IDPS));
                            break;
                        default:
                            module.handleNotify(mac, BG1, intent.getAction(), jsonObject.toString());
                            break;

                    }
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        }

        String getMacFromIdps(String idps) {
            //{"IDPS":[{"DeviceId":"9D300A5682","FirmWare":"13.5.0","HardWare":"13.6.0"}]}
            try {
                JSONObject sourceObject = new JSONObject(idps);
                JSONArray array = sourceObject.getJSONArray("IDPS");
                JSONObject object = (JSONObject) array.get(0);
                return object.getString("DeviceId");
            } catch (Exception e) {

            }
            return "";
        }

        JSONObject formatIdps(String idps) {
            try {
                JSONObject sourceObject = new JSONObject(idps);
                JSONArray array = sourceObject.getJSONArray("IDPS");
                return (JSONObject) array.get(0);
            } catch (Exception e) {

            }
            return null;
        }


        String getErrorDescription(String action, int err_num) {
            switch (action) {
                case Bg1Profile.ACTION_BG1_CONNECT_RESULT:
                case Bg1Profile.ACTION_BG1_SENDCODE_RESULT:
                    if ((err_num >= 6 && err_num <= 13) || (err_num >= 19 && err_num <= 28)) {
                        return "Send code failed.";
                    }
                    switch (err_num) {
                        case 0:
                            return "Success.";
                        case 1:
                            return "Hand shake timeout.";
                        case 2:
                        case 16://1307
                            return "Get idps failed.";
                        case 3:
                            return "Register clientId failed.";
                        case 5:
                        case 17://1307
                            return "Identify failed.";
                        case 32:
                            return "Connect timeout";
                        case 18:
                            return "Set bottleId failed.";
                        default:
                            return "Unknown.";
                    }

                case Bg1Profile.ACTION_BG1_MEASURE_ERROR:
                    switch (err_num) {
                        case 0:
                            return "Battery is low.";
                        case 1:
                            return "Glucose test result is out of the measurement range.";
                        case 2:
                            return "Unknown interference detected, please repeat the test.";
                        case 3:
                            return "Strip is used or unknown moisture detected, discard the test strip and repeat the test with a new strip.";
                        case 4:
                            return "Communication error,resend the code to repeat the test.";
                        case 5:
                        case 6:
                            return "The environmental temperature is beyond normal range, place the meter at room temperature for at least 30 minutes, then repeat the test.";
                        case 7:
                            return "Authentication failed more than 10 times.";
                        case 8:
                            return "Communication error, please repeat the test.";
                        case 9:
                        case 10:
                        case 11:
                            return "Communication error, please repeat the test. If the problem persists, contact iHealth customer service for assistance.";
                        case 12:
                            return "Glucose test result is low.";
                        case 13:
                            return "Glucose test result is high.";
                        case 400:
                            return "Parameters out of range.";
                        case 401:
                            return "Dolby is on, please turn it off.";
                        default:
                            return "Unknown.";
                    }
                default:
                    return "Unknown.";
            }
        }
    };

    @ReactMethod
    public void disconnectDevice(String mac, String type) {
        if (type.equals(BG1)) {
            Bg1Control.getInstance().disconnect();
        } else {
            iHealthDevicesManager.getInstance().disconnectDevice(mac, type);
        }
    }

    @ReactMethod
    public void sdkAuthWithLicense(String license) {
        boolean result = false;
        try {
            InputStream ins = mContext.getAssets().open(license);
            byte[] licenseBuffer = new byte[ins.available()];
            ins.read(licenseBuffer);
            ins.close();
            result = iHealthDevicesManager.getInstance().sdkAuthWithLicense(licenseBuffer);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        WritableMap writableMap = Arguments.createMap();
        writableMap.putBoolean("access", result);
        sendEvent(Event_Authenticate_Result, writableMap);
    }

    @ReactMethod
    public void isSupportOTG(Callback callback) {
        boolean isSupportOTG = iHealthDevicesManager.getInstance().checkSupportOTG();
        callback.invoke(isSupportOTG);
    }

}
