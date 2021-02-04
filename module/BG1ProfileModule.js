'use strict';


var { NativeModules } = require('react-native');

var RCTModule = NativeModules.BG1ProfileModule

/**
 * @module BG1ProfileModule
 */
module.exports = {

  /**
   * Callback indicating the send code result of bg1 device.
   */
  ACTION_BG1_SENDCODE_RESULT:RCTModule.ACTION_BG1_SENDCODE_RESULT,

  /**
   * The send code result of bg1 device.
   * value : 0 success; other error
   */
  BG1_SENDCODE_RESULT:RCTModule.BG1_SENDCODE_RESULT,

  /**
   * Callback indicating the error of Bg1 device.
   */
  ACTION_BG1_MEASURE_ERROR:RCTModule.ACTION_BG1_MEASURE_ERROR,

  /**
   * Flag Error number of Bg1 device.
   */
  BG1_MEASURE_ERROR:RCTModule.BG1_MEASURE_ERROR,

  /**
   * Callback indicating the strip in action.
   */
  ACTION_BG1_MEASURE_STRIP_IN:RCTModule.ACTION_BG1_MEASURE_STRIP_IN,

  /**
   * Callback indicating the get blood action.
   */
  ACTION_BG1_MEASURE_GET_BLOOD:RCTModule.ACTION_BG1_MEASURE_GET_BLOOD,

  /**
   * Callback indicating the measure result.
   */
  ACTION_BG1_MEASURE_RESULT:RCTModule.ACTION_BG1_MEASURE_RESULT,

  /**
   * The measure result
   * Range : 20-600 mg/dL
   */
  BG1_MEASURE_RESULT:RCTModule.BG1_MEASURE_RESULT,

  /**
   * Callback indicating the strip out action.
   */
  ACTION_BG1_MEASURE_STRIP_OUT:RCTModule.ACTION_BG1_MEASURE_STRIP_OUT,

  /**
   * Callback indicating the Bg1 device get in standby mode.
   */
  ACTION_BG1_MEASURE_STANDBY:RCTModule.ACTION_BG1_MEASURE_STANDBY,

  /**
   * the data id
   */
  DATA_ID:RCTModule.DATA_ID,

  /**
   * Callback indicating the code analysis result.
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
  BOTTLEID_BG:RCTModule.BOTTLEID_BG

}
