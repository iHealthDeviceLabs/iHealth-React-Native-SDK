'use strict';


var {NativeModules,Platform} = require('react-native');

var RCTModule = NativeModules.iHealthDeviceManagerModule

/**
 * @module iHealthDeviceManagerModule
 */
module.exports = {
    //Device Type
    AM3S: RCTModule.AM3S,
    /**
     * Device type number for AM4(4) 1 << 2
     */
    AM4: RCTModule.AM4,
    /**
     * Device type number for PO3(8) 1 << 3
     */
    PO3: RCTModule.PO3,
    /**
     * Device type number for BP5(33554432) 1 << 25
     */
    BP5: RCTModule.BP5,
    BP5S: RCTModule.BP5S,
    /**
     * Device type number for BP3L(32) 1 << 5
     */
    BP3L: RCTModule.BP3L,
    /**
     * Device type number for BP7S(16777216) 1 << 24
     */
    BP7: RCTModule.BP7,
    BP7S: RCTModule.BP7S,
    /**
     * Device type number for Bp550BT(128) 1 << 7
     */
    KN550: RCTModule.KN550,
    /**
     * Device type number for HS2(131072) 1 << 17
     */
    HS2: RCTModule.HS2,
    /**
     * Device type number for HS4S(268435456) 1 << 28
     */
    HS4S: RCTModule.HS4S,
    HS6: 10086,
    /**
     * Device type number for BG1(110)
     */
    BG1: RCTModule.BG1,
    /**
     * Device type number for BG5(4294967296) 1 << 32
     */
    BG5: RCTModule.BG5,

    BG5S: RCTModule.BG5S,

    ECG3: RCTModule.ECG3,

    ECG3USB: RCTModule.ECG3USB,

    BTM: RCTModule.BTM,

    TS28B: RCTModule.TS28B,

    NT13B: RCTModule.NT13B,

    HS2S: RCTModule.HS2S,

    BG1S: RCTModule.BG1S,

    /**
     * Notify event type for scan device result.("event_scan_device")
     */
    Event_Scan_Device: RCTModule.Event_Scan_Device,
    /**
     * Notify event type for scan action finish.("event_scan_finish")
     */
    Event_Scan_Finish: RCTModule.Event_Scan_Finish,
    /**
     * Notify event type for connect device successfully.("event_device_connected")
     */
    Event_Device_Connected: RCTModule.Event_Device_Connected,
    /**
     * Notify event type for connect device failed.("event_device_connect_failed")
     */
    Event_Device_Connect_Failed: RCTModule.Event_Device_Connect_Failed,
    /**
     * Notify event type for device disconnect.("event_device_disconnect")
     */
    Event_Device_Disconnect: RCTModule.Event_Device_Disconnect,
    /**
     * Notify event type for authenticate result.("event_authenticate_result")
     */
    Event_Authenticate_Result: RCTModule.Event_Authenticate_Result,


    /**
     * Authentication the configure information.
     * Attentation: Please register to receive event(iHealthDeviceManagerModel.Event_Authenticate_Result) before call the api.
     * @param {string} userName User's user name you use when you sign up
     * @param {string} clientID User's client id.
     * @param {string} clientSecret User's client secret.
     * @return {callback} Callback with a json object. Eg.{"authen":2}
     * <p/><li/>The measurement via SDK will be operated in the case of 1-3, and there is 10-day tryout if SDK Verification failed in case of SDK cannot connect Internet or Userid/clientID/clientSecret verification failed or SDK has not been authorized or User has not been authorized.
     * SDK is fully functional during tryout period, but will be terminated without verification through Internet after 10 days.The interface needs to be re-called after analyzing the return parameters. SDK application requires Internet connection.
     * If you encounter user status 4 with full internet access, please send Userid/clientID/clientSecret to this email sdk@ihealthlabs.com.cn to get help.
     * <p/>
     * The result value and description will be as below:
     * <table style="width:200px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
     * <tbody>
     * <tr><td>Value</td><td>Description</td></tr>
     * <tr><td>1</td><td>New-user registration succeeded.</td></tr>
     * <tr><td>2</td><td>User login succeeded.</td></tr>
     * <tr><td>3</td><td>The user is iHealth user as well, measurement via SDK has been activated, and the data from the measurement belongs to the user.</td></tr>
     * <tr><td>4</td><td>Testing without Internet connection succeeded.</td></tr>
     * <tr><td>5</td><td>Userid/clientID/clientSecret verification failed.</td></tr>
     * <tr><td>6</td><td>SDK has not been authorized.</td></tr>
     * <tr><td>7</td><td>User has not been authorized.</td></tr>
     * <tr><td>8</td><td>Internet error, verification failed.</td></tr>
     * </tbody>
     * </table>
     */
    authenConfigureInfo: function (userName, clientID, clientSecret) {
        RCTModule.authenConfigureInfo(userName, clientID, clientSecret)
    },
    /**
     * Authencation the appSecret
     * @param {string} appSecret
     * @return {callback} Callback with a boolen object. true:authencation success   false:authencation failed .<br/>
     */

    authenAppSecret: function (appSecret, callback) {
        RCTModule.authenAppSecret(appSecret, callback)
    },

    /**
     * Start discovery iHealth device with type
     * Attentation: Please register to receive event(iHealthDeviceManagerModel.Event_Scan_Device) before call the api.
     *
     * @param {number} type The type to be discovered.<br/>
     * e.g. startDiscovery(iHealthDeviceManagerModule.AM4) will discover AM4 devices.<br/>
     */
    startDiscovery: function (type) {
        RCTModule.startDiscovery(type)
    },


    /**
     * Stop discovery iHealth device
     * Attentation: Please register to receive event(iHealthDeviceManagerModel.Event_Scan_Finish) before call the api.
     */
    stopDiscovery: function () {
        RCTModule.stopDiscovery()
    },

    /**
     * Connect iHealth device
     * Attentation: Please register to receive event(iHealthDeviceManagerModel.Event_Device_Connected or iHealthDeviceManagerModel.Event_Device_Connect_Failed) before call the api.
     * @param {string} mac The mac address of device to be connected.<br/>
     * e.g. "004D3208D5D4"
     * @param {string} type Device type string.
     * @return {callback}  Callback with events {@link module:iHealthDeviceManagerModule.Event_Device_Connected Event_Device_Connected}
     * or {@link module:iHealthDeviceManagerModule.Event_Device_Connect_Failed Event_Device_Connect_Failed}.
     * And the mesage is format as {"errorid":0,"type":"BP5","mac":"8CDE52B62521"}
     * <p/>The key and value in the message will be as below:
     * <table style="width:200px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
     * <tbody>
     * <tr><td>Key</td><td>value</td></tr>
     * <tr><td>errorid</td><td>This value is to reflect the state of the system when the connection fails. Normally, it's 0.
     Please note, this field is different from the ErrorId of the DeviceProfileModule.</td></tr>
     * <tr><td>type</td><td>The device type. Eg.BP5</td></tr>
     * <tr><td>mac</td><td>The mac address.</td></tr>
     * </tbody>
     * </table>
     */
    connectDevice: function (mac, type) {
        RCTModule.connectDevice(mac, type)
    },

    /**
     * Connect BTM device
     * Attentation: Please register to receive event(iHealthDeviceManagerModel.Event_Device_Connected or iHealthDeviceManagerModel.Event_Device_Connect_Failed) before call the api.
     * @param {string} mac The mac address of device to be connected.<br/>
     * e.g. "004D3208D5D4"
     * @param {string} type Device type string.
     * @return {callback}  Callback with events {@link module:iHealthDeviceManagerModule.Event_Device_Connected Event_Device_Connected}
     * or {@link module:iHealthDeviceManagerModule.Event_Device_Connect_Failed Event_Device_Connect_Failed}.
     * And the mesage is format as {"errorid":0,"type":"BP5","mac":"8CDE52B62521"}
     * <p/>The key and value in the message will be as below:
     * <table style="width:200px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
     * <tbody>
     * <tr><td>Key</td><td>value</td></tr>
     * <tr><td>errorid</td><td>This value is to reflect the state of the system when the connection fails. Normally, it's 0.
     Please note, this field is different from the ErrorId of the DeviceProfileModule.</td></tr>
     * <tr><td>username</td><td>the identification of the user, could be the form of email address or mobile phone</td></tr>
     * <tr><td>mac</td><td>a valid FDIR-V3 mac.</td></tr>
     * <tr><td>type</td><td>TYPE_FDIR_V3</td></tr>
     * <tr><td>unit</td><td>Temperature unit.1: c 2: f</td></tr>
     * <tr><td>measureTarget</td><td>Measuring target.1: body 2: object</td></tr>
     * <tr><td>functionTarget</td><td>Offline target.1: offline 2: online</td></tr>
     * <tr><td>hour</td><td>Standby time hours. eg. 24</td></tr>
     * <tr><td>minute</td><td>Standby time minutes. eg.60</td></tr>
     * <tr><td>second</td><td>Standby time seconds. eg.60</td></tr>
     * </tbody>
     * </table>
     */
    connectTherm: function (username, mac, type, unit, measureTarget, functionTarget, hour, minute, second) {
        RCTModule.connectTherm(username, mac, type, unit, measureTarget, functionTarget, hour, minute, second)
    },


    /**
     * Get information for iHealth device
     *
     * @param {string} mac The mac address of device.<br/>
     * e.g. "004D3208D5D4"
     * @return {callback} Callback with a map object.<br/>
     * e.g. {"protocolstring":"com.jiuan.AMV12","accessoryname":"AM4","firmwareversion":"138","hardwareversion":"100","manufacture":"iHealth","serialnumber":"004D32079148","modenumber":"AM4 11070"}
     */
    getDevicesIDPS: function (mac, callback) {
        RCTModule.getDevicesIDPS(mac, callback)
    },

    /**
     * [Only for android] Disconnect an iHealth device that has been connected or in connecting status.
     * Attentation: Please register to receive event(iHealthDeviceManagerModel.Event_Device_Disconnect or iHealthDeviceManagerModel.Event_Device_Connect_Failed) before call the api.
     * @param {string} mac The mac address of device to be connected or in connecting.<br/>
     * e.g. "004D3208D5D4"
     * @param {string} type Device type string.
     * @return {callback}  Callback with events {@link module:iHealthDeviceManagerModule.Event_Device_Disconnect Event_Device_Disconnect}
     * or {@link module:iHealthDeviceManagerModule.Event_Device_Connect_Failed Event_Device_Connect_Failed}.
     * And the mesage is format as {"errorid":0,"type":"BP5","mac":"8CDE52B62521"}
     * <p/>The key and value in the message will be as below:
     * <table style="width:200px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
     * <tbody>
     * <tr><td>Key</td><td>value</td></tr>
     * <tr><td>errorid</td><td>This value is to reflect the state of the system when the connection fails. Normally, it's 0.
     Please note, this field is different from the ErrorId of the DeviceProfileModule.</td></tr>
     * <tr><td>type</td><td>The device type. Eg.BP5</td></tr>
     * <tr><td>mac</td><td>The mac address.</td></tr>
     * </tbody>
     * </table>
     */
    disconnectDevice: function (mac, type) {
        RCTModule.disconnectDevice(mac, type)
    },

    /**
     * If you want to use the iHealth Device, you must first call authentication method before connect a device.
     * To get a license, please refer to [iHealth Developer](https://dev.ihealthlabs.com).
     * @param license The license file name is like 'com_example_android.pem'. Download the license file from the website, integrate to your native project.
     * For android: should save the license file to the /assets/ folder.
     * @return {callback} Callback with a map object.<br/>
     * e.g. {"access": true}
     */
    sdkAuthWithLicense: function (license) {
        RCTModule.sdkAuthWithLicense(license)
    },

     /**
       * get the phone is support OTG or not
       * @return true or false
       */

     isSupportOTG: function (callback){
         	if (Platform.OS === 'ios'){
         		callback(true);
         	} else {
         		RCTModule.isSupportOTG(callback);
         	}

     },

}
