# BG5S Workflow

## Import BG5S Module

```js
import {
  BG5SModule,
  BG5SProfileModule
} from '@ihealth/ihealthlibrary-react-native';
```

## APIs

### Add and remove listener

```js
// add
notifyListener = DeviceEventEmitter.addListener(BG5SModule.Event_Notify,  (event) => {
    console.log(event);
});

// remove
notifyListener.remove();
```

### Set time

If you use new bg5 or it has not been used for a long time. You should sync current time with bg5.

```js
BG5SModule.setTime(mac);

// response
// {"type":"BG5S","mac":"5C0272267365","action":"action_set_time"}
notifyListener = DeviceEventEmitter.addListener(BG5SModule.Event_Notify,  (event) => {
    if (event.action === BG5SProfileModule.ACTION_SET_TIME) {
        console.log("set time");
    }
});
```

### Set Unit

The API can change the unit of the bg5 display.

```js
// 1: mmol/L 2: mg/dL
BG5SModule.setUnit(mac, 1);

// response
// {"type":"BG5S","mac":"5C0272267365","action":"action_set_unit"}
notifyListener = DeviceEventEmitter.addListener(BG5SModule.Event_Notify,  (event) => {
    if (event.action === BG5SProfileModule.ACTION_SET_UNIT) {
        console.log("set Unit");
    }
});
```

### get bg5s status information

```js
BG5SModule.getStatusInfo(mac);

// response
// {"info_unit":2,"info_code_version_ctl":3,"info_code_version_blood":3,"info_offline_data_num":0,"info_used_strip":0,////"info_timezone":8,"info_time":"2017-01-01 00:40:37","info_battery_level":71,"type":"BG5S","mac":"5C0272267365","action":"action_get_status_info"}

notifyListener = DeviceEventEmitter.addListener(BG5SModule.Event_Notify,  (event) => {
    if (event.action === BG5SProfileModule.ACTION_GET_STATUS_INFO) {
        console.log(event[BG5SProfileModule.INFO_BATTERY_LEVEL]);
        console.log(event[BG5SProfileModule.INFO_TIME]);
        console.log(event[BG5SProfileModule.INFO_TIMEZONE]);
        console.log(event[BG5SProfileModule.INFO_USED_STRIP]);
        console.log(event[BG5SProfileModule.INFO_OFFLINE_DATA_NUM]);
        console.log(event[BG5SProfileModule.INFO_CODE_VERSION_BLOOD]);
        console.log(event[BG5SProfileModule.INFO_CODE_VERSION_CTL]);
        console.log(event[BG5SProfileModule.INFO_UNIT]);
    }
});
```

### delete userd strip

```js
BG5SModule.deleteUsedStrip(QRCode);

// response
// {"type":"BG5S","mac":"5C0272267365","action":"action_delete_used_strip"}
notifyListener = DeviceEventEmitter.addListener(BG5SModule.Event_Notify,  (event) => {
    if (event.action === BG5SProfileModule.ACTION_DELETE_USED_STRIP) {
        
    }
});
```

### delete offline data

```js
BG5SModule.deleteOfflineData(QRCode);

// response
// {"type":"BG5S","mac":"5C0272267365","action":"action_delete_offline_data"}
notifyListener = DeviceEventEmitter.addListener(BG5SModule.Event_Notify,  (event) => {
    if (event.action === BG5SProfileModule.ACTION_DELETE_OFFLINE_DATA) {
        
    }
});
```

### get offline data

```js
BG5SModule.getOfflineData(mac);

// response
// {"offline_data":[{"dataID":"D8615BFEB73C3928D83131894D68E87B","data_measure_timezone":8,"data_measure_time":"2019-04-22 01:31:47","data_value":1023,"data_time_proof":false}],"type":"BG5S","mac":"5C0272267365","action":"action_get_offline_data"}

notifyListener = DeviceEventEmitter.addListener(BG5SModule.Event_Notify,  (event) => {
    if (event.action === BG5SProfileModule.ACTION_GET_OFFLINE_DATA) {
        console.log(event[BG5SProfileModule.OFFLINE_DATA]);
    }
});
```

### adjust offline data

```js
BG5SModule.adjustOfflineData(mac);

// response
// {"offline_data":[{"dataID":"D8615BFEB73C3928D83131894D68E87B","data_measure_timezone":8,"data_measure_time":"2019-04-22 01:31:47","data_value":1023,"data_time_proof":false}],"type":"BG5S","mac":"5C0272267365","action":"action_get_offline_data"}

notifyListener = DeviceEventEmitter.addListener(BG5SModule.Event_Notify,  (event) => {
    if (event.action === "action_adjust_offline_data") {
        console.log(event[BG5SProfileModule.OFFLINE_DATA]);
    }
});
```

### start a measurement

```js
// * measureType 1: measure with real blood, 2: measure with control solution
BG5SModule.startMeasure(mac, 1);

// response
notifyListener = DeviceEventEmitter.addListener(BG5SModule.Event_Notify,  (event) => {
    if (event.action === BG5SProfileModule.ACTION_STRIP_IN) {
        console.log("strip in");

    } else if (event.action === BG5SProfileModule.ACTION_STRIP_OUT) {
        console.log("strip out");

    } else if (event.action === BG5SProfileModule.ACTION_GET_BLOOD) {
        console.log("analysis blood");

    } else if (event.action === BG5SProfileModule.ACTION_RESULT) {
        // {"dataID":"FCB4230B3F081306DCC0404090861A36","result_value":84,"type":"BG5S","mac":"5C0272267365","action":"action_result"}
        console.log(event[BG5SProfileModule.RESULT_VALUE]);
        console.log(event[BG5SProfileModule.DATA_ID]);
    }
});
```

### get data stored in the bg5 device

```js
BG5SModule.setOfflineModel(mac, true);

// response
// // {"type":"BG5S","mac":"5C0272267365","action":"action_delete_offline_data"}
notifyListener = DeviceEventEmitter.addListener(BG5SModule.Event_Notify,  (event) => {
    if (event.action === BG5SProfileModule.ACTION_SET_OFFLINE_MEASUREMENT_MODE) {

    }
});
```