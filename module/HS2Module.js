/**
 * Created by lixuesong on 11/11/2016.
 */
'use strict';


var {NativeModules} = require('react-native');

var RCTModule = NativeModules.HS2Module

/**
 * @module hs2Module
 */
module.exports = {
  /**
   * Notify event type for hs2
   */
  Event_Notify: RCTModule.Event_Notify,

  /**
   * Start real-time measurement.
   * @param {string} mac Device's mac address
   * @param {string} unit Device's unit
   * @param {string} userId user id
   */
  measureOnline: function (mac, unit, userId) {
    RCTModule.measureOnline(mac, unit, userId)
  },

  /**
   * Get the value of historical data in the hs2.
   * @param {string} mac Device's mac address
   */
  getOfflineData: function (mac) {
    RCTModule.getOfflineData(mac)
  },

  /**
   * Disconnect the HS2
   * @param mac The mac address for blood pressure monitor
   */
  disconnect: function (mac) {
    RCTModule.disconnect(mac)
  },

  /**
   * Get all connected hs2 device
   *
   * e.g. {"devices":["A4D5783FB00C","A4D5783FFE58"]}
   */
  getAllConnectedDevices: function () {
    RCTModule.getAllConnectedDevices()
  },

  /**
   * Get all connected hs2 device
   *
   * e.g. {"devices":["A4D5783FB00C","A4D5783FFE58"]}
   */
  getBattery: function (mac) {
    RCTModule.getBattery(mac)
  }
}
