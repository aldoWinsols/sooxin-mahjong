package com.stockSyncServer.util;

import java.util.Comparator;

import com.stockSyncServer.model.Order;

public class ComparatorDesc implements Comparator {

	public int compare(Object arg0, Object arg1) {
		Order order0 = (Order) arg0;
		Order order1 = (Order) arg1;
		int flag = -1;

		if (order0.getWtPrice() > order1.getWtPrice()) {
			flag = 1;
		} else {
			flag = 0;
		}

		return flag;
	}
}
