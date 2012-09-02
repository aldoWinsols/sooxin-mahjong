package com.stock.inter;

import java.util.List;

public interface IBankService {
	
	public Object loan(String playerName,double money, int days); //贷款
	public Object deposit(String playerName,double money, int days); //存款
	
	public void unloan(String id); //还款
	public void undeposit(String id); //取款
	
	public List getBanks(String playerName);
}
