package com.robertSyncServer.services;

import java.util.ArrayList;
import java.util.List;

import com.robertSyncServer.model.Cjhistory;
import com.robertSyncServer.model.Order;
import com.stock.dao.Bag;
import com.stock.dao.Player;
import com.stock.inter.IPlayerService;

public class MainService {
	public static MainService instance;
	ArrayList<RobertService> robertServices = new ArrayList<RobertService>();
	
	ArrayList<StockService> stockServices = new ArrayList<StockService>();
	
	IPlayerService playerService = (IPlayerService) ConfigService
	.getInstance().getContext().getBean("playerService");
	
	public static MainService getInstance(){
		if(instance == null){
			instance = new MainService();
		}
		return instance;
	}

	public MainService(){
		
		List roberts = playerService.getRoberts();
		
		for(int i=0;i<10000;i++){
			Player player = (Player) roberts.get(i);
			RobertService robertService = new RobertService();
			robertService.robert.robertName = player.getPlayerName();
			robertService.robert.haveMoney = player.getHaveMoney();
			robertService.robert.operationNum = (int) (Math.random()*3600)+1;
			
			robertService.robert.bags = playerService.getBagsByPlayerName(player.getPlayerName());
			
			for(int t=0; t<robertService.robert.bags.size();t++){
				robertService.robert.chichang += robertService.robert.bags.get(t).getElPrice()*robertService.robert.bags.get(t).getHaveNum()*100;
			}

			robertServices.add(robertService);
		}
	}
	
	public StockService findStockServiceByStockCode(String stockCode){
		StockService stockService = null;
		
		for(int i=0;i<stockServices.size();i++){
			if(stockServices.get(i).stock.stockCode.equals(stockCode)){
				stockService = stockServices.get(i);
				break;
			}
		}
		
		return stockService;
	}
	
	public void doTimer(){
		for(int i=0;i<robertServices.size();i++){
			robertServices.get(i).todo();
		}
	}
	
	
	
	public void init(String stockCode, String stockName,int allStockNum,
			int liutongStockNum, double shouyi, double PE,
			double lastDayEndPrice,double xinxinLv, double todayStartPrice, double topPrice,
			double bottomPrice, double nowPrice, double nowCjNum,
			ArrayList<Cjhistory> cjhistorys, ArrayList<Order> buyOrders,
			ArrayList<Order> saleOrders){
		
		StockService stockService = new StockService();
		stockService.stock.setStockCode(stockCode);
		stockService.stock.setStockName(stockName);
		stockService.stock.setAllStockNum(allStockNum);
		stockService.stock.setLiutongStockNum(liutongStockNum);
		stockService.stock.setShouyi(shouyi);
		stockService.stock.setPE(PE);
		stockService.stock.setLastDayEndPrice(lastDayEndPrice);
		stockService.stock.setXinxinLv(xinxinLv);
		stockService.stock.setTodayStartPrice(todayStartPrice);
		stockService.stock.setTopPrice(topPrice);
		stockService.stock.setBottomPrice(bottomPrice);
		stockService.stock.setNowPrice(nowPrice);
		stockService.stock.setNowCjNum(nowCjNum);
		stockService.stock.setCjhistorys(cjhistorys);
		stockService.stock.setBuyOrders(buyOrders);
		stockService.stock.setSaleOrders(saleOrders);
		stockServices.add(stockService);
	}
	
	public void updateJiaoyi(String stockCode, double topPrice,
			double bottomPrice, double nowPrice, double nowCjNum,
			ArrayList<Order> buyOrders, ArrayList<Order> saleOrders,
			ArrayList<Cjhistory> thisCjhistoryS){
		
		for(int i=0; i<stockServices.size(); i++){
			if(stockServices.get(i).stock.stockCode.equals(stockCode)){
				stockServices.get(i).stock.topPrice = topPrice;
				stockServices.get(i).stock.bottomPrice = bottomPrice;
				stockServices.get(i).stock.nowPrice = nowPrice;
				stockServices.get(i).stock.nowCjNum = nowCjNum;
				stockServices.get(i).stock.buyOrders = buyOrders;
				stockServices.get(i).stock.saleOrders = saleOrders;
				
				if(thisCjhistoryS.size()>1){
					stockServices.get(i).stock.cjhistorys.addAll(thisCjhistoryS);
				}
				
			}
		}
	}

}
