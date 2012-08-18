package com.stock.inter;

import java.sql.Timestamp;
import java.util.List;

public interface IStockService {
	public List getStocks();

	public Object buy(String stockCode, String playerName, String orderNum,
			double wtPrice, int wtNum);

	public Object sale(String stockCode, String playerName, String orderNum,
			double wtPrice, int wtNum);

	public void blance(String stockNum, String buyPlayerName,
			String buyOrderNum, String salePlayerName, String saleOrderNum,
			String cjSort, int cjNum, Double cjPrice, String cjTime);
}
