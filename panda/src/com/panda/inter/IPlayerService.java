package com.panda.inter;

import com.panda.dao.Player;

public interface IPlayerService {
	public Object login(String playerName, String playerPwd);
	
	public Object regeist(Player player);
	
	public boolean checkPlayerNameIsHave(String playerName);
	
	public Object changePwd(String playerName, String playerOldPwd, String playerNewPwd);
	
	public void updateMoney(String playerName, Double changeMoney);

	public boolean checkPlayerNameIsExist(String playerName);
}
