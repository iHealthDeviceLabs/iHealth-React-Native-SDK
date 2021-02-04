package com.ihealth.ihealthlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.BtmProfile;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Nullable;

/**
 * Created by lixuesong on 15/11/2016.
 */
@ReactModule(name = "BTMProfileModule")
public class BTMProfileModule extends ReactContextBaseJavaModule {
    private static final String modelName = "BTMProfileModule";
    private static final String TAG = "BTMProfileModule";

    private static final String ACTION_BTM_BATTERY = "ACTION_BTM_BATTERY";
    private static final String BTM_BATTERY = "BTM_BATTERY";

    private static final String ACTION_BTM_MEMORY = "ACTION_BTM_MEMORY";
    private static final String MEMORY_COUNT = "MEMORY_COUNT";
    private static final String BTM_TEMPERATURE_ARRAY = "BTM_TEMPERATURE_ARRAY";
    private static final String BTM_TEMPERATURE = "BTM_TEMPERATURE";
    private static final String BTM_TEMPERATURE_TARGET = "BTM_TEMPERATURE_TARGET";
    private static final String BTM_MEASURE_TIME = "BTM_MEASURE_TIME";

    private static final String ACTION_BTM_MEASURE = "ACTION_BTM_MEASURE";

    private static final String ACTION_BTM_CALLBACK = "ACTION_BTM_CALLBACK";

    private static final String ACTION_ERROR_BTM = "ACTION_ERROR_BTM";
    private static final String ERROR_NUM_BTM = "ERROR_NUM_BTM";
    private static final String ERROR_DESCRIPTION_BTM = "ERROR_DESCRIPTION_BTM";
    private static final String ACTION_GET_ALL_CONNECTED_DEVICES = "ACTION_GET_ALL_CONNECTED_DEVICES";


    public BTMProfileModule(ReactApplicationContext reactContext) {
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
        constants.put(ACTION_BTM_BATTERY, BtmProfile.ACTION_BTM_BATTERY);
        constants.put(BTM_BATTERY, BtmProfile.BTM_BATTERY);

        constants.put(ACTION_BTM_MEMORY, BtmProfile.ACTION_BTM_MEMORY);
        constants.put(MEMORY_COUNT, BtmProfile.MEMORY_COUNT);
        constants.put(BTM_TEMPERATURE_ARRAY, BtmProfile.BTM_TEMPERATURE_ARRAY);
        constants.put(BTM_TEMPERATURE, BtmProfile.BTM_TEMPERATURE);
        constants.put(BTM_TEMPERATURE_TARGET, BtmProfile.BTM_TEMPERATURE_TARGET);
        constants.put(BTM_MEASURE_TIME, BtmProfile.BTM_MEASURE_TIME);

        constants.put(ACTION_BTM_MEASURE, BtmProfile.ACTION_BTM_MEASURE);

        constants.put(ACTION_BTM_CALLBACK, BtmProfile.ACTION_BTM_CALLBACK);

        constants.put(ACTION_ERROR_BTM, BtmProfile.ACTION_ERROR_BTM);
        constants.put(ERROR_NUM_BTM, BtmProfile.ERROR_NUM_BTM);
        constants.put(ERROR_DESCRIPTION_BTM, BtmProfile.ERROR_DESCRIPTION_BTM);
        constants.put(ACTION_GET_ALL_CONNECTED_DEVICES, iHealthBaseModule.ACTION_GET_ALL_CONNECTED_DEVICES);
        return constants;
    }
}
