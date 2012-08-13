package com.stock.inter;

public interface IPlayerService {
	public Object findPlayerByPlayerName(String playerName);
	public Object regeist(String playerName,String playerPwd);
}
