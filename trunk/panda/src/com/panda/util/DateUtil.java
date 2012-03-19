package com.panda.util;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang.time.DateUtils;

/**
 * 日期、時間快捷操作工具類 required lib : org.apache.commons.lang
 * 
 * @author Pan Jin Feng
 * 
 *         when what who comments
 */
public class DateUtil extends DateUtils {
	public static final int YEAR = Calendar.YEAR;
	public static final int MONTH = Calendar.MONTH;
	public static final int DATE = Calendar.DATE;
	public static final int HOUR = Calendar.HOUR_OF_DAY;
	public static final int MINUTE = Calendar.MINUTE;
	public static final int SECOND = Calendar.SECOND;
	public static final int MILLISECOND = Calendar.MILLISECOND;
	public static final int AM = Calendar.AM;
	public static final int AM_PM = Calendar.AM_PM;
	public static final int PM = Calendar.PM;

	/**
	 * 根據date得到timestamp
	 * 
	 * @param date
	 * @return
	 */
	public static Timestamp getTimestamp(Date date) {
		return Timestamp.valueOf(DateFormat.format(date,
				DateFormat.YYYY_MM_DD_HH24_MM_SS));
	}

	/**
	 * 将日期时间字符串转换为时期型
	 * 
	 * @param srcDateTime
	 *            待转化的日期时间字符串.
	 * 
	 * @return 转化后的日期时间.
	 */
	public static Date string2Date(String srcDateTime) {
		Date date = null;
		try {
			date = new SimpleDateFormat(DateFormat.YYYY_MM_DD_HH24_MM_SS)
					.parse(srcDateTime);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}

	/**
	 * 将日期时间字符串转换为时期型
	 * 
	 * @param srcDateTime
	 *            待转化的日期时间字符串.
	 * @param format
	 *            格式模式
	 * @return 转化后的日期时间.
	 */
	public static Date string2Date(String srcDateTime, String format) {
		Date date = null;
		try {
			date = new SimpleDateFormat(format).parse(srcDateTime);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}

	/**
	 * 得到某个时间的指定域,如get(new Date(),YEAR)得到现在时间的年
	 * 
	 * @param date
	 * @param field
	 * @return
	 */
	public static int get(Date date, int field) {
		Calendar calendar = Calendar.getInstance();
		calendar.clear();
		calendar.setTime(date);
		return calendar.get(field);
	}

	public static void set(Date date, int field, int value) {
		Calendar calendar = Calendar.getInstance();
		calendar.clear();
		calendar.setTime(date);
		calendar.set(field, value);
		date.setTime(calendar.getTimeInMillis());
	}

	/**
	 * 得到两个日期之差天数（enddate - startdate）
	 * 
	 * @param startdate
	 * @param enddate
	 * @return
	 */
	public static int getDiffDayNums(Date startdate, Date enddate) {
		return (int) ((enddate.getTime() - startdate.getTime()) / MILLIS_PER_DAY);
	}

	/**
	 * 得到两个日期之差天数（c1 - c2）
	 * 
	 * @param startdate
	 * @param enddate
	 * @return
	 */
	public static int getDiffDayNums(Calendar c1, Calendar c2) {
		return getDiffDayNums(c1.getTime(), c2.getTime());
	}

	/**
	 * 得到两个日期之差天数（time1 - time2）
	 * 
	 * @param startdate
	 * @param enddate
	 * @return
	 */
	public static int getDiffDayNums(Timestamp time1, Timestamp time2) {
		return (int) ((time1.getTime() - time2.getTime()) / MILLIS_PER_DAY);
	}

	public static int getDiffMins(Date startdate, Date enddate) {
		return (int) ((enddate.getTime() - startdate.getTime()) / MILLIS_PER_MINUTE);
	}

	public static int getDiffMins(Timestamp time1, Timestamp time2) {
		return (int) ((time1.getTime() - time2.getTime()) / MILLIS_PER_MINUTE);
	}

}
