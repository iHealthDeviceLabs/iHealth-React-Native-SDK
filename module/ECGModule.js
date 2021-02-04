/**
 *
 */
'use strict';


var {NativeModules} = require('react-native');

var RCTModule = NativeModules.ECGModule;

/**
 * @module ECGModule
 */
module.exports = {

  Event_Notify: RCTModule.Event_Notify,

  /**
   * SyncTime.
   */
  sysTime: function (mac) {
    RCTModule.sysTime(mac)
  },

  /**
   * startMeasure
   */
  startMeasure: function (mac) {
    RCTModule.startMeasure(mac)
  },
  /**
   * getBattery
   * @param {string} serialNumber the mac address of scale
   */
  getBattery: function (mac) {
    RCTModule.getBattery(mac)
  },
  /**
   * stopMeasure
   */
  stopMeasure: function (mac) {
    RCTModule.stopMeasure(mac)
  },
  /**
   * Get all connected ECG device
   *
   * e.g. {"devices":["A4D5783FB00C","A4D5783FFE58"]}
   */

  getAllConnectedDevices: function () {
    RCTModule.getAllConnectedDevices()
  },
  /**
   * Disconnect the ECG3
   * @param mac The mac address
   */
  disconnect: function (mac) {
    RCTModule.disconnect(mac)
  }
}
