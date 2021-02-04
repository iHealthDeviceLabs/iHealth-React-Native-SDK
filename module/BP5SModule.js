/**
 * Created by chenxuewei on 04/05/2019.
 */

'use strict';


var { NativeModules, Platform } = require('react-native');

var RCTModule = NativeModules.BP5SModule;

/**
 * @module BP5SModule
 */

module.exports = {

  Event_Notify: RCTModule.Event_Notify,

  startMeasure: (mac) => {
    if (RCTModule != null) {
      RCTModule.startMeasure(mac);
    }else {
      console.log('~~~~~ RCTModule is null')
    }
  },

  stopMeasure: (mac) => {
    if (RCTModule != null) {
      RCTModule.stopMeasure(mac);
    }else {
      console.log('~~~~~ RCTModule is null')
    }

  },

  deleteData: (mac) => {
    if (RCTModule != null) {
      RCTModule.deleteData(mac);
    }else {
      console.log('~~~~~ RCTModule is null')
    }
  },

  enbleOffline: (mac, mode) => {
    if (RCTModule != null) {
        RCTModule.enbleOffline(mac, mode);
    }else {
      console.log('~~~~~ RCTModule is null')
    }
  },


  /**
   * Get the BP7S device's battery.
   * @param {string} mac Device's mac address
   */
  getBattery: (mac) => {
    if (RCTModule != null) {
      RCTModule.getBattery(mac);
    }else {
      console.log('~~~~~ RCTModule is null')
    }
  },

  /**
   * get offline data number.
   * @param {string} mac Device's mac address
   */
  getOffLineNum: (mac) => {
    if (RCTModule != null) {
      RCTModule.getOffLineNum(mac);
    }else {
      console.log('~~~~~ RCTModule is null')
    }
  },

  /**
   * get offline data number.
   * @param {string} mac Device's mac address
   */
  getOffLineData: (mac) => {
    if (RCTModule != null) {
      RCTModule.getOffLineData(mac);
    }else {
      console.log('~~~~~ RCTModule is null')
    }
  },

  /**
   * Set BP7S device unit.
   * @param {string} mac Device's mac address
   * @param {int} unit 0:mmHg,1:kPa
   */
  setUnit: (mac, unit) => {
    if (RCTModule != null) {
      RCTModule.setUnit(mac, unit);
    }else {
      console.log('~~~~~ RCTModule is null')
    }
  },

  /**
   * Get the BP7S device's functionInfo.
   * @param {string} mac Device's mac address
   */

  getFunctionInfo: (mac) => {
    if (RCTModule != null) {
      RCTModule.getFunctionInfo(mac);
    }else {
      console.log('~~~~~ RCTModule is null')
    }
  },


  /**
   * Disconnect the BP5S
   *
   * @param {string} mac Device's mac address
   */

  disconnect: (mac) => {
    if (RCTModule != null) {
      RCTModule.disconnect(mac);
    }else {
      console.log('~~~~~ RCTModule is null')
    }
  },

  /**
   * Get all connected BP5S device
   *
   * e.g. {"devices":["A4D5783FB00C","A4D5783FFE58"]}
   */
  getAllConnectedDevices: () => {
    RCTModule.getAllConnectedDevices()
  }
};
