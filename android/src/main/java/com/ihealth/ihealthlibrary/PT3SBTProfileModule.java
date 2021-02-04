package com.ihealth.ihealthlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.Pt3sbtProfile;
import com.ihealth.communication.control.TS28BProfile;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Nullable;

@ReactModule(name = "PT3SBTProfileModule")
public class PT3SBTProfileModule extends ReactContextBaseJavaModule {

    private static final String modelName = PT3SBTProfileModule.class.getSimpleName();
    private static final String TAG = PT3SBTProfileModule.class.getSimpleName();

    private static final String ACTION_SET_TIME = "ACTION_SET_TIME";
    private static final String ACTION_GET_BATTERY = "ACTION_GET_BATTERY";
    private static final String ACTION_SET_UNIT = "ACTION_SET_UNIT";
    private static final String ACTION_GET_UNIT = "ACTION_GET_UNIT";
    private static final String ACTION_GET_HISTORY_COUNT = "ACTION_GET_HISTORY_COUNT";
    private static final String ACTION_GET_HISTORY_DATA = "ACTION_GET_HISTORY_DATA";
    private static final String ACTION_DELETE_HISTORY_DATA = "ACTION_DELETE_HISTORY_DATA";
    private static final String ACTION_TEMPERATURE_MEASUREMENT = "ACTION_TEMPERATURE_MEASUREMENT";
    private static final String ACTION_PUB_UNIT = "ACTION_PUB_UNIT";
    private static final String ACTION_GET_ALL_CONNECTED_DEVICES = "ACTION_GET_ALL_CONNECTED_DEVICES";

    private static final String STATUS = "STATUS";
    private static final String BATTERY = "BATTERY";
    private static final String UNIT = "UNIT";
    private static final String COUNT = "COUNT";
    private static final String TEMPERATURE = "TEMPERATURE";
    private static final String TS = "TS";
    private static final String HISTORY = "HISTORY";

    public PT3SBTProfileModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return modelName;
    }

    @Nullable
    @Override
    public Map<String, Object> getConstants() {
        Map<String, Object> constants = new HashMap<>();
        constants.put(ACTION_SET_TIME, Pt3sbtProfile.ACTION_SET_TIME);
        constants.put(ACTION_GET_BATTERY, Pt3sbtProfile.ACTION_GET_BATTERY);
        constants.put(ACTION_SET_UNIT, Pt3sbtProfile.ACTION_SET_UNIT);
        constants.put(ACTION_GET_UNIT, Pt3sbtProfile.ACTION_GET_UNIT);
        constants.put(ACTION_GET_HISTORY_COUNT, Pt3sbtProfile.ACTION_GET_HISTORY_COUNT);
        constants.put(ACTION_GET_HISTORY_DATA, Pt3sbtProfile.ACTION_GET_HISTORY_DATA);
        constants.put(ACTION_DELETE_HISTORY_DATA, Pt3sbtProfile.ACTION_DELETE_HISTORY_DATA);
        constants.put(ACTION_TEMPERATURE_MEASUREMENT, Pt3sbtProfile.ACTION_TEMPERATURE_MEASUREMENT);
        constants.put(ACTION_PUB_UNIT, Pt3sbtProfile.ACTION_PUB_UNIT);
        constants.put(ACTION_GET_ALL_CONNECTED_DEVICES, iHealthBaseModule.ACTION_GET_ALL_CONNECTED_DEVICES);

        constants.put(STATUS, Pt3sbtProfile.STATUS);
        constants.put(BATTERY, Pt3sbtProfile.BATTERY);
        constants.put(UNIT, Pt3sbtProfile.UNIT);
        constants.put(TS, Pt3sbtProfile.TS);
        constants.put(COUNT, Pt3sbtProfile.COUNT);
        constants.put(TEMPERATURE, Pt3sbtProfile.TEMPERATURE);
        constants.put(HISTORY, Pt3sbtProfile.HISTORY);

        return constants;
    }
}
