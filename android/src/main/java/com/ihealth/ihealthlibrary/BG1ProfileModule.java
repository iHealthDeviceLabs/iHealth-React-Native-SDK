package com.ihealth.ihealthlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.Bg1Profile;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Nullable;

/**
 * Created by zhaoyongguang on 07/12/2016.
 */
@ReactModule(name = "BG1ProfileModule")
public class BG1ProfileModule extends ReactContextBaseJavaModule {
    private static final String name = BG1ProfileModule.class.getSimpleName();
    /**
     * Callback indicating the send code result of bg1 device.
     * <ul>
     * KeyList:
     * <ul>
     * <li>
     * {@link #BG1_SENDCODE_RESULT}
     * </li>
     */
    private static final String ACTION_BG1_SENDCODE_RESULT = "ACTION_BG1_SENDCODE_RESULT";

    /**
     * The send code result of bg1 device.
     * <p/>
     * value : 0 success; other error
     */
    private static final String BG1_SENDCODE_RESULT = "BG1_SENDCODE_RESULT";

    /**
     * Callback indicating the error of Bg1 device.
     * <ul>
     * KeyList:
     * <ul>
     * <li>
     * {@link #BG1_MEASURE_ERROR}
     * </li>
     * </ul>
     * eg. {"error_num_for_bg1":0}
     * </ul>
     */
    private static final String ACTION_BG1_MEASURE_ERROR = "ACTION_BG1_MEASURE_ERROR";

    /**
     * Flag Error number of Bg1 device.
     * <p>Error code and Description</p>
     * <p>0:Battery is low.</p>
     * <p>1:Glucose test result is out of the measurement range.</p>
     * <p>2:Unknown interference detected, please repeat the test.</p>
     * <p>3:Strip is used or unknown moisture detected, discard the test strip and repeat the test with a new strip..</p>
     * <p>4:Communication error,resend the code to repeat the test. {@link Bg1Control#sendCode(String)}</p>
     * <p>5:The environmental temperature is beyond normal range, place the meter at room temperature for at least 30 minutes, then repeat the test.</p>
     * <p>6:The environmental temperature is beyond normal range, place the meter at room temperature for at least 30 minutes, then repeat the test.</p>
     * <p>7:Test strip coding error.</p>
     * <p>8:Communication error,rescan the code to repeat the test.</p>
     * <p>9:Communication error,Repeat the test with a new test strip. If the problem persists, contact iHealth customer service for assistance.</p>
     * <p>10:Communication error,Repeat the test with a new test strip. If the problem persists, contact iHealth customer service for assistance.</p>
     * <p>11:Communication error,Repeat the test with a new test strip. If the problem persists, contact iHealth customer service for assistance.</p>
     * <p>12:Glucose test result is low.</p>
     * <p>13:Glucose test result is high.</p>
     * <p>400:Parameters out of range.</p>
     * <p>401:Dolby is on ,please turn it off.</p>
     */
    private static final String BG1_MEASURE_ERROR = "BG1_MEASURE_ERROR";

    /**
     * Callback indicating the strip in action.
     */
    private static final String ACTION_BG1_MEASURE_STRIP_IN = "ACTION_BG1_MEASURE_STRIP_IN";

    /**
     * Callback indicating the get blood action.
     */
    private static final String ACTION_BG1_MEASURE_GET_BLOOD = "ACTION_BG1_MEASURE_GET_BLOOD";

    /**
     * Callback indicating the measure result.
     * <ul>
     * KeyList:
     * <ul>
     * <li>
     * {@link #BG1_MEASURE_RESULT}
     * </li>
     */
    private static final String ACTION_BG1_MEASURE_RESULT = "ACTION_BG1_MEASURE_RESULT";

    /**
     * The measure result
     * <p/>
     * Range : 20-600 mg/dL
     */
    private static final String BG1_MEASURE_RESULT = "BG1_MEASURE_RESULT";

    /**
     * Callback indicating the strip out action.
     */
    private static final String ACTION_BG1_MEASURE_STRIP_OUT = "ACTION_BG1_MEASURE_STRIP_OUT";

    /**
     * Callback indicating the Bg1 device get in standby mode.
     */
    private static final String ACTION_BG1_MEASURE_STANDBY = "ACTION_BG1_MEASURE_STANDBY";

    /**
     * the data id
     */
    private static final String DATA_ID = "DATA_ID";

    /**
     * Callback indicating the code analysis result.
     */
    private static final String ACTION_CODE_ANALYSIS = "ACTION_CODE_ANALYSIS";


    /**
     * the strip number
     */
    private static final String STRIP_NUM_BG = "STRIP_NUM_BG";


    /**
     * the expire time
     */
    private static final String STRIP_EXPIRETIME_BG = "STRIP_EXPIRETIME_BG";


    /**
     * the bottle id
     */
    private static final String BOTTLEID_BG = "BOTTLEID_BG";

    /**
     * @return the name of this module. This will be the name used to {@code require()} this module
     * from javascript.
     */
    @Override
    public String getName() {
        return name;
    }

    public BG1ProfileModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    /**
     * @return a map of constants this module exports to JS. Supports JSON types.
     */
    @Nullable
    @Override
    public Map<String, Object> getConstants() {
        Map<String, Object> constants = new HashMap<>();
        constants.put(ACTION_BG1_SENDCODE_RESULT, Bg1Profile.ACTION_BG1_SENDCODE_RESULT);
        constants.put(BG1_SENDCODE_RESULT, Bg1Profile.BG1_SENDCODE_RESULT);
        constants.put(ACTION_BG1_MEASURE_ERROR, Bg1Profile.ACTION_BG1_MEASURE_ERROR);
        constants.put(BG1_MEASURE_ERROR, Bg1Profile.BG1_MEASURE_ERROR);
        constants.put(ACTION_BG1_MEASURE_STRIP_IN, Bg1Profile.ACTION_BG1_MEASURE_STRIP_IN);
        constants.put(ACTION_BG1_MEASURE_GET_BLOOD, Bg1Profile.ACTION_BG1_MEASURE_GET_BLOOD);
        constants.put(ACTION_BG1_MEASURE_RESULT, Bg1Profile.ACTION_BG1_MEASURE_RESULT);
        constants.put(BG1_MEASURE_RESULT, Bg1Profile.BG1_MEASURE_RESULT);
        constants.put(ACTION_BG1_MEASURE_STRIP_OUT, Bg1Profile.ACTION_BG1_MEASURE_STRIP_OUT);
        constants.put(ACTION_BG1_MEASURE_STANDBY, Bg1Profile.ACTION_BG1_MEASURE_STANDBY);
        constants.put(DATA_ID, Bg1Profile.DATA_ID);
        constants.put(ACTION_CODE_ANALYSIS, "action_code_analysis");
        constants.put(STRIP_NUM_BG, "strip_num");
        constants.put(STRIP_EXPIRETIME_BG, "expire_time");
        constants.put(BOTTLEID_BG, "bottle_id");
        return constants;
    }
}
