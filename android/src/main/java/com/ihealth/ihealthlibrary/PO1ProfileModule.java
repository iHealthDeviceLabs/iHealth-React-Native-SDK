package com.ihealth.ihealthlibrary;

import android.text.TextUtils;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.Po1Profile;
import com.ihealth.communication.control.PoProfile;
import com.ihealth.communication.control.Pt3sbtControl;
import com.ihealth.communication.manager.iHealthDevicesManager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Nullable;

@ReactModule(name = "PO1ProfileModule")
public class PO1ProfileModule extends ReactContextBaseJavaModule {

    private static final String modelName = PO1ProfileModule.class.getSimpleName();
    private static final String TAG = PO1ProfileModule.class.getSimpleName();

    private static final String ACTION_BO_MEASUREMENT = "ACTION_BO_MEASUREMENT";
    private static final String ACTION_ERROR_PO1 = "ACTION_ERROR_PO1";
    private static final String ACTION_GET_BATTERY = "ACTION_GET_BATTERY";
    private static final String ACTION_GET_ALL_CONNECTED_DEVICES = "ACTION_GET_ALL_CONNECTED_DEVICES";

    private static final String ERROR_ID = "ERROR_ID";
    private static final String ERROR_DESCRIPTION = "ERROR_DESCRIPTION";
    private static final String BATTERY  = "BATTERY";
    private static final String STATUS = "STATUS";

    private static final String BLOOD_OXYGEN = "PO1_BLOOD_OXYGEN";
    private static final String PULSE = "PO1_PULSE";
    private static final String PULSE_FORCE = "PO1_PULSE_FORCE";
    private static final String PI = "PO1_PI";
    private static final String WAVE = "PO1_WAVE";

    public PO1ProfileModule(ReactApplicationContext reactContext) {
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
        constants.put(ACTION_BO_MEASUREMENT, Po1Profile.ACTION_BO_MEASUREMENT);
        constants.put(ACTION_GET_BATTERY, Po1Profile.ACTION_GET_BATTERY);
        constants.put(ACTION_ERROR_PO1, Po1Profile.ACTION_ERROR_PO1);
        constants.put(ERROR_ID, Po1Profile.ERROR_ID);
        constants.put(ERROR_DESCRIPTION, Po1Profile.ERROR_DESCRIPTION);
        constants.put(BATTERY, Po1Profile.BATTERY);
        constants.put(STATUS, Po1Profile.STATUS);
        constants.put(BLOOD_OXYGEN, Po1Profile.BLOOD_OXYGEN);
        constants.put(PULSE, Po1Profile.PULSE);
        constants.put(PULSE_FORCE, Po1Profile.PULSE_FORCE);
        constants.put(PI, Po1Profile.PI);
        constants.put(WAVE, Po1Profile.WAVE);
        constants.put(ACTION_GET_ALL_CONNECTED_DEVICES, iHealthBaseModule.ACTION_GET_ALL_CONNECTED_DEVICES);
        return constants;
    }
}
