package com.robertSyncServer.model;

import java.util.ArrayList;
import java.util.List;

import com.stock.dao.Bag;

public class Robert {
	public String robertName="";
	public double haveMoney=0.0;
	public String operationType = ""; //��������  1����   2����  3����
	public String moneyType="";
	public List<Bag> bags;
	
	public double chichang = 0.0; //持仓市值
	
	public double chichangLv = 0.5; //计划持仓比例
	
	public int operationNum = 1;//多久做一次操作  决定 断 中 长线玩家 1代表10秒
	public double winLv = 0.3; //赢利多少后卖出
	public double lossLv = 0.3; //亏了多少后卖出
	
	public double xinxinLv = 0.5; //信心指数

}
