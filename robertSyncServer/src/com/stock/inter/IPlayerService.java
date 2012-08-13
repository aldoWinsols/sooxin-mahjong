package com.stock.inter;

import java.util.List;

import com.stock.dao.Bag;

public interface IPlayerService {
	public List getRoberts();
	public Object findPlayerByPlayerName(String playerName);
	public Object regeist(String playerName,String playerPwd);
	public List<Bag> getBagsByPlayerName(String playerName);
}
