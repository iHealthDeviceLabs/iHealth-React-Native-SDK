'use strict';


var { NativeModules } = require('react-native');

var RCTModule = NativeModules.BG1Module

/**
 * @module BG1Module
 */
module.exports = {
  Event_Notify: RCTModule.Event_Notify,

    /**
   * Send code to bg1 device
   * @param {string} QRCode the result string of scanning strip bottle(ignore if use GDH strip)
   * @param {int} stripType 1:GOD      2:GDH
   * @param {int} measureType 1:Test with Blood    2:Test with control liquid (CTL)
   */
	sendCode: function(QRCode, stripType, measureType) {
    if (RCTModule != null) {
      RCTModule.sendCode(QRCode, stripType, measureType);
    }else {
      console.log('~~~~~ RCTModule is null')
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
  }

}
