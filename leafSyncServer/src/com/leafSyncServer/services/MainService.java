package com.leafSyncServer.services;

import java.sql.Array;
import java.util.ArrayList;

import org.red5.server.api.service.IServiceCapableConnection;

import com.leafSyncServer.model.Cjhistory;
import com.leafSyncServer.model.Message;
import com.leafSyncServer.model.Order;

public class MainService {
	public ArrayList<PlayerService> playerServices;
	public static MainService instance;
	
	ArrayList<StockService> stockServices = new ArrayList<StockService>();

	public MainService() {
		playerServices = new ArrayList<PlayerService>();
	}
	
	public void init(String stockCode, int allStockNum,
			int liutongStockNum, double shouyi, double PE,
			double lastDayEndPrice, double todayStartPrice, double topPrice,
			double bottomPrice, double nowPrice, double nowCjNum,
			ArrayList<Cjhistory> cjhistorys, ArrayList<Order> buyOrders,
			ArrayList<Order> saleOrders){
		
		StockService stockService = new StockService();
		stockService.stock.setStockCode(stockCode);
		stockService.stock.setAllStockNum(allStockNum);
		stockService.stock.setLiutongStockNum(liutongStockNum);
		stockService.stock.setShouyi(shouyi);
		stockService.stock.setPE(PE);
		stockService.stock.setLastDayEndPrice(lastDayEndPrice);
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
	
	public static MainService getInstance(){
		if(instance == null){
			instance = new MainService();
		}
		
		return instance;
	}

	public void addPlayerService(String playerName,IServiceCapableConnection iserver) {
		PlayerService playerService = new PlayerService();
		playerService.getPlayer().setPlayerName(playerName);
		playerService.getPlayer().setIserver(iserver);
		playerService.getPlayer().setClientID(iserver.getClient().getId());
		
		playerService.getPlayer().setNowStockCode("500001");
		playerServices.add(playerService);
	}

	public void removePlayerService(IServiceCapableConnection iserver) {
		for (int i = 0; i < playerServices.size(); i++) {
			if (playerServices.get(i).getPlayer().getClientID().equals(iserver.getClient().getId())) {
				playerServices.remove(i);
			}
		}
	}
	
	public void updateJiaoyi(String stockCode, double topPrice,
			double bottomPrice, double nowPrice, double nowCjNum,
			ArrayList<Order> buyOrders, ArrayList<Order> saleOrders,
			String cjhistoryS){
		Cjhistory cjhistory = null;
		
		for(int i=0; i<stockServices.size(); i++){
			if(stockServices.get(i).stock.stockCode.equals(stockCode)){
				stockServices.get(i).stock.topPrice = topPrice;
				stockServices.get(i).stock.bottomPrice = bottomPrice;
				stockServices.get(i).stock.nowPrice = nowPrice;
				stockServices.get(i).stock.nowCjNum = nowCjNum;
				stockServices.get(i).stock.buyOrders = buyOrders;
				stockServices.get(i).stock.saleOrders = saleOrders;
				
				if(cjhistoryS != null){
					String[] arr = cjhistoryS.split(",");
					
					cjhistory = new Cjhistory();
					cjhistory.setCjTime(arr[0]);
					cjhistory.setCjPrice(Double.valueOf(arr[1]));
					cjhistory.setCjNum(Integer.valueOf(arr[2]));
					cjhistory.setCjSort(arr[3]);
					
					stockServices.get(i).stock.cjhistorys.add(cjhistory);
				}
				
			}
		}
		
		Message message = new Message();
		message.setHead("updateJiaoyiI");
		message.setContent(new Object[]{buyOrders,saleOrders,cjhistory});
		MessageService.instance.send(stockCode, message);
	}

}
