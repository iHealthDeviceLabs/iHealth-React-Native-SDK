/**
 * Created by Jeepend on 11/11/2016.
 */
'use strict';


var {
    NativeModules,
    DeviceEventEmitter
} = require('react-native');

var AMProfileModule = require('./AMProfileModule.js');

var RCTModule = NativeModules.AM4Module

/**
 * @module AM4Module
 */
module.exports = {

  Event_Notify: RCTModule.Event_Notify,

  /**
   * Get AM4 device's IDPS information.
   * @param {string} mac Device's mac address
   */
  getIdps: function (mac) {
      RCTModule.getIdps(mac)
  },

  /**
   * Reset AM4 device.
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
   * @param {array} alarmIDArray Alarm id array to be query.<br/>
   *            <ul>
   *            <li>The parameters should be 1, 2, or 3</li>
   *            <li>The duplicate parameters will be IGNORED</li>
   *            <li>The query result will be in ascending order of id.</li>
   *            <li>If specified alarm not set yet, the result will not include the id.</li>
   *            </ul>
   */
  getAlarmClockDetail: function (mac, alarmIDArray) {
      RCTModule.getAlarmClockDetail(mac, alarmIDArray)
  },

  /**
   * Set alarm
   * @param {string} mac Device's mac address
   * @param {number} id  Alarm id<br/>
   *                 <b>Range:</b> 1, 2 or 3
   * @param {number} hour Alarm hour part<br/>
   *                 <b>Range:</b> [0, 23]
   * @param {number} min Alarm minute part<br/>
   *                 <b>Range:</b> [0, 59]
   * @param {boolean} isRepeat Indicates whether it will repeat:
   *                  <ul>
   *                  <li>true indicates that it will repeat as the <b>weeks</b> parameter</li>
   *                  <li>false indicates that it will only play one time and <b>IGNORE</b> the <b>weeks</b> parameter</li>
   *                  </ul>
   * @param {array} weekArray The days in a week to repeat the alarm, week[0~6] indicates Sun~Sat.<br/>
   *                 And 1 indicates open, 0 indicates close.<br/>
   *                 <b>For example:</b><br/>
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
   * @param {number} hour Activity remind hour part<br/>
   *                 <b>Range:</b> [0, 23]
   * @param {number} min Activity remind minute part<br/>
   *                 <b>Range:</b>[0, 59]
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
      if (id < 1 || id  > 0x7FFFFFFF) {
        let result = {
          "mac": mac,
          "type": "AM4",
          "action" : AMProfileModule.ACTION_ERROR_AM,
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
   * @param {number} bmr User's BMR<br/>
   *            <b>Range:</b> [1, 32767(0x7FFF)]
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
   * Get current time activity data.
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
   * @param {number} age User's age<br/>
   *                      <b>Range:</b> [1, 255]
   * @param {number} height User's height(int in cm)<br/>
   *                      <b>Range:</b> [1, 255]
   * @param {number} weight User's weight(float)<br/>
   *                      <b>Range:</b> [1.0, 255.0]
   * @param {number} gender User's gender<br/>
   *                      <b>Value:</b>
   *                      <ul>
   *                      <li>{@link module:AMProfileModule.AM_SET_FEMALE AMProfileModule.AM_SET_FEMALE(0)}</li>
   *                      <li>{@link module:AMProfileModule.AM_SET_MALE AMProfileModule.AM_SET_MALE(1)}</li>
   *                      </ul>
   * @param {number} unit Distance's unit type(kilometre or miles)<br/>
   *                      <b>Value:</b>
   *                      <ul>
   *                      <li>{@link module:AMProfileModule.AM_SET_UNIT_IMPERIAL_STANDARD AMProfileModule.AM_SET_UNIT_IMPERIAL_STANDARD(0)} (miles)</li>
   *                      <li>{@link module:AMProfileModule.AM_SET_UNIT_METRIC AMProfileModule.AM_SET_UNIT_METRIC(1)} (kilometre)</li>
   *                      </ul>
   * @param {number} target The goal of maximum steps<br/>
   *                      <b>Range:</b> [4, 2147483647(0x7FFFFFFF)]
   * @param {number} activityLevel The level of activity strength<br/>
   *                      <ul>
   *                      <li>1 indicates sedentary</li>
   *                      <li>2 indicates active</li>
   *                      <li>3 indicates very active</li>
   *                      </ul>
   * @param {number} min swim target time(in minutes)<br/>
   *                      <b>Range:</b> [1, 1439(23 * 60 + 59)]
   */
  setUserInfo: function (mac, age, height, weight, gender, unit, target, activityLevel, min) {
      RCTModule.setUserInfo(mac, age, height, weight, gender, unit, target, activityLevel, min)
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
   * Get swim parameters
   * @param {string} mac Device's mac address
   */
  checkSwimPara: function (mac) {
      RCTModule.checkSwimPara(mac)
  },

  /**
   * Set swim parameters
   * @param {string} mac Device's mac address
   * @param {boolean} isOpen Set true to open swim function, set false to close it.
   * @param {number} poolLength the swimming pool's length.<br/>
   *                   <b>Range:</b> [1, 255]
   * @param {number} hours The cut out time's hour part<br/>
   *              <b>Range:</b> [0, 23]
   * @param {number} minutes The cut out time's minute part<br/>
   *                Range[0, 59]
   * @param {number} unit The pool length's unit type(metre or yard).
   *             <ul>
   *             <li>{@link module:AMProfileModule.AM_SET_UNIT_IMPERIAL_STANDARD AMProfileModule.AM_SET_UNIT_IMPERIAL_STANDARD(0)} (yard)</li>
   *             <li>{@link module:AMProfileModule.AM_SET_UNIT_METRIC AMProfileModule.AM_SET_UNIT_METRIC(1)} (metre)</li>
   *             </ul>
   */
  setSwimPara: function (mac, isOpen, poolLength, hours, minutes, unit) {
      RCTModule.setSwimPara(mac, isOpen, poolLength, hours, minutes, unit)
  },

  /**
   * Get all connected AM4 device
   *
   * e.g. {"devices":["A4D5783FB00C","A4D5783FFE58"]}
   */
  getAllConnectedDevices: function () {
      RCTModule.getAllConnectedDevices()
  },
}
