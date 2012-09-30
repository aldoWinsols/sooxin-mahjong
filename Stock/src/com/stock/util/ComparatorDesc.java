package com.stock.util;

import java.util.Comparator;

import com.stock.dao.Player;

public class ComparatorDesc implements Comparator {

	public int compare(Object arg0, Object arg1) {
		Player player0 = (Player) arg0;
		Player player1 = (Player) arg1;
		int flag = -1;

		if (player0.getRealMoney() < player1.getRealMoney()) {
			flag = 1;
		} else {
			flag = 0;
		}

		return flag;
	}
}
