# HS6 Workflow

## import HS6 module

```js
import {
  HS6Module,
  HS6ProfileModule
} from '@ihealth/ihealthlibrary-react-native';
```

## APIs

### add and remove listener

```js
// add
notifyListener = DeviceEventEmitter.addListener(HS6Module.Event_Notify,  (event) => {
    console.log(event);
});

// remove
notifyListener.remove();
```

### init hs6

```js
// need the ihealth account, apply from ihealth developer website
HS6Module.init("xxx.xxx@xxx.com");
```

### set wifi for hs6

The api only support the 2.4G wifi.

```js
HS6Module.setWifi("xxxx", "1234567890");

// response
notifyListener = DeviceEventEmitter.addListener(HS6Module.Event_Notify,  (event) => {
    if (event.action === HS6ProfileModule.ACTION_HS6_SETWIFI) {
        console.log(event[HS6ProfileModule.SETWIFI_RESULT]);
    }
});
```

### bind user with hs6

```js
/**
 * birthday
 * weight(kg)
 * height(cm)
 * isSporter
 * gender
 * serialNumber
 */
HS6Module.bindDeviceHS6("1979-02-26 12:20:10", 85.0, 180, 2, 1, "ACCF2337A952");

// response
notifyListener = DeviceEventEmitter.addListener(HS6Module.Event_Notify,  (event) => {
    if (event.action === HS6ProfileModule.ACTION_HS6_BIND) {
        console.log(event[HS6ProfileModule.HS6_BIND_EXTRA]);
        // 1: bind success, 2: the scale has no empty position, 3: bind fail
        console.log(event[HS6ProfileModule.BIND_HS6_RESULT]);
        console.log(event[HS6ProfileModule.HS6_MODEL]);
        // The range is from 1~10
        console.log(event[HS6ProfileModule.HS6_POSITION]);
        // 1: setted, 0: not
        console.log(event[HS6ProfileModule.HS6_SETTED_WIFI]);
    }
});
```

### unbind hs6

```js
HS6Module.unBindDeviceHS6("ACCF2337A952");

// response
notifyListener = DeviceEventEmitter.addListener(HS6Module.Event_Notify,  (event) => {
    if (event.action === HS6ProfileModule.ACTION_HS6_UNBIND) {
        console.log(event[HS6ProfileModule.HS6_UNBIND_RESULT]);
    }
});
```

### get token

```js
/**
 * clientId, 
 * clientSecret, 
 * username, 
 * clientPara
`*/
HS6Module.getToken("xxx", "xxx", "xxx.xxx@xxx.com", "random_str");

// response
notifyListener = DeviceEventEmitter.addListener(HS6Module.Event_Notify,  (event) => {
    if (event.action === HS6ProfileModule.ACTION_HS6_GET_TOKEN) {
        console.log(event[HS6ProfileModule.GET_TOKEN_RESULT]);
    }
});
```

### set unit

```js
/**
 * username
 * unitType 0: Kg 1: lbs 2: st
`*/
HS6Module.setUnit("xxx.xxx@xxx.com", 0);

// response
notifyListener = DeviceEventEmitter.addListener(HS6Module.Event_Notify,  (event) => {
    if (event.action === HS6ProfileModule.ACTION_HS6_SET_UNIT) {
        console.log(event[HS6ProfileModule.SET_UNIT_RESULT]);
    }
});
```

### get data stored in cloud

```js
HS6Module.getCloudData("xxx", "xxx", "xxx.xxx@xxx.com", 0, 10);

// response
notifyListener = DeviceEventEmitter.addListener(HS6Module.Event_Notify,  (event) => {
    if (event.action === HSProfileModule.ACTION_HS6_GET_CLOUDDATA) {
        
    }
});
```

