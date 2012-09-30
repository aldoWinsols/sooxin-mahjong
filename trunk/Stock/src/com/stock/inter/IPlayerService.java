package com.stock.inter;

import java.util.List;

import com.stock.dao.Bag;

public interface IPlayerService {
	public List getRoberts();
	public Object findPlayerByPlayerName(String playerName);
	public Object regist(String playerName,String playerPwd);
	public Object login(String playerName,String playerPwd);
	public Object updatePlayerPwd(String playerName,String oldPlayerPwd,String newPlayerPwd);
	public List<Bag> getBagsByPlayerName(String playerName);
	
	public List getPaihang();
	public void buildPaihang();
}
