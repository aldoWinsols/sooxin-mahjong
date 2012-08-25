package com.stock.model
{
	/**
	 * 该类是专们绘制股票实时显示图中的烛台图
	 **/
	import flash.display.Sprite;
	
	import mx.core.UIComponent;
	
	public class DrawCandle extends UIComponent
	{
		private var rectObj:Sprite;
		private const candleWidth:int = 7; // 每个矩形8个像素宽
		private var beishu:int = 20;
		private var lineX:int = 4;
		
		/**
		 * #FF0000,Red;#008000,Green
		 * o:开盘价，c:收盘价，h:最高价,l:最低价
		 **/
		public function DrawCandle(o:Number,c:Number,h:Number,l:Number)
		{
			o = o * beishu;
			c = c * beishu;
			h = h * beishu;
			l = l * beishu;
			rectObj = new Sprite();
			var rectHeight:Number = 0;
			
			if(c > o) // 收盘价大于等于开盘价，填充红色，否则填充蓝色
			{
				// 绘制红色烛图
				rectHeight = Math.abs(c - o);
				if(rectHeight == 0){
					rectHeight ++;
				}
				var yControl:Number = h - c;
				rectObj.graphics.lineStyle(1,0xff0000); // 定义画线样式
				rectObj.graphics.moveTo(lineX,0);
				rectObj.graphics.lineTo(lineX,yControl); // 绘制当天最高价(线条高等于最高价减去收盘价)涨
				
//				rectObj.graphics.beginFill(0xff0000,1);
				rectObj.graphics.lineStyle(1, 0xff0000,1);
				rectObj.graphics.drawRect(0, yControl,candleWidth,rectHeight); // 矩型高等于收盘价减去开盘价
				rectObj.graphics.endFill();
				
				rectHeight += yControl;
				
				rectObj.graphics.moveTo(lineX,rectHeight);
				rectObj.graphics.lineTo(lineX,rectHeight + Math.abs(o - l)); // 绘制当天最低价(线条高等于开盘价减去最低价)
			}
			else
			{
				// 绘制绿色烛图
				rectHeight = Math.abs(o - c);
				if(rectHeight == 0){
					rectHeight ++;
				}
				var yControl:Number = h - o;
				
				rectObj.graphics.lineStyle(1,0x00eaff); // 定义画线样式
				rectObj.graphics.moveTo(lineX,0);
				rectObj.graphics.lineTo(lineX,yControl); // // 绘制当天最高价(线条高等于最高价减去开盘价)跌
				
				rectObj.graphics.beginFill(0x00eaff,1);
				rectObj.graphics.drawRect(0,yControl,candleWidth,rectHeight);
				rectObj.graphics.endFill();
				
				rectHeight += yControl;
				
				rectObj.graphics.moveTo(lineX,rectHeight);
				rectObj.graphics.lineTo(lineX,rectHeight + Math.abs(c - l)); // 绘制当天最低价(线条高等于收盘价减去最低价)
			}
			this.height = rectObj.height;
			this.width = rectObj.width;
			
			addChild(rectObj);
		}
	}
}