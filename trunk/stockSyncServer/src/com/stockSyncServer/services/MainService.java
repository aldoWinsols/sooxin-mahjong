package com.stockSyncServer.services;

import java.util.ArrayList;

import net.sf.json.JSONArray;

import com.stock.dao.Stock;
import com.stock.inter.IStockService;
import com.stockSyncServer.services.thread.OrderDataService;

public class MainService {

	public static MainService instance;
	public boolean isJingjia = true;
	
	public ArrayList<StockService> stockServices = new ArrayList<StockService>();
	public ArrayList<LeafService> leafServices = new ArrayList<LeafService>();
	private IStockService stockService;
	public MainService() {
		// addLeafs("http://127.0.0.1:5080/leafSyncServer/gateway");

		stockService = (IStockService) ConfigService.getInstance().getContext()
		.getBean("stockService");
		
		ArrayList<Stock> stocks = (ArrayList<Stock>) stockService.getStocks();

		for (int i = 0; i < stocks.size(); i++) {
			StockService stockService = new StockService();
			stockService.stock.setStockCode(stocks.get(i).getStockCode());// 股票代码
			stockService.stock.setStockName(stocks.get(i).getStockName());// 股票名称
			stockService.stock.setAllStockNum(stocks.get(i).getAllNum());// 总股本
			stockService.stock.setLiutongStockNum(stocks.get(i).getBusNum());// 流通股本
			stockService.stock.setShouyi(stocks.get(i).getShouyi());// 收益
			stockService.stock.setPE(stocks.get(i).getPe());// 市赢率
			stockService.stock.setLastDayEndPrice(stocks.get(i)
					.getLastDayEndPrice());// 昨日收盘价
			stockService.stock.setXinxinLv(stocks.get(i).getXinxinLv());//股票本身向好率
			stockServices.add(stockService);
		}
	}

	public static MainService getInstance() {
		if (instance == null) {
			instance = new MainService();
		}

		return instance;
	}

	public void addLeafs(String serverUrl) {
		LeafService leafService = new LeafService(serverUrl);
		leafServices.add(leafService);

		ArrayList<com.stockSyncServer.model.Stock> stocks = new ArrayList<com.stockSyncServer.model.Stock>();
		for (int i = 0; i < stockServices.size(); i++) {
			com.stockSyncServer.model.Stock sk = stockServices.get(i).stock;
			leafService.initLeaf(new Object[] { sk.stockCode, sk.stockName,sk.allStockNum,
					sk.liutongStockNum, sk.shouyi, sk.PE, sk.lastDayEndPrice,sk.xinxinLv,
					sk.todayStartPrice, sk.topPrice, sk.bottomPrice,
					sk.nowPrice, sk.nowCjNum, JSONArray.fromObject(sk.cjhistorys), JSONArray.fromObject(sk.buyOrders),
							JSONArray.fromObject(sk.saleOrders) });
		}
	}

	public void removeLeafs(String serverUrl) {
		for (int i = 0; i < leafServices.size(); i++) {
			if (leafServices.get(i).serverUrl.equals(serverUrl)) {
				leafServices.remove(i);
			}
		}
	}

	public void buy(String stockCode, String playerName, double wtPrice,
			int wtNum) {
		String orderNum = playerName + System.currentTimeMillis();
		OrderDataService.instance.addTask("buy", stockCode, playerName,
				orderNum, wtPrice, wtNum);
	}

	public void sale(String stockCode, String playerName, double wtPrice,
			int wtNum) {
		String orderNum = playerName + System.currentTimeMillis();
		OrderDataService.instance.addTask("sale", stockCode, playerName,
				orderNum, wtPrice, wtNum);
	}
}
