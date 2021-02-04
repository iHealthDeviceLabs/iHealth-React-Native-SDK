/**
 * Created by gaoyuanlong on 16/11/16.
 */
'use strict';


var { NativeModules } = require('react-native');

var RCTModule = NativeModules.BG5SProfileModule

/**
 * @module BG5SProfileModule
 */
module.exports = {

  /**
   * The action value of event indicating the error of BG device.<br/>
   */
  ACTION_ERROR_BG: RCTModule.ACTION_ERROR_BG,

  /**
   * The action value of event indicating keep link success.<br/>
   * The key and value will be as below:
   * <table style="width:100px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
   * <tbody>
   * <tr><td>Key</td><td>Value</td></tr>
   * <tr><td>action</td><td>{@link module:BGProfileModule.ACTION_KEEP_LINK BGProfileModule.ACTION_KEEP_LINK("action_keep_link")}</td></tr>
   * </tbody>
   * </table>
   * <b>Example:</b><br/>
   * {"mac":"8CDE52B5FAC2","type":"BG5","action":"action_keep_link"}<br/>
   */
  ACTION_GET_STATUS_INFO: RCTModule.ACTION_GET_STATUS_INFO,

  /**
   * The action value of event indicating set time success.<br/>
   * The key and value will be as below:
   * <table style="width:100px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
   * <tbody>
   * <tr><td>Key</td><td>Value</td></tr>
   * <tr><td>action</td><td>{@link module:BGProfileModule.ACTION_SET_TIME BGProfileModule.ACTION_SET_TIME("action_set_time")}</td></tr>
   * </tbody>
   * </table>
   * <b>Example:</b><br/>
   * {"mac":"8CDE52B5FAC2","type":"BG5","action":"action_set_time"}<br/>
   */
  ACTION_SET_TIME: RCTModule.ACTION_SET_TIME,

  /**
   * The action value of event indicating set unit success.<br/>
   * The key and value will be as below:
   * <table style="width:100px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
   * <tbody>
   * <tr><td>Key</td><td>Value</td></tr>
   * <tr><td>action</td><td>{@link module:BGProfileModule.ACTION_SET_UNIT BGProfileModule.ACTION_SET_UNIT("action_set_unit")}</td></tr>
   * </tbody>
   * </table>
   * <b>Example:</b><br/>
   * {"mac":"8CDE52B5FAC2","type":"BG5","action":"action_set_unit"}<br/>
   */
  ACTION_SET_UNIT: RCTModule.ACTION_SET_UNIT,

  /**
   * The action value of event indicating the result of get battery command.<br/>
   * The key and value will be as below:
   * <table style="width:100px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
   * <tbody>
   * <tr><td>Key</td><td>Value</td></tr>
   * <tr><td>action</td><td>{@link module:BGProfileModule.ACTION_GET_BATTERY BGProfileModule.ACTION_GET_BATTERY("action_battery_bg")}</td></tr>
   * <tr><td>{@link module:BGProfileModule.GET_BATTERY BGProfileModule.GET_BATTERY("battery")}</td><td>The battery value.</td></tr>
   * </tbody>
   * </table>
   * <b>Example:</b><br/>
   * {"mac":"8CDE52B5FAC2","battery":32,"type":"BG5","action":"action_battery_bg"}<br/>
   */
  ACTION_GET_BATTERY: RCTModule.ACTION_GET_BATTERY,

  /**
   * The action value of event indicating start measure success.<br/>
   * The key and value will be as below:
   * <table style="width:100px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
   * <tbody>
   * <tr><td>Key</td><td>Value</td></tr>
   * <tr><td>action</td><td>{@link module:BGProfileModule.ACTION_START_MEASURE BGProfileModule.ACTION_START_MEASURE("action_start_measure")}</td></tr>
   * </tbody>
   * </table>
   * <b>Example:</b><br/>
   * {mac":"8CDE52B5FAC2","type":"BG5","action":"action_start_measure"}<br/>
   */
  ACTION_START_MEASURE: RCTModule.ACTION_START_MEASURE,

  /**
   * The action value of event indicating the offline data count.<br/>
   * The key and value will be as below:
   * <table style="width:100px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
   * <tbody>
   * <tr><td>Key</td><td>Value</td></tr>
   * <tr><td>action</td><td>{@link module:BGProfileModule.ACTION_GET_OFFLINEDATA_COUNT BGProfileModule.ACTION_GET_OFFLINEDATA_COUNT("action_historicalnum_bg")}</td></tr>
   * <tr><td>{@link module:BGProfileModule.GET_OFFLINEDATA_COUNT BGProfileModule.GET_OFFLINEDATA_COUNT("count")}</td><td>The offline data count value.</td></tr>
   * </tbody>
   * </table>
   * <b>Example:</b><br/>
   * {"count":2,"mac":"8CDE52B5FAC2","type":"BG5","action":"action_historicalnum_bg"}
   * <br/>
   */
  ACTION_GET_OFFLINEDATA_COUNT: RCTModule.ACTION_GET_OFFLINEDATA_COUNT,

  /**
   * The action value of event indicating the result of offline data.<br/>
   * The key and value will be as below:
   * <table style="width:100px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
   * <tbody>
   * <tr><td>Key</td><td>Value</td></tr>
   * <tr><td>action</td><td>{@link module:BGProfileModule.ACTION_GET_OFFLINEDATA BGProfileModule.ACTION_GET_OFFLINEDATA("action_historicaldata_bg")}</td></tr>
   * <tr><td>{@link module:BGProfileModule.GET_OFFLINEDATA BGProfileModule.GET_OFFLINEDATA("his_data_bg")}</td><td>Get offline data command result</td></tr>
   * </tbody>
   * </table>
   * <b>Example:</b><br/>
   * {<br/>
   * {"his_data_bg":{"history":[{"dataID":"1B92511DE36F54508415257160F9D0EA","value":39,"date":"2017-06-08 15:08:00"},
   * {"dataID":"862D10B79A8560505720B983D658E095","timeProofing":0,"value":38,"date":"2017-06-08 15:09:01"}]},
   * "mac":"8CDE52B5FAC2","type":"BG5","action":"action_historicaldata_bg"}
   * <br/>
   */
  ACTION_GET_OFFLINEDATA: RCTModule.ACTION_GET_OFFLINEDATA,

  /**
   * The action value of event indicating delete offline data success.<br/>
   * The key and value will be as below:
   * <table style="width:100px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
   * <tbody>
   * <tr><td>Key</td><td>Value</td></tr>
   * <tr><td>action</td><td>{@link module:BGProfileModule.ACTION_DELETE_OFFLINEDATA BGProfileModule.ACTION_DELETE_OFFLINEDATA("action_delete_historical_data")}</td></tr>
   * </tbody>
   * </table>
   * <b>Example:</b><br/>
   * {"mac":"8CDE52B5FAC2","type":"BG5","action":"action_delete_historical_data"}
   * <br/>
   */
  ACTION_DELETE_OFFLINEDATA: RCTModule.ACTION_DELETE_OFFLINEDATA,

  /**
   * The action value of event indicating the result of set bottle message command.<br/>
   * The key and value will be as below:
   * <table style="width:100px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
   * <tbody>
   * <tr><td>Key</td><td>Value</td></tr>
   * <tr><td>action</td><td>{@link module:BGProfileModule.ACTION_SET_BOTTLEMESSAGE BGProfileModule.ACTION_SET_BOTTLEMESSAGE("action_set_bottle_message_success")}</td></tr>
   * <tr><td>{@link module:BGProfileModule.SET_BOTTLEMESSAGE BGProfileModule.SET_BOTTLEMESSAGE("set_bottle_message")}</td><td>Set bottle message command result</td></tr>
   * <tr><td>{@link module:BGProfileModule.START_MODE BGProfileModule.START_MODE("start_mode")}</td><td>The start mode of Bg5 device.</td></tr>
   * </tbody>
   * </table>
   * <b>Example:</b><br/>
   * {"start_mode":2,"set_bottle_message":true,"mac":"8CDE52B5FAC2","type":"BG5","action":"action_set_bottle_message_success"}
   * <br/>
   */
  ACTION_SET_BOTTLEMESSAGE: RCTModule.ACTION_SET_BOTTLEMESSAGE,

  /**
   * The action value of event indicating the result of get bottle message command.<br/>
   * The key and value will be as below:
   * <table style="width:100px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
   * <tbody>
   * <tr><td>Key</td><td>Value</td></tr>
   * <tr><td>action</td><td>{@link module:BGProfileModule.ACTION_GET_BOTTLEMESSAGE BGProfileModule.ACTION_GET_BOTTLEMESSAGE("action_get_codeinfo")}</td></tr>
   * <tr><td>{@link module:BGProfileModule.GET_EXPIRECTIME BGProfileModule.GET_EXPIRECTIME("expiretime")}</td><td>The strip expire time of Bg5 device.</td></tr>
   * <tr><td>{@link module:BGProfileModule.GET_USENUM BGProfileModule.GET_USENUM("usenum")}</td><td>The strip used num, from offline data by Bg5 device.</td></tr>
   * </tbody>
   * </table>
   * <b>Example:</b><br/>
   * {"expiretime":"2099-12-16","usenum":0,"mac":"8CDE52B5FAC2","type":"BG5","action":"action_get_codeinfo"}
   * <br/>
   */
  ACTION_GET_BOTTLEMESSAGE: RCTModule.ACTION_GET_BOTTLEMESSAGE,

  /**
   * The action value of event indicating set bottleID success.<br/>
   * The key and value will be as below:
   * <table style="width:100px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
   * <tbody>
   * <tr><td>Key</td><td>Value</td></tr>
   * <tr><td>action</td><td>{@link module:BGProfileModule.ACTION_SET_BOTTLEID BGProfileModule.ACTION_SET_BOTTLEID("action_setbottleid_success")}</td></tr>
   * </tbody>
   * </table>
   * <b>Example:</b><br/>
   * {"mac":"8CDE52B5FAC2","type":"BG5","action":"action_setbottleid_success"}
   * <br/>
   */
  ACTION_SET_BOTTLEID: RCTModule.ACTION_SET_BOTTLEID,

  /**
   * The action value of event indicating the result of get bottleID command.<br/>
   * The key and value will be as below:
   * <table style="width:100px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
   * <tbody>
   * <tr><td>Key</td><td>Value</td></tr>
   * <tr><td>action</td><td>{@link module:BGProfileModule.ACTION_GET_BOTTLEID BGProfileModule.ACTION_GET_BOTTLEID("action_get_bottleid")}</td></tr>
   * <tr><td>{@link module:BGProfileModule.GET_BOTTLEID BGProfileModule.GET_BOTTLEID("bottleid")}</td><td>The bottleId of Bg5 device.</td></tr>
   * </tbody>
   * </table>
   * <b>Example:</b><br/>
   * {"bottleid":926305,"mac":"8CDE52B5FAC2","type":"BG5","action":"action_get_bottleid"}
   * <br/>
   */
  ACTION_GET_BOTTLEID: RCTModule.ACTION_GET_BOTTLEID,


  /**
   * The action value of event indicating the result of strip was put in the devices.<br/>
   * The key and value will be as below:
   * <table style="width:100px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
   * <tbody>
   * <tr><td>Key</td><td>Value</td></tr>
   * <tr><td>action</td><td>{@link module:BGProfileModule.ACTION_STRIP_IN BGProfileModule.ACTION_STRIP_IN("action_measure_strip_in")}</td></tr>
   * </tbody>
   * </table>
   * <b>Example:</b><br/>
   * {"mac":"8CDE52B5FAC2","type":"BG5","action":"action_measure_strip_in"}<br/>
   */
  ACTION_STRIP_IN: RCTModule.ACTION_STRIP_IN,

  /**
   * The action value of event indicating the result of strip out of the devices.<br/>
   * The key and value will be as below:
   * <table style="width:100px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
   * <tbody>
   * <tr><td>Key</td><td>Value</td></tr>
   * <tr><td>action</td><td>{@link module:BGProfileModule.ACTION_STRIP_OUT BGProfileModule.ACTION_STRIP_OUT("action_measure_strip_out")}</td></tr>
   * </tbody>
   * </table>
   * <b>Example:</b><br/>
   * {"mac":"8CDE52B5FAC2","type":"BG5","action":"action_measure_strip_out"}
   * <br/>
   */
  ACTION_STRIP_OUT: RCTModule.ACTION_STRIP_OUT,

  /**
   * The action value of event indicating the result of get the blood.<br/>
   * The key and value will be as below:
   * <table style="width:100px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
   * <tbody>
   * <tr><td>Key</td><td>Value</td></tr>
   * <tr><td>action</td><td>{@link module:BGProfileModule.ACTION_GET_BLOOD BGProfileModule.ACTION_GET_BLOOD("action_measure_get_blood")}</td></tr>
   * </tbody>
   * </table>
   * <b>Example:</b><br/>
   * {"mac":"8CDE52B5FAC2","type":"BG5","action":"action_measure_get_blood"}
   * <br/>
   */
  ACTION_GET_BLOOD: RCTModule.ACTION_GET_BLOOD,

  /**
   * The action value of event indicating the result of get measure value from devices.<br/>
   * The key and value will be as below:
   * <table style="width:100px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
   * <tbody>
   * <tr><td>Key</td><td>Value</td></tr>
   * <tr><td>action</td><td>{@link module:BGProfileModule.ACTION_ONLINE_RESULT_BG BGProfileModule.ACTION_ONLINE_RESULT_BG("action_value_bg")}</td></tr>
   * <tr><td>{@link module:BGProfileModule.ONLINE_RESULT_BG BGProfileModule.ONLINE_RESULT_BG("result")}</td><td>The bg value measured by device</td></tr>
   * <tr><td>{@link module:BGProfileModule.DATA_ID BGProfileModule.DATA_ID("dataID")}</td><td>The dataID measured by device</td></tr>
   * </tbody>
   * </table>
   * <b>Example:</b><br/>
   * {"dataID":"E0A831AE7D2220A6417D4E050EA3FCA1","result":141,"mac":"8CDE52B5FAC2","type":"BG5","action":"action_value_bg"}
   * <br/>
   */
  ACTION_ONLINE_RESULT_BG: RCTModule.ACTION_ONLINE_RESULT_BG,

  /**
   * The error num means different error.
   * <p>0:Battery is low.</p>
   * <p>1:Glucose test result is out of the measurement range.</p>
   * <p>2:Unknown interference detected, please repeat the test.</p>
   * <p>3:Strip is used or unknown moisture detected, discard the test strip and repeat the test with a new strip..</p>
   * <p>4:Reading transmission error. Repeat the test with a new test strip. If the problem persists, contact iHealth customer service for assistance.</p>
   * <p>5:The environmental temperature is beyond normal range, place the meter at room temperature for at least 30 minutes, then repeat the test.</p>
   * <p>6:The environmental temperature is beyond normal range, place the meter at room temperature for at least 30 minutes, then repeat the test.</p>
   * <p>7:Test strip coding error.</p>
   * <p>8:Communication error, press"START" or rescan the code to repeat the test.</p>
   * <p>9:Strip removed in the middle of reading, repeat the test with a new strip.</p>
   * <p>10:Insert a new test strip and repeat the test.</p>
   * <p>11:Cannot write to SN or KEY.</p>
   * <p>12:Please set time.</p>
   * <p>13:0 test strips remaining.</p>
   * <p>14:Test strip expired.</p>
   * <p>15:Unplug the charging cable before testing.</p>
   * <p>18:Unplug the charging cable before read the history data</>
   * <p>19:Charging line is inserted</>
   * <p>20:Charging line pull out</>
   * <p>21:The bluetooth module failure</>
   * <p>100:The device is disconnected (Android doesn't support this code)</>
   * <p>112:Device don't support to query energy.</p>
   * <p>400:Parameters out of range.</p>
   * <p>402:The order of call is wrong.</p>
   * <p>403:Parameter type is not matched in function call.</p>
   * <p>404:Function(disConnect) is not supported in iOS platform.(Only available in iOS platform)</p>
   * <p>405:QRCode format error</p>
   */
  ERROR_NUM_BG: RCTModule.ERROR_NUM_BG,

  /**
   * The error discription.
   */
  ERROR_DESCRIPTION_BG: RCTModule.ERROR_DESCRIPTION_BG,

  /**
   * The battery value.
   */
  GET_BATTERY: RCTModule.GET_BATTERY,

  /**
   * The offline data count value.
   */
  GET_OFFLINEDATA_COUNT: RCTModule.GET_OFFLINEDATA_COUNT,

  /**
   * Get offline data value.
   */
  GET_OFFLINEDATA: RCTModule.GET_OFFLINEDATA,

  /**
   * Set bottle message result value.
   */
  SET_BOTTLEMESSAGE: RCTModule.SET_BOTTLEMESSAGE,

  /**
   * the start mode of Bg5 device.
   * <li>
   * value=1, start by insert strip, no need to call <BG5Module.startMeasure>
   * </li>
   * <li>
   * value=2, start by tap the button, need to call <BG5Module.startMeasure>
   * </li>
   * </ul>
   */
  START_MODE: RCTModule.START_MODE,

  /**
   * The strip expire time of Bg5 device.
   */
  GET_EXPIRECTIME: RCTModule.GET_EXPIRECTIME,

  /**
   * The strip used num, from offline data by Bg5 device.
   */
  GET_USENUM: RCTModule.GET_USENUM,


  /**
   * The bottleId of Bg5 device.
   */
  GET_BOTTLEID: RCTModule.GET_BOTTLEID,

  /**
   * The bg value measured by device
   */
  ONLINE_RESULT_BG: RCTModule.ONLINE_RESULT_BG,

  /**
   * The dataID measured by device
   */
  DATA_ID: RCTModule.DATA_ID,

  /**
   * Callback indicating the code analysis result.
   * The key and value will be as below:
   * <table style="width:100px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
   * <tbody>
   * <tr><td>Key</td><td>Value</td></tr>
   * <tr><td>action</td><td>{@link module:BGProfileModule.ACTION_CODE_ANALYSIS BGProfileModule.ACTION_CODE_ANALYSIS("action_code_analysis")}</td></tr>
   * <tr><td>{@link module:BGProfileModule.STRIP_NUM_BG BGProfileModule.STRIP_NUM_BG("strip_num")}</td><td>The strip number of the QRCode</td></tr>
   * <tr><td>{@link module:BGProfileModule.STRIP_EXPIRETIME_BG BGProfileModule.STRIP_EXPIRETIME_BG("expire_time")}</td><td>The expire time of the QRCode</td></tr>
   * <tr><td>{@link module:BGProfileModule.BOTTLEID_BG BGProfileModule.BOTTLEID_BG("bottle_id")}</td><td>The bottle id of the QRCode</td></tr>
   * </tbody>
   * </table>
   * <b>Example:</b><br/>
   * {"bottle_id":"926305","expire_time":"2017-03-01","strip_num":"25","action":"action_code_analysis"}
 * <br/>
   */
  ACTION_CODE_ANALYSIS:RCTModule.ACTION_CODE_ANALYSIS,

  /**
   * the strip number
   */
  STRIP_NUM_BG:RCTModule.STRIP_NUM_BG,

  /**
   * the expire time
   */
  STRIP_EXPIRETIME_BG:RCTModule.STRIP_EXPIRETIME_BG,

  /**
   * the bottle id
   */
  BOTTLEID_BG:RCTModule.BOTTLEID_BG,

  /**
   * Indicates get all connected devices.
   */
  ACTION_GET_ALL_CONNECTED_DEVICES: RCTModule.ACTION_GET_ALL_CONNECTED_DEVICES
}
