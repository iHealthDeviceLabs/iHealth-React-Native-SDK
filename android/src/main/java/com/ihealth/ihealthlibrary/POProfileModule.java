package com.ihealth.ihealthlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.PoProfile;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Nullable;

/**
 * Created by lixuesong on 15/11/2016.
 */
@ReactModule(name = "POProfileModule")
public class POProfileModule extends ReactContextBaseJavaModule {
    private static final String modelName = "POProfileModule";
    private static final String TAG = "POProfileModule";

    private static final String ACTION_BATTERY_PO = "ACTION_BATTERY_PO";
    private static final String BATTERY_PO = "BATTERY_PO";

    private static final String ACTION_LIVEDA_PO = "ACTION_LIVEDA_PO";
    private static final String PULSE_WAVE_PO = "PULSE_WAVE_PO";
    private static final String PI_PO = "PI_PO";
    private static final String PULSE_STRENGTH_PO = "PULSE_STRENGTH_PO";
    private static final String BLOOD_OXYGEN_PO = "BLOOD_OXYGEN_PO";
    private static final String PULSE_RATE_PO = "PULSE_RATE_PO";

    private static final String ACTION_RESULTDATA_PO = "ACTION_RESULTDATA_PO";
    private static final String DATAID = "DATAID";

    private static final String ACTION_OFFLINEDATA_PO = "ACTION_OFFLINEDATA_PO";
    private static final String OFFLINEDATA_PO = "OFFLINEDATA_PO";
    private static final String MEASURE_DATE_PO = "MEASURE_DATE_PO";

    private static final String ACTION_NO_OFFLINEDATA_PO = "ACTION_NO_OFFLINEDATA_PO";
    private static final String ACTION_ERROR_PO = "ACTION_ERROR_PO";
    private static final String ACTION_GET_ALL_CONNECTED_DEVICES = "ACTION_GET_ALL_CONNECTED_DEVICES";


    public POProfileModule(ReactApplicationContext reactContext) {
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
        constants.put(ACTION_BATTERY_PO, PoProfile.ACTION_BATTERY_PO);
        constants.put(BATTERY_PO, PoProfile.BATTERY_PO);

        constants.put(ACTION_LIVEDA_PO, PoProfile.ACTION_LIVEDA_PO);
        constants.put(PULSE_WAVE_PO, PoProfile.PULSE_WAVE_PO);
        constants.put(PI_PO, PoProfile.PI_PO);
        constants.put(PULSE_STRENGTH_PO, PoProfile.PULSE_STRENGTH_PO);
        constants.put(BLOOD_OXYGEN_PO, PoProfile.BLOOD_OXYGEN_PO);
        constants.put(PULSE_RATE_PO, PoProfile.PULSE_RATE_PO);

        constants.put(ACTION_RESULTDATA_PO, PoProfile.ACTION_RESULTDATA_PO);
        constants.put(DATAID, PoProfile.DATAID);

        constants.put(ACTION_OFFLINEDATA_PO, PoProfile.ACTION_OFFLINEDATA_PO);
        constants.put(OFFLINEDATA_PO, PoProfile.OFFLINEDATA_PO);
        constants.put(MEASURE_DATE_PO, PoProfile.MEASURE_DATE_PO);

        constants.put(ACTION_NO_OFFLINEDATA_PO, PoProfile.ACTION_NO_OFFLINEDATA_PO);
        constants.put(ACTION_ERROR_PO, PoProfile.ACTION_ERROR_PO);
        constants.put(ACTION_GET_ALL_CONNECTED_DEVICES, iHealthBaseModule.ACTION_GET_ALL_CONNECTED_DEVICES);
        return constants;
    }
}
