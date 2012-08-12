package com.stock.inter;

import java.util.List;

public interface IPlayerService {
	public List getRoberts();
	public Object findPlayerByPlayerName(String playerName);
	public Object regeist(String playerName,String playerPwd);
}
