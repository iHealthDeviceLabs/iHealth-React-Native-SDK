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
import com.ihealth.communication.control.Am3sControl;
import com.ihealth.communication.manager.iHealthDevicesManager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Jeepend on 22/11/2016.
 */
@ReactModule(name = "AM3SModule")
public class AM3SModule extends iHealthBaseModule {
    private static final String modelName = "AM3SModule";
    private static final String TAG = "AM3SModule";

    private static final String EVENT_NOTIFY = "event_notify_am3s";

    public AM3SModule(ReactApplicationContext reactContext) {
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

    private static Am3sControl getControl(String mac) {
        return iHealthDevicesManager.getInstance().getAm3sControl(mac);
    }

    @ReactMethod
    public void getIdps(String mac) {
        Am3sControl control = getControl(mac);
        if (control != null) {
            String idps = control.getIdps();
            WritableMap params = Arguments.createMap();
            if (!TextUtils.isEmpty(idps)) {
                Utils.jsonToMap(idps, params);
            }
            sendEvent(EVENT_NOTIFY, params);
        } else {
            Log.e(TAG, "Can not find AM3S Control mac:" + mac);
        }
    }

    @ReactMethod
    public void reset(String mac) {
        Am3sControl control = getControl(mac);
        if (control != null) {
            control.reset(1);
        } else {
            Log.e(TAG, "Can not find AM3S Control mac:" + mac);
        }
    }

    @ReactMethod
    public void getUserId(String mac) {
        Am3sControl control = getControl(mac);
        if (control != null) {
            control.getUserId();
        } else {
            Log.e(TAG, "Can not find AM3S Control mac:" + mac);
        }
    }

    @ReactMethod
    public void getAlarmClockNum(String mac) {
        Am3sControl control = getControl(mac);
        if (control != null) {
            control.getAlarmClockNum();
        } else {
            Log.e(TAG, "Can not find AM3S Control mac:" + mac);
        }
    }

    @ReactMethod
    public void getAlarmClockDetail(String mac, ReadableArray alarmIDArray) {
        Am3sControl control = getControl(mac);
        if (control != null) {
            int[] alarmIDs = new int[alarmIDArray.size()];
            for (int i = 0; i < alarmIDArray.size(); i++) {
                alarmIDs[i] = alarmIDArray.getInt(i);
            }
            control.getAlarmClockDetail(alarmIDs);
        } else {
            Log.e(TAG, "Can not find AM3S Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setAlarmClock(String mac, int id, int hour, int min, boolean isRepeat, ReadableArray weekArray, boolean isOn) {
        Am3sControl control = getControl(mac);
        if (control != null) {
            int[] weeks = new int[weekArray.size()];
            for (int i = 0; i < weekArray.size(); i++) {
                weeks[i] = weekArray.getInt(i);
            }
            control.setAlarmClock(id, hour, min, isRepeat, weeks, isOn);
        } else {
            Log.e(TAG, "Can not find AM3S Control mac:" + mac);
        }
    }

    @ReactMethod
    public void deleteAlarmClock(String mac, int id) {
        Am3sControl control = getControl(mac);
        if (control != null) {
            control.deleteAlarmClock(id);
        } else {
            Log.e(TAG, "Can not find AM3S Control mac:" + mac);
        }
    }

    @ReactMethod
    public void getActivityRemind(String mac) {
        Am3sControl control = getControl(mac);
        if (control != null) {
            control.getActivityRemind();
        } else {
            Log.e(TAG, "Can not find AM3S Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setActivityRemind(String mac, int hour, int min, boolean isOn) {
        Am3sControl control = getControl(mac);
        if (control != null) {
            control.setActivityRemind(hour, min, isOn);
        } else {
            Log.e(TAG, "Can not find AM3S Control mac:" + mac);
        }
    }

    @ReactMethod
    public void queryAMState(String mac) {
        Am3sControl control = getControl(mac);
        if (control != null) {
            control.queryAMState();
        } else {
            Log.e(TAG, "Can not find AM3S Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setUserId(String mac, int id) {
        Am3sControl control = getControl(mac);
        if (control != null) {
            control.setUserId(id);
        } else {
            Log.e(TAG, "Can not find AM3S Control mac:" + mac);
        }
    }

    @ReactMethod
    public void getUserInfo(String mac) {
        Am3sControl control = getControl(mac);
        if (control != null) {
            control.getUserInfo();
        } else {
            Log.e(TAG, "Can not find AM3S Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setUserBmr(String mac, int bmr) {
        Am3sControl control = getControl(mac);
        if (control != null) {
            control.setUserBmr(bmr);
        } else {
            Log.e(TAG, "Can not find AM3S Control mac:" + mac);
        }
    }

    @ReactMethod
    public void syncActivityData(String mac) {
        Am3sControl control = getControl(mac);
        if (control != null) {
            control.syncActivityData();
        } else {
            Log.e(TAG, "Can not find AM3S Control mac:" + mac);
        }
    }

    @ReactMethod
    public void syncSleepData(String mac) {
        Am3sControl control = getControl(mac);
        if (control != null) {
            control.syncSleepData();
        } else {
            Log.e(TAG, "Can not find AM3S Control mac:" + mac);
        }
    }

    @ReactMethod
    public void syncRealData(String mac) {
        Am3sControl control = getControl(mac);
        if (control != null) {
            control.syncRealData();
        } else {
            Log.e(TAG, "Can not find AM3S Control mac:" + mac);
        }
    }

    @ReactMethod
    public void syncRealTime(String mac) {
        Am3sControl control = getControl(mac);
        if (control != null) {
            control.syncRealTime();
        } else {
            Log.e(TAG, "Can not find AM3S Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setHourMode(String mac, int hourMode) {
        Am3sControl control = getControl(mac);
        if (control != null) {
            control.setHourMode(hourMode);
        } else {
            Log.e(TAG, "Can not find AM3S Control mac:" + mac);
        }
    }

    @ReactMethod
    public void getHourMode(String mac) {
        Am3sControl control = getControl(mac);
        if (control != null) {
            control.getHourMode();
        } else {
            Log.e(TAG, "Can not find AM3S Control mac:" + mac);
        }
    }

    @ReactMethod
    public void disconnect(String mac) {
        Am3sControl control = getControl(mac);
        if (control != null) {
            control.disconnect();
        } else {
            Log.e(TAG, "Can not find AM3S Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setUserInfo(String mac, int age, int height, float weight, int gender, int unit, int target, int activityLevel) {
        Am3sControl control = getControl(mac);
        if (control != null) {
            control.setUserInfo(age, height, weight, gender, unit, target, activityLevel);
        } else {
            Log.e(TAG, "Can not find AM3S Control mac:" + mac);
        }
    }

    @ReactMethod
    public void syncStageReportData(String mac) {
        Am3sControl control = getControl(mac);
        if (control != null) {
            control.syncStageReprotData();
        } else {
            Log.e(TAG, "Can not find AM3S Control mac:" + mac);
        }
    }

    @ReactMethod
    public void sendRandom(String mac) {
        Am3sControl control = getControl(mac);
        if (control != null) {
            control.sendRandom();
        } else {
            Log.e(TAG, "Can not find AM3S Control mac:" + mac);
        }
    }

    @ReactMethod
    public void getPicture(String mac) {
        Am3sControl control = getControl(mac);
        if (control != null) {
            control.getPicture();
        } else {
            Log.e(TAG, "Can not find AM3S Control mac:" + mac);
        }
    }

    @ReactMethod
    public void setPicture(String mac, int index) {
        Am3sControl control = getControl(mac);
        if (control != null) {
            control.setPicture(index);
        } else {
            Log.e(TAG, "Can not find AM3S Control mac:" + mac);
        }
    }

    @ReactMethod
    public void getAllConnectedDevices() {
        List<String> devices = iHealthDevicesManager.getInstance().getAm3sDevices();
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
