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

### get device information

```js
ECGUSBModule.getIdps()
```

### get all connected devices

```js
ECGUSBModule.getAllConnectedDevices();
```

### get data stored in the ecg3 device

```js
ECGUSBModule.syncData();
```

### delete data stored in the ecg3 device

```js
ECGUSBModule.deleteData();
```

### splice data

```js
ECGUSBModule.spliceData(["ECGSDK_20160420025256",
                         "ECGSDK_20160420025453",
                         "ECGSDK_20160420030824",
                         "ECGSDK_20160420082435"]);
```

### get cache

```js
ECGUSBModule.getCache();
```

### delete cache data

```js
ECGUSBModule.deleteCacheData();
```

### get filter data

```js
ECGUSBModule.getFilterDataByFileName("ECG_Total_Data_20160420025256.dat","ECG_Total_Mark_20160420025256.txt");
```

