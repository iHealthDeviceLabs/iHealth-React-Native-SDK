package com.ihealth.ihealthlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.Bg1Profile;
import com.ihealth.communication.control.Bg1sProfile;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Nullable;

/**
 * Created by zhaoyongguang on 07/12/2016.
 */
@ReactModule(name = "BG1SProfileModule")
public class BG1SProfileModule extends ReactContextBaseJavaModule {
    private static final String name = BG1SProfileModule.class.getSimpleName();
    /**
     * The action type of callback indicating the error of BG1S device.<br/>
     * <b>KeyList of the message:</b>
     * <ul>
     * <li>{@link #ERROR_NUM_BG1S}</li>
     * <li>{@link #ERROR_DESCRIPTION_BG1S}</li>
     * </ul>
     * <b>Example message:</b><br/>
     * {<br/>
     * &nbsp; &nbsp; "error": 400,<br/>
     * &nbsp; &nbsp; "description": "getOfflineData() parameter userPstCode should be in the range [0, 19]."<br/>
     * }<br/>
     */
    String ACTION_ERROR_BG1S = "action_error";
    /**
     * error code
     */
    String ERROR_NUM_BG1S = "error_num";
    /**
     * error description
     */
    String ERROR_DESCRIPTION_BG1S = "error_description";

    /**
     * The action type of callback indicating get device info.
     */
    String ACTION_GET_DEVICE_INFO = "action_get_device_info";

    /**
     * The action type of callback indicating set mode of measure.
     */
    String ACTION_SET_MEASURE_MODE = "action_set_measure_mode";

    /**
     * Callback indicating power of Battery for BG1S device.
     */
    String ACTION_BATTERY_BG1S = "battery_bg1s";

    /**
     * The power of Battery for BG1S device.
     */
    String INFO_BATTERY_BG1S = "battery";

    /**
     * The version of Blood Code for BG1S device.
     */
    String INFO_VERSION_CODE_BLOOD_BG1S = "info_version_code_blood_bg1s";

    /**
     * The version of CTL Code for BG1S device.
     */
    String INFO_VERSION_CODE_CTL_BG1S = "info_version_code_ctl_bg1s";

    /**
     * The history data status
     * <ul>
     * <li>0: has no history data</li>
     * <li>1: has history data</li>
     * </ul>
     */
    String INFO_HISTORY_STATUS_BG1S = "info_history_status_bg1s";


    /**
     * The action type of callback indicating blood drop detected.
     */
    String ACTION_GET_BLOOD = "action_get_blood";

    /**
     * The action type of callback indicating insertion status of test strip.
     * <ul>
     * <li>1: strip in</li>
     * <li>2: strip out</li>
     * </ul>
     */
    String ACTION_STRIP_INSERTION_STATUS = "action_strip_insertion_status";

    /**
     * The insertion status of test strip
     */
    String STRIP_INSERTION_STATUS = "insertion_status";

    /**
     * The action type of callback indicating result of measure.
     */
    String ACTION_MEASURE_RESULT = "action_measure_result";
    /**
     * The mode of measure
     */
    String MEASURE_MODE = "measure_mode";
    /**
     * The result of measure
     */
    String MEASURE_RESULT = "measure_result";
    /**
     * The status of operation
     */
    String OPERATION_STATUS = "status";

    /**
     * The describe of operation
     */
    String OPERATION_DESCRIBE = "describe";

    /**
     * The action type of callback indicating check code of device.
     */
    String ACTION_CHECK_CODE = "action_check_code";

    /**
     * The result of check the blood code
     * <ul>
     * <li>0: check the blood code is success</li>
     * <li>other: check the blood code is fail</li>
     * </ul>
     */
    String BLOOD_CHECK_CODE_RESULT = "blood_check_code_result";

    /**
     * The blood code.
     */
    String BLOOD_CODE = "blood_code";

    /**
     * The CRC of the blood code
     */
    String BLOOD_CODE_CRC = "blood_code_crc";


    /**
     * The result of check the blood code
     * <ul>
     * <li>0: check the blood code is success</li>
     * <li>other: check the blood code is fail</li>
     * </ul>
     */
    String CTL_CHECK_CODE_RESULT = "ctl_check_code_result";

    /**
     * The CTL code.
     */
    String CTL_CODE = "ctl_code";

    /**
     * The CRC of the CTL code
     */
    String CTL_CODE_CRC = "ctl_code_crc";

    /**
     * The action type of callback indicating set code of device.
     */
    String ACTION_SET_DEVICE_CODE = "action_set_device_code";

    /**
     * @return the name of this module. This will be the name used to {@code require()} this module
     * from javascript.
     */
    @Override
    public String getName() {
        return name;
    }

    public BG1SProfileModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    /**
     * @return a map of constants this module exports to JS. Supports JSON types.
     */
    @Nullable
    @Override
    public Map<String, Object> getConstants() {
        Map<String, Object> constants = new HashMap<>();
        constants.put(ACTION_ERROR_BG1S, Bg1sProfile.ACTION_ERROR_BG1S);
        constants.put(ERROR_NUM_BG1S, Bg1sProfile.ERROR_NUM_BG1S);
        constants.put(ERROR_DESCRIPTION_BG1S, Bg1sProfile.ERROR_DESCRIPTION_BG1S);

        constants.put(ACTION_GET_DEVICE_INFO, Bg1sProfile.ACTION_GET_DEVICE_INFO);
        constants.put(ACTION_SET_MEASURE_MODE, Bg1sProfile.ACTION_SET_MEASURE_MODE);
        constants.put(ACTION_BATTERY_BG1S, Bg1sProfile.ACTION_BATTERY_BG1S);
        constants.put(INFO_BATTERY_BG1S, Bg1sProfile.INFO_BATTERY_BG1S);
        constants.put(INFO_VERSION_CODE_BLOOD_BG1S, Bg1sProfile.INFO_VERSION_CODE_BLOOD_BG1S);
        constants.put(INFO_VERSION_CODE_CTL_BG1S, Bg1sProfile.INFO_VERSION_CODE_CTL_BG1S);
        constants.put(INFO_HISTORY_STATUS_BG1S, Bg1sProfile.INFO_HISTORY_STATUS_BG1S);

        constants.put(ACTION_GET_BLOOD, Bg1sProfile.ACTION_GET_BLOOD);
        constants.put(ACTION_STRIP_INSERTION_STATUS, Bg1sProfile.ACTION_STRIP_INSERTION_STATUS);
        constants.put(STRIP_INSERTION_STATUS, Bg1sProfile.STRIP_INSERTION_STATUS);
        constants.put(ACTION_MEASURE_RESULT, Bg1sProfile.ACTION_MEASURE_RESULT);
        constants.put(MEASURE_MODE, Bg1sProfile.MEASURE_MODE);
        constants.put(MEASURE_RESULT, Bg1sProfile.MEASURE_RESULT);

        constants.put(OPERATION_STATUS, Bg1sProfile.OPERATION_STATUS);
        constants.put(OPERATION_DESCRIBE, Bg1sProfile.OPERATION_DESCRIBE);

        constants.put(ACTION_CHECK_CODE, Bg1sProfile.ACTION_CHECK_CODE);
        constants.put(BLOOD_CHECK_CODE_RESULT, Bg1sProfile.BLOOD_CHECK_CODE_RESULT);
        constants.put(BLOOD_CODE, Bg1sProfile.BLOOD_CODE);
        constants.put(BLOOD_CODE_CRC, Bg1sProfile.BLOOD_CODE_CRC);
        constants.put(CTL_CHECK_CODE_RESULT, Bg1sProfile.CTL_CHECK_CODE_RESULT);
        constants.put(CTL_CODE, Bg1sProfile.CTL_CODE);
        constants.put(CTL_CODE_CRC, Bg1sProfile.CTL_CODE_CRC);
        constants.put(ACTION_SET_DEVICE_CODE, Bg1sProfile.ACTION_SET_DEVICE_CODE);
        return constants;
    }
}
