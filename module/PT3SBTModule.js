'use strict';

var {NativeModules} = require('react-native');

var RCTModule = NativeModules.PT3SBTModule

 /**
  * @module PT3SBTModule
  */
module.exports = {

  Event_Notify: RCTModule.Event_Notify,

  /**
   * set time
   * @param {string} mac Device's mac address
   */
  setTime: function (mac) {
    RCTModule.setTime(mac)
  },

  /**
   * get battery
   * @param {string} mac Device's mac address
   */
  getBattery: function (mac) {
    RCTModule.getBattery(mac)
  },

  /**
   * set unit
   * @param {string} mac Device's mac address
   */
  setUnit: function (mac, unit) {
    RCTModule.setUnit(mac, unit)
  },

  /**
   * get unit
   * @param {string} mac Device's mac address
   */
  getUnit: function (mac) {
    RCTModule.getUnit(mac)
  },

  /**
   * get history data count
   * @param {string} mac Device's mac address
   */
  getHistoryCount: function (mac) {
    RCTModule.getHistoryCount(mac)
  },

  /**
   * get history data
   * @param {string} mac Device's mac address
   */
  getHistoryData: function (mac) {
    RCTModule.getHistoryData(mac)
  },

  /**
   * delete history data
   * @param {string} mac Device's mac address
   */
  deleteHistory: function (mac) {
    RCTModule.deleteHistory(mac)
  },

  /**
   * Disconnect the pt3sbt
   * @param mac The mac address for PT3SBT
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

