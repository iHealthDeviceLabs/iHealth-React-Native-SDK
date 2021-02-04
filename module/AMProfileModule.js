/**
 * Created by Jeepend on 15/11/2016.
 */
'use strict';


var {NativeModules} = require('react-native');

var RCTModule = NativeModules.AMProfileModule

/**
 * @module AMProfileModule
 */
module.exports = {

  ACTION_ERROR_AM: RCTModule.ACTION_ERROR_AM,
  ACTION_RESET_AM: RCTModule.ACTION_RESET_AM,
  ACTION_USERID_AM: RCTModule.ACTION_USERID_AM,
  ACTION_SET_USERID_SUCCESS_AM: RCTModule.ACTION_SET_USERID_SUCCESS_AM,
  ACTION_SYNC_TIME_SUCCESS_AM: RCTModule.ACTION_SYNC_TIME_SUCCESS_AM,
  ACTION_SET_USERINFO_SUCCESS_AM: RCTModule.ACTION_SET_USERINFO_SUCCESS_AM,
  ACTION_GET_USERINFO_AM: RCTModule.ACTION_GET_USERINFO_AM,
  ACTION_GET_ALARMNUM_AM: RCTModule.ACTION_GET_ALARMNUM_AM,
  ACTION_GET_ALARMINFO_AM: RCTModule.ACTION_GET_ALARMINFO_AM,
  ACTION_SET_ALARMINFO_SUCCESS_AM: RCTModule.ACTION_SET_ALARMINFO_SUCCESS_AM,
  ACTION_DELETE_ALARM_SUCCESS_AM: RCTModule.ACTION_DELETE_ALARM_SUCCESS_AM,
  ACTION_GET_ACTIVITY_REMIND_AM: RCTModule.ACTION_GET_ACTIVITY_REMIND_AM,
  ACTION_SET_ACTIVITYREMIND_SUCCESS_AM: RCTModule.ACTION_SET_ACTIVITYREMIND_SUCCESS_AM,
  ACTION_SYNC_ACTIVITY_DATA_AM: RCTModule.ACTION_SYNC_ACTIVITY_DATA_AM,
  ACTION_SYNC_SLEEP_DATA_AM: RCTModule.ACTION_SYNC_SLEEP_DATA_AM,
  ACTION_SYNC_STAGE_DATA_AM: RCTModule.ACTION_SYNC_STAGE_DATA_AM,
  ACTION_QUERY_STATE_AM: RCTModule.ACTION_QUERY_STATE_AM,
  ACTION_SYNC_REAL_DATA_AM: RCTModule.ACTION_SYNC_REAL_DATA_AM,
  ACTION_SET_BMR_SUCCESS_AM: RCTModule.ACTION_SET_BMR_SUCCESS_AM,
  ACTION_GET_SWIMINFO_AM: RCTModule.ACTION_GET_SWIMINFO_AM,
  ACTION_SET_SWIMINFO_AM: RCTModule.ACTION_SET_SWIMINFO_AM,
  ACTION_GET_RANDOM_AM: RCTModule.ACTION_GET_RANDOM_AM,
  ACTION_SET_HOUR_MODE_SUCCESS_AM: RCTModule.ACTION_SET_HOUR_MODE_SUCCESS_AM,
  ACTION_GET_HOUR_MODE_AM: RCTModule.ACTION_GET_HOUR_MODE_AM,
  ACTION_SET_DEVICE_MODE_AM: RCTModule.ACTION_SET_DEVICE_MODE_AM,
  ACTION_CLOUD_BINDING_AM_SUCCESS: RCTModule.ACTION_CLOUD_BINDING_AM_SUCCESS,
  ACTION_CLOUD_BINDING_AM_FAIL: RCTModule.ACTION_CLOUD_BINDING_AM_FAIL,
  ACTION_CLOUD_UNBINDING_AM_SUCCESS: RCTModule.ACTION_CLOUD_UNBINDING_AM_SUCCESS,
  ACTION_CLOUD_UNBINDING_AM_FAIL: RCTModule.ACTION_CLOUD_UNBINDING_AM_FAIL,
  ACTION_CLOUD_SEARCH_AM: RCTModule.ACTION_CLOUD_SEARCH_AM,
  ACTION_CLOUD_SEARCH_FAIL_AM: RCTModule.ACTION_CLOUD_SEARCH_FAIL_AM,
  ACTION_SET_PICTURE_SUCCESS_AM: RCTModule.ACTION_SET_PICTURE_SUCCESS_AM,
  ACTION_GET_PICTURE_AM: RCTModule.ACTION_GET_PICTURE_AM,

  // Keys
  ERROR_NUM_AM: RCTModule.ERROR_NUM_AM,
  ERROR_ID_ILLEGAL_ARGUMENT: RCTModule.ERROR_ID_ILLEGAL_ARGUMENT,
  ERROR_ID_VERSION_NOT_SUPPORT: RCTModule.ERROR_ID_VERSION_NOT_SUPPORT,
  ERROR_DESCRIPTION_AM: RCTModule.ERROR_DESCRIPTION_AM,
  RESET_AM: RCTModule.RESET_AM,
  USERID_AM: RCTModule.USERID_AM,
  GET_USER_AGE_AM: RCTModule.GET_USER_AGE_AM,
  GET_USER_STEP_AM: RCTModule.GET_USER_STEP_AM,
  GET_USER_HEIGHT_AM: RCTModule.GET_USER_HEIGHT_AM,
  GET_USER_SEX_AM: RCTModule.GET_USER_SEX_AM,
  GET_USER_WEIGHT_AM: RCTModule.GET_USER_WEIGHT_AM,
  GET_USER_UNIT_AM: RCTModule.GET_USER_UNIT_AM,
  GET_USER_TARGET1_AM: RCTModule.GET_USER_TARGET1_AM,
  GET_USER_TARGET2_AM: RCTModule.GET_USER_TARGET2_AM,
  GET_USER_TARGET3_AM: RCTModule.GET_USER_TARGET3_AM,
  GET_USER_SWIMTARGET_AM: RCTModule.GET_USER_SWIMTARGET_AM,
  GET_ALARMNUM_AM: RCTModule.GET_ALARMNUM_AM,
  GET_ALARMNUM_ID_AM: RCTModule.GET_ALARMNUM_ID_AM,
  GET_ALARM_CLOCK_DETAIL: RCTModule.GET_ALARM_CLOCK_DETAIL,
  GET_ALARM_ID_AM: RCTModule.GET_ALARM_ID_AM,
  GET_ALARM_TIME_AM: RCTModule.GET_ALARM_TIME_AM,
  GET_ALARM_ISREPEAT_AM: RCTModule.GET_ALARM_ISREPEAT_AM,
  GET_ALARM_WEEK_AM: RCTModule.GET_ALARM_WEEK_AM,
  GET_ALARM_WEEK_SUNDAY_AM: RCTModule.GET_ALARM_WEEK_SUNDAY_AM,
  GET_ALARM_WEEK_MONDAY_AM: RCTModule.GET_ALARM_WEEK_MONDAY_AM,
  GET_ALARM_WEEK_TUESDAY_AM: RCTModule.GET_ALARM_WEEK_TUESDAY_AM,
  GET_ALARM_WEEK_WEDNESDAY_AM: RCTModule.GET_ALARM_WEEK_WEDNESDAY_AM,
  GET_ALARM_WEEK_THURSDAY_AM: RCTModule.GET_ALARM_WEEK_THURSDAY_AM,
  GET_ALARM_WEEK_FRIDAY_AM: RCTModule.GET_ALARM_WEEK_FRIDAY_AM,
  GET_ALARM_WEEK_SATURDAY_AM: RCTModule.GET_ALARM_WEEK_SATURDAY_AM,
  GET_ALARM_ISON_AM: RCTModule.GET_ALARM_ISON_AM,
  GET_ACTIVITY_REMIND_TIME_AM: RCTModule.GET_ACTIVITY_REMIND_TIME_AM,
  GET_ACTIVITY_REMIND_ISON_AM: RCTModule.GET_ACTIVITY_REMIND_ISON_AM,
  /**
   * The key of the whole activity data.("activity")
   */
  SYNC_ACTIVITY_DATA_AM: RCTModule.SYNC_ACTIVITY_DATA_AM,
  /**
   * The key of the time for every 5 min activity data.("time")<br/>
   * <b>Value format: </b><br/>
   * yyyy-MM-dd HH:mm:ss<br/>
   * <b>Example: </b><br/>
   * 2016-07-18 09:00:00
   */
  SYNC_ACTIVITY_DATA_TIME_AM: RCTModule.SYNC_ACTIVITY_DATA_TIME_AM,
  /**
   * The key of the step number for every 5 min activity data.("step")<br/>
   * <b>Value range:</b><br/>
   * 0-4294967295(0xFFFFFFFF)
   */
  SYNC_ACTIVITY_DATA_STEP_AM: RCTModule.SYNC_ACTIVITY_DATA_STEP_AM,
  /**
   * The key of the step length for every 5 min activity data.("stepsize")<br/>
   * <b>Value range:</b><br/>
   * 0-255(0xFF)
   */
  SYNC_ACTIVITY_DATA_STEP_LENGTH_AM: RCTModule.SYNC_ACTIVITY_DATA_STEP_LENGTH_AM,
  /**
   * The key of the calorie for every 5 min activity data.("calorie")<br/>
   * <b>Value range:</b><br/>
   * 0-65535(0xFFFF)
   */
  SYNC_ACTIVITY_DATA_CALORIE_AM: RCTModule.SYNC_ACTIVITY_DATA_CALORIE_AM,
  /**
   * The key of the whole data for every 5 min activity data.("activity_each_data")
   */
  SYNC_ACTIVITY_EACH_DATA_AM: RCTModule.SYNC_ACTIVITY_EACH_DATA_AM,
  /**
   * The key of the whole sleep data.("sleep")
   */
  SYNC_SLEEP_DATA_AM: RCTModule.SYNC_SLEEP_DATA_AM,
  /**
   * The key of the each 5 minute's sleep time.("time")<br/>
   * <b>Value format:</b><br/>
   * yyyy-MM-dd HH:mm:ss
   */
  SYNC_SLEEP_DATA_TIME_AM: RCTModule.SYNC_SLEEP_DATA_TIME_AM,
  /**
   * The key of the each 5 minute's sleep level.("level")<br/>
   * <b>Value:</b><br/>
   * <ul>
   * <li>0 indicates awake</li>
   * <li>1 indicates light sleep</li>
   * <li>2 indicates deep sleep</li>
   * </ul>
   */
  SYNC_SLEEP_DATA_LEVEL_AM: RCTModule.SYNC_SLEEP_DATA_LEVEL_AM,
  SYNC_SLEEP_EACH_DATA_AM: RCTModule.SYNC_SLEEP_EACH_DATA_AM,
  /**
   * The key of data array of the stage data.("stage_data")
   */
  SYNC_STAGE_DATA_AM: RCTModule.SYNC_STAGE_DATA_AM,
  SYNC_STAGE_DATA_TYPE_AM: RCTModule.SYNC_STAGE_DATA_TYPE_AM,
  /**
   * Type of work out.("stage_data_type_workout")
   */
  SYNC_STAGE_DATA_TYPE_WORKOUT_AM: RCTModule.SYNC_STAGE_DATA_TYPE_WORKOUT_AM,
  /**
   * Type of sleep.("sleep")
   */
  SYNC_STAGE_DATA_TYPE_SLEEP_AM: RCTModule.SYNC_STAGE_DATA_TYPE_SLEEP_AM,
  /**
   * Type of swim.("swim")
   */
  SYNC_STAGE_DATA_TYPE_SWIM_AM: RCTModule.SYNC_STAGE_DATA_TYPE_SWIM_AM,
  /**
   * Type of page view summary.("page_view_summary")
   */
  SYNC_STAGE_DATA_TYPE_PAGE_VIEW_SUMMARY: RCTModule.SYNC_STAGE_DATA_TYPE_PAGE_VIEW_SUMMARY,
  /**
   * The key of stage report stop time.("stoptime")<br/>
   * <b>Value format:</b><br/>
   * yyyy-MM-dd HH:mm:ss
   */
  SYNC_STAGE_DATA_STOP_TIME_AM: RCTModule.SYNC_STAGE_DATA_STOP_TIME_AM,
  /**
   * The key of stage report used time(in minutes).("usedtime")<br/>
   * <b>Value range:</b><br/>
   * 0-65535(0xFFFF)
   */
  SYNC_STAGE_DATA_USED_TIME_AM: RCTModule.SYNC_STAGE_DATA_USED_TIME_AM,
  /**
   * The key of the step number of work out.("stage_data_workout_step")<br/>
   * <b>Value range:</b><br/>
   * 0-4294967295(0xFFFFFFFF)
   */
  SYNC_STAGE_DATA_WORKOUT_STEP_AM: RCTModule.SYNC_STAGE_DATA_WORKOUT_STEP_AM,
  /**
   * The key of the distance.("stage_data_distance")<br/>
   * It's string type<br/>
   * <b>Value format&range:</b><br/>
   * "123.456"("0.0"-"255.255"(0xFF.0xFF))
   */
  SYNC_STAGE_DATA_DISTANCE_AM: RCTModule.SYNC_STAGE_DATA_DISTANCE_AM,
  /**
   * The key of the calorie.("calorie")<br/>
   * <b>Value range:</b><br/>
   * 0-65535(0xFFFF)
   */
  SYNC_STAGE_DATA_CALORIE_AM: RCTModule.SYNC_STAGE_DATA_CALORIE_AM,
  /**
   * The key of sleep efficiency.("sleepefficiency")<br/>
   * <b>Value range:</b><br/>
   * 0.0-100.0
   */
  SYNC_STAGE_DATA_SLEEP_EFFICIENCY_AM: RCTModule.SYNC_STAGE_DATA_SLEEP_EFFICIENCY_AM,
  /**
   * The key of whether need to extend sleep 50 minutes or not.("is50min")<br/>
   * <b>Value:</b><br/>
   * <ul>
   * <li>0 indicates not need to extend.</li>
   * <li>1 indicates need to extend.</li>
   * </ul>
   */
  SYNC_STAGE_DATA_SLEEP_IS50MIN_AM: RCTModule.SYNC_STAGE_DATA_SLEEP_IS50MIN_AM,
  /**
   * The key of swim stroke.("swimming stroke")<br/>
   * <b>Value:</b><br/>
   * <ul>
   * <li>0 indicates freestyle.</li>
   * <li>1 indicates breaststroke.</li>
   * <li>2 indicates backstroke.</li>
   * <li>5 indicates unknown.</li>
   * </ul>
   */
  SYNC_STAGE_DATA_SWIM_STROKE_AM: RCTModule.SYNC_STAGE_DATA_SWIM_STROKE_AM,
  /**
   * The key of swim arm pulling time.("number of strokes")<br/>
   * <b>Value range:</b><br/>
   * 0-65535(0xFFFF)
   */
  SYNC_STAGE_DATA_SWIM_PULL_TIMES_AM: RCTModule.SYNC_STAGE_DATA_SWIM_PULL_TIMES_AM,
  /**
   * The key of swim round number.("number of turns")<br/>
   * <b>Value range:</b><br/>
   * 0-255(0xFF)
   */
  SYNC_STAGE_DATA_SWIM_TURNS_AM: RCTModule.SYNC_STAGE_DATA_SWIM_TURNS_AM,
  /**
   * The key of the swimming pool length.("stage_data_swimpool_length")<br/>
   * <b>Value range:</b><br/>
   * 0-255(0xFF)
   */
  SYNC_STAGE_DATA_SWIMPOOL_LENGTH_AM: RCTModule.SYNC_STAGE_DATA_SWIMPOOL_LENGTH_AM,
  /**
   * The key of the time of cut in swim and begin swim(in minutes).("stage_data_cutindif")<br/>
   * <b>Value range:</b><br/>
   * 0-65535(0xFFFF)
   */
  SYNC_STAGE_DATA_SWIM_CUTINDIF_AM: RCTModule.SYNC_STAGE_DATA_SWIM_CUTINDIF_AM,
  /**
   * The key of the time of cut out swim and end swim(in minutes).("stage_data_cutoutdif")<br/>
   * <b>Value range:</b><br/>
   * 0-65535(0xFFFF)
   */
  SYNC_STAGE_DATA_SWIM_CUTOUTDIF_AM: RCTModule.SYNC_STAGE_DATA_SWIM_CUTOUTDIF_AM,
  /**
   * The key of the swim process flag.("stage_data_processflag")<br/>
   * <b>Value:</b><br/>
   * <ul>
   * <li>0 indicates swim in process.</li>
   * <li>1 indicates start of swimming.</li>
   * <li>2 indicates end of swimming.</li>
   * <li>3 indicates the swim is only a single round.</li>
   * </ul>
   */
  SYNC_STAGE_DATA_SWIM_PROCESSFLAG_AM: RCTModule.SYNC_STAGE_DATA_SWIM_PROCESSFLAG_AM,
  /**
   * The key of the date of page view summary.("stage_data_view_summary_date")<br/>
   * <b>Value format:</b><br/>
   * yyyy-MM-dd
   */
  SYNC_STAGE_DATA_VIEW_SUMMARY_DATE_AM: RCTModule.SYNC_STAGE_DATA_VIEW_SUMMARY_DATE_AM,
  /**
   * The key of the count that user view the step page.("stage_data_view_summary_step")<br/>
   * <b>Value range:</b><br/>
   * 0-65535(0xFFFF)
   */
  SYNC_STAGE_DATA_VIEW_SUMMARY_STEP_AM: RCTModule.SYNC_STAGE_DATA_VIEW_SUMMARY_STEP_AM,
  /**
   * The key of the count that user view the distance page.("stage_data_view_summary_distance")<br/>
   * <b>Value range:</b><br/>
   * 0-65535(0xFFFF)
   */
  SYNC_STAGE_DATA_VIEW_SUMMARY_DISTANCE_AM: RCTModule.SYNC_STAGE_DATA_VIEW_SUMMARY_DISTANCE_AM,
  /**
   * The key of the count that user view the calorie page.("stage_data_view_summary_calorie")<br/>
   * <b>Value range:</b><br/>
   * 0-65535(0xFFFF)
   */
  SYNC_STAGE_DATA_VIEW_SUMMARY_CALORIE_AM: RCTModule.SYNC_STAGE_DATA_VIEW_SUMMARY_CALORIE_AM,
  /**
   * The key of the count that user view the activity target page.("stage_data_view_summary_target")<br/>
   * <b>Value range:</b><br/>
   * 0-65535(0xFFFF)
   */
  SYNC_STAGE_DATA_VIEW_SUMMARY_TARGET_AM: RCTModule.SYNC_STAGE_DATA_VIEW_SUMMARY_TARGET_AM,
  /**
   * The key of the count that user view the swim summary page.("stage_data_view_summary_swim")<br/>
   * <b>Value range:</b><br/>
   * 0-65535(0xFFFF)
   */
  SYNC_STAGE_DATA_VIEW_SUMMARY_SWIM_AM: RCTModule.SYNC_STAGE_DATA_VIEW_SUMMARY_SWIM_AM,
  /**
   * The key of state information.("query_state")<br/>
   * <b>Value:</b><br/>
   * <ul>
   * <li>0 indicates waist</li>
   * <li>1 indicates wrist</li>
   * <li>2 indicates sleep</li>
   * </ul>
   */
  QUERY_STATE_AM: RCTModule.QUERY_STATE_AM,
  /**
   * The key of battery level.("battery")<br/>
   * <b>Value range:</b><br/>
   * 0-10(10 indicates full)
   */
  QUERY_BATTERY_AM: RCTModule.QUERY_BATTERY_AM,
  /**
   * The key of the real step count.("step")<br/>
   * <b>Value range:</b><br/>
   * 0-4294967295(0xFFFFFFFF)
   */
  SYNC_REAL_STEP_AM: RCTModule.SYNC_REAL_STEP_AM,
  /**
   * The key of the real calorie(not including BMR).("calorie")<br/>
   * <b>Value range:</b><br/>
   * 0-65535(0xFFFF)
   */
  SYNC_REAL_CALORIE_AM: RCTModule.SYNC_REAL_CALORIE_AM,
  /**
   * The key of the real summary calorie(including BMR).("totalcalories")<br/>
   * <b>Value range:</b><br/>
   * 0-65535 + BMR(0xFFFF + BMR)
   */
  SYNC_REAL_TOTALCALORIE_AM: RCTModule.SYNC_REAL_TOTALCALORIE_AM,
  /**
   * The key of swimming lane length.("get_swimlane_length")<br/>
   * <b>Value range:</b><br/>
   * 0-255(0xFF)
   */
  GET_SWIMLANE_LENGTH_AM: RCTModule.GET_SWIMLANE_LENGTH_AM,
  /**
   * The key of whether the swim function is open or not.("get_swim_switch_am")<br/>
   * <b>Value:</b><br/>
   * <ul>
   * <li>0 indicates swim function closed</li>
   * <li>1/2 indicates swim function open</li>
   * </ul>
   */
  GET_SWIM_SWITCH_AM: RCTModule.GET_SWIM_SWITCH_AM,
  /**
   * The key of the hour part of cut out swim function.("get_swim_cutout_hour_am")<br/>
   * <b>Value range:</b><br/>
   * 0-255(0xFF)
   */
  GET_SWIM_CUTOUT_HOUR_AM: RCTModule.GET_SWIM_CUTOUT_HOUR_AM,
  /**
   * The key of the minute part of cut out swim function.("get_swim_cutout_min_am")<br/>
   * <b>Value range:</b><br/>
   * 0-255(0xFF)
   */
  GET_SWIM_CUTOUT_MINUTE_AM: RCTModule.GET_SWIM_CUTOUT_MINUTE_AM,
  /**
   * The key of swim unit type.("get_swim_unit_am")<br/>
   * <b>Value:</b><br/>
   * <ul>
   * <li>{@link module:AMProfileModule.AM_SET_UNIT_METRIC AMProfileModule.AM_SET_UNIT_METRIC(1)}</li>
   * <li>{@link module:AMProfileModule.AM_SET_UNIT_IMPERIAL_STANDARD AMProfileModule.AM_SET_UNIT_IMPERIAL_STANDARD(0)}</li>
   * </ul>
   */
  GET_SWIM_UNIT_AM: RCTModule.GET_SWIM_UNIT_AM,
  /**
   * The key of the random number sent to device.("random")<br/>
   * The value will be a 6-long number decimal string.<br/>
   * <b>Value range:</b><br/>
   * "000000"-"999999"
   */
  GET_RANDOM_AM: RCTModule.GET_RANDOM_AM,
  AM_SWITCH_OPEN: RCTModule.AM_SWITCH_OPEN,
  AM_SWITCH_CLOSE: RCTModule.AM_SWITCH_CLOSE,
  AM_SWITCH_REPEAT: RCTModule.AM_SWITCH_REPEAT,
  AM_SEITCH_NOT_REPEAT: RCTModule.AM_SEITCH_NOT_REPEAT,
  /**
   * The value indicates male.(1)
   */
  AM_SET_MALE: RCTModule.AM_SET_MALE,
  /**
   * The value indicates female.(0)
   */
  AM_SET_FEMALE: RCTModule.AM_SET_FEMALE,
  /**
   * The value indicates metric unit type(kilometre/metre).(1)
   */
  AM_SET_UNIT_METRIC: RCTModule.AM_SET_UNIT_METRIC,
  /**
   * The value indicates imperial standard unit type(miles/yard).(0)
   */
  AM_SET_UNIT_IMPERIAL_STANDARD: RCTModule.AM_SET_UNIT_IMPERIAL_STANDARD,
  /**
   * The value indicates whole world 12 hour mode(0)
   */
  AM_SET_12_HOUR_MODE: RCTModule.AM_SET_12_HOUR_MODE,
  /**
   * The value indicates whole world 24 hour mode(1)
   */
  AM_SET_24_HOUR_MODE: RCTModule.AM_SET_24_HOUR_MODE,
  /**
   * The value indicates Europe world 12 hour mode(3)
   */
  AM_SET_EUROPE_12_HOUR_MODE: RCTModule.AM_SET_EUROPE_12_HOUR_MODE,
  /**
   * The value indicates Europe world 24 hour mode(5)
   */
  AM_SET_EUROPE_24_HOUR_MODE: RCTModule.AM_SET_EUROPE_24_HOUR_MODE,
  /**
   * The value indicates except Europe world 12 hour mode(2)
   */
  AM_SET_EXCEPT_EUROPE_12_HOUR_MODE: RCTModule.AM_SET_EXCEPT_EUROPE_12_HOUR_MODE,
  /**
   * The value indicates except Europe world 24 hour mode(4)
   */
  AM_SET_EXCEPT_EUROPE_24_HOUR_MODE: RCTModule.AM_SET_EXCEPT_EUROPE_24_HOUR_MODE,
  /**
   * The key of the time mdoe.<br/>
   * <b>Value:</b><br/>
   * <ul>
   * <li>{@link module:AMProfileModule.AM_SET_12_HOUR_MODE AMProfileModule.AM_SET_12_HOUR_MODE(0)}</li>
   * <li>{@link module:AMProfileModule.AM_SET_24_HOUR_MODE AMProfileModule.AM_SET_24_HOUR_MODE(1)}</li>
   * <li>{@link module:AMProfileModule.AM_SET_EXCEPT_EUROPE_12_HOUR_MODE AMProfileModule.AM_SET_EXCEPT_EUROPE_12_HOUR_MODE(2)}</li>
   * <li>{@link module:AMProfileModule.AM_SET_EUROPE_12_HOUR_MODE AMProfileModule.AM_SET_EUROPE_12_HOUR_MODE(3)}</li>
   * <li>{@link module:AMProfileModule.AM_SET_EXCEPT_EUROPE_24_HOUR_MODE AMProfileModule.AM_SET_EXCEPT_EUROPE_24_HOUR_MODE(4)}</li>
   * <li>{@link module:AMProfileModule.AM_SET_EUROPE_24_HOUR_MODE AMProfileModule.AM_SET_EUROPE_24_HOUR_MODE(5)}</li>
   * </ul>
   */
  GET_HOUR_MODE_AM: RCTModule.GET_HOUR_MODE_AM,
  /**
   * Indicates device is sleep mode.(0)
   */
  AM_DEVICE_MODE_SLEEP: RCTModule.AM_DEVICE_MODE_SLEEP,
  /**
   * Indicates device is activity mode.(1)
   */
  AM_DEVICE_MODE_ACTIVITY: RCTModule.AM_DEVICE_MODE_ACTIVITY,
  /**
   * Indicates device is flight mode.(2)
   */
  AM_DEVICE_MODE_FLIGHT: RCTModule.AM_DEVICE_MODE_FLIGHT,
  /**
   * Indicates device is driving mode.(3)
   */
  AM_DEVICE_MODE_DRIVING: RCTModule.AM_DEVICE_MODE_DRIVING,
  CLOUD_SEARCH_AM: RCTModule.CLOUD_SEARCH_AM,
  /**
   * The key of the MD5 hash of the data.("dataID")
   */
  DATAID: RCTModule.DATAID,
  /**
   * The key of the picture index.("get_picture_am")<br/>
   * <b>Value:</b><br/>
   * <ul>
   * <li>0 indicates the frog picture.</li>
   * <li>1 indicates the default picture.</li>
   * </ul>
   */
  GET_PICTURE_AM: RCTModule.GET_PICTURE_AM,

  /**
   * Indicates get all connected devices.
   */
  ACTION_GET_ALL_CONNECTED_DEVICES: RCTModule.ACTION_GET_ALL_CONNECTED_DEVICES
}
