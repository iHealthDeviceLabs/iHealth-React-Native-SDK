package com.ihealth.ihealthlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.Hs2sProfile;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Nullable;

@ReactModule(name = "HS2SProfileModule")
public class HS2SProfileModule extends ReactContextBaseJavaModule {
    private static final String modelName = "HS2SProfileModule";
    private static final String TAG = "HS2SProfileModule";

    private static final String ACTION_ERROR_HS = "ACTION_ERROR_HS";
    private static final String ERROR_NUM_HS = "ERROR_NUM_HS";
    private static final String ERROR_DESCRIPTION_HS = "ERROR_DESCRIPTION_HS";

    private static final String ACTION_GET_DEVICE_INFO = "ACTION_GET_DEVICE_INFO";
    private static final String HS_USER_COUNT = "HS_USER_COUNT";
    private static final String HS_UNIT_CURRENT = "HS_UNIT_CURRENT";

    private static final String ACTION_BATTERY_HS = "ACTION_BATTERY_HS";
    private static final String BATTERY_HS = "BATTERY_HS";

    private static final String ACTION_SET_UNIT_SUCCESS = "ACTION_SET_UNIT_SUCCESS";

    private static final String ACTION_GET_USER_INFO = "ACTION_GET_USER_INFO";
    private static final String USER_INFO_COUNT = "USER_INFO_COUNT";
    private static final String USER_INFO_ARRAY = "USER_INFO_ARRAY";
    private static final String USER_INFO_USER_ID = "USER_INFO_USER_ID";
    private static final String USER_INFO_CREATE_TIME = "USER_INFO_CREATE_TIME";
    private static final String USER_INFO_WEIGHT = "USER_INFO_WEIGHT";
    private static final String USER_INFO_GENDER = "USER_INFO_GENDER";
    private static final String USER_INFO_AGE = "USER_INFO_AGE";
    private static final String USER_INFO_HEIGHT = "USER_INFO_HEIGHT";
    private static final String USER_INFO_IMPEDANCE = "USER_INFO_IMPEDANCE";
    private static final String USER_INFO_BODYBUILDING = "USER_INFO_BODYBUILDING";

    private static final String ACTION_CREATE_OR_UPDATE_USER_INFO = "ACTION_CREATE_OR_UPDATE_USER_INFO";
    private static final String OPERATION_STATUS = "OPERATION_STATUS";
    private static final String OPERATION_DESCRIBE = "OPERATION_DESCRIBE";

    private static final String ACTION_DELETE_USER_INFO = "ACTION_DELETE_USER_INFO";

    private static final String ACTION_SPECIFY_USERS = "ACTION_SPECIFY_USERS";

    private static final String ACTION_MEASURE_FINISH_AT_CRITICAL = "ACTION_MEASURE_FINISH_AT_CRITICAL";

    private static final String ACTION_HISTORY_DATA_NUM = "ACTION_HISTORY_DATA_NUM";
    private static final String HISTORY_DATA_USER_COUNT = "HISTORY_DATA_USER_COUNT";
    private static final String HISTORY_DATA_COUNT_ARRAY = "HISTORY_DATA_COUNT_ARRAY";
    private static final String HISTORY_DATA_COUNT = "HISTORY_DATA_COUNT";

    private static final String ACTION_HISTORY_DATA = "ACTION_HISTORY_DATA";
    private static final String DATA_ID = "DATA_ID";
    private static final String DATA_WEIGHT = "DATA_WEIGHT";
    private static final String DATA_IMPEDANCE = "DATA_IMPEDANCE";
    private static final String DATA_USER_NUM = "DATA_USER_NUM";
    private static final String DATA_GENDER = "DATA_GENDER";
    private static final String DATA_AGE = "DATA_AGE";
    private static final String DATA_HEIGHT = "DATA_HEIGHT";
    private static final String DATA_MEASURE_TIME = "DATA_MEASURE_TIME";
    private static final String DATA_RIGHT_TIME = "DATA_RIGHT_TIME";
    private static final String DATA_BODYBUILDING = "DATA_BODYBUILDING";
    private static final String DATA_INSTRUCTION_TYPE = "DATA_INSTRUCTION_TYPE";
    private static final String DATA_BODY_FIT_PERCENTAGE = "DATA_BODY_FIT_PERCENTAGE";
    private static final String DATA_MUSCLE_MASS = "DATA_MUSCLE_MASS";
    private static final String DATA_BONE_SALT_CONTENT = "DATA_BONE_SALT_CONTENT";
    private static final String DATA_BODY_WATER_RATE = "DATA_BODY_WATER_RATE";
    private static final String DATA_PROTEIN_RATE = "DATA_PROTEIN_RATE";
    private static final String DATA_SKELETAL_MUSCLE_MASS = "DATA_SKELETAL_MUSCLE_MASS";
    private static final String DATA_BASAL_METABOLIC_RATE = "DATA_BASAL_METABOLIC_RATE";
    private static final String DATA_VISCERAL_FAT_GRADE = "DATA_VISCERAL_FAT_GRADE";
    private static final String DATA_PHYSICAL_AGE = "DATA_PHYSICAL_AGE";
    private static final String DATA_BODY_MASS_INDEX = "DATA_BODY_MASS_INDEX";

    private static final String DATA_STANDARD_WEIGHT = "DATA_STANDARD_WEIGHT";
    private static final String DATA_WEIGHT_CONTROL = "DATA_WEIGHT_CONTROL";
    private static final String DATA_MUSCLE_CONTROL = "DATA_MUSCLE_CONTROL";
    private static final String DATA_FAT_CONTROL = "DATA_FAT_CONTROL";
    private static final String DATA_FAT_WEIGHT = "DATA_FAT_WEIGHT";
    private static final String DATA_DE_FAT_WEIGHT = "DATA_DE_FAT_WEIGHT";

    private static final String ACTION_ONLINE_RESULT = "ACTION_ONLINE_RESULT";
    private static final String ACTION_DELETE_HISTORY_DATA = "ACTION_DELETE_HISTORY_DATA";

    private static final String ACTION_ANONYMOUS_DATA_NUM = "ACTION_ANONYMOUS_DATA_NUM";
    private static final String ANONYMOUS_DATA_COUNT = "ANONYMOUS_DATA_COUNT";

    private static final String ACTION_DELETE_ANONYMOUS_DATA = "ACTION_DELETE_ANONYMOUS_DATA";
    private static final String ACTION_ONLINE_REAL_TIME_WEIGHT = "ACTION_ONLINE_REAL_TIME_WEIGHT";
    private static final String ACTION_BODY_FAT_RESULT = "ACTION_BODY_FAT_RESULT";
    private static final String DATA_BODY_FAT_RESULT = "DATA_BODY_FAT_RESULT";

    private static final String ACTION_RESTORE_FACTORY_SETTINGS = "ACTION_RESTORE_FACTORY_SETTINGS";

    private static final String ACTION_GET_ALL_CONNECTED_DEVICES = "ACTION_GET_ALL_CONNECTED_DEVICES";

    private static final String ACTION_HS2S_LightUp_DEVICE = "ACTION_HS2S_LightUp_DEVICE";
    private static final String HS2S_DEVICE_STATUS = "HS2S_DEVICE_STATUS";
    private static final String ACTION_HS2S_MEASURE_HEARTRATE = "ACTION_HS2S_MEASURE_HEARTRATE";
    private static final String ACTION_HS2S_EXIT_MEASURE_HEARTRATE_STATUS = "ACTION_HS2S_EXIT_MEASURE_HEARTRATE_STATUS";
    private static final String HS2S_MEASURE_HEARTRATE_RESULT = "HS2S_MEASURE_HEARTRATE_RESULT";

    public HS2SProfileModule(ReactApplicationContext reactContext) {
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
        constants.put(ACTION_ERROR_HS, Hs2sProfile.ACTION_ERROR_HS);
        constants.put(ERROR_NUM_HS, Hs2sProfile.ERROR_NUM_HS);
        constants.put(ERROR_DESCRIPTION_HS, Hs2sProfile.ERROR_DESCRIPTION_HS);

        constants.put(ACTION_GET_DEVICE_INFO, Hs2sProfile.ACTION_GET_DEVICE_INFO);
        constants.put(HS_USER_COUNT, Hs2sProfile.HS_USER_COUNT);
        constants.put(HS_UNIT_CURRENT, Hs2sProfile.HS_UNIT_CURRENT);

        constants.put(ACTION_BATTERY_HS, Hs2sProfile.ACTION_BATTERY_HS);
        constants.put(BATTERY_HS, Hs2sProfile.BATTERY_HS);

        constants.put(ACTION_SET_UNIT_SUCCESS, Hs2sProfile.ACTION_SET_UNIT_SUCCESS);

        constants.put(ACTION_GET_USER_INFO, Hs2sProfile.ACTION_GET_USER_INFO);
        constants.put(USER_INFO_COUNT, Hs2sProfile.USER_INFO_COUNT);
        constants.put(USER_INFO_ARRAY, Hs2sProfile.USER_INFO_ARRAY);
        constants.put(USER_INFO_USER_ID, Hs2sProfile.USER_INFO_USER_ID);
        constants.put(USER_INFO_CREATE_TIME, Hs2sProfile.USER_INFO_CREATE_TIME);
        constants.put(USER_INFO_WEIGHT, Hs2sProfile.USER_INFO_WEIGHT);
        constants.put(USER_INFO_GENDER, Hs2sProfile.USER_INFO_GENDER);
        constants.put(USER_INFO_AGE, Hs2sProfile.USER_INFO_AGE);
        constants.put(USER_INFO_HEIGHT, Hs2sProfile.USER_INFO_HEIGHT);
        constants.put(USER_INFO_IMPEDANCE, Hs2sProfile.USER_INFO_IMPEDANCE);
        constants.put(USER_INFO_BODYBUILDING, Hs2sProfile.USER_INFO_BODYBUILDING);

        constants.put(ACTION_CREATE_OR_UPDATE_USER_INFO, Hs2sProfile.ACTION_CREATE_OR_UPDATE_USER_INFO);
        constants.put(OPERATION_STATUS, Hs2sProfile.OPERATION_STATUS);
        constants.put(OPERATION_DESCRIBE, Hs2sProfile.OPERATION_DESCRIBE);

        constants.put(ACTION_DELETE_USER_INFO, Hs2sProfile.ACTION_DELETE_USER_INFO);
        constants.put(ACTION_SPECIFY_USERS, Hs2sProfile.ACTION_SPECIFY_USERS);
        constants.put(ACTION_MEASURE_FINISH_AT_CRITICAL, Hs2sProfile.ACTION_MEASURE_FINISH_AT_CRITICAL);

        constants.put(ACTION_HISTORY_DATA_NUM, Hs2sProfile.ACTION_HISTORY_DATA_NUM);
        constants.put(HISTORY_DATA_USER_COUNT, Hs2sProfile.HISTORY_DATA_USER_COUNT);
        constants.put(HISTORY_DATA_COUNT_ARRAY, Hs2sProfile.HISTORY_DATA_COUNT_ARRAY);
        constants.put(HISTORY_DATA_COUNT, Hs2sProfile.HISTORY_DATA_COUNT);

        constants.put(ACTION_HISTORY_DATA, Hs2sProfile.ACTION_HISTORY_DATA);
        constants.put(DATA_ID, Hs2sProfile.DATA_ID);
        constants.put(DATA_WEIGHT, Hs2sProfile.DATA_WEIGHT);
        constants.put(DATA_IMPEDANCE, Hs2sProfile.DATA_IMPEDANCE);
        constants.put(DATA_USER_NUM, Hs2sProfile.DATA_USER_NUM);
        constants.put(DATA_GENDER, Hs2sProfile.DATA_GENDER);
        constants.put(DATA_AGE, Hs2sProfile.DATA_AGE);
        constants.put(DATA_HEIGHT, Hs2sProfile.DATA_HEIGHT);
        constants.put(DATA_MEASURE_TIME, Hs2sProfile.DATA_MEASURE_TIME);
        constants.put(DATA_RIGHT_TIME, Hs2sProfile.DATA_RIGHT_TIME);
        constants.put(DATA_BODYBUILDING, Hs2sProfile.DATA_BODYBUILDING);
        constants.put(DATA_INSTRUCTION_TYPE, Hs2sProfile.DATA_INSTRUCTION_TYPE);
        constants.put(DATA_BODY_FIT_PERCENTAGE, Hs2sProfile.DATA_BODY_FIT_PERCENTAGE);
        constants.put(DATA_MUSCLE_MASS, Hs2sProfile.DATA_MUSCLE_MASS);
        constants.put(DATA_BONE_SALT_CONTENT, Hs2sProfile.DATA_BONE_SALT_CONTENT);
        constants.put(DATA_BODY_WATER_RATE, Hs2sProfile.DATA_BODY_WATER_RATE);
        constants.put(DATA_SKELETAL_MUSCLE_MASS, Hs2sProfile.DATA_SKELETAL_MUSCLE_MASS);
        constants.put(DATA_BASAL_METABOLIC_RATE, Hs2sProfile.DATA_BASAL_METABOLIC_RATE);
        constants.put(DATA_VISCERAL_FAT_GRADE, Hs2sProfile.DATA_VISCERAL_FAT_GRADE);
        constants.put(DATA_PHYSICAL_AGE, Hs2sProfile.DATA_PHYSICAL_AGE);
        constants.put(DATA_BODY_MASS_INDEX, Hs2sProfile.DATA_BODY_MASS_INDEX);
        constants.put(DATA_STANDARD_WEIGHT, Hs2sProfile.DATA_STANDARD_WEIGHT);
        constants.put(DATA_WEIGHT_CONTROL, Hs2sProfile.DATA_WEIGHT_CONTROL);
        constants.put(DATA_MUSCLE_CONTROL, Hs2sProfile.DATA_MUSCLE_CONTROL);
        constants.put(DATA_FAT_CONTROL, Hs2sProfile.DATA_FAT_CONTROL);
        constants.put(DATA_FAT_WEIGHT, Hs2sProfile.DATA_FAT_WEIGHT);
        constants.put(DATA_DE_FAT_WEIGHT, Hs2sProfile.DATA_DE_FAT_WEIGHT);

        constants.put(ACTION_ONLINE_RESULT, Hs2sProfile.ACTION_ONLINE_RESULT);
        constants.put(ACTION_DELETE_HISTORY_DATA, Hs2sProfile.ACTION_DELETE_HISTORY_DATA);

        constants.put(ACTION_ANONYMOUS_DATA_NUM, Hs2sProfile.ACTION_ANONYMOUS_DATA_NUM);
        constants.put(ANONYMOUS_DATA_COUNT, Hs2sProfile.ANONYMOUS_DATA_COUNT);

        constants.put(ACTION_DELETE_ANONYMOUS_DATA, Hs2sProfile.ACTION_DELETE_ANONYMOUS_DATA);
        constants.put(ACTION_ONLINE_REAL_TIME_WEIGHT, Hs2sProfile.ACTION_ONLINE_REAL_TIME_WEIGHT);
        constants.put(ACTION_BODY_FAT_RESULT, Hs2sProfile.ACTION_BODY_FAT_RESULT);
        constants.put(DATA_BODY_FAT_RESULT, Hs2sProfile.DATA_BODY_FAT_RESULT);

        constants.put(ACTION_RESTORE_FACTORY_SETTINGS, Hs2sProfile.ACTION_RESTORE_FACTORY_SETTINGS);
        constants.put(ACTION_GET_ALL_CONNECTED_DEVICES, iHealthBaseModule.ACTION_GET_ALL_CONNECTED_DEVICES);

        constants.put(ACTION_HS2S_LightUp_DEVICE, Hs2sProfile.ACTION_SET_BLE_LIGHT);
        constants.put(HS2S_DEVICE_STATUS, Hs2sProfile.OPERATION_STATUS);
        constants.put(ACTION_HS2S_MEASURE_HEARTRATE, Hs2sProfile.ACTION_START_HEARTRATE_MEASURE);
        constants.put(ACTION_HS2S_EXIT_MEASURE_HEARTRATE_STATUS, Hs2sProfile.ACTION_STOP_HEARTRATE_MEASURE);
        constants.put(HS2S_MEASURE_HEARTRATE_RESULT, Hs2sProfile.DATA_HEARTRATE);
        return constants;
    }
}
