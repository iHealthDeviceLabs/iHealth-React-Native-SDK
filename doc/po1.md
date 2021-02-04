# PO1 Workflow

## Import PO1 Module

```js
import {
  PO1Module,
  PO1ProfileModule
} from '@ihealth/ihealthlibrary-react-native';
```

## APIs

### Add and remove listener

```js
// add
notifyListener = DeviceEventEmitter.addListener(PO1Module.Event_Notify,  (event) => {
    console.log(event);
});

// remove
notifyListener.remove();
```

### get battery

```js
PO1Module.getBattery(mac);

// response
// {battery: 32, type: "PO1", mac: "004D320C41BE", action: "action_get_battery"}
notifyListener = DeviceEventEmitter.addListener(PO1Module.Event_Notify,  (event) => {
    if (event.action === PO1ProfileModule.ACTION_GET_BATTERY) {
        console.log(event[PO1ProfileModule.BATTERY]);
    }
});
```

### online measurement

```js
// response
// {type: "PO1", mac: "004D320C41BE", action: "action_bo_measurement", "po1_blood_oxygen":97,"po1_pulse":61,"po1_pulse_force":7.800000190734863,"po1_pi":3,"po1_wave":[42,69,95,95,78]}
notifyListener = DeviceEventEmitter.addListener(PO1Module.Event_Notify,  (event) => {
    if (event.action === PO1ProfileModule.ACTION_BO_MEASUREMENT) {
        console.log(event[PO1ProfileModule.PO1_BLOOD_OXYGEN]);
        console.log(event[PO1ProfileModule.PO1_PULSE]);
        console.log(event[PO1ProfileModule.PO1_PULSE_FORCE]);
        console.log(event[PO1ProfileModule.PO1_PI]);
        console.log(event[PO1ProfileModule.PO1_WAVE]);
    }
});
```