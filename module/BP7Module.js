'use strict';


var { NativeModules } = require('react-native');

var RCTModule = NativeModules.BP7Module;

/**
 * @module BP7Module
 */

module.exports = {

  Event_Notify: RCTModule.Event_Notify,

  /**
   * Get the BP7 device's battery.
   * @param {string} mac Device's mac address
   */
  getBattery: function (mac) {
    if (RCTModule != null) {
      RCTModule.getBattery(mac);
    }else {
      console.log('~~~~~ RCTModule is null')
    }
  },

  /**
   * Start bp7 measurement.
   * @param {string} mac Device's mac address
   * @param {int} unit 0:mmHg,1:kPa
   */
  startMeasure: function(mac){
    if (RCTModule != null) {
      RCTModule.startMeasure(mac);
    }else {
      console.log('~~~~~ RCTModule is null')
    }
  },

  /**
   * Stop bp7 measurement.
   * @param {string} mac Device's mac address
   */
  stopMeasure: function (mac) {
    if (RCTModule != null) {
      RCTModule.stopMeasure(mac);
    }else {
      console.log('~~~~~ RCTModule is null')
    }
  },

  /**
   * Enable offline measurement mode.
   * @param {string} mac Device's mac address
   */
  enableOfflineMeasurement: function (mac) {
    if (RCTModule != null) {
      RCTModule.enableOfflineMeasurement(mac);
    }else {
      console.log('~~~~~ RCTModule is null')
    }
  },

  /**
   * Disable offline measurement mode.
   * @param {string} mac Device's mac address
   */
  disableOfflineMeasurement: function (mac) {
    if (RCTModule != null) {
      RCTModule.disableOfflineMeasurement(mac);
    }else {
      console.log('~~~~~ RCTModule is null')
    }
  },

  /**
   * get the count of offline data.
   * @param {string} mac Device's mac address
   */
  getOfflineNum: function (mac) {
    if (RCTModule != null) {
      RCTModule.getOfflineNum(mac);
    }else {
      console.log('~~~~~ RCTModule is null')
    }
  },

  /**
   * Get offline data number.
   * @param {string} mac Device's mac address
   */
  getOfflineData: function (mac) {
    if (RCTModule != null) {
      RCTModule.getOfflineData(mac);
    }else {
      console.log('~~~~~ RCTModule is null')
    }
  },

  /**
   * Check offline measurement mode.
   * @param {string} mac Device's mac address
   * @param {int} unit 0:mmHg,1:kPa
   */
  isEnableOffline: function(mac, unit){
    if (RCTModule != null) {
      RCTModule.isEnableOffline(mac, unit);
    }else {
      console.log('~~~~~ RCTModule is null')
    }
  },

  /**
   * Set BP7 device unit.
   * @param {string} mac Device's mac address
   * @param {int} unit 0:mmHg,1:kPa
   */
  conformAngle: function(mac){
    if (RCTModule != null) {
      RCTModule.conformAngle(mac);
    }else {
      console.log('~~~~~ RCTModule is null')
    }
  },

  /**
   * Disconnect the BP7
   *
   * @param {string} mac Device's mac address
   */

  disconnect: function (mac) {
      if (RCTModule != null) {
          RCTModule.disconnect(mac);
      }else {
          console.log('~~~~~ RCTModule is null')
      }
  },

  /**
   * Get all connected BP7 device
   *
   * e.g. {"devices":["A4D5783FB00C","A4D5783FFE58"]}
   */
  getAllConnectedDevices: function () {
      RCTModule.getAllConnectedDevices()
  }
};
