'use strict';


var {NativeModules} = require('react-native');

var RCTModule = NativeModules.BP5Module

/**
 * @module BP5Module
 */
module.exports = {

  Event_Notify: RCTModule.Event_Notify,

  /**
   * Start measure blood pressure monitor
   * @param {string} mac Device's mac address
   */

  startMeasure: function (mac) {
    RCTModule.startMeasure(mac)
  },

  /**
   * Cancel the measuring process immediately if device is in measuring state.
   * @param {string} mac Device's mac address
   */
  stopMeasure: function (mac) {
    RCTModule.stopMeasure(mac)
  },

  /**
   * Get the BP5 device's battery.
   * @param {string} mac Device's mac address
   */
  getBattery: function (mac) {
    if (RCTModule != null) {
      RCTModule.getBattery(mac);
    } else {
      console.log('~~~~~ RCTModule is null')
    }
  },

  /**
   * Enable device can measure offline .
   * @param {string} mac Device's mac address
   */
  enbleOffline: function (mac) {
    if (RCTModule != null) {
        RCTModule.enbleOffline(mac);
    } else {
        console.log('~~~~~ RCTModule is null')
    }
  },

  /**
   * Enable device can't measure offline .
   * @param {string} mac Device's mac address
   */
  disableOffline: function (mac) {
    if (RCTModule != null) {
      RCTModule.disableOffline(mac);
    } else {
      console.log('~~~~~ RCTModule is null')
    }
  },

  /**
   * Enable device can't measure offline.
   * @param {string} mac Device's mac address
   */
  isEnableOffline: function (mac) {
    if (RCTModule != null) {
      RCTModule.isEnableOffline(mac);
    } else {
      console.log('~~~~~ RCTModule is null')
    }
  },

  /**
   * get offline data number. (iOS not support)
   * @param {string} mac Device's mac address
   */
  getOfflineNum: function (mac) {
    if (RCTModule != null) {
      RCTModule.getOfflineNum(mac);
    } else {
      console.log('~~~~~ RCTModule is null')
    }
  },

  /**
   * get offline data.
   * @param {string} mac Device's mac address
   */
  getOfflineData: function (mac) {
    if (RCTModule != null) {
      RCTModule.getOfflineData(mac);
    } else {
      console.log('~~~~~ RCTModule is null')
    }
  },

  /**
   * Disconnect the BP5 (iOS not support)
   *
   * @param {string} mac Device's mac address
   */
  disconnect: function (mac) {
    if (RCTModule != null) {
      RCTModule.disconnect(mac);
    } else {
      console.log('~~~~~ RCTModule is null')
    }
  },

  /**
   * Get all connected BP5 device
   *
   * e.g. {"devices":["A4D5783FB00C","A4D5783FFE58"]}
   */
  getAllConnectedDevices: function () {
    RCTModule.getAllConnectedDevices()
  }
}
