package com.ihealth.ihealthlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.HS6Control;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Nullable;

/**
 * Created by lixuesong on 15/11/2016.
 */
@ReactModule(name = "HS6ProfileModule")
public class HS6ProfileModule extends ReactContextBaseJavaModule {
    private static final String modelName = "HS6ProfileModule";
    private static final String TAG = "HS6ProfileModule";

    private static final String ACTION_HS6_SETWIFI = "ACTION_HS6_SETWIFI";
    private static final String SETWIFI_RESULT = "SETWIFI_RESULT";

    private static final String ACTION_HS6_BIND = "ACTION_HS6_BIND";
    private static final String HS6_BIND_EXTRA = "HS6_BIND_EXTRA";
    private static final String BIND_HS6_RESULT = "BIND_HS6_RESULT";
    private static final String HS6_MODEL = "HS6_MODEL";
    private static final String HS6_POSITION = "HS6_POSITION";
    private static final String HS6_SETTED_WIFI = "HS6_SETTED_WIFI";

    private static final String ACTION_HS6_UNBIND = "ACTION_HS6_UNBIND";
    private static final String HS6_UNBIND_RESULT = "HS6_UNBIND_RESULT";

    private static final String ACTION_HS6_GET_TOKEN = "ACTION_HS6_GET_TOKEN";
    private static final String GET_TOKEN_RESULT = "GET_TOKEN_RESULT";

    private static final String ACTION_HS6_SET_UNIT = "ACTION_HS6_SET_UNIT";
    private static final String SET_UNIT_RESULT = "SET_UNIT_RESULT";

    private static final String ACTION_HS6_ERROR = "ACTION_HS6_ERROR";
    private static final String HS6_ERROR = "HS6_ERROR";


    public static final String ACTION_HS6_GET_DATA = "ACTION_HS6_GET_DATA";

    public static final String DATA_RESULT = "DATA_RESULT";

    public static final String DATA_DOWNLOAD_TS = "DATA_DOWNLOAD_TS";
    public static final String DATA_LEFTNUMBER = "DATA_LEFTNUMBER";


    public HS6ProfileModule(ReactApplicationContext reactContext) {
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
        constants.put(ACTION_HS6_SETWIFI, HS6Control.ACTION_HS6_SETWIFI);
        constants.put(SETWIFI_RESULT, HS6Control.SETWIFI_RESULT);

        constants.put(ACTION_HS6_BIND, HS6Control.ACTION_HS6_BIND);
        constants.put(HS6_BIND_EXTRA, HS6Control.HS6_BIND_EXTRA);
        constants.put(BIND_HS6_RESULT, HS6Control.BIND_HS6_RESULT);
        constants.put(HS6_MODEL, HS6Control.HS6_MODEL);
        constants.put(HS6_POSITION, HS6Control.HS6_POSITION);
        constants.put(HS6_SETTED_WIFI, HS6Control.HS6_SETTED_WIFI);

        constants.put(ACTION_HS6_UNBIND, HS6Control.ACTION_HS6_UNBIND);
        constants.put(HS6_UNBIND_RESULT, HS6Control.HS6_UNBIND_RESULT);

        constants.put(ACTION_HS6_GET_TOKEN, HS6Control.ACTION_HS6_GET_TOKEN);
        constants.put(GET_TOKEN_RESULT, HS6Control.GET_TOKEN_RESULT);

        constants.put(ACTION_HS6_SET_UNIT, HS6Control.ACTION_HS6_SET_UNIT);
        constants.put(SET_UNIT_RESULT, HS6Control.SET_UNIT_RESULT);

        constants.put(ACTION_HS6_ERROR, HS6Control.ACTION_HS6_ERROR);
        constants.put(HS6_ERROR, HS6Control.HS6_ERROR);
        constants.put(ACTION_HS6_GET_DATA, HS6Control.ACTION_HS6_GET_DATA);
        constants.put(DATA_RESULT, HS6Control.DATA_RESULT);
        constants.put(DATA_DOWNLOAD_TS, HS6Control.DATA_DOWNLOAD_TS);
        constants.put(DATA_LEFTNUMBER, HS6Control.DATA_LEFTNUMBER);

        return constants;
    }
}
