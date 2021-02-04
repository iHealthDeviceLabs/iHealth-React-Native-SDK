# AM4 Workflow

## Import AM4 Module

```js
import {
  AM4Module,
  AMProfileModule
} from '@ihealth/ihealthlibrary-react-native';
```

## APIs

### Add and remove listener

```js
// add
notifyListener = DeviceEventEmitter.addListener(AM4Module.Event_Notify,  (event) => {
    console.log(event);
});

// remove
notifyListener.remove();
```

### get all connected am4 devices

```js
AM4Module.getAllConnectedDevices();
```

### disconnect a am4 devices

```js
AM4Module.disconnect(mac);
```

### erase am4 memory

```js
AM4Module.reset(mac);

// response
notifyListener = DeviceEventEmitter.addListener(AM4Module.Event_Notify,  (event) => {
    if (event.action === AMProfileModule.ACTION_RESET_AM) {
        if (0 === event[AMProfileModule.RESET_AM]) {
            console.log('reset fail');
        } else if (1 === event[AMProfileModule.RESET_AM]) {
            console.log('reset success');
        }
    }
});
```

### get the user id bound to the device

```js
AM4Module.getUserId(mac);

// response
notifyListener = DeviceEventEmitter.addListener(AM4Module.Event_Notify,  (event) => {
    if (event.action === AMProfileModule.ACTION_USERID_AM) {
        console.log(event[AMProfileModule.USERID_AM]);
    }
});
```

### set the user id to the device

```js
// id: user id, the range is 0~0x7fffffff
AM4Module.setUserId(mac, id);

// response
notifyListener = DeviceEventEmitter.addListener(AM4Module.Event_Notify,  (event) => {
    if (event.action === AMProfileModule.ACTION_SET_USERID_SUCCESS_AM) {
        console.log('set success');
    }
});
```

### setAlarmClock

```js

/**
 * id: alarm clock id, you can set up to 3 alarm clocks
 * hour: clock hour
 * min:  clock minates
 * isRepeat: one time or repeat
 * weeks: available on the day of the week
 * isOn: open or close
 */

AM4Module.setAlarmClock(mac, 1, 12, 0, true, [1, 1, 1, 1, 1, 0, 0], false);

// response
notifyListener = DeviceEventEmitter.addListener(AM4Module.Event_Notify,  (event) => {
    if (event.action === AMProfileModule.ACTION_SET_ALARMINFO_SUCCESS_AM) {
        console.log('set success');
    }
});
```

### get alarm clock ids

```js
AM4Module.getAlarmClockNum(mac);

// response
notifyListener = DeviceEventEmitter.addListener(AM4Module.Event_Notify,  (event) => {
    if (event.action === AMProfileModule.ACTION_SET_ALARMINFO_SUCCESS_AM) {
        console.log(event[AMProfileModule.GET_ALARMNUM_AM]);    // e.g. 3
        console.log(event[AMProfileModule.GET_ALARMNUM_ID_AM]); // e.g. [1, 2, 3]
    }
});
```

### get alarm clock detail

```js
AM4Module.getAlarmClockDetail(mac, [1, 3, 2]);

// response
notifyListener = DeviceEventEmitter.addListener(AM4Module.Event_Notify,  (event) => {
    if (event.action === AMProfileModule.ACTION_GET_ALARMINFO_AM) {
        let dataArray = event[BPProfileModule.GET_ALARM_CLOCK_DETAIL];
        if (dataArray == undefined) {
            result = "There is not offline data in device"
        }else {
            for (let i = 0; i < dataArray.length; i++) {
                let offlineData = dataArray[i];
                console.log(offlineData[AMProfileModule.GET_ALARM_ID_AM]);
                console.log(offlineData[AMProfileModule.GET_ALARM_TIME_AM]);
                console.log(offlineData[AMProfileModule.GET_ALARM_ISREPEAT_AM]);
                console.log(offlineData[AMProfileModule.GET_ALARM_WEEK_AM]);
                console.log(offlineData[AMProfileModule.GET_ALARM_ISON_AM]);
            }
        } 
    }
});
```

### delete alarm clock by id

```js
AM4Module.deleteAlarmClock(mac, 1);

// response
notifyListener = DeviceEventEmitter.addListener(AM4Module.Event_Notify,  (event) => {
    if (event.action === AMProfileModule.ACTION_DELETE_ALARM_SUCCESS_AM) {
        console.log('delete success');
    }
});
```

### set activity reminder interval

```js
/**
 * hour
 * min
 * isOn: open or close
 */
AM4Module.setActivityRemind(mac, 0, 30, false);

// response
notifyListener = DeviceEventEmitter.addListener(AM4Module.Event_Notify,  (event) => {
    if (event.action === AMProfileModule.ACTION_SET_ACTIVITYREMIND_SUCCESS_AM) {
        console.log('set success');
    }
});
```

### get activity reminder interval

```js
AM4Module.getActivityRemind(mac);

// response
notifyListener = DeviceEventEmitter.addListener(AM4Module.Event_Notify,  (event) => {
    if (event.action === AMProfileModule.ACTION_GET_ACTIVITY_REMIND_AM) {
        console.log('get success');
    }
});
```

### get am4 information

```js
AM4Module.queryAMState(mac);

// response
notifyListener = DeviceEventEmitter.addListener(AM4Module.Event_Notify,  (event) => {
    if (event.action === AMProfileModule.ACTION_QUERY_STATE_AM) {
        // 0 indicates waist
        // 1 indicates wrist
        // 2 indicates sleep
        console.log(event[AMProfileModule.QUERY_STATE_AM]);
        // battery level 0~10
        console.log(event[AMProfileModule.QUERY_BATTERY_AM]);
    }
});
```

### set user id to the am4 device

```js
// The user id range is from 0 to 0x7fffffff
AM4Module.setUserId(mac, 8);

// response
notifyListener = DeviceEventEmitter.addListener(AM4Module.Event_Notify,  (event) => {
    if (event.action === AMProfileModule.ACTION_SET_USERID_SUCCESS_AM) {
        console.log('set success');
    }
});
```

### set user information to the am4 device

```js
/**
 * age
 * height(cm)
 * weight(lbs)
 * gender 0: female, 1: male
 * unit 0: miles, 1: kilometre
 * target the goal of steps, the range is from 4 ~ 65535
 * activityLevel 1: sedentary, 2: active, 3: very active
 */
AM4Module.setUserInfo(mac, 25, 183, 80, AMProfileModule.AM_SET_MALE, AMProfileModule.AM_SET_UNIT_METRIC, 10000, 1, 30);

// response
notifyListener = DeviceEventEmitter.addListener(AM4Module.Event_Notify,  (event) => {
    if (event.action === AMProfileModule.ACTION_SET_USERINFO_SUCCESS_AM) {
        console.log('set success');
    }
});
```

### get user information stored in the am4 device

```js
AM4Module.getUserInfo(mac);

// response
notifyListener = DeviceEventEmitter.addListener(AM4Module.Event_Notify,  (event) => {
    if (event.action === AMProfileModule.ACTION_GET_USERINFO_AM) {
        console.log(event[AMProfileModule.GET_USER_AGE_AM]);
        console.log(event[AMProfileModule.GET_USER_STEP_AM]);
        console.log(event[AMProfileModule.GET_USER_HEIGHT_AM]);
        console.log(event[AMProfileModule.GET_USER_SEX_AM]);
        console.log(event[AMProfileModule.GET_USER_WEIGHT_AM]);
        console.log(event[AMProfileModule.GET_USER_UNIT_AM]);
        console.log(event[AMProfileModule.GET_USER_AGE_AM]);
        console.log(event[AMProfileModule.GET_USER_TARGET1_AM]);
        console.log(event[AMProfileModule.GET_USER_TARGET2_AM]);
        console.log(event[AMProfileModule.GET_USER_TARGET3_AM]);
    }
});
```

### set bmr to the am4 device

```js
// bmr Basal Metabolic Rate
AM4Module.setUserBmr(mac, 2000);

// response
notifyListener = DeviceEventEmitter.addListener(AM4Module.Event_Notify,  (event) => {
    if (event.action === AMProfileModule.ACTION_SET_BMR_SUCCESS_AM) {
        console.log('set success');
    }
});
```

### get activity steps

```js
AM4Module.syncActivityData(mac);

// response
notifyListener = DeviceEventEmitter.addListener(AM4Module.Event_Notify,  (event) => {
    if (event.action === AMProfileModule.ACTION_SYNC_ACTIVITY_DATA_AM) {
        let dataArray = event[AMProfileModule.SYNC_ACTIVITY_EACH_DATA_AM];
        if (dataArray == undefined) {
            result = "There is not offline data in device"
        }else {
            for (let i = 0; i < dataArray.length; i++) {
                let offlineData = dataArray[i];
                console.log(offlineData[AMProfileModule.SYNC_ACTIVITY_DATA_TIME_AM]);
                console.log(offlineData[AMProfileModule.SYNC_ACTIVITY_DATA_STEP_AM]);
                console.log(offlineData[AMProfileModule.SYNC_ACTIVITY_DATA_CALORIE_AM]);
                console.log(offlineData[AMProfileModule.SYNC_ACTIVITY_DATA_STEP_LENGTH_AM]);
                console.log(offlineData[AMProfileModule.DATAID]);
            }
        }
    }
});
```

### get current activity steps

```js
AM4Module.syncRealData(mac);

// response
notifyListener = DeviceEventEmitter.addListener(AM4Module.Event_Notify,  (event) => {
    if (event.action === AMProfileModule.ACTION_SYNC_REAL_DATA_AM) {
        console.log(offlineData[AMProfileModule.SYNC_REAL_STEP_AM]);
        console.log(offlineData[AMProfileModule.SYNC_REAL_CALORIE_AM]);
        console.log(offlineData[AMProfileModule.SYNC_REAL_TOTALCALORIE_AM]);
    }
});
```

### set current time to am4 device

```js
AM4Module.syncRealData(mac);

// response
notifyListener = DeviceEventEmitter.addListener(AM4Module.Event_Notify,  (event) => {
    if (event.action === AMProfileModule.ACTION_SYNC_TIME_SUCCESS_AM) {
        console.log('set success');
    }
});
```

### set hour mode (12 or 24) to am4 device

```js
/**
 * AMProfileModule.AM_SET_12_HOUR_MODE(0)
 * AMProfileModule.AM_SET_24_HOUR_MODE(1)
 * AMProfileModule.AM_SET_EXCEPT_EUROPE_12_HOUR_MODE(2)
 * AMProfileModule.AM_SET_EUROPE_12_HOUR_MODE(3)
 * AMProfileModule.AM_SET_EXCEPT_EUROPE_24_HOUR_MODE(4)
 * AMProfileModule.AM_SET_EUROPE_24_HOUR_MODE
 **/
AM4Module.setHourMode(mac, AMProfileModule.AM_SET_24_HOUR_MODE);

// response
notifyListener = DeviceEventEmitter.addListener(AM4Module.Event_Notify,  (event) => {
    if (event.action === AMProfileModule.ACTION_SET_HOUR_MODE_SUCCESS_AM) {
        console.log('set success');
    }
});
```

### get hour mode (12 or 24) from am4 device


```js
AM4Module.getHourMode(mac);

// response
notifyListener = DeviceEventEmitter.addListener(AM4Module.Event_Notify,  (event) => {
    if (event.action === AMProfileModule.ACTION_GET_HOUR_MODE_AM) {
        console.log(event[AMProfileModule.GET_HOUR_MODE_AM]);
    }
});
```

### get sleep data stored in the am4

```js
AM4Module.syncSleepData(mac);

// response
notifyListener = DeviceEventEmitter.addListener(AM4Module.Event_Notify,  (event) => {
    if (event.action === AMProfileModule.ACTION_SYNC_SLEEP_DATA_AM) {
        let dataArray = event[AMProfileModule.SYNC_SLEEP_DATA_AM];
        if (dataArray == undefined) {
            result = "There is not offline data in device"
        }else {
            for (let i = 0; i < dataArray.length; i++) {
                let offlineData = dataArray[i];
                console.log(offlineData[AMProfileModule.SYNC_SLEEP_EACH_DATA_AM]);
                console.log(offlineData[AMProfileModule.SYNC_SLEEP_DATA_TIME_AM]);
                console.log(offlineData[AMProfileModule.SYNC_SLEEP_DATA_LEVEL_AM]);
                console.log(offlineData[AMProfileModule.DATAID]);
            }
        }
    }
});
```
