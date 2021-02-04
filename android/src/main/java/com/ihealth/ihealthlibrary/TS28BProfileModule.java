package com.ihealth.ihealthlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.TS28BProfile;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Nullable;

@ReactModule(name = "TS28BProfileModule")
public class TS28BProfileModule extends ReactContextBaseJavaModule {

    private static final String modelName = "TS28BProfileModule";
    private static final String TAG = "TS28BProfileModule";

    private static final String ACTION_MEASUREMENT_RESULT = "ACTION_MEASUREMENT_RESULT";
    private static final String UNIT_FLAG = "unit_flag";
    private static final String RESULT = "result";
    private static final String TS_FLAG = "ts_flag";
    private static final String TS = "ts";
    private static final String THERMOMETER_TYPE_FLAG = "thermometer_type_flag";
    private static final String THERMOMETER_TYPE = "thermometer_type";

    private static final String ACTION_GET_ALL_CONNECTED_DEVICES = "ACTION_GET_ALL_CONNECTED_DEVICES";

    public TS28BProfileModule(ReactApplicationContext reactContext) {
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
        constants.put(ACTION_MEASUREMENT_RESULT, TS28BProfile.ACTION_MEASUREMENT_RESULT);
        constants.put(UNIT_FLAG, TS28BProfile.UNIT_FLAG);
        constants.put(RESULT, TS28BProfile.RESULT);
        constants.put(TS_FLAG, TS28BProfile.TS_FLAG);
        constants.put(TS, TS28BProfile.TS);
        constants.put(THERMOMETER_TYPE_FLAG, TS28BProfile.THERMOMETER_TYPE_FLAG);
        constants.put(THERMOMETER_TYPE, TS28BProfile.THERMOMETER_TYPE);
        constants.put(ACTION_GET_ALL_CONNECTED_DEVICES, iHealthBaseModule.ACTION_GET_ALL_CONNECTED_DEVICES);
        return constants;
    }
}
