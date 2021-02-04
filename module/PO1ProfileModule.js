/**
 * Created by lixuesong on 15/11/2016.
 */
'use strict';


var {NativeModules} = require('react-native');

var RCTModule = NativeModules.PO1ProfileModule

/**
 * @module POProfileModule
 */
module.exports = {

  //Actions
  ACTION_BO_MEASUREMENT: RCTModule.ACTION_BO_MEASUREMENT,
  ACTION_GET_BATTERY: RCTModule.ACTION_GET_BATTERY,
  ACTION_ERROR_PO1: RCTModule.ACTION_ERROR_PO1,
  ACTION_GET_ALL_CONNECTED_DEVICES: RCTModule.ACTION_GET_ALL_CONNECTED_DEVICES,

  //Keys
  ERROR_ID: RCTModule.ERROR_ID,
  ERROR_DESCRIPTION: RCTModule.ERROR_DESCRIPTION,
  BATTERY: RCTModule.BATTERY, 
  STATUS: RCTModule.STATUS,
  BLOOD_OXYGEN: RCTModule.BLOOD_OXYGEN,
  PULSE: RCTModule.PULSE,
  PULSE_FORCE: RCTModule.PULSE_FORCE,
  PI: RCTModule.PI,
  WAVE: RCTModule.WAVE,
  
}
