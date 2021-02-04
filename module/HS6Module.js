/**
 * Created by lixuesong on 11/11/2016.
 */
'use strict';


var {NativeModules} = require('react-native');

var RCTModule = NativeModules.HS6Module

/**
 * @module HS6Module
 */
module.exports = {

  Event_Notify: RCTModule.Event_Notify,

  /**
   * Initializes method.
   * @param {string} userName the name of user
   */
  init: function (userName) {
    RCTModule.init(userName)
  },

  /**
   * Set wifi to the scale.
   * @param {string} ssid the name of net
   * @param {string} password the password of the net
   */
  setWifi: function (ssid, password) {
    RCTModule.setWifi(ssid, password)
  },

  /**
   * Bind the user and scale together,after bind success user's weight datas can be transmitted to the cloud.
   * And this method is a time consuming operation that cannot be called in the main thread.
   * @param {string} birthday format like yyyy-MM-dd HH:mm:ss
   * @param {float} weight the unit is kg
   * @param {int} height the unit is cm
   * @param {int} isSporter is sporter; 2 is not ;3 unknown
   * @param {int} gender 0 is male ;1 is female
   * @param {string} serialNumber the mac address of the scale
   */
  bindDeviceHS6: function (birthday, weight, height, isSporter, gender, serialNumber) {
    RCTModule.bindDeviceHS6(birthday, weight, height, isSporter, gender, serialNumber)
  },

  /**
   * Unbind the user and scale,and this method is a time consuming operation that cannot be called in the main thread.
   * @param {string} serialNumber the mac address of scale
   */
  unBindDeviceHS6: function (serialNumber) {
    RCTModule.unBindDeviceHS6(serialNumber)
  },

  /**
   * Get AccessToken of HS6 user,and this method is a time consuming operation that cannot be called
   * in the main thread.
   * After get AccessToken, you can call openApi(http://developer.ihealthlabs.com) to pull data form iHealth cloud.
   * @param {string} clientId the identification of the SDK
   * @param {string} clientSecret the identification of the SDK
   * @param {string} username the identification of the user
   * @param {string} clientPara a random string,return back without change
   */
  getToken: function (clientId, clientSecret, username, clientPara) {
    RCTModule.getToken(clientId, clientSecret, username, clientPara)
  },

  /**
   * Set unit of HS6,and this method is a time consuming operation that cannot be called
   * in the main thread.
   * @param {string} username the identification of the user
   * @param {int} unitType the unit type
   *                 <p>0 Kg
   *                 <p>1 lbs
   *                 <p>2 st
   */
  setUnit: function (username, unitType) {
    RCTModule.setUnit(username, unitType)
  },

  /**
   * DownloadHS6 CloudData
   * @param {string} clientId the identification of the SDK
   * @param {string} clientSecret the identification of the SDK
   * @param {string} username the identification of the user
   * @param {long} ts  time stamp of HS6 measure data. UTC time, unit in milliseconds.
   * @param {long} pageSize the specific size of data in one download progress
   */
  getCloudData: function (clientId, clientSecret, username, ts, pageSize) {
    RCTModule.getCloudData(clientId, clientSecret, username, ts, pageSize)
  },
}
