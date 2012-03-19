package com.panda.util;

import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang.time.DateFormatUtils;

/**
 * 日期、時間格式化工具類
 * required lib : org.apache.commons.lang
 *
 * when				what	who				comments
 */
public class DateFormat extends DateFormatUtils {

	// 得到年月日
	public static final String YYYY_MM_DD = "yyyy-MM-dd";
	// 得到24小时制的年月日时分秒
	public static final String YYYY_MM_DD_HH24_MM_SS = "yyyy-MM-dd HH:mm:ss";

	public static final String YYYY_MM_DD_HH24_MM_SS_UNDERLINE = "yyyy_MM_dd_HH_mm_ss";

	public static String formatYMD(Date date) {
		return format(date, YYYY_MM_DD);
	}

	public static String formatYMD(Calendar c) {
		return formatYMD(c.getTime());
	}

	public static String formatYMD(Timestamp timestamp) {
		return format(timestamp, YYYY_MM_DD);
	}

	public static String formatYMDH24MS(Date date) {
		return format(date, YYYY_MM_DD_HH24_MM_SS);
	}

	public static String formatYMDH24MS(Calendar c) {
		return formatYMDH24MS(c.getTime());
	}

	public static String formatYMDH24MS(Timestamp timestamp) {
		return format(timestamp, YYYY_MM_DD_HH24_MM_SS);
	}

	public static String format(Timestamp timestamp, String pattern) {
		return format(timestamp.getTime(), pattern);
	}

}
