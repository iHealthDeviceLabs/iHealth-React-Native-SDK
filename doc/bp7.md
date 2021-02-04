# BP7 Workflow

## import BP7 module

```js
import {
  BP7Module,
  BPProfileModule
} from '@ihealth/ihealthlibrary-react-native';
```

## APIs

### add and remove listener

```js
// add
notifyListener = DeviceEventEmitter.addListener(BP7Module.Event_Notify,  (event) => {
    console.log(event);
});

// remove
notifyListener.remove();
```

### start a measurement

The API is asyn function. It will return message until finish measurement.

```js
// When you start a measurement, need call startMeasure function firstly, you will get angle of BP7
// make sure your angle is below the 30 degree, then call conformAngle function, the BP7 will start a measurement. 
BP5Module.startMeasure(mac);

BP5Module.conformAngle(mac);

notifyListener = DeviceEventEmitter.addListener(BP5Module.Event_Notify,  (event) => {
    if (event.action === BPProfileModule.ACTION_ANGLE_BP) {
        // {"which_arm":0,"value":22}
        console.log(event[BPProfileModule.WHICH_ARM]);
        console.log(event[BPProfileModule.ANGLE_BP]);

    } else if (event.action === BPProfileModule.ACTION_ZOREING_BP) {
        console.log("zero adjustment");

    } else if (event.action === BPProfileModule.ACTION_ZOREOVER_BP) {
        console.log("zero adjustment is done");

    } else if (event.action === BPProfileModule.ACTION_ONLINE_PRESSURE_BP) {
        // {"pressure":3}
        console.log(event[BPProfileModule.BLOOD_PRESSURE_BP]);

    } else if (event.action === BPProfileModule.ACTION_ONLINE_PULSEWAVE_BP) {
        // {"pressure":31,"heartbeat":false,"wave":"[15,15,15,15,15,15,15,15]"}
        console.log(event[BPProfileModule.BLOOD_PRESSURE_BP]);
        console.log(event[BPProfileModule.FLAG_HEARTBEAT_BP]);
        console.log(event[BPProfileModule.PULSEWAVE_BP]);

    } else if (event.action === BPProfileModule.ACTION_ONLINE_RESULT_BP) {
        // {"sys":122,"dia":87,"heartRate":75,"arrhythmia":false,"hsd":false,"dataID":"E3FC99C20A7FA7F7B7F8FC4B9DD059DF"}
        console.log(event[BPProfileModule.HIGH_BLOOD_PRESSURE_BP]);
        console.log(event[BPProfileModule.LOW_BLOOD_PRESSURE_BP]);
        console.log(event[BPProfileModule.PULSE_BP]);
        console.log(event[BPProfileModule.MEASUREMENT_AHR_BP]);
        console.log(event[BPProfileModule.DATAID]);

    } else if (event.action === BPProfileModule.ACTION_ERROR_BP) {
        console.log(event[BPProfileModule.ERROR_NUM_BP]);
        console.log(event[BPProfileModule.ERROR_DESCRIPTION_BP]);
    }
});
```

### cancel current measurement

```js
BP5Module.stopMeasure(mac);
```

### get battery

```js
BP5Module.getBattery(mac);

notifyListener = DeviceEventEmitter.addListener(BP5Module.Event_Notify,  (event) => {
    if (event.action === BPProfileModule.ACTION_BATTERY_BP) {
        console.log(event[BPProfileModule.BATTERY_BP]);
    }
});
```

### enable offline mode

```js
BP5Module.enbleOffline(mac);
```

### disable offline mode

```js
BP5Module.disableOffline(mac);
```

### is enable offline mode

```js
BP5Module.isEnableOffline(mac);

notifyListener = DeviceEventEmitter.addListener(BP5Module.Event_Notify,  (event) => {
    if (e.action === BPProfileModule.ACTION_IS_ENABLE_OFFLINE) {
        console.log(event[BPProfileModule.IS_ENABLE_OFFLINE]);
    }
});
```

### get quantity of data stored in the bp5 device

```js
BP5Module.getOfflineNum(mac);

notifyListener = DeviceEventEmitter.addListener(BP5Module.Event_Notify,  (event) => {
    if (e.action === BPProfileModule.ACTION_HISTORICAL_NUM_BP) {
        // {"offlinenum":2}
        console.log(event[BPProfileModule.HISTORICAL_NUM_BP]);
    }
});
```

### get data stored in the bp5 device

```js
BP5Module.getOfflineData(mac);

notifyListener = DeviceEventEmitter.addListener(BP5Module.Event_Notify,  (event) => {
    // {"data":[{"time":"2009-01-02 15:12:00","sys":120,"dia":72,"heartRate":71,"arrhythmia":false,"hsd":false,"dataID":"F77B50204315322FAB3B31548E6CDC4E"},{"time":"2009-01-02 15:13:00","sys":115,"dia":73,"heartRate":68,"arrhythmia":false,"hsd":false,"dataID":"F75BC53C3E43ACC3BA3DE1343B317398"}]}
    if (event.action === BPProfileModule.ACTION_HISTORICAL_DATA_BP) {
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
BP5Module.disConnect(mac);
```

### get device information

```js
iHealthDeviceManagerModule.getDevicesIDPS(mac, (event) => {
    console.info(event);
})
```

### get all connected devices

```js
BP5Module.getAllConnectedDevices();
```
