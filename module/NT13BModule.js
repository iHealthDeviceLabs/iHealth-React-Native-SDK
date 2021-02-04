'use strict';

var {NativeModules} = require('react-native');

var RCTModule = NativeModules.NT13BModule

 /**
  * @module NT13BModule
  */
module.exports = {

  Event_Notify: RCTModule.Event_Notify,

  /**
   * listen measurement
   * @param {string} mac Device's mac address
   */
  measure: function (mac) {
    RCTModule.measure(mac)
  },

  /**
   * Disconnect the nt13b
   * @param mac The mac address for BTM
   */
  disconnect: function (mac) {
    RCTModule.disconnect(mac)
  },

  /**
   * Get all connected BTM device
   *
   * e.g. {"devices":["A4D5783FB00C","A4D5783FFE58"]}
   */
  getAllConnectedDevices: function () {
    RCTModule.getAllConnectedDevices()
  }
}

