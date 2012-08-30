package com.stockSyncServer.services;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import net.sf.json.JSONArray;

import com.stock.dao.Mline;
import com.stock.dao.Stock;
import com.stock.inter.IStockService;
import com.stockSyncServer.model.StockLocal;
import com.stockSyncServer.services.thread.BalanceJingjiaService;
import com.stockSyncServer.services.thread.LineDataService;
import com.stockSyncServer.services.thread.OrderDataService;

public class MainService {

	public static MainService instance;

	public boolean isJingjia = false;// 当前是否竞价状态
	public boolean isOpen = true;// 当前是否开放投住

	public boolean aa = false;// 当前是否竞价状态

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
			stockService.stock.setXinxinLv(stocks.get(i).getXinxinLv());// 股票本身向好率
			stockServices.add(stockService);
		}
	}

	public static MainService getInstance() {
		if (instance == null) {
			instance = new MainService();
		}

		return instance;
	}

	int n = 0;
	public synchronized void todo() {
		n++;
		
		Timestamp timestamp = new Timestamp(new Date().getTime());
		
		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dateStr = sdf.format(timestamp); //转为字符串	
		
		System.out.println(dateStr);
		
		int hour = Integer.valueOf(dateStr.substring(11,13).replace(" ", ""));
		int minute = Integer.valueOf(dateStr.substring(14,16).replace(" ", ""));
		
		if (hour == 9 && minute == 15) {
			if (!isOpen) {
				isOpen = true;
				isJingjia = true;
			}
		}

		System.out.println(hour+"=="+minute);
		if (hour == 9 && minute == 16) {
			if (isJingjia) {
				isJingjia = false;
				
				for (int i = 0; i < stockServices.size(); i++) {
					stockServices.get(i).balanceJingjia();
				}
				
				BalanceJingjiaService.instance.start();// 结算集合竞价
				
				System.out.println("isJingjia"+isJingjia);
				
			}
		}

		if (hour == 11 && minute == 30) {
			if (isOpen) {
				isOpen = false;
			}
		}

		if (hour == 13 && minute == 0) {
			if (!isOpen) {
				isOpen = true;
			}
		}
		if (hour == 15 && minute == 0) {
			if (isOpen) {
				isOpen = false;
			}
		}

		if (n % 6 == 0) {
			String timestr = hour + ":" + minute;

			for (int i = 0; i < stockServices.size(); i++) {
				StockLocal stock = stockServices.get(i).stock;

				MessageService.instance.broadcastFenshi(new Object[] { timestr,
						stock.getStockCode(), stock.topPrice,
						stock.bottomPrice, stock.getNowPrice(),
						stock.getNowCjNum() });

				if (n % 60 == 0) {
					Mline mline = new Mline();
					mline.setStockCode(stock.getStockCode());
					mline.setBuildDate(new Timestamp(new Date().getTime()));
					mline.setPrice(stock.getNowPrice());
					mline.setTurnover(stock.getNowCjNum());
					LineDataService.instance.addMTask(mline);
					
					stock.mlines.add(mline);

					Date date = new Date();
					String t = date.getHours()+";"+date.getMinutes();
					MessageService.instance.broadcastMline(new Object[]{stock.stockCode,stock.nowPrice,stock.getNowCjNum(),t});
				}

				if (n % 3600 == 0) {
					// Hline hline = new Hline();
					// hline.setStockCode(stock.getStockCode());
					// hline.setBuildDate(new Timestamp(new Date().getTime()));
					// hline.setPrice(stock.getNowPrice());
					// hline.setTurnover(stock.getNowCjNum());
					// LineDataService.instance.addHTask(hline);
				}

				if (n % 3600 * 4 == 0) {
					// Dline dline = new Dline();
					// dline.setStockCode(stock.getStockCode());
					// dline.setBuildDate(new Timestamp(new Date().getTime()));
					// dline.setPrice(stock.getNowPrice());
					// dline.setTurnover(stock.getNowCjNum());
					// LineDataService.instance.addDTask(dline);
				}
			}
		}
	}

	public void addLeafs(String serverUrl) {
		LeafService leafService = new LeafService(serverUrl);
		leafServices.add(leafService);

		ArrayList<com.stockSyncServer.model.StockLocal> stocks = new ArrayList<com.stockSyncServer.model.StockLocal>();
		for (int i = 0; i < stockServices.size(); i++) {
			com.stockSyncServer.model.StockLocal sk = stockServices.get(i).stock;
			leafService.initLeaf(new Object[] { sk.stockCode, sk.stockName,
					sk.allStockNum, sk.liutongStockNum, sk.shouyi, sk.PE,
					sk.lastDayEndPrice, sk.xinxinLv, sk.todayStartPrice,
					sk.topPrice, sk.bottomPrice, sk.nowPrice, sk.nowCjNum,
					JSONArray.fromObject(sk.cjhistorys),
					JSONArray.fromObject(sk.buyOrders),
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
	
	public void cancel(String stockCode, String orderNum){
		for(int i=0; i<stockServices.size();i++){
			if(stockServices.get(i).stock.stockCode.equals(stockCode)){
				stockServices.get(i).cancel(orderNum);
			}
		}
	}
}
