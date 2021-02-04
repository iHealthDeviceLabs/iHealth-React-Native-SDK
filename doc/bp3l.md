# BP3L Workflow

## import BP3L module

```js
import {
  BP3LModule,
  BPProfileModule
} from '@ihealth/ihealthlibrary-react-native';
```

## APIs

### add and remove listener

```js
// add
notifyListener = DeviceEventEmitter.addListener(BP3LModule.Event_Notify,  (event) => {
    console.log(event);
});

// remove
notifyListener.remove();
```

### start a measurement

The API is asyn function. It will return message until finish measurement.

```js
BP3LModule.startMeasure(mac);

notifyListener = DeviceEventEmitter.addListener(BP3LModule.Event_Notify,  (event) => {
    if (event.action === BPProfileModule.ACTION_ZOREING_BP) {
        console.log("zero adjustment");

    } else if (event.action === BPProfileModule.ACTION_ZOREOVER_BP) {
        console.log("zero adjustment is done");

    } else if (event.action === BPProfileModule.ACTION_ONLINE_PRESSURE_BP) {
        console.log(event[BPProfileModule.BLOOD_PRESSURE_BP]);

    } else if (event.action === BPProfileModule.ACTION_ONLINE_PULSEWAVE_BP) {
        console.log(event[BPProfileModule.BLOOD_PRESSURE_BP]);
        console.log(event[BPProfileModule.FLAG_HEARTBEAT_BP]);
        console.log(event[BPProfileModule.PULSEWAVE_BP]);

    } else if (event.action === BPProfileModule.ACTION_ONLINE_RESULT_BP) {
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
BP3LModule.stopMeasure(mac);
```

### get battery

```js
BP3LModule.getBattery(mac);

notifyListener = DeviceEventEmitter.addListener(BP3LModule.Event_Notify,  (event) => {
    if (event.action === BPProfileModule.ACTION_BATTERY_BP) {
        console.log(event[BPProfileModule.BATTERY_BP]);
    }
});
```

### enable offline mode

```js
BP3LModule.enbleOffline(mac);
```

### disable offline mode

```js
BP3LModule.disableOffline(mac);
```

### is enable offline mode

```js
BP3LModule.isEnableOffline(mac);

notifyListener = DeviceEventEmitter.addListener(BP3LModule.Event_Notify,  (event) => {
    if (e.action === BPProfileModule.ACTION_IS_ENABLE_OFFLINE) {
        console.log(event[BPProfileModule.IS_ENABLE_OFFLINE]);
    }
});
```

### get quantity of data stored in the bp5 device

```js
BP3LModule.getOfflineNum(mac);

notifyListener = DeviceEventEmitter.addListener(BP3LModule.Event_Notify,  (event) => {
    if (e.action === BPProfileModule.ACTION_HISTORICAL_NUM_BP) {
        console.log(event[BPProfileModule.HISTORICAL_NUM_BP]);
    }
});
```

### get data stored in the bp5 device

```js
BP3LModule.getOfflineData(mac);

notifyListener = DeviceEventEmitter.addListener(BP3LModule.Event_Notify,  (event) => {
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
BP3LModule.disConnect(mac);
```

### get device information

```js
iHealthDeviceManagerModule.getDevicesIDPS(mac, (event) => {
    console.info(event);
})
```

### get all connected devices

```js
BP3LModule.getAllConnectedDevices();
```
