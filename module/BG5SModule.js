/**
 * @author chenxuewei
 */
'use strict';


var { NativeModules, Platform } = require('react-native');

var RCTModule = NativeModules.BG5SModule;

/**
 * @module BG5SModule
 */
module.exports = {

    Event_Notify: RCTModule.Event_Notify,

    /**
     * Get status information of BG5 device.
     * @param {string} mac Device's mac address
     */
    getStatusInfo: function (mac){

        if (RCTModule != null) {
            RCTModule.getStatusInfo(mac);
        } else {
            console.log('~~~~~ BG5S getStatusInfo RCTModule is null')
        }
    },

    /**
     * Set time to BG5 device.
     * @param {string} mac Device's mac address
     */
    setTime: function (mac, date, timezone){
        if (RCTModule != null) {
            RCTModule.setTime(mac, date, timezone);
        } else {
            console.log('~~~~~ BG5S setTime RCTModule is null')
        }
    },

    /**
     * Set unit to BG5 device.
     * @param {string} mac Device's mac address
     * @param {number} type 1:mmol/L 2:mg/dL
     */
    setUnit: function (mac, type){
        if (RCTModule != null) {
            RCTModule.setUnit(mac, type);
        } else {
            console.log('~~~~~ BG5S setUnit RCTModule is null')
        }
    },

    /**
     * Delete the offline data in BG5 device.
     * @param {string} mac Device's mac address
     */
    deleteUsedStrip: function (mac){
        if (RCTModule != null) {
            RCTModule.deleteUsedStrip(mac);
        } else {
            console.log('~~~~~ BG5S deleteUsedStrip RCTModule is null')
        }
    },

     /**
     * Delete the offline data in BG5 device.
     * @param {string} mac Device's mac address
     */
    deleteOfflineData: function (mac){
        if (RCTModule != null) {
            RCTModule.deleteOfflineData(mac);
        } else {
            console.log('~~~~~ BG5S deleteOfflineData RCTModule is null')
        }
    },

    /**
     * Delete the offline data in BG5 device.
     * @param {string} mac Device's mac address
     */
    getOfflineData: function (mac){
        if (RCTModule != null) {
            RCTModule.getOfflineData(mac);
        } else {
            console.log('~~~~~ BG5S getOfflineData RCTModule is null')
        }
    },

    /**
     * Start measure with specific measure type.
     * @param {string} mac Device's mac address
     * @param {number} type Measure type, 1.Measure with blood measure, 2.Measure with control liquid
     */
    startMeasure: function (mac, type){
        if (RCTModule != null) {
            RCTModule.startMeasure(mac, type);
        } else {
            console.log('~~~~~ BG5S startMeasure RCTModule is null')
        }
    },

    /**
     * Get offline data of BG5 device.
     * @param {string} mac Device's mac address
     */
    adjustOfflineData: function (mac, timeString, originData){
        if (RCTModule != null) {
            RCTModule.adjustOfflineData(mac, timeString, originData);
        } else {
            console.log('~~~~~ BG5S adjustOfflineData RCTModule is null')
        }
    },

    setOfflineModel: function (mac, enable) {
        if (RCTModule != null) {
            RCTModule.getAllConnectedDevices(mac, enable);
        } else {
            console.log('~~~~~ BG5S adjustOfflineData RCTModule is null')
        }
    },

    disConnect: function (mac){
        if (RCTModule != null) {
            if (Platform.OS === 'ios'){
                RCTModule.disConnect(mac);
            } else {
                RCTModule.disconnect(mac);
            }
        } else {
            console.log('~~~~~ BG5S disConnect RCTModule is null')
        }
    },

    /**
     * Get all connected BG5S device
     *
     * e.g. {"devices":["A4D5783FB00C","A4D5783FFE58"]}
     */
    getAllConnectedDevices: function () {
        RCTModule.getAllConnectedDevices()
    },
}
