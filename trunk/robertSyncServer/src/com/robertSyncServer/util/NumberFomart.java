package com.robertSyncServer.util;

import java.text.DecimalFormat;

public class NumberFomart {
	
	static DecimalFormat df=new DecimalFormat(".##");
	public static Double for2(double d){
		return Double.valueOf(df.format(d));
	}

}
