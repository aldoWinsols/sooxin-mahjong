package com.robertSyncServer.services;

import java.text.DecimalFormat;

import com.robertSyncServer.model.Robert;
import com.robertSyncServer.util.NumberFomart;
import com.stock.dao.Bag;

public class RobertService {
	public Robert robert;
	public int n=1;
	public RobertService(){
		robert = new Robert();
	}
	
	public void todo(){
		n++;
		if(n%robert.operationNum == 0){
			
			for(int i=0; i<robert.bags.size();i++){
				Bag bag = robert.bags.get(i);
				StockService stockService = MainService.instance.findStockServiceByStockCode(bag.getStockNum());
				
				if(stockService.stock.nowPrice > bag.getElPrice()){
					if((stockService.stock.nowPrice - bag.getElPrice())/bag.getElPrice() > robert.winLv){
						RemoteService.instance.sale(stockService.stock.stockCode, robert.robertName, getRandowPrice(stockService), bag.getHaveNum()-bag.getClockNum());
						
						robert.bags.remove(i);
						i--;
						
						return;
					}
				}else{
					if ((stockService.stock.nowPrice - bag.getElPrice())
							/ bag.getElPrice() < robert.lossLv) {
						RemoteService.instance.sale(stockService.stock.stockCode, robert.robertName, getRandowPrice(stockService), bag.getHaveNum()-bag.getClockNum());
						
						robert.bags.remove(i);
						i--;
						
						return;
					}
				}
			}
			
			
			double chichang = 0.0;
			for(int i=0; i<robert.bags.size();i++){
				chichang += robert.bags.get(i).getElPrice()*robert.bags.get(i).getHaveNum();
			}
			
			if(chichang == 0){
				StockService stockService = MainService.instance.stockServices.get((int) (Math.random()*MainService.instance.stockServices.size()));
				
				int buyNum = (int) (robert.haveMoney*robert.chichangLv/stockService.stock.getNowPrice());
				
				double buyPrice = getRandowPrice(stockService);
				RemoteService.instance.buy(stockService.stock.stockCode, robert.robertName,buyPrice, buyNum);
				
				robert.haveMoney -= buyPrice*buyNum;
				return;
				
			}else if(chichang/(chichang+robert.haveMoney) < robert.chichangLv){
				StockService stockService = MainService.instance.stockServices.get((int) (Math.random()*MainService.instance.stockServices.size()));
				
				int buyNum = (int) (((robert.haveMoney*robert.chichangLv/(1-robert.chichangLv))-chichang)/stockService.stock.getNowPrice());
				
				double buyPrice = getRandowPrice(stockService);
				RemoteService.instance.buy(stockService.stock.stockCode, robert.robertName,buyPrice, buyNum);
				
				robert.haveMoney -= buyPrice*buyNum;
			}
		}
	}
	
	public double getRandowPrice(StockService stockService){
		double price = 0.0;

		if(stockService.stock.getNowPrice() < 10){
			price = stockService.stock.getNowPrice() + 0.01*Math.round(Math.random()*Math.random()*7)*(Math.random()>0.5?1:-1);
		}
		else if((stockService.stock.getNowPrice() > 10) && (stockService.stock.getNowPrice() < 100)){
			price = stockService.stock.getNowPrice() + 0.1*Math.round(Math.random()*Math.random()*7)*(Math.random()>0.5?1:-1);
		}else{
			price = stockService.stock.getNowPrice() + 1*Math.round(Math.random()*Math.random()*7)*(Math.random()>0.5?1:-1);
		}
		
		return NumberFomart.for2(price);
	}

}
