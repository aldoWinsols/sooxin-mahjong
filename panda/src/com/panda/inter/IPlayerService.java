package com.panda.inter;

public interface IPlayerService {
	public Object login(String playerName, String playerPwd);
	
	public Object regeist(String playerName, String playerPwd);
	
	public boolean checkPlayerNameIsHave(String playerName);
	
	public Object changePwd(String playerName, String playerOldPwd, String playerNewPwd);
	
	public void updateMoney(String playerName, Double changeMoney);

}
