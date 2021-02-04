package com.ihealth.ihealthlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.NT13BProfile;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Nullable;

@ReactModule(name = "NT13BProfileModule")
public class NT13BProfileModule extends ReactContextBaseJavaModule {

    private static final String modelName = "NT13BProfileModule";
    private static final String TAG = "NT13BProfileModule";

    private static final String ACTION_MEASUREMENT_RESULT = "ACTION_MEASUREMENT_RESULT";
    private static final String UNIT_FLAG = "unit_flag";
    private static final String RESULT = "result";
    private static final String TS_FLAG = "ts_flag";
    private static final String TS = "ts";
    private static final String THERMOMETER_TYPE_FLAG = "thermometer_type_flag";
    private static final String THERMOMETER_TYPE = "thermometer_type";

    private static final String ACTION_GET_ALL_CONNECTED_DEVICES = "ACTION_GET_ALL_CONNECTED_DEVICES";

    public NT13BProfileModule(ReactApplicationContext reactContext) {
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
        constants.put(ACTION_MEASUREMENT_RESULT, NT13BProfile.ACTION_MEASUREMENT_RESULT);
        constants.put(UNIT_FLAG, NT13BProfile.UNIT_FLAG);
        constants.put(RESULT, NT13BProfile.RESULT);
        constants.put(TS_FLAG, NT13BProfile.TS_FLAG);
        constants.put(TS, NT13BProfile.TS);
        constants.put(THERMOMETER_TYPE_FLAG, NT13BProfile.THERMOMETER_TYPE_FLAG);
        constants.put(THERMOMETER_TYPE, NT13BProfile.THERMOMETER_TYPE);
        constants.put(ACTION_GET_ALL_CONNECTED_DEVICES, iHealthBaseModule.ACTION_GET_ALL_CONNECTED_DEVICES);
        return constants;
    }
}
