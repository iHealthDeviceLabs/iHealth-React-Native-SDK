'use strict';

var {NativeModules} = require('react-native');

var RCTModule = NativeModules.BG1SModule

 /**
  * @module BG1SModule
  */
module.exports = {

  Event_Notify: RCTModule.Event_Notify,

  /**
   * listen getFunction
   * @param {string} mac Device's mac address
   */
  getFunction: function (mac) {
    RCTModule.getFunction(mac)
  },


  /**
   * listen measurement
   * @param {string} mac Device's mac address
   */
  measure: function (mac, measureMode) {
    RCTModule.measure(mac, measureMode)
  },

  /**
   * Disconnect the BG1S
   * @param mac The mac address for BG1S
   */
  disconnect: function (mac) {
    RCTModule.disconnect(mac)
  },

  /**
   * Get all connected BG1S device
   *
   * e.g. {"devices":["A4D5783FB00C","A4D5783FFE58"]}
   */
  getAllConnectedDevices: function () {
    RCTModule.getAllConnectedDevices()
  }
}

