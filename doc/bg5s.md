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
notifyListener = DeviceEventEmitter.addListener(BG5SModule.Event_Notify,  (event) => {
    if (event.action === BG5SProfileModule.ACTION_SET_UNIT) {
        console.log("set Unit");
    }
});
```

### get bg5s status information

```js
BG5SModule.getBottleInfoFromQR(QRCode);

// response
notifyListener = DeviceEventEmitter.addListener(BG5SModule.Event_Notify,  (event) => {
    if (event.action === BG5SProfileModule.ACTION_CODE_ANALYSIS) {
        console.log(event[BG5SProfileModule.STRIP_NUM_BG]);
        console.log(event[BG5SProfileModule.STRIP_EXPIRETIME_BG]);
        console.log(event[BG5SProfileModule.BOTTLEID_BG]);
    }
});
```

### set bottle id

```js
BG5SModule.getBottleInfoFromQR(QRCode);

// response
notifyListener = DeviceEventEmitter.addListener(BG5SModule.Event_Notify,  (event) => {
    if (event.action === BGProfileModule.ACTION_SET_BOTTLEID) {
        console.log("Set bottleID");
    }
});
```

### get bottle id

```js
BG5SModule.getBottleInfoFromQR(QRCode);

// response
notifyListener = DeviceEventEmitter.addListener(BG5SModule.Event_Notify,  (event) => {
    if (event.action === BGProfileModule.ACTION_GET_BOTTLEID) {
        console.log(event[BGProfileModule.GET_BOTTLEID]);
    }
});
```

### Set bottle message

When you use a new bg5 device or you open a new strip bottle, must set bottle message to bg5 device.

```js
/**
 * mac         device mac address
 * stripType   1: GOD, 2: GDH
 * measureType 1: measure with real blood, 2: measure with control solution
 * barcode     for GOD strip, you can scan barcode at top of the bottle. for GDH strip, set null.
 * unusedStrip unused strip.
 * expireDay   check the expire day on the bottle, and stirp is expired after opening for 90 days.
 */
BG5SModule.setBottleMessage(mac, 1, 1, QRCode, 25, "2027-07-15");

// response
notifyListener = DeviceEventEmitter.addListener(BG5SModule.Event_Notify,  (event) => {
    if (event.action === BGProfileModule.ACTION_SET_BOTTLEMESSAGE) {
        console.log("set bottle message success");
    }
});
```

### get bottle message

```js
BG5SModule.getBottleMessage(mac);

// response
notifyListener = DeviceEventEmitter.addListener(BG5SModule.Event_Notify,  (event) => {
    if (event.action === BGProfileModule.ACTION_GET_BOTTLEMESSAGE) {
        console.log(event[BGProfileModule.GET_EXPIRECTIME]);
        console.log(event[BGProfileModule.GET_USENUM]);
    }
});
```

### start a measurement

```js
// * measureType 1: measure with real blood, 2: measure with control solution
BG5SModule.startMeasure(mac, 1);

// response
notifyListener = DeviceEventEmitter.addListener(BG5SModule.Event_Notify,  (event) => {
    if (event.action === BGProfileModule.ACTION_STRIP_IN) {
        console.log("strip in");

    } else if (event.action === BGProfileModule.ACTION_STRIP_OUT) {
        console.log("strip out");

    } else if (event.action === BGProfileModule.ACTION_GET_BLOOD) {
        console.log("analysis blood");

    } else if (event.action === BGProfileModule.ACTION_ONLINE_RESULT_BG) {
        console.log(event[BGProfileModule.ONLINE_RESULT_BG]);
        console.log(event[BGProfileModule.DATA_ID]);
    }
});
```

### get data stored in the bg5 device

```js
BG5SModule.getOfflineData(mac);

// response
notifyListener = DeviceEventEmitter.addListener(BG5SModule.Event_Notify,  (event) => {
    if (event.action === BGProfileModule.ACTION_GET_OFFLINEDATA_COUNT) {
        console.log(event[BGProfileModule.GET_OFFLINEDATA_COUNT]);
        console.log(event[BGProfileModule.GET_OFFLINEDATA]);
    }
});
```