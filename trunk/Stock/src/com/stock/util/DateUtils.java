package com.stock.util;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * 此类提供日期格式化等方法
 * 
 * @author 潘近峰 2009-9-3
 */
public class DateUtils {

	public static final int YEAR = Calendar.YEAR;
	public static final int MONTH = Calendar.MONTH;
	public static final int DATE = Calendar.DATE;
	public static final int HOUR = Calendar.HOUR_OF_DAY;
	public static final int MINUTE = Calendar.MINUTE;
	public static final int SECOND = Calendar.SECOND;
	public static final int MILLISECOND = Calendar.MILLISECOND;

	private DateUtils() {

	}

	/**
	 * 返回yyyy-MM-dd HH:mm:ss.sss格式的日期字符串
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
	 * 返回yyyy-MM-dd HH:mm:ss格式的日期字符串
	 * 
	 * @param date
	 *            (java.util.Date)
	 * @return
	 */
	public static String parse2YMDHMS(Date date) {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
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
	public static int getDiffDate(Date startdate, Date enddate) {
		return (int) ((enddate.getTime() - startdate.getTime()) / (24 * 60 * 60 * 1000));
	}

	/**
	 * 是否为同一天
	 * 
	 * @param startdate
	 * @param enddate
	 * @return
	 */
	public static boolean isSameDay(Date startdate, Date enddate) {
		if (startdate != null && enddate != null) {
			return getDiffDate(startdate, enddate) == 0;
		}
		return false;
	}

	public static int compare(Date date1, Date date2) {
		Calendar calendar1 = Calendar.getInstance();
		calendar1.clear();
		calendar1.setTime(date1);

		Calendar calendar2 = Calendar.getInstance();
		calendar2.clear();
		calendar2.setTime(date2);
		return calendar1.compareTo(calendar2);
	}

	/**
	 * 判断日期是否处于指定时间段内
	 * 
	 * @param date
	 * @param startdate
	 * @param enddate
	 * @param frontInclude
	 * @param backInclude
	 * @return
	 */
	public static boolean isBetween(Date date, Date startdate, Date enddate,
			boolean frontInclude, boolean backInclude) {
		int compareRes1 = compare(date, startdate);
		if (compareRes1 < 0) {
			return false;
		}
		if (!frontInclude && compareRes1 == 0) {
			return false;
		}
		int compareRes2 = compare(date, enddate);
		if (compareRes2 > 0) {
			return false;
		}
		if (!backInclude && compareRes2 == 0) {
			return false;
		}
		return true;
	}

	/**
	 * 是否是同年同月同日
	 * 
	 * @param date1
	 * @param date2
	 * @return
	 */
	public static boolean isSameDate(Date date1, Date date2) {
		if (date1 != null && date2 != null) {
			return get(date1, YEAR) == get(date2, YEAR)
					&& get(date1, MONTH) == get(date2, MONTH)
					&& get(date1, DATE) == get(date2, DATE);
		}
		return false;
	}

	/**
	 * 得到某年某月的天数
	 * 
	 * @param year
	 * @param month
	 * @return
	 */

	public static int getDaysofMonth(int year, int month) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(year, month - 1, 1);
		return calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
	}

	/**
	 * 日期往后推指定天数 改变原来的date对象同时返回一个新的date对象
	 * 
	 * @param date
	 * @param i
	 * @return
	 */
	public static Date addDay(Date date, int i) {
		Calendar calendar = Calendar.getInstance();
		calendar.clear();
		calendar.setTime(date);
		calendar.add(Calendar.DAY_OF_MONTH, i);

		date.setTime(calendar.getTimeInMillis());

		return date;
	}

	/**
	 * 日期往前推指定天数
	 * 
	 * @param date
	 * @param i
	 * @return
	 */
	public static Date subDay(Date date, int i) {
		return addDay(date, -i);
	}

	/**
	 * 限制日期选择的起始日期
	 * <p>
	 * 如果选择的起始日期小于了限制最小起始日期则将选择日期置为限制的最小起始日期
	 * </p>
	 * 
	 * @param date
	 * @return
	 */
//	public static Date limitedStartDate(Date date) {
//		Date minStartDate = Analyser.getInstance().getMinStartDate();
//		date.setTime((compare(date, minStartDate) < 0 ? minStartDate : date)
//				.getTime());
//		return date;
//	}

	/**
	 * 得到一个日期的副本
	 * 
	 * @param date
	 * @return
	 */
	public static Date copyDate(Date date) {
		Date copy = new Date();
		copy.setTime(date.getTime());
		return copy;
	}

	/**
	 *将一个日期的小时设置为指定小时，分，秒，毫秒都设置为0
	 * 
	 * @param date
	 * @param clock
	 * @return
	 */
	public static Date setClock(Date date, int clock) {
		if (clock > 24) {
			clock = 24;
		}
		Calendar calendar = Calendar.getInstance();
		calendar.clear();
		calendar.setTime(date);
		calendar.set(Calendar.HOUR_OF_DAY, clock);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);
		date.setTime(calendar.getTimeInMillis());
		return calendar.getTime();
	}

	/**
	 * 设置时分秒
	 * 
	 * @param date
	 * @param hour
	 * @param munites
	 * @param seconds
	 * @return
	 */
	public static Date setHMS(Date date, int hour, int munites, int seconds) {
		if (hour > 24) {
			hour = 24;
		}
		Calendar calendar = Calendar.getInstance();
		calendar.clear();
		calendar.setTime(date);
		calendar.set(Calendar.HOUR_OF_DAY, hour);
		calendar.set(Calendar.MINUTE, munites);
		calendar.set(Calendar.SECOND, seconds);
		calendar.set(Calendar.MILLISECOND, 0);
		date.setTime(calendar.getTimeInMillis());
		return calendar.getTime();
	}
}
