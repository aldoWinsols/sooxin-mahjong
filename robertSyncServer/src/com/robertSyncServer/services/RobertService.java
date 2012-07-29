package com.robertSyncServer.services;

import java.text.DecimalFormat;

import com.robertSyncServer.model.Robert;
import com.robertSyncServer.util.NumberFomart;

public class RobertService {
	private Robert robert;
	public RobertService(){
		robert = new Robert();
	}
	
	public void todo(){
		
		if(Math.random()>0.9999){
			StockService stockService = MainService.instance.stockServices.get((int) (Math.random()*MainService.instance.stockServices.size()));
			
			double price = 0.0;

			if(stockService.stock.getNowPrice() < 10){
				price = stockService.stock.getNowPrice() + 0.01*Math.round(Math.random()*Math.random()*7)*(Math.random()>0.5?1:-1);
			}
			else if((stockService.stock.getNowPrice() > 10) && (stockService.stock.getNowPrice() < 100)){
				price = stockService.stock.getNowPrice() + 0.1*Math.round(Math.random()*Math.random()*7)*(Math.random()>0.5?1:-1);
			}else{
				price = stockService.stock.getNowPrice() + 1*Math.round(Math.random()*Math.random()*7)*(Math.random()>0.5?1:-1);
			}
			
			price=NumberFomart.for2(price);

				
			if(Math.random()>0.5){
				RemoteService.instance.buy(stockService.stock.stockCode, "dd",price , (int)(Math.random()*1000));
			}else{
				RemoteService.instance.sale(stockService.stock.stockCode, "dd", price, (int)(Math.random()*1000));
			}
		}
	}

}
