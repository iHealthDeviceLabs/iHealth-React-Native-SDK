package com.ihealth.ihealthlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.BpProfile;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Nullable;

/**
 * Created by zhangxu on 16/11/16.
 */
@ReactModule(name = "BPProfileModule")
public class BPProfileModule extends ReactContextBaseJavaModule {


    private static final String modelName = "BPProfileModule";
    private static final String TAG = "BPProfileModule";


    private static final String ACTION_ERROR_BP = "ACTION_ERROR_BP";
    private static final String ERROR_NUM_BP = "ERROR_NUM_BP";
    private static final String ERROR_DESCRIPTION_BP = "ERROR_DESCRIPTION_BP";

    //battery
    private static final String ACTION_BATTERY_BP = "ACTION_BATTERY_BP";
    private static final String BATTERY_BP = "BATTERY_BP";

    private static final String ACTION_ZOREING_BP = "ACTION_ZOREING_BP";
    private static final String ACTION_ZOREOVER_BP = "ACTION_ZOREOVER_BP";

    private static final String ACTION_ONLINE_PRESSURE_BP = "ACTION_ONLINE_PRESSURE_BP";
    private static final String BLOOD_PRESSURE_BP = "BLOOD_PRESSURE_BP";

    private static final String ACTION_ONLINE_PULSEWAVE_BP = "ACTION_ONLINE_PULSEWAVE_BP";
    private static final String FLAG_HEARTBEAT_BP = "FLAG_HEARTBEAT_BP";
    private static final String PULSEWAVE_BP = "PULSEWAVE_BP";

    private static final String ACTION_ONLINE_RESULT_BP = "ACTION_ONLINE_RESULT_BP";
    private static final String HIGH_BLOOD_PRESSURE_BP = "HIGH_BLOOD_PRESSURE_BP";
    private static final String LOW_BLOOD_PRESSURE_BP = "LOW_BLOOD_PRESSURE_BP";
    private static final String PULSE_BP = "PULSE_BP";
    private static final String MEASUREMENT_AHR_BP = "MEASUREMENT_AHR_BP";
    private static final String MEASUREMENT_HSD_BP = "MEASUREMENT_HSD_BP";
    private static final String DATAID = "DATAID";

    private static final String ACTION_HISTORICAL_NUM_BP = "ACTION_HISTORICAL_NUM_BP";
    private static final String HISTORICAL_NUM_BP = "HISTORICAL_NUM_BP";


    private static final String ACTION_HISTORICAL_DATA_BP = "ACTION_HISTORICAL_DATA_BP";
    private static final String HISTORICAL_DATA_BP = "HISTORICAL_DATA_BP";
    private static final String MEASUREMENT_DATE_BP = "MEASUREMENT_DATE_BP";
    private static final String MEASUREMENT_STRAT_ANGLE_BP = "MEASUREMENT_STRAT_ANGLE_BP";
    private static final String MEASUREMENT_ANGLE_CHANGE_BP = "MEASUREMENT_ANGLE_CHANGE_BP";
    private static final String MEASUREMENT_HAND_BP = "MEASUREMENT_HAND_BP";

    private static final String ACTION_HISTORICAL_OVER_BP = "ACTION_HISTORICAL_OVER_BP";

    private static final String ACTION_FUNCTION_INFORMATION_BP = "ACTION_FUNCTION_INFORMATION_BP";
    private static final String FUNCTION_IS_UPAIR_MEASURE = "FUNCTION_IS_UPAIR_MEASURE";
    private static final String FUNCTION_IS_ARM_MEASURE = "FUNCTION_IS_ARM_MEASURE";
    private static final String FUNCTION_HAVE_ANGLE_SENSOR = "FUNCTION_HAVE_ANGLE_SENSOR";
    private static final String FUNCTION_HAVE_OFFLINE = "FUNCTION_HAVE_OFFLINE";
    private static final String FUNCTION_HAVE_HSD = "FUNCTION_HAVE_HSD";
    private static final String FUNCTION_HAVE_ANGLE_SETTING = "FUNCTION_HAVE_ANGLE_SETTING";
    private static final String FUNCTION_IS_MULTI_UPLOAD = "FUNCTION_IS_MULTI_UPLOAD";
    private static final String FUNCTION_HAVE_SELF_UPDATE = "FUNCTION_HAVE_SELF_UPDATE";

    private static final String ACTION_ENABLE_OFFLINE_BP = "ACTION_ENABLE_OFFLINE_BP";
    private static final String ACTION_DISENABLE_OFFLINE_BP = "ACTION_DISENABLE_OFFLINE_BP";
    private static final String ACTION_IS_ENABLE_OFFLINE = "ACTION_IS_ENABLE_OFFLINE";
    private static final String IS_ENABLE_OFFLINE = "IS_ENABLE_OFFLINE";

    private static final String ACTION_SET_UNIT_SUCCESS_BP = "ACTION_SET_UNIT_SUCCESS_BP";
    private static final String ACTION_SET_ANGLE_SUCCESS_BP = "ACTION_SET_ANGLE_SUCCESS_BP";

    private static final String ACTION_INTERRUPTED_BP = "ACTION_INTERRUPTED_BP";
    private static final String ACTION_GET_ALL_CONNECTED_DEVICES = "ACTION_GET_ALL_CONNECTED_DEVICES";

    private static final String ACTION_ANGLE_BP = "ACTION_ANGLE_BP";
    private static final String WHICH_ARM = "WHICH_ARM";
    private static final String ANGLE_BP = "ANGLE_BP";

    public BPProfileModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return modelName;
    }

    @Nullable
    @Override
    public Map<String, Object> getConstants() {

        final Map<String, Object> constants = new HashMap<>();

        constants.put(ACTION_ERROR_BP, BpProfile.ACTION_ERROR_BP);
        constants.put(ERROR_NUM_BP, BpProfile.ERROR_NUM_BP);
        constants.put(ERROR_DESCRIPTION_BP, BpProfile.ERROR_DESCRIPTION_BP);

        constants.put(ACTION_BATTERY_BP, BpProfile.ACTION_BATTERY_BP);
        constants.put(BATTERY_BP,BpProfile.BATTERY_BP);

        constants.put(ACTION_ZOREING_BP, BpProfile.ACTION_ZOREING_BP);
        constants.put(ACTION_ZOREOVER_BP, BpProfile.ACTION_ZOREOVER_BP);

        constants.put(ACTION_ONLINE_PRESSURE_BP, BpProfile.ACTION_ONLINE_PRESSURE_BP);
        constants.put(BLOOD_PRESSURE_BP,BpProfile.BLOOD_PRESSURE_BP);

        constants.put(ACTION_ONLINE_PULSEWAVE_BP,BpProfile.ACTION_ONLINE_PULSEWAVE_BP);
        constants.put(FLAG_HEARTBEAT_BP,BpProfile.FLAG_HEARTBEAT_BP);
        constants.put(PULSEWAVE_BP,BpProfile.PULSEWAVE_BP);

        constants.put(ACTION_ONLINE_RESULT_BP, BpProfile.ACTION_ONLINE_RESULT_BP);
        constants.put(HIGH_BLOOD_PRESSURE_BP,BpProfile.HIGH_BLOOD_PRESSURE_BP);
        constants.put(LOW_BLOOD_PRESSURE_BP,BpProfile.LOW_BLOOD_PRESSURE_BP);
        constants.put(PULSE_BP,BpProfile.PULSE_BP);
        constants.put(MEASUREMENT_AHR_BP,BpProfile.MEASUREMENT_AHR_BP);
        constants.put(MEASUREMENT_HSD_BP,BpProfile.MEASUREMENT_HSD_BP);
        constants.put(DATAID,BpProfile.DATAID);

        constants.put(ACTION_HISTORICAL_NUM_BP, BpProfile.ACTION_HISTORICAL_NUM_BP);
        constants.put(HISTORICAL_NUM_BP, BpProfile.HISTORICAL_NUM_BP);

        constants.put(ACTION_HISTORICAL_DATA_BP,BpProfile.ACTION_HISTORICAL_DATA_BP);
        constants.put(HISTORICAL_DATA_BP, BpProfile.HISTORICAL_DATA_BP);
        constants.put(MEASUREMENT_DATE_BP, BpProfile.MEASUREMENT_DATE_BP);
        constants.put(MEASUREMENT_STRAT_ANGLE_BP,BpProfile.MEASUREMENT_STRAT_ANGLE_BP);
        constants.put(MEASUREMENT_ANGLE_CHANGE_BP,BpProfile.MEASUREMENT_ANGLE_CHANGE_BP);
        constants.put(MEASUREMENT_HAND_BP,BpProfile.MEASUREMENT_HAND_BP);

        constants.put(ACTION_HISTORICAL_OVER_BP,BpProfile.ACTION_HISTORICAL_OVER_BP);

        constants.put(ACTION_FUNCTION_INFORMATION_BP,BpProfile.ACTION_FUNCTION_INFORMATION_BP);
        constants.put(FUNCTION_IS_UPAIR_MEASURE, BpProfile.FUNCTION_IS_UPAIR_MEASURE);
        constants.put(FUNCTION_IS_ARM_MEASURE, BpProfile.FUNCTION_IS_ARM_MEASURE);
        constants.put(FUNCTION_HAVE_ANGLE_SENSOR, BpProfile.FUNCTION_HAVE_ANGLE_SENSOR);
        constants.put(FUNCTION_HAVE_OFFLINE, BpProfile.FUNCTION_HAVE_OFFLINE);
        constants.put(FUNCTION_HAVE_HSD, BpProfile.FUNCTION_HAVE_HSD);
        constants.put(FUNCTION_HAVE_ANGLE_SETTING, BpProfile.FUNCTION_HAVE_ANGLE_SETTING);
        constants.put(FUNCTION_IS_MULTI_UPLOAD, BpProfile.FUNCTION_IS_MULTI_UPLOAD);
        constants.put(FUNCTION_HAVE_SELF_UPDATE, BpProfile.FUNCTION_HAVE_SELF_UPDATE);

        constants.put(ACTION_ENABLE_OFFLINE_BP, BpProfile.ACTION_ENABLE_OFFLINE_BP);
        constants.put(ACTION_DISENABLE_OFFLINE_BP, BpProfile.ACTION_DISENABLE_OFFLINE_BP);

        constants.put(ACTION_IS_ENABLE_OFFLINE, BpProfile.ACTION_IS_ENABLE_OFFLINE);
        constants.put(IS_ENABLE_OFFLINE,BpProfile.IS_ENABLE_OFFLINE);

        constants.put(ACTION_SET_UNIT_SUCCESS_BP,BpProfile.ACTION_SET_UNIT_SUCCESS_BP);
        constants.put(ACTION_SET_ANGLE_SUCCESS_BP,BpProfile.ACTION_SET_ANGLE_SUCCESS_BP);

        constants.put(ACTION_INTERRUPTED_BP, BpProfile.ACTION_INTERRUPTED_BP);
        constants.put(ACTION_GET_ALL_CONNECTED_DEVICES, iHealthBaseModule.ACTION_GET_ALL_CONNECTED_DEVICES);

        constants.put(ACTION_ANGLE_BP, BpProfile.ACTION_ANGLE_BP);
        constants.put(WHICH_ARM, BpProfile.WHICH_ARM);
        constants.put(ANGLE_BP, BpProfile.ANGLE_BP);

        return constants;
    }
}
