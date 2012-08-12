package com.stock.services
{
	import com.stock.control.BargainControl;
	import com.stock.model.Alert;
	import com.stock.model.Stock;
	
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	
	import mx.collections.ArrayList;

	public class StockSyncService
	{
		NetConnection.defaultObjectEncoding=flash.net.ObjectEncoding.AMF3;
		private static var instance:StockSyncService;
		private var conn:NetConnection;
		public function StockSyncService()
		{
			conn=new NetConnection();
			conn.client=this;
			connServer(PlayerService.instance.player.playerName);
		}
		
		public static function getInstance():StockSyncService
		{
			if (instance == null)
			{
				instance=new StockSyncService();
			}
			return instance;
		} 
		
		public function connServer(playerName:String):void
		{
//			var str:String = ConfigService.instance.config.mainConnUrl;
			conn.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler); 
			conn.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			conn.connect("rtmp://192.168.1.2/leafSyncServer", playerName);
		}
		
		private function netStatusHandler(evt:NetStatusEvent):void
		{
			trace(evt.info.code);
			if (evt.info.code == "NetConnection.Connect.Success")
			{

			}
			else
			{

			}
			
		}

		public function asyncErrorHandler(e:AsyncErrorEvent):void
		{
			Alert.show("服务器同步发生异常！");
		}
		
		public function buy(stockCode:String, playerName:String, wtPrice:Number, wtNum:Number):void {
			conn.call("buy", new Responder(resultHandler, statusHandler), stockCode,playerName,wtPrice,wtNum);
		}
		
		public function sale(stockCode:String, playerName:String, wtPrice:Number, wtNum:Number):void {
			conn.call("sale", new Responder(resultHandler, statusHandler), stockCode,playerName,wtPrice,wtNum);
		}
		
		public function dealStock(stockCode:String){
			conn.call("dealStock", new Responder(resultHandler, statusHandler), PlayerService.instance.player.playerName,stockCode);
		}
		
		public function updateJiaoyiI(topPrice:Number,bottomPrice:Number,nowPrice:Number,nowCjNum:Number,buys:Array,sales:Array,cjhistory:Array){
			BargainControl.instance.updateJiaoyi(topPrice,bottomPrice,nowPrice,nowCjNum,buys,sales,cjhistory);
		}
		
		public function updateI(timeStr:String,stockCode:String,topPrice:Number,bottomPrice:Number,nowPrice:Number,nowCjNum:Number){
			MainService.instance.update(timeStr,stockCode,topPrice,bottomPrice,nowPrice,nowCjNum);
		}
		
		public function initI(sks:Array):void{
			MainService.instance.init(sks);
		}
		
		private function resultHandler(obj:Object):void{
			trace("result_handler:" + obj);
		}
		
		private function statusHandler(obj:Object):void{
			trace("status_handler:" + obj);
		}
	}
}