package com.mahjongSyncServer.util;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 此类提供日期格式化方法
 * 
 * @author 潘近峰 2009-9-3
 */
@SuppressWarnings("deprecation")
public class DateUtils {

	private DateUtils() {

	}

	/**
	 * 返回yyyy-MM-dd HH:mm:ss格式的日期字符串
	 * 
	 * @param date
	 *            (java.util.Date)
	 * @return
	 */
	public static String parser2String(Date date) {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.sss");
		return dateFormat.format(date);
	}

	/**
	 * 将Date日期类型转换为Timestamp类型日期
	 * 
	 * @param date
	 * @return
	 */
	public static Timestamp parser2Timestamp(Date date) {
		return Timestamp.valueOf(parser2String(date));
	}

	/**
	 * 将Date日期转换为yyyyMMddHHmmsssss格式字符串
	 * 
	 * @param date
	 * @return
	 */
	public static String getString(Date date) {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.sss");
		return dateFormat.format(date);
	}

	/**
	 * 将Date日期转换为yyyyMMdd格式字符串
	 * 
	 * @param date
	 * @return
	 */
	public static String getYYYYMMDD(Date date) {
		if (date == null) {
			return "";
		}

		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		return dateFormat.format(date);
	}

	/**
	 * 得到两个日期之差
	 * 
	 * @param startdate
	 * @param enddate
	 * @return
	 */
	public static int getDiffDate(Date startdate, Date enddate) {
		return (int) ((enddate.getTime() - startdate.getTime()) / (24 * 60 * 60 * 1000));
	}

	/**
	 * 得到某年某月的天数
	 * 
	 * @param year
	 * @param month
	 * @return
	 */

	public static int getDaysofMonth(int year, int month) {
		Date start = new Date();
		start.setYear(year - 1900);
		start.setMonth(month - 1);
		Date end = new Date();
		end.setYear(year - 1900);
		end.setMonth(month);

		return getDiffDate(start, end);
	}

	/**
	 * 日期往后推指定天数
	 * 
	 * @param date
	 * @param i
	 * @return
	 */
	public static Date addDay(Date date, int i) {
		date.setDate(date.getDate() + i);
		return date;
	}

	public static Date subDay(Date date, int i) {
		date.setDate(date.getDate() - i);
		return date;
	}
}
