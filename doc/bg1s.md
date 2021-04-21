# BG1S Workflow

## Import BG1S Module

```js
import {
  BG1SModule,
  BG1SProfileModule
} from '@ihealth/ihealthlibrary-react-native';
```

## APIs

### Add and remove listener

```js
// add
notifyListener = DeviceEventEmitter.addListener(BG1SModule.Event_Notify,  (event) => {
    console.log(event);
});

// remove
notifyListener.remove();
```

### get function

Set current time to BG1S and return battery level, bg1s code version.

```js
BG1SModule.getFunction(mac);

// response
// {"action": "action_get_device_info", "battery": 100, "info_version_code_blood_bg1s": 1, "info_version_code_ctl_bg1s": 2, "mac": "F65FF0CBA330", "type": "BG1S"}
notifyListener = DeviceEventEmitter.addListener(BG1SModule.Event_Notify,  (event) => {
    if (event.action === BG1SProfileModule.ACTION_CODE_ANALYSIS) {
        console.log(event[BG1SProfileModule.INFO_BATTERY_BG1S]);
        console.log(event[BG1SProfileModule.INFO_VERSION_CODE_BLOOD_BG1S]);
        console.log(event[BG1SProfileModule.INFO_VERSION_CODE_CTL_BG1S]);
    }
});
```

### start a measurement

```js
// measureMode 0: measure with real blood, 1: measure with control solution
BG1SModule.measure(mac, 1);

// response
notifyListener = DeviceEventEmitter.addListener(BG1SModule.Event_Notify,  (event) => {
    if (event.action === BG1SProfileModule.ACTION_STRIP_INSERTION_STATUS) {
        // {"action": "action_strip_insertion_status", "describe": "strip in", "insertion_status": 1, "mac": "F65FF0CBA330", "type": "BG1S"}
        console.log("strip in");

    } else if (event.action === BG1SProfileModule.ACTION_GET_BLOOD) {
        //  {"action": "action_get_blood", "describe": "get blood", "mac": "F65FF0CBA330", "type": "BG1S"}
        console.log("blood");

    } else if (event.action === BG1SProfileModule.ACTION_MEASURE_RESULT) {
        // {"action": "action_measure_result", "mac": "F65FF0CBA330", "measure_mode": 0, "measure_result": 0, "type": "BG1S"}
        console.log(event[BG1SProfileModule.MEASURE_MODE]);
        console.log(event[BG1SProfileModule.MEASURE_RESULT]);
    }
});
```
