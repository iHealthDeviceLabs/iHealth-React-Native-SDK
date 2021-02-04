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
// measureMode 1: measure with real blood, 2: measure with control solution
BG1SModule.measure(mac, 1);

// response
notifyListener = DeviceEventEmitter.addListener(BG1SModule.Event_Notify,  (event) => {
    if (event.action === BG1SProfileModule.ACTION_STRIP_INSERTION_STATUS) {
        console.log("strip in");

    } else if (event.action === BG1SProfileModule.ACTION_GET_BLOOD) {
        console.log("blood");

    } else if (event.action === BG1SProfileModule.ACTION_SET_MEASURE_MODE) {
        console.log(event[BG1SProfileModule.MEASURE_MODE]);
        console.log(event[BG1SProfileModule.MEASURE_RESULT]);
    }
});
```
