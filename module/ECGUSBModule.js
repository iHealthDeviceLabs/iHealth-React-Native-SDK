/**
 *
 */
'use strict';

var { NativeModules, Platform } = require('react-native');

var RCTModule = NativeModules.ECGUSBModule

/**
 * @module ECGUSBModule
 */
module.exports = {
  /**
   * Notify event type for ECG
   */
  Event_Notify: RCTModule.Event_Notify,

  /**
   * SyncTime.
   */
  syncData: function () {
    RCTModule.syncData()
  },

  /**
   * deleteData.
   */
  deleteData: function () {
    RCTModule.deleteData()
  },

  /**
   * Get all connected ECG device
   *
   * e.g. {"devices":"A4D5783FB00C"}
   */
  getAllConnectedDevices: function () {
    RCTModule.getAllConnectedDevices()
  },

  /**
  * Get device idps info (only for android)
  *
  * e.g. {"firmwareversion":"1.2.6","serialnumber":"F26265594E00","modenumber":"ECG3 11070","hardwareversion":"3.1.0","manufacture":"iHealth","accessoryname":"ECG recorder","protocolstring":"com.jiuan.ECGV10"}
  */
  getIdps: function () {
    RCTModule.getIdps()
  },

  /**
   * Splicing original files
  *
  * You can add a listener for ECGProfileModule.ACTION_SPLICE;
  *
  * success example:
  *
  * {"action":ECGProfileModule.ACTION_SPLICE,ECGProfileModule.SPLICE_DATA:{"DataFileName":"ECG_Total_Data_yyyyMMddHHmmss.dat","MarkFileName":"ECG_Total_Mark_yyyyMMddHHmmss.txt","StartTime":"yyyyMMddHHmmss","EndTime":"yyyyMMddHHmmss","FilePath":"xxx"},"type":"ECG3USB","mac":"F26265594E00"}
  *
  * fail example:
  *
  * {"action":ECGProfileModule.ACTION_SPLICE,ECGProfileModule.SPLICE_ERROR_DESCRIPTION:"fileNames's length is less than 1.","type":"ECG3USB","mac":""}
  *
  *
  */
  spliceData: function (filesNames){
    RCTModule.spliceData(filesNames)
  },


  /**
   * Get cache
   *
   * You can add a listener for ECGProfileModule.ACTION_GET_CACHE;
   *
   * result example:
   *
   * {"action":ECGProfileModule.ACTION_GET_CACHE,ECGProfileModule.GET_CACHE_DATA:[see ECGProfileModule.DATAINFO],"type":"ECG3USB","mac":"F26265594E00"}
   *
   */
  getCache: function () {
      RCTModule.getCache()
  },

  /**
   * Delete cache files
   * only android
   * if you get the cache files of ECG, you should clear the cache files
   */
  deleteCacheData: function (){
    if (Platform.OS === 'ios'){
      console.log('deleteCacheData is not available in iOS.')
    } else {
      RCTModule.deleteCacheData()
    }
  },

  /**
   * get ECG filter files by filename
   *
   * you can edit "ECG_Data_20180930123000" and "ECG_Mark_20180930123000"
   * or  can edit "ECG_Total_Data_20180930123000" and "ECG_Mark_Data_20180930123000"
   *
   * You can add a listener for ECGProfileModule.ACTION_FILTER;
   *
   * success example:
   *
   * {"action":ECGProfileModule.ACTION_FILTER,ECGProfileModule.FILTER_DATA:[{"SampleRate":249.999999,"FileName":"ECG_SDK_yyyyMMddHHmmss","StartTime":"yyyyMMddHHmmss","EndTime":"yyyyMMddHHmmss","FilePath":"xxx"}],"type":"ECG3USB","mac":"F26265594E00"}
   *
   * fail example:
   *
   * {"action":ECGProfileModule.ACTION_FILTER,ECGProfileModule.FILTER_ERROR_DESCRIPTION:"input parameter is invalid.","type":"ECG3USB","mac":"F26265594E00"}
   *
   *
   */
  getFilterDataByFileName: function (dataFileName ,markFileName){
      RCTModule.getFilterDataByFileName(dataFileName,markFileName)
  }
}
