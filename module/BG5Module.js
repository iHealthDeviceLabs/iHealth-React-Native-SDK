/**
 * Created by gaoyuanlong on 16/11/17.
 */
'use strict';


var {NativeModules} = require('react-native');

var RCTModule = NativeModules.BG5Module

/**
 * @module BG5Module
 */
module.exports = {
  Event_Notify: RCTModule.Event_Notify,

  /**
   * Keep BG5 connecting.
   * @param {string} mac Device's mac address
   */
  holdLink: function (mac){
    if (RCTModule != null) {
      RCTModule.holdLink(mac);
    } else {
      console.log('~~~~~ BG5 holdLink RCTModule is null')
    }
  },

  /**
   * Get battery level of BG5 device.
   * @param {string} mac Device's mac address
   */
  getBattery: function (mac){
    if (RCTModule != null) {
      RCTModule.getBattery(mac);
    } else {
      console.log('~~~~~ BG5 getBattery RCTModule is null')
    }
  },

  /**
   * Set time to BG5 device.
   * @param {string} mac Device's mac address
   */
  setTime: function (mac){
    if (RCTModule != null) {
      RCTModule.setTime(mac);
    } else {
      console.log('~~~~~ BG5 setTime RCTModule is null')
    }
  },

  /**
   * Set unit to BG5 device.
   * @param {string} mac Device's mac address
   * @param {number} type 1:mmol/L 2:mg/dL
   */
  setUnit: function (mac, type){
    if (RCTModule != null) {
      RCTModule.setUnit(mac, type);
    } else {
      console.log('~~~~~ BG5 setUnit RCTModule is null')
    }
  },

  /**
   * Start measure with specific measure type.
   * @param {string} mac Device's mac address
   * @param {number} type Measure type, 1.Measure with blood measure, 2.Measure with control liquid
   */
  startMeasure: function (mac, type){
    if (RCTModule != null) {
      RCTModule.startMeasure(mac, type);
    } else {
      console.log('~~~~~ BG5 startMeasure RCTModule is null')
    }
  },

  /**
   * Get offline data of BG5 device.
   * @param {string} mac Device's mac address
   */
  getOfflineData: function (mac){
    if (RCTModule != null) {
      RCTModule.getOfflineData(mac);
    } else {
      console.log('~~~~~ BG5 getOffineData RCTModule is null')
    }
  },

  /**
   * Delete the offline data in BG5 device.
   * @param {string} mac Device's mac address
   */
  deleteOfflineData: function (mac){
    if (RCTModule != null) {
      RCTModule.deleteOfflineData(mac);
    } else {
      console.log('~~~~~ BG5 deleteOfflineData RCTModule is null')
    }
  },

  /**
   * Set bottle message to BG5 device.
   * @param {string} mac Device's mac address
   * @param {number} stripType GOD(value 1) or GDH(value 2)
   * @param {number} measureType measure with blood(value 1) or measure with control liquid(value 2)
   * @param {number} QRCode the QR code send to the deivce(GOD strip), GDH ignore
   * @param {number} stripNum the left count of strip, range [1, 255]
   * @param {string} overDate the expire time of the strip, format: yyyy-MM-dd, should be valid
   */
  setBottleMessage: function (mac, stripType, measureType, QRCode, stripNum, overDate){
    if (RCTModule != null) {
      RCTModule.setBottleMessageWithInfo(mac, stripType, measureType, QRCode, stripNum, overDate);
    } else {
      console.log('~~~~~ BG5 setBottleMessage RCTModule is null')
    }
  },

  /**
   * Get bottle message from BG5 device.
   * @param {string} mac Device's mac address
   */
  getBottleMessage: function (mac){
    if (RCTModule != null) {
      RCTModule.getBottleMessage(mac);
    } else {
      console.log('~~~~~ BG5 getBottleMessage RCTModule is null')
    }
  },

  /**
   * Set bottleId to BG5 device.
   * @param {string} mac Device's mac address
   * @param {string} ID UserID set to device
   */
  setBottleID: function (mac, ID){
      if (RCTModule != null) {
          RCTModule.setBottleId(mac, ID);
      } else {
          console.log('~~~~~ BG5 setBottleID RCTModule is null')
      }
  },

  /**
   * Get bottleId from BG5 device.
   * @param {string} mac Device's mac address
   */
  getBottleID: function (mac){
      if (RCTModule != null) {
          RCTModule.getBottleId(mac);
      } else {
          console.log('~~~~~ BG5 getBottleID RCTModule is null')
      }
  },

  disConnect: function (mac){
      if (RCTModule != null) {
          RCTModule.disConnect(mac);
      } else {
          console.log('~~~~~ BG5 getBottleID RCTModule is null')
      }
  },

  /**
   * Parse bottle info from QRCode, include strip expire time,strip number,bottle id
   * @param {string} QRCode
   */
  getBottleInfoFromQR: function(QRCode){
      if (RCTModule != null) {
          RCTModule.getBottleInfoFromQR(QRCode);
      }else {
          console.log('~~~~~ RCTModule is null')
      }
  },
  /**
   * Get all connected BG5 device
   *
   * e.g. {"devices":["A4D5783FB00C","A4D5783FFE58"]}
   */
  getAllConnectedDevices: function () {
      RCTModule.getAllConnectedDevices()
  },
}
