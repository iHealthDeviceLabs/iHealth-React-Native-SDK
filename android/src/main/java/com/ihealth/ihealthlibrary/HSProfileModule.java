package com.ihealth.ihealthlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.HsProfile;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Nullable;

/**
 * Created by lixuesong on 15/11/2016.
 */
@ReactModule(name = "HSProfileModule")
public class HSProfileModule extends ReactContextBaseJavaModule {
    private static final String modelName = "HSProfileModule";
    private static final String TAG = "HSProfileModule";

    private static final String ACTION_LIVEDATA_HS = "ACTION_LIVEDATA_HS";
    private static final String LIVEDATA_HS = "LIVEDATA_HS";

    private static final String ACTION_ONLINE_RESULT_HS = "ACTION_ONLINE_RESULT_HS";
    private static final String DATAID = "DATAID";
    private static final String WEIGHT_HS = "WEIGHT_HS";
    private static final String FAT_HS = "FAT_HS";
    private static final String WATER_HS = "WATER_HS";
    private static final String MUSCLE_HS = "MUSCLE_HS";
    private static final String SKELETON_HS = "SKELETON_HS";
    private static final String FATELEVEL_HS = "FATELEVEL_HS";
    private static final String DCI_HS = "DCI_HS";

    private static final String ACTION_HISTORICAL_DATA_HS = "ACTION_HISTORICAL_DATA_HS";
    private static final String HISTORDATA__HS = "HISTORDATA__HS";
    private static final String MEASUREMENT_DATE_HS = "MEASUREMENT_DATE_HS";

    private static final String ACTION_HISTORICAL_DATA_COMPLETE_HS = "ACTION_HISTORICAL_DATA_COMPLETE_HS";

    private static final String ACTION_NO_HISTORICALDATA = "ACTION_NO_HISTORICALDATA";

    private static final String ACTION_ERROR_HS = "ACTION_ERROR_HS";
    private static final String ERROR_NUM_HS = "ERROR_NUM_HS";
    private static final String ERROR_ID_ILLEGAL_ARGUMENT = "ERROR_ID_ILLEGAL_ARGUMENT";
    private static final String ERROR_ID_WIFI_DISABLED = "ERROR_ID_WIFI_DISABLED";
    private static final String ERROR_DESCRIPTION_HS = "ERROR_DESCRIPTION_HS";
    private static final String ACTION_GET_ALL_CONNECTED_DEVICES = "ACTION_GET_ALL_CONNECTED_DEVICES";


    public HSProfileModule(ReactApplicationContext reactContext) {
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
        constants.put(ACTION_LIVEDATA_HS, HsProfile.ACTION_LIVEDATA_HS);
        constants.put(LIVEDATA_HS, HsProfile.LIVEDATA_HS);

        constants.put(ACTION_ONLINE_RESULT_HS, HsProfile.ACTION_ONLINE_RESULT_HS);
        constants.put(HISTORDATA__HS, HsProfile.HISTORDATA__HS);
        constants.put(DATAID, HsProfile.DATAID);
        constants.put(WEIGHT_HS, HsProfile.WEIGHT_HS);
        constants.put(FAT_HS, HsProfile.FAT_HS);
        constants.put(WATER_HS, HsProfile.WATER_HS);
        constants.put(MUSCLE_HS, HsProfile.MUSCLE_HS);
        constants.put(SKELETON_HS, HsProfile.SKELETON_HS);
        constants.put(FATELEVEL_HS, HsProfile.FATELEVEL_HS);
        constants.put(DCI_HS, HsProfile.DCI_HS);

        constants.put(ACTION_HISTORICAL_DATA_HS, HsProfile.ACTION_HISTORICAL_DATA_HS);
        constants.put(MEASUREMENT_DATE_HS, HsProfile.MEASUREMENT_DATE_HS);

        constants.put(ACTION_HISTORICAL_DATA_COMPLETE_HS, HsProfile.ACTION_HISTORICAL_DATA_COMPLETE_HS);

        constants.put(ACTION_NO_HISTORICALDATA, HsProfile.ACTION_NO_HISTORICALDATA);

        constants.put(ACTION_ERROR_HS, HsProfile.ACTION_ERROR_HS);
        constants.put(ERROR_NUM_HS, HsProfile.ERROR_NUM_HS);
        constants.put(ERROR_ID_ILLEGAL_ARGUMENT, HsProfile.ERROR_ID_ILLEGAL_ARGUMENT);
        constants.put(ERROR_ID_WIFI_DISABLED, HsProfile.ERROR_ID_WIFI_DISABLED);
        constants.put(ERROR_DESCRIPTION_HS, HsProfile.ERROR_DESCRIPTION_HS);
        constants.put(ACTION_GET_ALL_CONNECTED_DEVICES, iHealthBaseModule.ACTION_GET_ALL_CONNECTED_DEVICES);
        return constants;
    }
}
