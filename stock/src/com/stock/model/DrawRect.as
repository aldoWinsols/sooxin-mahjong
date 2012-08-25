package com.stock.model
{
	import flash.display.Sprite;
	
	import mx.core.UIComponent;

	public class DrawRect extends UIComponent
	{
		private var rectObj:Sprite;
		private const candleWidth:int = 7; // 每个矩形8个像素宽
		
		public function DrawRect(sunkInfo:SunKInfo, num:Number)
		{
//			var beishu:int = 0;
//			
//			beishu = minTurnover / 3000000 * 50*150;
////			beishu = 300000;
			rectObj = new Sprite();
//			var num:Number = (sunkInfo.turnover - minTurnover) / 50 / beishu;
//			if(num == 0){
//				num == 1;
//			}
			num = Number(num.toFixed(2));
			
			if(sunkInfo.shoupan > sunkInfo.kaipan){
				rectObj.graphics.beginFill(0xff0000, 1); // 定义画线样式
			}else{
				rectObj.graphics.beginFill(0x00eaff, 1); // 定义画线样式
			}
			
			rectObj.graphics.drawRect(0, 0, candleWidth, num);
			rectObj.graphics.endFill();
			
			this.height = rectObj.height;
			this.width = rectObj.width;
			addChild(rectObj);
		}
	}
}