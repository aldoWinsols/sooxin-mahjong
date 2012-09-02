package com.stock.model
{
	import flash.events.IEventDispatcher;
	
	import mx.utils.ObjectProxy;

	[Bindable]
	public class Stock extends ObjectProxy
	{
		public var stockCode:String = "";// 股票代码
		public var stockName:String = "";// 股票名称
		public var allStockNum:int = 0;// 总股本
		public var shizhi:Number = 0;//市值
		public var liutongStockNum:int = 0;// 流通
		public var jinzhi:Number = 0.0; // 收益
		public var shouyi:Number = 0.0; // 净资
		public var lastDayCjshou:int = 0; // 昨日成交笔数
		public var PE:Number = 0.0;// 市赢率
		
		public var lastDayEndPrice:Number = 0.0; // 昨日收盘价格
		public var todayStartPrice:Number = 0.0;// 今日开盘价格
		public var topPrice:Number = 0.0;// 当日最高价格
		public var bottomPrice:Number = 0.0; // 当日最低价
		public var nowPrice:Number = 0.0;// 当前价格
		public var nowCjNum:Number = 0.0;// 当前成交量
		
		public var zhangfu:String =""; //涨幅
		public var zhangdie:Number =0.0; //涨跌
		public var huanshou:String="";//换手
		public var zhenfu:String="";//震幅
		
		public var cjhistorys:Array = new Array();// 成交笔
		
		public var buyOrders:Array = new Array();// 买单
		public var saleOrders:Array = new Array();// 卖单
		
		public var zpan:int = 0;//总盘
		public var wpan:int = 0;//外盘
		public var npan:int = 0;//内盘
		public var liangb:Number = 0.0;//量比
		
		public function Stock()
		{
			
		}
	}
}