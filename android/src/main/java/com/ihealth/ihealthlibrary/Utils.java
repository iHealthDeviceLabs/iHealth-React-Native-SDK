package com.ihealth.ihealthlibrary;



import android.util.Log;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;


import java.util.Iterator;


/**
 * Created by jing on 16/11/10.
 */


public class Utils {

    private static final String TAG = "Utils";


    public static void jsonToMap(String jsonString, WritableMap writableMap) {
        JSONObject jsonObject = null;
        try {
            jsonObject = new JSONObject(jsonString);

            if (jsonObject.length()>0) {
                for (Iterator<String> keys=jsonObject.keys(); keys.hasNext();) {
                    String key = keys.next();
                    try {
                        Object object = jsonObject.get(key);
                        if (object instanceof JSONObject) {
                            writableMap.putMap(key, getMapFromJSONObject((JSONObject) object));
                        } else if (object instanceof JSONArray) {
                            writableMap.putArray(key, getWritableArrayFromJSONArray((JSONArray) object));
                        } else {
                            objectToMap(object, writableMap, key);
                        }
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                }
            }

        } catch (JSONException e) {
            e.printStackTrace();
        }
    }

    public static WritableMap getMapFromJSONObject(JSONObject object) {
        WritableMap map = Arguments.createMap();
        Iterator<String> keyIterator = object.keys();
        while (keyIterator.hasNext()) {
            String key = keyIterator.next();
            try {
                Object value = object.get(key);
                if (value instanceof JSONObject) {
                    // value is JSONObject case
                    map.putMap(key, getMapFromJSONObject((JSONObject) value));
                } else if (value instanceof JSONArray) {
                    // value is JSONArray case
                    map.putArray(key, getWritableArrayFromJSONArray((JSONArray) value));
                } else {
                    // Normal object case
                    objectToMap(value, map, key);
                }
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }
        return map;
    }

    public static WritableArray getWritableArrayFromJSONArray(JSONArray array) {
        WritableArray writableArray = Arguments.createArray();
        for (int i = 0; i < array.length(); i++) {
            try {
                Object objectInArray = array.get(i);
                if (objectInArray instanceof JSONObject) {
                    writableArray.pushMap(getMapFromJSONObject((JSONObject) objectInArray));
                } else if (objectInArray instanceof Boolean) {
                    writableArray.pushBoolean((Boolean) objectInArray);
                } else if(objectInArray instanceof Integer) {
                    writableArray.pushInt((Integer) objectInArray);
                } else if(objectInArray instanceof Double) {
                    writableArray.pushDouble((Double) objectInArray);
                } else if(objectInArray instanceof String) {
                    writableArray.pushString((String) objectInArray);
                } else if(objectInArray instanceof Long) {
                    writableArray.pushDouble((Long) objectInArray);
                } else {
                    Log.e(TAG, "Unknown type : " + objectInArray.getClass().getSimpleName());
                }
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }
        return writableArray;
    }

    private static void objectToMap(Object object, WritableMap writableMap, String key) {
        if (object instanceof Boolean) {
            writableMap.putBoolean(key, (Boolean) object);
        } else if(object instanceof Integer) {
            writableMap.putInt(key, (Integer) object);
        } else if(object instanceof Double) {
            writableMap.putDouble(key, (Double) object);
        } else if(object instanceof String) {
            writableMap.putString(key, (String) object);
        } else if(object instanceof Long) {
            writableMap.putDouble(key, (Long) object);
        } else {
            Log.e(TAG, "Unknown type : " + object.getClass().getSimpleName());
        }
    }
}
