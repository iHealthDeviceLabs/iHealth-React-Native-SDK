/**
 * Created by zhangxu on 16/11/14.
 */
'use strict';


var {NativeModules} = require('react-native');

var RCTModule = NativeModules.BP3LModule;

/**
 * @module BP3LModule
 */
module.exports = {

  Event_Notify: RCTModule.Event_Notify,

  /**
   * Start measure blood pressure monitor
   * @param {string} mac Device's mac address
   */
  startMeasure: function (mac) {
    if (RCTModule != null) {
      RCTModule.startMeasure(mac);
    } else {
      console.log('~~~~~ RCTModule is null')
    }
  },


  /**
   * Cancel the measuring process immediately if device is in measuring state.
   * @param {string} mac Device's mac address
   */
  stopMeasure: function (mac) {
    if (RCTModule != null) {
      RCTModule.stopMeasure(mac);
    } else {
      console.log('~~~~~ RCTModule is null')
    }
  },

  /**
   * Get the BP3L device's battery.
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
   * Disconnect the BP3L
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
   * Get all connected AM3S device
   *
   * e.g. {"devices":["A4D5783FB00C","A4D5783FFE58"]}
   */
  getAllConnectedDevices: function () {
    RCTModule.getAllConnectedDevices()
  }
}
