# PT3SBT Workflow

## Import PT3SBT Module

```js
import {
  PT3SBTModule,
  PT3SBTProfileModule
} from '@ihealth/ihealthlibrary-react-native';
```

## APIs

### Add and remove listener

```js
// add
notifyListener = DeviceEventEmitter.addListener(PT3SBTModule.Event_Notify,  (event) => {
    console.log(event);
});

// remove
notifyListener.remove();
```

### set time

```js
PT3SBTModule.setTime(mac);

// response
// {status: "success", type: "PT3SBT", mac: "004D320C41BE", action: "action_set_time"}
notifyListener = DeviceEventEmitter.addListener(PT3SBTModule.Event_Notify,  (event) => {
    if (event.action === PT3SBTProfileModule.ACTION_SET_TIME) {
        console.log(event[NT13BProfileModule.STATUS]);
    } 
});
```

### get battery

```js
PT3SBTModule.getBattery(mac);

// response
// { battery: 70, type: "PT3SBT", mac: "004D320C41BE", action: "action_get_battery"}
notifyListener = DeviceEventEmitter.addListener(PT3SBTModule.Event_Notify,  (event) => {
    if (event.action === PT3SBTProfileModule.ACTION_GET_BATTERY) {
        console.log(event[PT3SBTProfileModule.BATTERY]);
    } 
});
```

### set unit

```js
// 1: centigrade, 2: fahrenheit
PT3SBTModule.setUnit(mac, unit);

// response
// {status: "success", type: "PT3SBT", mac: "004D320C41BE", action: "action_set_unit"}
notifyListener = DeviceEventEmitter.addListener(PT3SBTModule.Event_Notify,  (event) => {
    if (event.action === PT3SBTProfileModule.ACTION_SET_UNIT) {
        console.log(event[PT3SBTProfileModule.STATUS]);
    } 
});
```

### get unit

```js
PT3SBTModule.getUnit(mac);

// response
// {unit: 2, type: "PT3SBT", mac: "004D320C41BE", action: "action_get_unit"}
notifyListener = DeviceEventEmitter.addListener(PT3SBTModule.Event_Notify,  (event) => {
    if (event.action === PT3SBTProfileModule.ACTION_GET_UNIT) {
        console.log(event[PT3SBTProfileModule.UNIT]);
    } 
});
```

### get history data count

```js
PT3SBTModule.getHistoryCount(mac);

// response
// {count: 37, type: "PT3SBT", mac: "004D320C41BE", action: "action_get_history_count"}
notifyListener = DeviceEventEmitter.addListener(PT3SBTModule.Event_Notify,  (event) => {
    if (event.action === PT3SBTProfileModule.ACTION_GET_HISTORY_COUNT) {
        console.log(event[PT3SBTProfileModule.COUNT]);
    } 
});
```

### get history data

**Note: After call get history data, must to delele history data. If don't, the PT3SBT will keep on offline mode.**

```js
PT3SBTModule.getHistoryData(mac);

// response
// {history: Array, type: "PT3SBT", mac: "004D320C41BE", action: "action_get_history_data"}
notifyListener = DeviceEventEmitter.addListener(PT3SBTModule.Event_Notify,  (event) => {
    if (event.action === PT3SBTProfileModule.ACTION_GET_HISTORY_DATA) {
        const arr = event[PT3SBTProfileModule.HISTORY];
        arr.foreach(item => {
            console.log(item[PT3SBTProfileModule.TEMPERATURE]);
            console.log(item[PT3SBTProfileModule.TS]);
        })
    } 
});
```

### delete history data

```js
PT3SBTModule.deleteHistoryData(mac);

// response
// {status: "success", type: "PT3SBT", mac: "004D320C41BE", action: "action_delete_history_data"}
notifyListener = DeviceEventEmitter.addListener(PT3SBTModule.Event_Notify,  (event) => {
    if (event.action === PT3SBTProfileModule.ACTION_DELETE_HISTORY_DATA) {
        console.log(event[PT3SBTProfileModule.STATUS]);
    } 
});
```

### online measurement

```js
// response
// {Tbody: 3845", type: "PT3SBT", mac: "004D320C41BE", action: "action_temperature_measurement"}
// the real temperature is Tbody / 100, this is centigrade
notifyListener = DeviceEventEmitter.addListener(PT3SBTModule.Event_Notify,  (event) => {
    if (event.action === PT3SBTProfileModule.ACTION_TEMPERATURE_MEASUREMENT) {
        console.log(event[PT3SBTProfileModule.TEMPERATURE]);
    } 
});
```
