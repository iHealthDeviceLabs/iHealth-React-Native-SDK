# BP7S Workflow

## Import BP7S Module

```js
import {
  BP7SModule,
  BPProfileModule
} from '@ihealth/ihealthlibrary-react-native';
```

## APIs

### add and remove listener

```js
// add
notifyListener = DeviceEventEmitter.addListener(BP7SModule.Event_Notify,  (event) => {
    console.log(event);
});

// remove
notifyListener.remove();
```

### get battery

```js
BP7SModule.getBattery(mac);

notifyListener = DeviceEventEmitter.addListener(BP7SModule.Event_Notify,  (event) => {
    if (event.action === BPProfileModule.ACTION_BATTERY_BP) {
        console.log(event[BPProfileModule.BATTERY_BP]);
    }
});
```

### set unit

The API can change the unit of the bg5 display.

```js
// unit :0 mmHg;1 kPa
BP7SModule.setUnit(mac, 1);

// response
notifyListener = DeviceEventEmitter.addListener(BP7SModule.Event_Notify,  (event) => {
    if (event.action === BPProfileModule.ACTION_SET_UNIT_SUCCESS_BP) {
        console.log("set Unit");
    }
});
```

### get quantity of data stored in the bp5 device

```js
BP7SModule.getOfflineNum(mac);

// response
notifyListener = DeviceEventEmitter.addListener(BP7SModule.Event_Notify,  (event) => {
    if (e.action === BPProfileModule.ACTION_HISTORICAL_NUM_BP) {
        console.log(event[BPProfileModule.HISTORICAL_NUM_BP]);
    }
});
```

### get data stored in the bp5 device

```js
BP7SModule.getOfflineData(mac);

notifyListener = DeviceEventEmitter.addListener(BP7SModule.Event_Notify,  (event) => {
    if (e.action === BPProfileModule.ACTION_HISTORICAL_DATA_BP) {
        let dataArray = event[BPProfileModule.HISTORICAL_DATA_BP];
        if (dataArray == undefined) {
            result = "There is not offline data in device"
        }else {
            for (let i = 0; i < dataArray.length; i++) {
                let offlineData = dataArray[i];

                console.log(offlineData[BPProfileModule.MEASUREMENT_DATE_BP]);
                console.log(offlineData[BPProfileModule.HIGH_BLOOD_PRESSURE_BP]);
                console.log(offlineData[BPProfileModule.LOW_BLOOD_PRESSURE_BP]);
                console.log(offlineData[BPProfileModule.PULSE_BP]);
                console.log(offlineData[BPProfileModule.MEASUREMENT_AHR_BP]);
                console.log(offlineData[BPProfileModule.MEASUREMENT_HSD_BP]);
                console.log(offlineData[BPProfileModule.DATAID]);
            }
        }
    }
});
```

### disconnect device

```js
BP7SModule.disConnect(mac);
```

### set angle range

```js
/**
 * leftHigh  the maximum measure angle of left hand, the maximum value must less than 90
 * leftLow   the minimum measure angle of left hand, the minimum value must more than 0, and less than leftUpper
 * rightHigh the maximum measure angle of right hand, the maximum value must less than 90
 * leftLow   the minimum measure angle of right hand, the minimum value must more than 0, and less than rightUpper
 */
BP7SModule.angleSet(mac, 80, 30, 80, 30);

// response
notifyListener = DeviceEventEmitter.addListener(BP7SModule.Event_Notify,  (event) => {
    if (e.action === BPProfileModule.ACTION_SET_ANGLE_SUCCESS_BP) {
        console.log("set angle");
    }
});
```

### get bp7s device information

```js
BP7SModule.getFunctionInfo(mac);
```

### get all connected devices

```js
BP7SModule.getAllConnectedDevices();
```