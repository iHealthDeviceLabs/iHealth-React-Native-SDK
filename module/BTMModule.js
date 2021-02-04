/**
 * Created by lixuesong on 11/11/2016.
 */
'use strict';

var {NativeModules} = require('react-native');

var RCTModule = NativeModules.BTMModule

 /**
  * @module BTMModule
  */
module.exports = {

  Event_Notify: RCTModule.Event_Notify,

  /**
   * Get the BTM battery status.
   * @param {string} mac Device's mac address
   */
  getBattery: function (mac) {
    RCTModule.getBattery(mac)
  },

  /**
   * Get the value of historical data in the BTM.
   * @param {string} mac Device's mac address
   */
  getMemoryData: function (mac) {
    RCTModule.getMemoryData(mac)
  },

  /**
   * Set the standby time
   * @param {string} mac Device's mac address
   * @param {number} hour Standby time hours [0, 23]
   * @param {number} minute Standby time minute [0, 59]
   * @param {number} second Standby time second [0, 59]
   */
  setStandbyTime: function (mac, hour, minute, second) {
    RCTModule.setStandbyTime(mac, hour, minute, second)
  },

  /**
   * Set the temperature unit
   * @param {string} mac Device's mac address
   * @param {number} unit temperature unit<br/>
   *                 <b>The unit of:</b> BtmControl.TEMPERATURE_UNIT_C or BtmControl.TEMPERATURE_UNIT_F
   */
  setTemperatureUnit: function (mac, unit) {
    RCTModule.setTemperatureUnit(mac, unit)
  },

  /**
   * Set the measuring target
   * @param {string} mac Device's mac address
   * @param {number} measuring target
   */
  setMeasuringTarget: function (mac, target) {
    RCTModule.setMeasuringTarget(mac, target)
  },

  /**
   * Set the offline target
   * @param {string} mac Device's mac address
   * @param {number} measuring target
   */
  setOfflineTarget: function (mac, target) {
    RCTModule.setOfflineTarget(mac, target)
  },

  /**
   * Disconnect the BTM
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
