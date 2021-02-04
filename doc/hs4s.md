# HS4S Workflow

## import HS4S module

```js
import {
  HS4SModule,
  HSProfileModule
} from '@ihealth/ihealthlibrary-react-native';
```

## APIs

### add and remove listener

```js
// add
notifyListener = DeviceEventEmitter.addListener(HS4SModule.Event_Notify,  (event) => {
    console.log(event);
});

// remove
notifyListener.remove();
```

### start a measurement

The API is asyn function. It will return message until finish measurement.

```js
HS4SModule.startMeasure(mac);

notifyListener = DeviceEventEmitter.addListener(HS4SModule.Event_Notify,  (event) => {
    if (event.action === HSProfileModule.ACTION_ONLINE_RESULT_HS) {
        console.log(event[HSProfileModule.DATAID]);
        console.log(event[HSProfileModule.WEIGHT_HS]);
        console.log(event[HSProfileModule.FAT_HS]);
        console.log(event[HSProfileModule.WATER_HS]);
        console.log(event[HSProfileModule.MUSCLE_HS]);
        console.log(event[HSProfileModule.SKELETON_HS]);
        console.log(event[HSProfileModule.FATELEVEL_HS]);
        console.log(event[HSProfileModule.DCI_HS]);
    }
});
```

### get data stored in the HS4S device

```js
HS4SModule.getOfflineData(mac);

notifyListener = DeviceEventEmitter.addListener(HS4SModule.Event_Notify,  (event) => {
    if (event.action === HSProfileModule.ACTION_HISTORICAL_DATA_HS) {
        let dataArray = event[HSProfileModule.HISTORDATA_HS];
        if (dataArray == undefined) {
            result = "There is not offline data in device"
        }else {
            for (let i = 0; i < dataArray.length; i++) {
                let offlineData = dataArray[i];
                console.log(offlineData[HSProfileModule.MEASUREMENT_DATE_HS]);
                console.log(offlineData[HSProfileModule.WEIGHT_HS]);
                console.log(offlineData[HSProfileModule.FAT_HS]);
                console.log(offlineData[HSProfileModule.WATER_HS]);
                console.log(offlineData[HSProfileModule.MUSCLE_HS]);
                console.log(offlineData[HSProfileModule.SKELETON_HS]);
                console.log(offlineData[HSProfileModule.FATELEVEL_HS]);
                console.log(offlineData[HSProfileModule.DATAID]);
            }
        }
    }
});
```

### disconnect device

```js
BP3LModule.disConnect(mac);
```

### get all connected devices

```js
BP3LModule.getAllConnectedDevices();
```
