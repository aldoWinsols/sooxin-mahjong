package com.stock.inter;

import com.stock.dao.Ipo;

public interface IIpoService {
	public Ipo getIpo();
	public Object buy(String playerName, int num);

}
