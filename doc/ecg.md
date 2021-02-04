# ECG3 Workflow

## import ECG3 module

```js
import {
  ECGModule,
  ECGProfileModule
} from '@ihealth/ihealthlibrary-react-native';
```

## APIs

### add and remove listener

```js
// add
notifyListener = DeviceEventEmitter.addListener(ECGModule.Event_Notify,  (event) => {
    console.log(event);
});

// remove
notifyListener.remove();
```

### get all connected devices

```js
ECGModule.getAllConnectedDevices();
```

### start a measurement

```js
ECGModule.startMeasure(mac);

// response
notifyListener = DeviceEventEmitter.addListener(ECGModule.Event_Notify,  (event) => {
    if (event.action === ECGModule.ACTION_ELECTRODE_STATUS) {
        console.log(event[ECGProfileModule.ELECTRODE_STATUS]);
        console.log(event[ECGProfileModule.ERROR_DESCRIPTION_ECG]);
    }
});
```

### cancel a measurement

```js
ECGModule.stopMeasure(mac);
```

### get battery

```js
ECGModule.getBattery(mac);

// response
notifyListener = DeviceEventEmitter.addListener(ECGModule.Event_Notify,  (event) => {
    if (event.action === ECGModule.ACTION_BATTERY_ECG) {
        console.log(event[ECGProfileModule.BATTERY_ECG])
    }
});
```

### set current time to device

```js
ECGModule.sysTime(mac);
```
