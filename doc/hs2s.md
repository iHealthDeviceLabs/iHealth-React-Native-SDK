# HS2S Workflow

## import HS2S module

```js
import {
  HS2SModule,
  HS2SProfileModule
} from '@ihealth/ihealthlibrary-react-native';
```

## APIs

### add and remove listener

```js
// add
notifyListener = DeviceEventEmitter.addListener(HS2SModule.Event_Notify,  (event) => {
    console.log(event);
});

// remove
notifyListener.remove();
```

### get device information

```js
HS2SModule.getDeviceInfo(mac);

notifyListener = DeviceEventEmitter.addListener(HS2SModule.Event_Notify,  (event) => {
    if (event.action === "action_get_device_info") {
       console.log(event["battery"]);
       console.log(event["unit_current"]);
       console.log(event["user_count"]);
    }
}
```

### get device battery

```js
HS2SModule.getBattery(mac);

notifyListener = DeviceEventEmitter.addListener(HS2SModule.Event_Notify,  (event) => {
    if (event.action === "action_get_battery_hs") {
       console.log(event["battery_hs"]);
    }
}
```

### set Unit

```js
HS2SModule.setUnit(mac);

notifyListener = DeviceEventEmitter.addListener(HS2SModule.Event_Notify,  (event) => {
    if (event.action === "action_set_unit") {
       console.log(event["result"]);
    }
}
```

### get user information

```js
HS2SModule.getUserInfo(mac);

notifyListener = DeviceEventEmitter.addListener(HS2SModule.Event_Notify,  (event) => {
    if (event.action === "action_get_user_info") {
       console.log(event["user_info-count"]);
       let array = event["user_info_array"];
       console.log(array["body_building"]);
       console.log(array["impedance"]);
       console.log(array["height"]);
       console.log(array["age"]);
       console.log(array["gender"]);
       console.log(array["weight"]);
       console.log(array["create_time"]);
       console.log(array["user_id"]);
    }
}
```

### create user

```js
HS2SModule.updateUserInfo(mac);

notifyListener = DeviceEventEmitter.addListener(HS2SModule.Event_Notify,  (event) => {
    if (event.action === "action_create_or_update_user_info") {
       console.log(event["result"]);
    }
}
```

### delete user

```js
HS2SModule.deleteUser(mac, userId);

notifyListener = DeviceEventEmitter.addListener(HS2SModule.Event_Notify,  (event) => {
    if (event.action === "action_delete_user_info") {
       console.log(event["result"]);
    }
}
```

### get the number of offline data

```js
HS2SModule.getMemoryDataCount(mac, userId);

notifyListener = DeviceEventEmitter.addListener(HS2SModule.Event_Notify,  (event) => {
    if (event.action === "action_history_data_num") {
       console.log(event["history_data_count"]);
    }
}
```

### get offline data

```js
HS2SModule.getMemoryData(mac, userId);

notifyListener = DeviceEventEmitter.addListener(HS2SModule.Event_Notify,  (event) => {
    if (event.action === "action_history_data") {
        let arr = event["history_data"];
        arr.forEach(function(result) {
            console.log(result["fat_weight"]);
            console.log(result["fat_control"];
            console.log(result["weight_control"];
            console.log(result["standard_weight"];
            console.log(result["skeletal_muscle_mass"];
            console.log(result["body_water_rate"];
            console.log(result["muscle_mas"];
            console.log(result["instruction_type"];
            console.log(result["body_building"];
            console.log(result["height"];
            console.log(result["gender"];
            console.log(result["muscle_control"];
            console.log(result["physical_age"];
            console.log(result["visceral_fat_grade"];
            console.log(result["protein_rate"];
            console.log(result["bone_salt_content"];
            console.log(result["visceral_fat_grade"];
            console.log(result["measure_time"];
            console.log(result["age"];
            console.log(result["impedance"];
            console.log(result["weight"];
       })
    }
}
```

### delete offline data by user id

```js
HS2SModule.deleteMemoryData(mac, userId);

notifyListener = DeviceEventEmitter.addListener(HS2SModule.Event_Notify,  (event) => {
    if (event.action === "action_delete_history_data") {
       console.log(event["result"]);
    }
}
```

### get the number of anonymous offline data

```js
HS2SModule.getAnonymousMemoryDataCount(mac);

notifyListener = DeviceEventEmitter.addListener(HS2SModule.Event_Notify,  (event) => {
    if (event.action === "action_anonymous_data_num") {
       console.log(event["anonymous_data_count"]);
    }
}
```

### get anonymous offline data

```js
HS2SModule.getAnonymousMemoryData(mac);

notifyListener = DeviceEventEmitter.addListener(HS2SModule.Event_Notify,  (event) => {
    if (event.action === "action_anonymous_data") {
        let arr = event["history_data"];
        arr.forEach(function(result) {
            console.log(result["instruction_type"];
            console.log(result["body_building"];
            console.log(result["height"];
            console.log(result["gender"];
            console.log(result["measure_time"];
            console.log(result["age"];
            console.log(result["impedance"];
            console.log(result["weight"];
       })
    }
}
```

### delete anonymous offline data

```js
HS2SModule.deleteAnonymousMemoryData(mac);

notifyListener = DeviceEventEmitter.addListener(HS2SModule.Event_Notify,  (event) => {
    if (event.action === "action_delete_anonymous_data") {
       console.log(event["result"]);
    }
}
```

### start a online measurement

The API is asyn function. It will return message until finish measurement.

```js
HS2SModule.measure(mac);

notifyListener = DeviceEventEmitter.addListener(HS2SModule.Event_Notify,  (event) => {
    if (event.action === "action_specify_users") {
        console.log(event["result"]);
        // 1: success, 0: failure

    } else if (event.action === "action_online_real_time_weight") {
        console.log(event["weight"]);

    } else if (event.action === "action_online_result") {
        console.log(event["weight"]);

    } else if (event.action === "action_body_fat_result") {
        let bodyFat = event["data_body_fat_result"];
        let fat_weight = bodyFat["fat_weight"];
        let fat_control = bodyFat["fat_control"];
        let weight_control = bodyFat["weight_control"];
        let standard_weight = bodyFat["standard_weight"];
        let skeletal_muscle_mass = bodyFat["skeletal_muscle_mass"];
        let body_water_rate = bodyFat["body_water_rate"];
        let muscle_mas = bodyFat["muscle_mas"];
        let instruction_type = bodyFat["instruction_type"];
        let body_building = bodyFat["body_building"];
        let height = bodyFat["height"];
        let gender = bodyFat["gender"];
        let muscle_control = bodyFat["muscle_control"];
        let physical_age = bodyFat["physical_age"];
        let visceral_fat_grade = bodyFat["visceral_fat_grade"];
        let protein_rate = bodyFat["protein_rate"];
        let bone_salt_content = bodyFat["bone_salt_content"];
        let visceral_fat_grade = bodyFat["visceral_fat_grade"];
        let measure_time = bodyFat["measure_time"];
        let age = bodyFat["age"];
        let impedance = bodyFat["impedance"];
        let weight = bodyFat["weight"];

    } else if (event.action === "action_measure_finish_at_critical") { }
});
```

### start heart rate measurement mode

```js
HS2SModule.resetDevice(mac);

notifyListener = DeviceEventEmitter.addListener(HS2SModule.Event_Notify,  (event) => {
    if (event.action === HS2SProfileModule.ACTION_HS2S_MEASURE_HEARTRATE) {
       
    }
}
```

### stop heart rate measurement mode

```js
HS2SModule.resetDevice(mac);

notifyListener = DeviceEventEmitter.addListener(HS2SModule.Event_Notify,  (event) => {
    if (event.action === HS2SProfileModule.ACTION_HS2S_EXIT_MEASURE_HEARTRATE_STATUS) {
        // {"status":0,"heartrate":78}
       console.log(event.message);
    }
}
```

### reset device

```js
HS2SModule.resetDevice(mac);

notifyListener = DeviceEventEmitter.addListener(HS2SModule.Event_Notify,  (event) => {
    if (event.action === "action_restore_factory_settings") {
       console.log(event["result"]);
    }
}
```

### disconnect device

```js
HS2SModule.disConnect(mac);
```

### get all connected devices

```js
HS2SModule.getAllConnectedDevices();
```
