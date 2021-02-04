/**
 * Created by Jeepend on 22/11/2016.
 */
'use strict';


var {
  NativeModules,
  DeviceEventEmitter
} = require('react-native');

var AMProfileModule = require('./AMProfileModule.js');

var RCTModule = NativeModules.AM3SModule
/**
 * @module AM3SModule
 */
module.exports = {

  Event_Notify: RCTModule.Event_Notify,

  /**
   * AM3S IDPS information
   *
   * @argument mac
   */
  getIdps: function (mac) {
      RCTModule.getIdps(mac)
  },

  /**
   * Reset AM3S device.
   * @param {string} mac Device's mac address
   */
  reset: function (mac) {
      RCTModule.reset(mac)
  },

  /**
   * Get user's ID
   * @param {string} mac Device's mac address
   */
  getUserId: function (mac) {
      RCTModule.getUserId(mac)
  },

  /**
   * Get alarms' count
   * @param {string} mac Device's mac address
   */
  getAlarmClockNum: function (mac) {
      RCTModule.getAlarmClockNum(mac)
  },

  /**
   * Get alarm information by id
   * @param {string} mac Device's mac address
   * @param {array} alarmIDArray Alarm id array to be query.
   */
  getAlarmClockDetail: function (mac, alarmIDArray) {
      RCTModule.getAlarmClockDetail(mac, alarmIDArray)
  },

  /**
   * Set/Unset alarm
   * @param {string} mac Device's mac address
   * @param {number} id  Alarm id
   * @param {number} hour Alarm hour part [0, 23]
   * @param {number} min Alarm minute part [0, 59]
   * @param {boolean} isRepeat Indicates whether it will repeat:
   * @param {array} weekArray The days in a week to repeat the alarm, week[0~6] indicates Sun~Sat.
   *                 {0, 1, 1, 1, 1, 1, 0} means the alarm will repeat on Mon, Tue, Wed, Thu, Fri.
   * @param {boolean} isOn true if want to set the alarm, false to unset it.
   */
  setAlarmClock: function (mac, id, hour, min, isRepeat, weekArray, isOn) {
      RCTModule.setAlarmClock(mac, id, hour, min, isRepeat, weekArray, isOn)
  },

  /**
   * Delete alarm by id
   * @param {string} mac Device's mac address
   * @param {number} id Alarm id(should be 1, 2 or 3)
   */
  deleteAlarmClock: function (mac, id) {
      RCTModule.deleteAlarmClock(mac, id)
  },

  /**
   * Get activity remind setting.
   * @param {string} mac Device's mac address
   */
  getActivityRemind: function (mac) {
      RCTModule.getActivityRemind(mac)
  },

  /**
   * Set/Unset activity remind
   * @param {string} mac Device's mac address
   * @param {number} hour Activity remind hour part [0, 23]
   * @param {number} min Activity remind minute part [0, 59]
   * @param {boolean} isOn true if want to set activity remind, false to unset it.
   */
  setActivityRemind: function (mac, hour, min, isOn) {
      RCTModule.setActivityRemind(mac, hour, min, isOn)
  },

  /**
   * Get device state and battery information
   * @param {string} mac Device's mac address
   */
  queryAMState: function (mac) {
      RCTModule.queryAMState(mac)
  },

  /**
   * Set user ID
   * @param {string} mac Device's mac address
   * @param {number} id new user id <br/>
   *           <b>Range:</b> [1, 2147483647(0x7FFFFFFF)]
   */
  setUserId: function (mac, id) {
    if (id < 1 || id > 0x7FFFFFFF) {
      let result = {
        "mac": mac,
        "type": "AM3S",
        "action": AMProfileModule.ACTION_ERROR_AM,
      }
      result[AMProfileModule.ERROR_NUM_AM] = AMProfileModule.ERROR_ID_ILLEGAL_ARGUMENT
      result[AMProfileModule.ERROR_DESCRIPTION_AM] = 'setUserId() parameter id should be in the range [1, 2147483647(0x7FFFFFFF)]'
      DeviceEventEmitter.emit(RCTModule.Event_Notify, result)
      return
    }
    RCTModule.setUserId(mac, id)
  },

  /**
   * Get user information
   * @param {string} mac Device's mac address
   */
  getUserInfo: function (mac) {
      RCTModule.getUserInfo(mac)
  },

  /**
   * Set user's BMR
   * @param {string} mac Device's mac address
   * @param {number} bmr User's BMR [1, 32767(0x7FFF)]
   */
  setUserBmr: function (mac, bmr) {
      RCTModule.setUserBmr(mac, bmr)
  },

  /**
   * Get the activity data.
   * @param {string} mac Device's mac address
   */
  syncActivityData: function (mac) {
      RCTModule.syncActivityData(mac)
  },

  /**
   * Get the sleep data.
   * @param {string} mac Device's mac address
   */
  syncSleepData: function (mac) {
      RCTModule.syncSleepData(mac)
  },

  /**
   * Get current time activity data
   * @param {string} mac Device's mac address
   */
  syncRealData: function (mac) {
      RCTModule.syncRealData(mac)
  },

  /**
   * Set the system time to AM device.
   * @param {string} mac Device's mac address
   */
  syncRealTime: function (mac) {
      RCTModule.syncRealTime(mac)
  },

  /**
   * Set hour mode
   * @param {string} mac Device's mac address
   * @param {number} hourMode The value should be one of following:
   *                 <ul>
   *                 <li>{@link module:AMProfileModule.AM_SET_12_HOUR_MODE AMProfileModule.AM_SET_12_HOUR_MODE(0)}</li>
   *                 <li>{@link module:AMProfileModule.AM_SET_24_HOUR_MODE AMProfileModule.AM_SET_24_HOUR_MODE(1)}</li>
   *                 <li>{@link module:AMProfileModule.AM_SET_EXCEPT_EUROPE_12_HOUR_MODE AMProfileModule.AM_SET_EXCEPT_EUROPE_12_HOUR_MODE(2)}</li>
   *                 <li>{@link module:AMProfileModule.AM_SET_EUROPE_12_HOUR_MODE AMProfileModule.AM_SET_EUROPE_12_HOUR_MODE(3)}</li>
   *                 <li>{@link module:AMProfileModule.AM_SET_EXCEPT_EUROPE_24_HOUR_MODE AMProfileModule.AM_SET_EXCEPT_EUROPE_24_HOUR_MODE(4)}</li>
   *                 <li>{@link module:AMProfileModule.AM_SET_EUROPE_24_HOUR_MODE AMProfileModule.AM_SET_EUROPE_24_HOUR_MODE(5)}</li>
   *                 </ul>
   */
  setHourMode: function (mac, hourMode) {
      RCTModule.setHourMode(mac, hourMode)
  },

  /**
   * Get hour mode
   * @param {string} mac Device's mac address
   */
  getHourMode: function (mac) {
      RCTModule.getHourMode(mac)
  },

  /**
   * Disconnect device
   * @param {string} mac Device's mac address
   */
  disconnect: function (mac) {
      RCTModule.disconnect(mac)
  },

  /**
   * Set user information
   * @param {string} mac Device's mac address
   * @param {number} age User's age [1, 255]
   * @param {number} height User's height(int in cm) [1, 255]
   * @param {number} weight User's weight(float) [1.0, 255.0]
   * @param {number} gender User's gender
   * @param {number} unit Distance's unit type(kilometre or miles)
   * @param {number} target The goal of maximum steps [4, 65535(0xFFFF)]
   * @param {number} activityLevel The level of activity strength
   */
  setUserInfo: function (mac, age, height, weight, gender, unit, target, activityLevel) {
      RCTModule.setUserInfo(mac, age, height, weight, gender, unit, target, activityLevel)
  },

  /**
   * Get stage report data
   * @param {string} mac Device's mac address
   */
  syncStageReportData: function (mac) {
      RCTModule.syncStageReportData(mac)
  },

  /**
   * Send random number to device to prepare for binding, the number will be displayed on the device.
   * @param {string} mac Device's mac address
   */
  sendRandom: function (mac) {
      RCTModule.sendRandom(mac)
  },

  /**
   * Get AM picture's index
   * @param {string} mac Device's mac address
   */
  getPicture: function (mac) {
      RCTModule.getPicture(mac)
  },

  /**
   * Set picture for AM
   * @param {string} mac Device's mac address
   * @param {number} index The index of picture
   */
  setPicture: function (mac, index) {
      RCTModule.setPicture(mac, index)
  },

  /**
   * Get all connected AM3S device
   *
   * e.g. {"devices":["A4D5783FB00C","A4D5783FFE58"]}
   */
  getAllConnectedDevices: function () {
      RCTModule.getAllConnectedDevices()
  },
}
