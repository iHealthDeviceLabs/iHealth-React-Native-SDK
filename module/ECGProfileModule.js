/**
 *
 */
'use strict';


var { NativeModules } = require('react-native');

var RCTModule = NativeModules.ECGProfileModule;

/**
 * @module ECGProfileModule
 */
module.exports = {

  /**
   * The action value of event indicates the error of ECG device.
   */
  ACTION_ERROR_ECG:RCTModule.ACTION_ERROR_ECG,

  /**
   * The Key of error number of ECG device.
   */
  ERROR_NUM_ECG:RCTModule.ERROR_NUM_ECG,

  /**
   * The Key of error description of ECG device.
   */
  ERROR_DESCRIPTION_ECG:RCTModule.ERROR_DESCRIPTION_ECG,

  /**
   * The action value of event indicates the battery of ECG device.
   */
  ACTION_BATTERY_ECG:RCTModule.ACTION_BATTERY_ECG,

  /**
   * The Key of BATTERY_ECG for ECG device.
   */
  BATTERY_ECG:RCTModule.BATTERY_ECG,

  /**
   * sync time.
   */
  ACTION_SYSTIME:RCTModule.ACTION_SYSTIME,

  /**
   * Stop Measure.
   */
  ACTION_STOPMEASURE_ECG:RCTModule.ACTION_STOPMEASURE_ECG,

  /**
   * ACTION_MEASURE_WAVEData. <br>
   *
   * examples:<br/>
   * {"MEASURE_WAVEData":[-2.2548201084136963,-2.531399965286255,-2.8357763290405273,-3.1377346515655518,-3.4188733100891113,-3.680877685546875],"mac":"FC86F8390F66","type":"ECG3","action":"ACTION_MEASURE_WAVEData"}<br/>
   */
  ACTION_MEASURE_WAVEData:RCTModule.ACTION_MEASURE_WAVEData,

  MEASURE_WAVEData:RCTModule.MEASURE_WAVEData,
  /**
   * ACTION_MEASURE_ECGPulse. <br>
   * <b>Value range:</b><br/><br/>
   * examples:<br/>
   * {"MEASURE_ECGPulse":0,"action":"ACTION_MEASURE_ECGPulse","mac":"FC86F8390F66","type":"ECG3"}</b>
   */
  ACTION_MEASURE_ECGPulse:RCTModule.ACTION_MEASURE_ECGPulse,

  MEASURE_ECGPulse:RCTModule.MEASURE_ECGPulse,
  /**
   * ACTION_STARTSYNCDATA_ECGUSB. <br>
   * <b>Value range:</b><br/><br/>
   * <b>true: sufficiently</b><br/>
   * <b>false: insufficiently</b>
   */
  ACTION_STARTSYNCDATA_ECGUSB:RCTModule.ACTION_STARTSYNCDATA_ECGUSB,
  /**
   * ACTION_SYNCDATAINFO_ECGUSB. <br>
   * <b>Value range:</b><br/><br/>
   * <b>true: sufficiently</b><br/>
   * <b>false: insufficiently</b>
   */
  ACTION_SYNCDATAINFO_ECGUSB:RCTModule.ACTION_SYNCDATAINFO_ECGUSB,
  /**
   * DATAINFO. <br>
   * <b>Value range:</b><br/><br/>
   * <b>true: sufficiently</b><br/>
   * <b>false: insufficiently</b>
   */
  DATAINFO:RCTModule.DATAINFO,
  /**
   * ACTION_SYNCDATAPROGRESS_ECGUSB. <br>
   * <b>Value range:</b><br/><br/>
   * <b>true: sufficiently</b><br/>
   * <b>false: insufficiently</b>
   */
  ACTION_SYNCDATAPROGRESS_ECGUSB:RCTModule.ACTION_SYNCDATAPROGRESS_ECGUSB,
  /**
   * PROGRESS. <br>
   * <b>Value range:</b><br/><br/>
   * <b>true: sufficiently</b><br/>
   * <b>false: insufficiently</b>
   */
  PROGRESS:RCTModule.PROGRESS,
  /**
   * ACTION_DELETEDATA_ECGUSB. <br>
   * <b>Value range:</b><br/><br/>
   * <b>true: sufficiently</b><br/>
   * <b>false: insufficiently</b>
   */
  ACTION_DELETEDATA_ECGUSB:RCTModule.ACTION_DELETEDATA_ECGUSB,
  /**
   * Indicates get all connected devices.
   */
  ACTION_GET_ALL_CONNECTED_DEVICES: RCTModule.ACTION_GET_ALL_CONNECTED_DEVICES,
  /**
   * ECGUSB error action.
   */
  ACTION_ERROR_ECGUSB:RCTModule.ACTION_ERROR_ECGUSB,
  /**
   * ECGUSB error number.
   *
   * <b>Value range:</b><br/>
   *
   * <p>0:Query command timeout</p>
   * <p>1:Received SD card info is wrong.</p>
   * <p>2:Receive devce's error log: SD card error.</p>
   * <p>3:There is not enough space for ECG's offline data.</p>
   * <p>4:Receive wrong data.</p>
   * <p>5:Receive wrong data.</p>
   * <p>6:Receive data timeout.</p>
   * <p>7:Save file error.</p>
   * <p>8:Device is disconnected.</p>
   * <p>9:Format fail.</p>
   * <p>13:Format command timeout.</p>
   * <p>500:Command timeout.</p>
   */
  ERROR_NUM_ECGUSB:RCTModule.ERROR_NUM_ECGUSB,
  /**
   * ECGUSB error description.
   *
   * <b>Value range:</b><br/>
   *
   * <p>0:Query command timeout</p>
   * <p>1:Received SD card info is wrong.</p>
   * <p>2:Receive devce's error log: SD card error.</p>
   * <p>3:There is not enough space for ECG's offline data.</p>
   * <p>4:Receive wrong data.</p>
   * <p>5:Receive wrong data.</p>
   * <p>6:Receive data timeout.</p>
   * <p>7:Save file error.</p>
   * <p>8:Device is disconnected.</p>
   * <p>9:Format fail.</p>
   * <p>10:Splicing files fail.</p>
   * <p>11:get ECG data from cache fail.</p>
   * <p>12:get filter files fail by filename.</p>
   * <p>500:Command timeout.</p>
   */

  ERROR_DESCRIPTION_ECGUSB:RCTModule.ERROR_DESCRIPTION_ECGUSB,
  /**
   * Splice action.
   */
  ACTION_SPLICE:RCTModule.ACTION_SPLICE,
  /**
   * The key of splice result.
   */
  SPLICE_DATA:RCTModule.SPLICE_DATA,
  /**
   * The key of splice error description.
   */
  SPLICE_ERROR_DESCRIPTION:RCTModule.SPLICE_ERROR_DESCRIPTION,
  /**
   * Electrode status action.
   */
  ACTION_ELECTRODE_STATUS:RCTModule.ACTION_ELECTRODE_STATUS,
  /**
   * Electrode status. In fact, 2 and 3 will not send. Receive ACTION_MEASURE_WAVEData again means Electrode loss recovery. <br/>
   *
   * <b>Value range:</b><br/>
   * <p>1:Electrode Loss.</p>
   * <p>2:Electrode Loss Recovery.</p>
   * <p>3:Electrode Loss Timeout.</p>
   */
  ELECTRODE_STATUS:RCTModule.ELECTRODE_STATUS,
  /**
   * Get cache.
   * If app crashes during syncData, there may be some data not return to your callback (ACTION_SYNCDATAINFO_ECGUSB). Then you can call this api to get the unreturned data.
   */
  ACTION_GET_CACHE:RCTModule.ACTION_GET_CACHE,
  /**
   * The key of getCache result.
   */
  GET_CACHE_DATA:RCTModule.GET_CACHE_DATA,
  /**
   * Filter.
   * To analyze the SPLICE_DATA returned by synthesize api.
   */
  ACTION_FILTER:RCTModule.ACTION_FILTER,
  /**
   * The key of filter result.
   */
  FILTER_DATA:RCTModule.FILTER_DATA,
  /**
   * The key of filter error description. only for iOS
   */
  FILTER_ERROR_DESCRIPTION:RCTModule.FILTER_ERROR_DESCRIPTION

}
