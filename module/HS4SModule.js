/**
 * Created by lixuesong on 11/11/2016.
 */
'use strict';

var {NativeModules} = require('react-native');

var RCTModule = NativeModules.HS4SModule

/**
 * @module HS4SModule
 */
module.exports = {
  /**
   * Notify event type for HS4S
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
   * Get the value of historical data in the HS4S.
   * @param {string} mac Device's mac address
   */
  getOfflineData: function (mac) {
    RCTModule.getOfflineData(mac)
  },

  /**
   * Disconnect the HS4S
   * @param mac The mac address for blood pressure monitor
   */
  disconnect: function (mac) {
    RCTModule.disconnect(mac)
  },

  /**
   * Get all connected HS4S device
   *
   * e.g. {"devices":["A4D5783FB00C","A4D5783FFE58"]}
   */
  getAllConnectedDevices: function () {
    RCTModule.getAllConnectedDevices()
  },
}
