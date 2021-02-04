/**
 * Created by lixuesong on 11/11/2016.
 */
'use strict';


var {NativeModules} = require('react-native');

var RCTModule = NativeModules.HS2SModule

/**
 * @module hs2sModule
 */
module.exports = {
  /**
   * Notify event type for hs2s
   */
  Event_Notify: RCTModule.Event_Notify,


  getDeviceInfo: function (mac) {
    RCTModule.getDeviceInfo(mac)
  },
  /**
   * Get  hs2s device battary
   *
   */
  getBattery: function (mac) {
    RCTModule.getBattery(mac)
  },

  setUnit: function (mac,unit) {
    RCTModule.setUnit(mac,unit)
  },
  getUserInfo: function (mac) {
    RCTModule.getUserInfo(mac)
  },
  updateUserInfo: function (mac,userID,createTS,weight,age,height,sex,impedanceMark,fitnessMark) {
    RCTModule.updateUserInfo(mac,userID,createTS,weight,age,height,sex,impedanceMark,fitnessMark);
  },

  deleteUser: function (mac,userID) {
    RCTModule.deleteUser(mac,userID);
  },

  getMemoryDataCount: function (mac,userID) {
    RCTModule.getMemoryDataCount(mac,userID);
  },

  getMemoryData: function (mac,userID) {
    RCTModule.getMemoryData(mac,userID);
  },

  deleteMemoryData: function (mac,userID) {
    RCTModule.deleteMemoryData(mac,userID);
  },

  getAnonymousMemoryDataCount: function (mac) {
    RCTModule.getAnonymousMemoryDataCount(mac);
  },

  getAnonymousMemoryData: function (mac) {
    RCTModule.getAnonymousMemoryData(mac);
  },

  deleteAnonymousMemoryData: function (mac) {
    RCTModule.deleteAnonymousMemoryData(mac)
  },

  measure: function (mac,userType,userID,createTS,weight,age,height,sex,impedanceMark,fitnessMark) {
    RCTModule.measure(mac,userType,userID,createTS,weight,age,height,sex,impedanceMark,fitnessMark)
  },

  resetDevice: function (mac) {
    RCTModule.resetDevice(mac)
  },

  broadCastTypeDevice: function (mac) {
    RCTModule.broadCastTypeDevice(mac)
  },

  setDeviceLightUp: function (mac) {
    RCTModule.setDeviceLightUp(mac)
  },

  enterHS2SHeartRateMeasurementMode: function (mac) {
    RCTModule.enterHS2SHeartRateMeasurementMode(mac)
  },

  exitHS2SHeartRateMeasurementMode: function (mac) {
    RCTModule.exitHS2SHeartRateMeasurementMode(mac)
  },


  /**
   * Disconnect the HS2S
   * @param mac The mac address for blood pressure monitor
   */
  disconnect: function (mac) {
    RCTModule.disconnect(mac)
  },

  /**
   * Get all connected hs2s device
   *
   * e.g. {"devices":["A4D5783FB00C","A4D5783FFE58"]}
   */
  getAllConnectedDevices: function () {
    RCTModule.getAllConnectedDevices()
  }


}
