'use strict';

var {NativeModules} = require('react-native');

var RCTModule = NativeModules.PO1Module

/**
 * @module PO1Module
 */
module.exports = {

  Event_Notify: RCTModule.Event_Notify,

  /**
   * Get the PO1 battery status.
   * @param {string} mac Device's mac address
   */
  getBattery: function (mac) {
      RCTModule.getBattery(mac)
  },

  /**
   * Disconnect the PO1
   * @param mac The mac address
   */
  disconnect: function (mac) {
      RCTModule.disconnect(mac)
  },

  /**
   * Get all connected PO1 device
   *
   * e.g. {"devices":["A4D5783FB00C","A4D5783FFE58"]}
   */
  getAllConnectedDevices: function () {
      RCTModule.getAllConnectedDevices()
  }
}
