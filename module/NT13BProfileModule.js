'use strict';

var { NativeModules } = require('react-native');

var RCTModule = NativeModules.NT13BProfileModule

/**
 * @module NT13BProfileModule
 */
module.exports = {
  ACTION_MEASUREMENT_RESULT: RCTModule.ACTION_MEASUREMENT_RESULT,
  UNIT_FLAG: RCTModule.UNIT_FLAG,
  RESULT: RCTModule.RESULT,
  TS_FLAG: RCTModule.TS_FLAG,
  TS: RCTModule.TS,
  THERMOMETER_TYPE_FLAG: RCTModule.THERMOMETER_TYPE_FLAG,
  THERMOMETER_TYPE: RCTModule.THERMOMETER_TYPE,

  ACTION_GET_ALL_CONNECTED_DEVICES: RCTModule.ACTION_GET_ALL_CONNECTED_DEVICES
}
