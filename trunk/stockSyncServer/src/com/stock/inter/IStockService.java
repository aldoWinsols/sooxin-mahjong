package com.stock.inter;

import java.sql.Timestamp;
import java.util.List;

public interface IStockService {
	public List getStocks();
	public void blance(String stockNum,String buyPlayerName, String salePlayerName, String cjSort,int cjNum,Double cjPrice,Timestamp cjTime);
}