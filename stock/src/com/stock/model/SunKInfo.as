package com.stock.model
{
	public class SunKInfo
	{
		public var date:String = "";
		public var kaipan:Number = 0;
		public var shoupan:Number = 0;
		public var max:Number = 0;
		public var min:Number = 0;
		public var turnover:Number = 0;
		
		public function SunKInfo(date:String, kaipan:Number, shoupan:Number, max:Number, min:Number, turnover:Number)
		{
			this.date = date;
			this.kaipan = Number(kaipan.toFixed(2));
			this.shoupan = Number(shoupan.toFixed(2));
			this.max = Number(max.toFixed(2));
			this.min = Number(min.toFixed(2));
			this.turnover = Number(turnover.toFixed(2));
		}
	}
}