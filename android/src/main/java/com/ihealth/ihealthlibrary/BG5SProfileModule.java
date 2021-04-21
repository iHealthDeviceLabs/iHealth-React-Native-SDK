package com.ihealth.ihealthlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.Bg5Profile;
import com.ihealth.communication.control.Bg5sProfile;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Nullable;

@ReactModule(name = "BG5SProfileModule")
public class BG5SProfileModule extends ReactContextBaseJavaModule  {

    private static final String modelName = "BG5SProfileModule";
    private static final String TAG = modelName;

    private static final String ACTION_ERROR = "action_error";
    private static final String ACTION_SET_TIME = "action_set_time";
    private static final String ACTION_SET_UNIT = "action_set_unit";
    private static final String ACTION_SEND_CODE = "action_send_code";
    private static final String ACTION_DELETE_USED_STRIP = "action_delete_used_strip";
    private static final String ACTION_DELETE_OFFLINE_DATA = "action_delete_offline_data";
    private static final String ACTION_GET_OFFLINE_DATA = "action_get_offline_data";
    private static final String ACTION_START_MEASURE = "action_start_measure";
    private static final String ACTION_KEEP_LINK = "action_keep_link";
    private static final String ACTION_STRIP_IN = "action_strip_in";
    private static final String ACTION_GET_BLOOD = "action_get_blood";
    private static final String ACTION_STRIP_OUT = "action_strip_out";
    private static final String ACTION_RESULT = "action_result";
    private static final String ACTION_GET_STATUS_INFO = "action_get_status_info";
    private static final String ACTION_SET_OFFLINE_MEASUREMENT_MODE = "action_set_offline_measurement_mode";
    private static final String ACTION_ENTER_CHARGED_STATE = "action_enter_charged_state";
    private static final String ACTION_LEAVE_CHARGED_STATE = "action_leave_charged_state";
    private static final String ACTION_GET_ALL_CONNECTED_DEVICES = "ACTION_GET_ALL_CONNECTED_DEVICES";

    private static final String ERROR_NUM = "error_num";
    private static final String ERROR_DESCRIPTION = "error_description";
    private static final String INFO_BATTERY_LEVEL = "info_battery_level";
    private static final String INFO_TIME = "info_time";
    private static final String INFO_TIMEZONE = "info_timezone";
    private static final String INFO_USED_STRIP = "info_used_strip";
    private static final String INFO_OFFLINE_DATA_NUM = "info_offline_data_num";
    private static final String INFO_CODE_VERSION_BLOOD = "info_code_version_blood";
    private static final String INFO_CODE_VERSION_CTL = "info_code_version_ctl";
    private static final String INFO_UNIT = "info_unit";
    private static final String SEND_CODE_RESULT = "send_code_result";
    private static final String OFFLINE_DATA = "offline_data";
    private static final String DATA_TIME_PROOF = "data_time_proof";
    private static final String DATA_MEASURE_TIME = "data_measure_time";
    private static final String DATA_MEASURE_TIMEZONE = "data_measure_timezone";
    private static final String DATA_VALUE = "data_value";
    private static final String RESULT_VALUE = "result_value";
    private static final String DATA_ID = "dataID";

    public BG5SProfileModule(ReactApplicationContext reactContext) {
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

        constants.put(ACTION_ERROR, Bg5sProfile.ACTION_ERROR);
        constants.put(ACTION_SET_TIME, Bg5sProfile.ACTION_SET_TIME);
        constants.put(ACTION_SET_UNIT, Bg5sProfile.ACTION_SET_UNIT);
        constants.put(ACTION_SEND_CODE, Bg5sProfile.ACTION_SEND_CODE);
        constants.put(ACTION_START_MEASURE, Bg5sProfile.ACTION_START_MEASURE);
        constants.put(ACTION_DELETE_USED_STRIP, Bg5sProfile.ACTION_DELETE_USED_STRIP);
        constants.put(ACTION_DELETE_OFFLINE_DATA, Bg5sProfile.ACTION_DELETE_OFFLINE_DATA);
        constants.put(ACTION_GET_OFFLINE_DATA, Bg5sProfile.ACTION_GET_OFFLINE_DATA);
        constants.put(ACTION_KEEP_LINK, Bg5sProfile.ACTION_KEEP_LINK);
        constants.put(ACTION_STRIP_IN, Bg5sProfile.ACTION_STRIP_IN);
        constants.put(ACTION_STRIP_OUT, Bg5sProfile.ACTION_STRIP_OUT);
        constants.put(ACTION_GET_BLOOD, Bg5sProfile.ACTION_GET_BLOOD);
        constants.put(ACTION_RESULT, Bg5sProfile.ACTION_RESULT);
        constants.put(ACTION_GET_STATUS_INFO, Bg5sProfile.ACTION_GET_STATUS_INFO);
        constants.put(ACTION_SET_OFFLINE_MEASUREMENT_MODE, Bg5sProfile.ACTION_SET_OFFLINE_MEASUREMENT_MODE);
        constants.put(ACTION_ENTER_CHARGED_STATE, Bg5sProfile.ACTION_ENTER_CHARGED_STATE);
        constants.put(ACTION_LEAVE_CHARGED_STATE, Bg5sProfile.ACTION_LEAVE_CHARGED_STATE);
        constants.put(ACTION_GET_ALL_CONNECTED_DEVICES, iHealthBaseModule.ACTION_GET_ALL_CONNECTED_DEVICES);

        constants.put(ERROR_NUM, Bg5sProfile.ERROR_NUM);
        constants.put(ERROR_DESCRIPTION, Bg5sProfile.ERROR_DESCRIPTION);
        constants.put(INFO_BATTERY_LEVEL, Bg5sProfile.INFO_BATTERY_LEVEL);
        constants.put(INFO_TIME, Bg5sProfile.INFO_TIME);
        constants.put(INFO_TIMEZONE, Bg5sProfile.INFO_TIMEZONE);
        constants.put(INFO_USED_STRIP, Bg5sProfile.INFO_USED_STRIP);
        constants.put(INFO_OFFLINE_DATA_NUM, Bg5sProfile.INFO_OFFLINE_DATA_NUM);
        constants.put(INFO_CODE_VERSION_BLOOD, Bg5sProfile.INFO_CODE_VERSION_BLOOD);
        constants.put(INFO_CODE_VERSION_CTL, Bg5sProfile.INFO_CODE_VERSION_CTL);
        constants.put(INFO_UNIT, Bg5sProfile.INFO_UNIT);
        constants.put(SEND_CODE_RESULT, Bg5sProfile.SEND_CODE_RESULT);
        constants.put(OFFLINE_DATA, Bg5sProfile.OFFLINE_DATA);
        constants.put(DATA_TIME_PROOF, Bg5sProfile.DATA_TIME_PROOF);
        constants.put(DATA_MEASURE_TIME, Bg5sProfile.DATA_MEASURE_TIME);
        constants.put(DATA_MEASURE_TIMEZONE, Bg5sProfile.DATA_MEASURE_TIMEZONE);
        constants.put(DATA_VALUE, Bg5sProfile.DATA_VALUE);
        constants.put(RESULT_VALUE, Bg5sProfile.RESULT_VALUE);
        constants.put(DATA_ID, Bg5sProfile.DATA_ID);

        return constants;
    }
}
