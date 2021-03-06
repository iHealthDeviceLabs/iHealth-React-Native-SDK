/**
 * Created by lixuesong on 15/11/2016.
 */
'use strict';


var {NativeModules} = require('react-native');

var RCTModule = NativeModules.POProfileModule

/**
 * @module POProfileModule
 */
module.exports = {

  ACTION_BATTERY_PO: RCTModule.ACTION_BATTERY_PO,
  ACTION_LIVEDA_PO: RCTModule.ACTION_LIVEDA_PO,
  ACTION_RESULTDATA_PO: RCTModule.ACTION_RESULTDATA_PO,
  ACTION_OFFLINEDATA_PO: RCTModule.ACTION_OFFLINEDATA_PO,
  ACTION_NO_OFFLINEDATA_PO: RCTModule.ACTION_NO_OFFLINEDATA_PO,
  ACTION_ERROR_PO: RCTModule.ACTION_ERROR_PO,

  //Keys
  BATTERY_PO: RCTModule.BATTERY_PO,
  PULSE_WAVE_PO: RCTModule.PULSE_WAVE_PO,
  PI_PO: RCTModule.PI_PO,
  PULSE_STRENGTH_PO: RCTModule.PULSE_STRENGTH_PO,
  BLOOD_OXYGEN_PO: RCTModule.BLOOD_OXYGEN_PO,
  PULSE_RATE_PO: RCTModule.PULSE_RATE_PO,
  DATAID: RCTModule.DATAID,
  OFFLINEDATA_PO: RCTModule.OFFLINEDATA_PO,
  MEASURE_DATE_PO: RCTModule.MEASURE_DATE_PO,
  ACTION_GET_ALL_CONNECTED_DEVICES: RCTModule.ACTION_GET_ALL_CONNECTED_DEVICES
}
