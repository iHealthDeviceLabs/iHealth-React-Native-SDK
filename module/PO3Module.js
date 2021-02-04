/**
 * Created by lixuesong on 11/11/2016.
 */
'use strict';


var {NativeModules} = require('react-native');

var RCTModule = NativeModules.PO3Module

/**
 * @module PO3Module
 */
module.exports = {

  Event_Notify: RCTModule.Event_Notify,

  /**
   * Get the PO3 battery status.
   * @param {string} mac Device's mac address
   */
  getBattery: function (mac) {
      RCTModule.getBattery(mac)
  },

  /**
   * Start real-time measurement.
   * @param {string} mac Device's mac address
   */
  startMeasure: function (mac) {
      RCTModule.startMeasure(mac)
  },

  /**
   * Get the value of historical data in the PO3.
   * @param {string} mac Device's mac address
   */
  getHistoryData: function (mac) {
      RCTModule.getHistoryData(mac)
  },

  /**
   * Disconnect the PO3
   * @param mac The mac address
   */
  disconnect: function (mac) {
      RCTModule.disconnect(mac)
  },

  /**
   * Get all connected PO3 device
   *
   * e.g. {"devices":["A4D5783FB00C","A4D5783FFE58"]}
   */
  getAllConnectedDevices: function () {
      RCTModule.getAllConnectedDevices()
  }
}
