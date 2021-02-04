# PO3 Workflow

## Import PO3 Module

```js
import {
  PO3Module,
  POProfileModule
} from '@ihealth/ihealthlibrary-react-native';
```

## APIs

### Add and remove listener

```js
// add
notifyListener = DeviceEventEmitter.addListener(PO3Module.Event_Notify,  (event) => {
    console.log(event);
});

// remove
notifyListener.remove();
```

### get battery

```js
PO3Module.getBattery(mac);

// response
notifyListener = DeviceEventEmitter.addListener(PO3Module.Event_Notify,  (event) => {
    if (event.action === POProfileModule.ACTION_BATTERY_PO) {
        console.log(event[POProfileModule.BATTERY_PO]);
    }
});
```

### start a measurement with app

```js
PO3Module.startMeasure(mac);

// response
notifyListener = DeviceEventEmitter.addListener(PO3Module.Event_Notify,  (event) => {
    if (event.action === POProfileModule.ACTION_LIVEDA_PO) {
        console.log(event[POProfileModule.PULSE_WAVE_PO]);
        console.log(event[POProfileModule.PI_PO]);
        console.log(event[POProfileModule.PULSE_STRENGTH_PO]);
        console.log(event[POProfileModule.BLOOD_OXYGEN_PO]);
        console.log(event[POProfileModule.PULSE_RATE_PO]);
    } else if(){
        // final result
        console.log(event[POProfileModule.PULSE_WAVE_PO]);
        console.log(event[POProfileModule]);
        console.log(event[POProfileModule.PI_PO]);
        console.log(event[POProfileModule.PULSE_STRENGTH_PO]);
        console.log(event[POProfileModule.BLOOD_OXYGEN_PO]);
        console.log(event[POProfileModule.PULSE_RATE_PO]);
    }
});
```

### get data stored in the po3 device

```js
PO3Module.getHistoryData(mac);

// response
notifyListener = DeviceEventEmitter.addListener(PO3Module.Event_Notify,  (event) => {
    if (event.action === POProfileModule.ACTION_NO_OFFLINEDATA_PO) {
        console.log("There is no more data stored in the po3 device.");
    } else if (event.action === POProfileModule.ACTION_OFFLINEDATA_PO) {
        const dataArray = event[POProfileModule.OFFLINEDATA_PO];
        for (let i = 0; i < dataArray.length; i++) {
                let offlineData = dataArray[i];
                console.log(offlineData[POProfileModule.MEASUREMENT_DATE_BP]);
                console.log(offlineData[POProfileModule.HIGH_BLOOD_PRESSURE_BP]);
                console.log(offlineData[POProfileModule.LOW_BLOOD_PRESSURE_BP]);
                console.log(offlineData[POProfileModule.PULSE_BP]);
                console.log(offlineData[POProfileModule.MEASUREMENT_AHR_BP]);
                console.log(offlineData[POProfileModule.MEASUREMENT_HSD_BP]);
                console.log(offlineData[POProfileModule.DATAID]);
            }
    }
});
```