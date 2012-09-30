package com.stock.model
{
	[Bindable]
	[RemoteClass(alias="com.stock.dao.Ipo")]
	public class Ipo
	{

		public var stockCode:String;
		public var stockName:String;
		public var allNum:Number;
		public var busNum:Number;
		public var jinzhi:Number;
		public var shouyi:Number;
		public var startBuy:String;
		public var startSale:String;
		public var introdunce:String;
		public var price:Number;

		public function Ipo()
		{
		}
	}
}