package com.stock.util;

public class Util {
	public static boolean isContainChinese(String inStr) {
		if (inStr.getBytes().length != inStr.length()) {
			return true;
		}
		return false;
	}
}
