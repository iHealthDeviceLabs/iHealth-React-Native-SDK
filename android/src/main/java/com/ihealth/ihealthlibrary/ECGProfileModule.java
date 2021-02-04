package com.ihealth.ihealthlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.module.annotations.ReactModule;
import com.ihealth.communication.control.ECG3Profile;
import com.ihealth.communication.manager.iHealthDevicesManager;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Nullable;

/**
 * Created by zhaoyongguang on 2018/1/22.
 */
@ReactModule(name = "ECGProfileModule")
public class ECGProfileModule extends ReactContextBaseJavaModule {
    private static final String modelName = "ECGProfileModule";

    private static final String ACTION_ERROR_ECG = "ACTION_ERROR_ECG";
    private static final String ERROR_NUM_ECG = "ERROR_NUM_ECG";
    private static final String ERROR_DESCRIPTION_ECG = "ERROR_DESCRIPTION_ECG";
    private static final String ACTION_BATTERY_ECG = "ACTION_BATTERY_ECG";
    private static final String BATTERY_ECG = "BATTERY_ECG";
    private static final String ACTION_SYSTIME = "ACTION_SYSTIME";
    private static final String ACTION_STOPMEASURE_ECG = "ACTION_STOPMEASURE_ECG";
    public static final String ACTION_MEASURE_WAVEData = "ACTION_MEASURE_WAVEData";
    public static final String ACTION_MEASURE_ECGPulse = "ACTION_MEASURE_ECGPulse";

    /**
     * Callback indicating sync offline data from ECG3_USB.
     * <ul>
     * KeyList:
     * <ul>
     * <li>{@link #OFFLINE_DATA_SYNC_PROGRESS} </li>
     * <li>{@link #OFFLINE_DATA_SYNC_FINISH} </li>
     * <li>{@link #OFFLINE_DATAS}  </li>
     * </ul>
     * </ul>
     * <p>
     * <p>
     * If {@link #OFFLINE_DATA_SYNC_FINISH  sync finish }, you can get filtered data info with {@link #OFFLINE_DATAS}.
     * <br />eg.<br />
     * {<br />
     * <span> </span>&nbsp;&nbsp;&nbsp;&nbsp;"offline_data_sync_progress": 100,<br />
     * <span> </span>&nbsp;&nbsp;&nbsp;&nbsp;"offline_data_sync_finish": true,<br />
     * <span> </span>&nbsp;&nbsp;&nbsp;&nbsp;"offline_datas": [{<br />
     * <span> </span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"offline_data_file_name": "20160420022253",<br />
     * <span> </span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"offline_data_simpling_rate": 248,<br />
     * <span> </span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"offline_data_start_time": "20160420022253",<br />
     * <span> </span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"offline_data_finish_time": "20160420022357",<br />
     * <span> </span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"offline_data_flag": 7<br />
     * <span> </span>}]<br />
     * }<br />
     * <p>
     * <p>All the filtered data is stored in the current app`s internal storage {@link iHealthDevicesManager#TYPE_ECG3_USB ECG3_USB} directory.
     * <b>And the data fields are in the order of MSB to LSB. Where MSB = Most Significant Bit and LSB = Least Significant Bit.</b>
     * <p>The definition of those data as bellow 1~7:
     * <ol>
     * <li>Filtered ECG data, Short type, every 2 bytes represent a simpling value. The target file: {@link ECGAnalyseResult_[fileName].txt} That is {@link #PREFIX_FILTERED_DATA} + fileName + .txt
     * <li>ECG HR Information EveryHour, Int type, every 4 bytes represent a value, and every 4 value as a group. Act as  Maximum HR/Minimum HR/Average HR/Total heart beat of every hour. The target file: {@link ECGHREveryHour_[fileName].txt} That is {@link #PREFIX_HR_EVERY_HOUR} + fileName + .txt
     * <li>ECG HR Information for Day, Int type, every 4 bytes represent a value, and every 4 value as a group. Act as  Maximum HR/Minimum HR/Average HR/Total heart beat of the day. The target file: {@link ECGDetail_[fileName].txt} That is {@link #PREFIX_HR_DETAIL} + fileName + .txt
     * <li>Abnormal points filtered by algorithm, Int type, every 4 bytes represent a value. The target file: {@link ECGOBByFilter_[fileName].txt} That is {@link #PREFIX_OB_BY_FILTER} + fileName + .txt
     * <li>Abnormal points marked by user, Int type, every 4 bytes represent a value.The target file: {@link OBData_[fileName].txt} That is {@link #PREFIX_OB} + fileName + .txt
     * <li>Electrode lead off Begin points, Int type, every 4 bytes represent a value. The target file: {@link ECGLeadOffBegin_[fileName].txt} That is {@link #PREFIX_LEADOFF_BEGIN} + fileName + .txt
     * <li>Electrode lead off End points, Int type, every 4 bytes represent a value.  The target file: {@link ECGLeadOffEnd_[fileName].txt} That is {@link #PREFIX_LEADOFF_END} + fileName + .txt
     * <p>
     * </ol>
     * <p>{@link notice And then, read the target data as follows:}
     * <pre class="prettyprint lang-java">
     * //Example to access the result files
     * private void readData() {
     * // Step 1, get the dir path
     * File resultsDir = new File(getFilesDir().getAbsolutePath() + File.separator + iHealthDevicesManager.TYPE_ECG3_USB);
     * // Step 2, get the target file according to the file name and flags {@link ECG3Profile#OFFLINE_DATA_FLAG}
     * //check bit 0 of OFFLINE_DATA_FLAG
     * if ((offline_data_flag &amp; 0x01) != 0) {
     * //wave data
     * File file = new File(resultsDir, ECG3Profile.PREFIX_FILTERED_DATA + fileName + ".txt");
     * if (file.exists()) {
     * byte[] array = new byte[(int) file.length()];
     * InputStream in = null;
     * try {
     * in = new FileInputStream(file);
     * in.read(array);
     * } catch (FileNotFoundException e) {
     * e.printStackTrace();
     * } catch (IOException e) {
     * e.printStackTrace();
     * } finally {
     * if (in != null) {
     * try {
     * in.close();
     * } catch (IOException e) {
     * e.printStackTrace();
     * }
     * }
     * }
     * short[] waveBuffer = BytetoShort(array);
     * float[] formatDataBuffer = FormatECGData(waveBuffer);
     * //todo draw view
     * } else {
     * Log.e(TAG, "File not exist: " + file);
     * }
     * }
     * //check bit 1 of OFFLINE_DATA_FLAG
     * if ((offline_data_flag &amp; 0x02) != 0) {
     * //heart rate data
     * File fileHREveryHour = new File(resultsDir, ECG3Profile.PREFIX_HR_EVERY_HOUR + fileName + ".txt");
     * if (fileHREveryHour.exists()) {
     * byte[] array = new byte[(int) fileHREveryHour.length()];
     * InputStream in = null;
     * try {
     * in = new FileInputStream(fileHREveryHour);
     * in.read(array);
     * } catch (FileNotFoundException e) {
     * e.printStackTrace();
     * } catch (IOException e) {
     * e.printStackTrace();
     * } finally {
     * if (in != null) {
     * try {
     * in.close();
     * } catch (IOException e) {
     * e.printStackTrace();
     * }
     * }
     * }
     * int[] hrEveryHourBuffer = BytetoInt(array);
     * //todo show hr list
     * } else {
     * Log.e(TAG, "File not exist: " + fileHREveryHour);
     * }
     * File fileHRAllDay = new File(resultsDir, ECG3Profile.PREFIX_HR_DETAIL + fileName + ".txt");
     * if (fileHRAllDay.exists()) {
     * byte[] array = new byte[(int) fileHRAllDay.length()];
     * InputStream in = null;
     * try {
     * in = new FileInputStream(fileHRAllDay);
     * in.read(array);
     * } catch (FileNotFoundException e) {
     * e.printStackTrace();
     * } catch (IOException e) {
     * e.printStackTrace();
     * } finally {
     * if (in != null) {
     * try {
     * in.close();
     * } catch (IOException e) {
     * e.printStackTrace();
     * }
     * }
     * }
     * int[] hrAllDayBuffer = BytetoInt(array);
     * //todo show hr list
     * } else {
     * Log.e(TAG, "File not exist: " + fileHRAllDay);
     * }
     * }
     * // the same for other data
     * }
     * // Every 2 bytes represents a short data, the fields are in the order of MSB to LSB. Where MSB = Most Significant Bit and LSB = Least Significant Bit
     * private short[] BytetoShort(byte[] array) {
     * short[] result = new short[array.length / 2];
     * for (int i = 0; i &lt; result.length; i++) {
     * int value = array[i * 2] * 256 + array[i * 2 + 1];
     * result[i] = (short) ((value &gt; 32767) ? (value - 65536) : value);
     * }
     * return result;
     * }
     * // Every 4 bytes represents a int data, the fields are in the order of MSB to LSB. Where MSB = Most Significant Bit and LSB = Least Significant Bit
     * private int[] BytetoInt(byte[] array) {
     * int[] result = new int[array.length / 4];
     * for (int i = 0; i &lt; result.length; i++) {
     * result[i] = array[i * 4] * 256 * 256 * 256
     * + array[i * 4 + 1] * 256 * 256
     * + array[i * 4 + 2] * 256
     * + array[i * 4 + 3];
     * }
     * return result;
     * }
     * //Format ECG value,  unit mV
     * private float[] FormatECGData(short[] array) {
     * float[] result = new float[array.length];
     * for (int i = 0; i < result.length; i++) {
     * result[i] = array[i] * 2420.0f / (6 * 32767);
     * }
     * return result;
     * }
     * </pre>
     * Otherwise, no filtered data, only update the sync progress.
     * <br /> eg.
     * {<br />
     * <span> </span>&nbsp;&nbsp;&nbsp;&nbsp;"offline_data_sync_progress": 30.5,<br />
     * <span> </span>&nbsp;&nbsp;&nbsp;&nbsp;"offline_data_sync_finish": false<br />
     * }<br />
     * <br />
     */
    public static final String ACTION_STARTSYNCDATA_ECGUSB = "ACTION_STARTSYNCDATA_ECGUSB";

    public static final String ACTION_SYNCDATAPROGRESS_ECGUSB = "ACTION_SYNCDATAPROGRESS_ECGUSB";
    /**
     * Callback indicating no historical data for ECG device.
     */
    public static final String ACTION_NO_HISTORICAL_DATA = "ACTION_NO_HISTORICAL_DATA";
    /**
     * Key of sync progress, range [0, 100]. Value 100 indicates sync finish.
     */
    public static final String PROGRESS = "PROGRESS";

    public static final String ACTION_SYNCDATAINFO_ECGUSB = "ACTION_SYNCDATAINFO_ECGUSB";
    public static final String DATAINFO = "DATAINFO";

    public static final String MEASURE_WAVEData = "MEASURE_WAVEData";
    public static final String MEASURE_ECGPulse = "MEASURE_ECGPulse";

    public static final String FILEPATH = "FilePath";
    /**
     * Key of file name.
     */
    private static final String OFFLINE_DATA_FILE_NAME = "OFFLINE_DATA_FILE_NAME";

    /**
     * Key of simpling rate.You should use it to display view.
     */
    private static final String OFFLINE_DATA_SIMPLING_RATE = "OFFLINE_DATA_SIMPLING_RATE";
    /**
     * Key of start measure time.
     */
    private static final String OFFLINE_DATA_START_TIME = "OFFLINE_DATA_START_TIME";
    /**
     * Key of stop measure time.
     */
    private static final String OFFLINE_DATA_FINISH_TIME = "OFFLINE_DATA_FINISH_TIME";

    public static final String ACTION_SPLICE = "ACTION_SPLICE";
    public static final String SPLICE_DATA = "SPLICE_DATA";
    public static final String ACTION_GET_CACHE = "ACTION_GET_CACHE";
    public static final String GET_CACHE_DATA = "GET_CACHE_DATA";
    public static final String ACTION_FILTER = "ACTION_FILTER";
    public static final String FILTER_DATA = "FILTER_DATA";


    /**
     * Key of data flags, define which data fields are valid in the result.
     * <p>
     * <table style="width:200px;" align="center" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
     * <tbody>
     * <tr><td>Name</td><td>Format</td><td>Bit field</td></tr>
     * <tr><td>Flags</td><td>32bits</td><td>
     * <table style="width:500px;" cellpadding="2" cellspacing="0">
     * <tbody>
     * <tr><td>Bit</td><td>Size</td><td>Name</td><td>Definition</td></tr>
     * <tr><td>0</td><td>1</td><td>Represent filtered data, target file: {@link #PREFIX_FILTERED_DATA}+[fileName].txt</td><td>
     * <table style="width:300px;" cellpadding="2" cellspacing="0">
     * <tbody>
     * <tr><td>Value</td><td>Description</td></tr>
     * <tr><td>0</td><td>NA</td></tr>
     * <tr><td>1</td><td>Valid</td></tr>
     * </tbody>
     * </table></td>
     * </tr>
     * <tr><td>1</td><td>1</td><td>Represent heart rate data, target file: {@link #PREFIX_HR_EVERY_HOUR}+[fileName].txt and {@link #PREFIX_HR_DETAIL}+[fileName].txt</td><td>
     * <table style="width:300px;" cellpadding="2" cellspacing="0">
     * <tbody>
     * <tr><td>0</td><td>NA</td></tr>
     * <tr><td>1</td><td>Valid</td></tr>
     * </tbody>
     * </table></td>
     * </tr>
     * <tr><td>2</td><td>1</td><td>Represent abnormal points filtered by algorithm, target file: {@link #PREFIX_OB_BY_FILTER}+[fileName].txt</td><td>
     * <table style="width:300px;" cellpadding="2" cellspacing="0">
     * <tbody>
     * <tr><td>0</td><td>NA</td></tr>
     * <tr><td>1</td><td>Valid</td></tr>
     * </tbody>
     * </table></td>
     * </tr>
     * <tr><td>3</td><td>1</td><td>Represent electrode lead off data,target file: {@link #PREFIX_LEADOFF_BEGIN}+[fileName].txt and {@link #PREFIX_LEADOFF_END}+[fileName].txt</td><td>
     * <table style="width:300px;" cellpadding="2" cellspacing="0">
     * <tbody>
     * <tr><td>0</td><td>NA</td></tr>
     * <tr><td>1</td><td>Valid</td></tr>
     * </tbody>
     * </table></td>
     * </tr>
     * <tr><td>4</td><td>1</td><td>Represent abnormal points marked by user, target file: {@link #PREFIX_OB}+[fileName].txt</td><td>
     * <table style="width:300px;" cellpadding="2" cellspacing="0">
     * <tbody>
     * <tr><td>0</td><td>NA</td></tr>
     * <tr><td>1</td><td>Valid</td></tr>
     * </tbody>
     * </table></td>
     * </tr>
     * <tr><td>5~31</td><td>27</td><td>Reserved</td><td></td>
     * </tr>
     * </tbody>
     * </table></td>
     * </tr>
     * </tbody>
     * </table>
     */
    private static final String OFFLINE_DATA_FLAG = "offline_data_flag";

    private static final String ACTION_DELETEDATA_ECGUSB = "ACTION_DELETEDATA_ECGUSB";
    private static final String DELETE_RESULT = "DELETE_RESULT";
    private static final String ACTION_ELECTRODE_STATUS = "ACTION_ELECTRODE_STATUS";
    private static final String ELECTRODE_STATUS = "ELECTRODE_STATUS";

    private static final String ACTION_GET_IDPS = "ACTION_GET_IDPS";

    private static final String ACTION_ERROR_ECGUSB = "ACTION_ERROR_ECGUSB";
    private static final String ERROR_NUM_ECGUSB = "ERROR_NUM_ECGUSB";
    private static final String ERROR_DESCRIPTION_ECGUSB = "ERROR_DESCRIPTION_ECGUSB";
    private static final String ACTION_GET_ALL_CONNECTED_DEVICES = "ACTION_GET_ALL_CONNECTED_DEVICES";

    public ECGProfileModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    /**
     * @return the name of this module. This will be the name used to {@code require()} this module
     * from javascript.
     */
    @Override
    public String getName() {
        return modelName;
    }

    /**
     * @return a map of constants this module exports to JS. Supports JSON types.
     */
    @Nullable
    @Override
    public Map<String, Object> getConstants() {
        final Map<String, Object> constants = new HashMap<>();

        constants.put(ACTION_ERROR_ECG, ECG3Profile.ACTION_ERROR);
        constants.put(ERROR_NUM_ECG, ECG3Profile.ERROR_NUM);
        constants.put(ERROR_DESCRIPTION_ECG, ECG3Profile.ERROR_DESCRIPTION);
        constants.put(ACTION_BATTERY_ECG, ECG3Profile.ACTION_GET_BATTERY);
        constants.put(BATTERY_ECG, ECG3Profile.BATTERY);
        constants.put(ACTION_SYSTIME, ECG3Profile.ACTION_SET_TIME);
        constants.put(ACTION_STOPMEASURE_ECG, ECG3Profile.ACTION_STOP_ONLINE_MEASUREMENT);
        constants.put(ACTION_MEASURE_WAVEData, ACTION_MEASURE_WAVEData);
        constants.put(MEASURE_WAVEData, MEASURE_WAVEData);
        constants.put(ACTION_MEASURE_ECGPulse, ACTION_MEASURE_ECGPulse);
        constants.put(MEASURE_ECGPulse, MEASURE_ECGPulse);

        constants.put(ACTION_STARTSYNCDATA_ECGUSB, ACTION_STARTSYNCDATA_ECGUSB);
        constants.put(ACTION_SYNCDATAPROGRESS_ECGUSB, ACTION_SYNCDATAPROGRESS_ECGUSB);
        constants.put(PROGRESS, PROGRESS);
        constants.put(ACTION_SYNCDATAINFO_ECGUSB, ACTION_SYNCDATAINFO_ECGUSB);
        constants.put(DATAINFO, DATAINFO);
        constants.put(OFFLINE_DATA_FILE_NAME, ECG3Profile.OFFLINE_DATA_FILE_NAME);
        constants.put(OFFLINE_DATA_SIMPLING_RATE, ECG3Profile.OFFLINE_DATA_SIMPLING_RATE);
        constants.put(OFFLINE_DATA_START_TIME, ECG3Profile.OFFLINE_DATA_START_TIME);
        constants.put(OFFLINE_DATA_FINISH_TIME, ECG3Profile.OFFLINE_DATA_FINISH_TIME);
        constants.put(OFFLINE_DATA_FLAG, ECG3Profile.OFFLINE_DATA_FLAG);

        constants.put(ACTION_DELETEDATA_ECGUSB, ECG3Profile.ACTION_DELETE_DATA);
        constants.put(DELETE_RESULT, ECG3Profile.DELETE_RESULT);
        constants.put(ACTION_ELECTRODE_STATUS, ECG3Profile.ACTION_ELECTRODE_STATUS);
        constants.put(ELECTRODE_STATUS, ECG3Profile.ELECTRODE_STATUS);

        constants.put(ACTION_GET_IDPS, ECG3Profile.ACTION_GET_IDPS);

        constants.put(ACTION_ERROR_ECGUSB, ECG3Profile.ACTION_ERROR);
        constants.put(ERROR_NUM_ECGUSB, ECG3Profile.ERROR_NUM);
        constants.put(ERROR_DESCRIPTION_ECGUSB, ECG3Profile.ERROR_DESCRIPTION);
        constants.put(ACTION_GET_ALL_CONNECTED_DEVICES, iHealthBaseModule.ACTION_GET_ALL_CONNECTED_DEVICES);
        constants.put(FILEPATH,ECG3Profile.FILE_PATH);

        constants.put(ACTION_SPLICE, ECG3Profile.ACTION_SPLICING_DATA);
        constants.put(SPLICE_DATA, ECG3Profile.GET_SPLICING_DATA);

        constants.put(ACTION_GET_CACHE, ECG3Profile.ACTION_GET_CACHE_DATA);
        constants.put(GET_CACHE_DATA, ECG3Profile.GET_CACHE_DATA);

        constants.put(ACTION_FILTER, ECG3Profile.ACTION_GET_FILTER_FILES);
        constants.put(FILTER_DATA, ECG3Profile.GET_FILTER_DATA);
        return constants;
    }
}
