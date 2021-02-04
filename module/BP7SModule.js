/**
 * Created by zhangxu on 16/11/20.
 */

'use strict';


var { NativeModules } = require('react-native');

var RCTModule = NativeModules.BP7SModule;

/**
 * @module BP7SModule
 */

module.exports = {

  Event_Notify: RCTModule.Event_Notify,

  /**
   * Get the BP7S device's battery.
   * @param {string} mac Device's mac address
   */
  getBattery: function (mac) {
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
  getOffLineNum:function (mac) {
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
  getOffLineData:function (mac) {
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
  setUnit:function (mac, unit){
    if (RCTModule != null) {
      RCTModule.setUnit(mac,unit);
    }else {
      console.log('~~~~~ RCTModule is null')
    }
  },

  /**
   * Set BP7S device angle.
   * @param {string} mac Device's mac address
   * @param {int} leftUpper the maximum measure angle of left hand, the maximum value must less than 90.
   * @param {int} leftLows the minimum measure angle of left hand, the minimum value must more than 0, and less than leftUpper.
   * @param {int} rightUpper the maximum measure angle of right hand, the maximum value must less than 90.
   * @param {int} rightLow the minimum measure angle of right hand, the minimum value must more than 0, and less than rightUpper.
   *
   */
  angleSet:function (mac, leftUpper, leftLows, rightUpper, rightLow) {
    if (RCTModule != null) {
      RCTModule.angleSet(mac,leftUpper,leftLows,rightUpper,rightLow);
    }else {
      console.log('~~~~~ RCTModule is null')
    }
  },

  /**
   * Get the BP7S device's functionInfo.
   * @param {string} mac Device's mac address
   */
  getFunctionInfo:function (mac) {
    if (RCTModule != null) {
      RCTModule.getFunctionInfo(mac);
    }else {
      sconsole.log('~~~~~ RCTModule is null')
    }
  },

  /**
   * Disconnect the BP7S
   *
   * @param {string} mac Device's mac address
   */

  disconnect: function (mac) {

      if (RCTModule != null) {
          RCTModule.disconnect(mac);
      }else {
          console.log('~~~~~ RCTModule is null')
      }
  },

  /**
   * Get all connected BP7S device
   *
   * e.g. {"devices":["A4D5783FB00C","A4D5783FFE58"]}
   */
  getAllConnectedDevices: function () {
      RCTModule.getAllConnectedDevices()
  }
};
