package com.stock.control
{	
	import com.stock.model.DashLine;
	import com.stock.view.Linechart;
	
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import mx.core.UIComponent;
	
	import spark.components.Group;

	public class LinechartControl
	{
		public var linechart:Linechart;
		public static var instance:LinechartControl;
		private var x:int = 40;
		private var y:int = 85;
		private var spacingX:int = 25;
		private var spacingY:int = 81;
		
		private var wight:int = 650;
		private var height:int = 350;
		
		private var color:uint = 0xFF3232;			//涨颜色
		private var fallColor:uint = 0x00E600;		//跌颜色
		private var curveColor:uint = 0xffffff;		//曲线颜色
		
		private var ui:UIComponent = null;
		
		private var lastPoint1:Point = null;
		
		private var openingPrice:Number = 5;		//开盘价
		private var increase:Number = 0.01;			//加减值
		
		private var riseArray:Vector.<TextField> = null;	//涨数组
		private var fallArray:Vector.<TextField> = null;	//跌数组
		private var riseRatioArray:Vector.<TextField> = null;	//涨比例数组
		private var fallRatioArray:Vector.<TextField> = null;	//跌比例数组
		private var timerNum:int = 6;
		private var zhongdian:int = 0;
		
		private var lastNumbers:Vector.<Number> = null;
		private var group:Group = null;
		
		public function LinechartControl(linechart:Linechart)
		{
			instance = this;
			lastPoint1 = new Point();
			lastPoint1.x = x;
			this.linechart = linechart;
			ui = new UIComponent();
			this.linechart.addElement(ui);
			
			
			riseArray = new Vector.<TextField>();	
			fallArray = new Vector.<TextField>();	
			riseRatioArray = new Vector.<TextField>();	
			fallRatioArray = new Vector.<TextField>();	
			lastNumbers = new Vector.<Number>();
			
			graphics();

//			this.linechart.addEventListener(MouseEvent.CLICK,clickHandler);
		}
		
		private function clickHandler(e:MouseEvent):void{
			MainControl.instance.main.bargain.visible = false;
			this.linechart.scaleX = 1.5;
			this.linechart.scaleY = 1.5;
		}
		
		public function graphics():void{
			group = new Group();
			group.x = linechart.x;
			group.y = linechart.y;
			
			addLeftTextField();
			addRightTextField();
			
			this.linechart.graphics.lineStyle(1, color);
			this.linechart.graphics.drawRect(x, y, wight, height);
			
			var i:int = 0;
			for(i = 1;i < 14; i ++){
				
				var y1:int = y + spacingX * i;
				if(i == 7){
					zhongdian = y1;
					lastPoint1.y = zhongdian;
					this.linechart.graphics.lineStyle(2, color);
				}else{					
					this.linechart.graphics.lineStyle(1, color);
				}
				this.linechart.graphics.moveTo(wight + x, y1);
				this.linechart.graphics.lineTo(x , y1);
			}
			
			i = 0;
			for(i = 1;i <= 7; i ++){
				
				var x1:int = x + spacingY * i;
				if(i == 4){
					this.linechart.graphics.lineStyle(1, color);
					
					this.linechart.graphics.moveTo(x1, height + y);
					this.linechart.graphics.lineTo(x1, y);
				}else{
					var dl:DashLine = new DashLine();
					ui.addChild(dl.myInit(1, color, 1, x1, y, x1, height + y, 1, 1, 1));
				}
			}
			
			this.linechart.addElement(group);
		}
		
		public function addLeftTextField():void{
			var i:int = 0;
			var y1:int = 0;
			var text:TextField = null;
			
			for(i = 7;i >= 0; i --){
				y1 = y + spacingX * i;
				
				text = new TextField();
				text.selectable = false;
				
				if(i < 7){
					text.text = (openingPrice + ((7 - i) * increase)).toFixed(2) + "";
					text.textColor = color;
				}else if(i == 7){
					text.text = openingPrice + "";
					text.textColor = 0xffffff;
				}
				
				ui.addChild(text);
				text.x = x - text.textWidth - 10;
				text.y = y1 - int(text.textHeight / 2) - 2;
				riseArray.push(text);
			}
			
			for(i = 8;i < 15; i ++){
				y1 = y + spacingX * i;
				
				text = new TextField();
				text.selectable = false;
				
				if(i > 7){
					text.text = (openingPrice - ((i - 7) * increase)).toFixed(2) + "";
					text.textColor = fallColor;
				}
				
				ui.addChild(text);
				text.x = x - text.textWidth - 10;
				text.y = y1 - int(text.textHeight / 2) - 2;
				fallArray.push(text);
			}
		}
		
		public function addRightTextField():void{
			var i:int = 0;
			var y1:int = 0;
			var x1:int = 0;
			var text:TextField = null;
			
			for(i = 7;i >= 0; i --){
				y1 = y + spacingX * i;
				x1 = wight + spacingX;
				
				text = new TextField();
				text.selectable = false;
				
				var rise:Number = Number(riseArray[Math.abs(i - 7)].text);
				text.text = Number((rise - openingPrice) / openingPrice * 100).toFixed(2) + "%";
				if(i < 7){
					text.textColor = color;
				}else if(i == 7){
					text.textColor = 0xffffff;
				}
				
				ui.addChild(text);
				text.x = x1 + text.textWidth;
				text.y = y1 - int(text.textHeight / 2) - 2;
				riseRatioArray.push(text);
			}
			
			for(i = 8;i < 15; i ++){
				y1 = y + spacingX * i;
				x1 = wight + spacingX;
				
				text = new TextField();
				text.selectable = false;
				
				var fall:Number = Number(fallArray[i - 8].text);
				text.text = Number(Math.abs((fall - openingPrice) / openingPrice * 100)).toFixed(2) + "%";
				
				if(i > 7){
					text.textColor = fallColor;
				}
				
				ui.addChild(text);
				text.x = x1 + text.textWidth;
				text.y = y1 - int(text.textHeight / 2) - 2;
				fallRatioArray.push(text);
			}
		}
		
		private function againSetNumber(number:Number):void{
			var bool:int = 0;
			if(number > Number(riseArray[riseArray.length - 1].text)){
				increase = Math.abs((number - openingPrice) / 7);
				bool = 1;
			}else if(number < Number(fallArray[fallArray.length - 1].text)){
				increase = Math.abs((number - openingPrice) / 7);
				bool = 2;
			}
			if(bool == 1 || bool == 2){
				increase = Math.floor(increase * 100) / 100;
				
				var i:int = 0;
				var gap:Number = 0;
				var num:Number = 0;
				if(bool == 1){
					for(i = 1;i < riseArray.length; i ++){
						num = openingPrice + (increase * i);
						if(i == riseArray.length - 1){
							gap = number - Number(riseArray[i - 1].text);
							riseArray[i].text = number.toFixed(2);
						}else{
							riseArray[i].text = num.toFixed(2);
						}
						
					}
					for(i = 0;i < fallArray.length; i ++){
						num = openingPrice - (increase * (i + 1));
						if(i == fallArray.length - 1){
							fallArray[i].text = (Number(fallArray[i - 1].text) - gap).toFixed(2);
						}else{
							fallArray[i].text = num.toFixed(2);
						}
					}
				}else{
					for(i = 0;i < fallArray.length; i ++){
						num = openingPrice - (increase * (i + 1));
						if(i == fallArray.length - 1){
							gap = Math.abs(number - Number(fallArray[i - 1].text));
							fallArray[i].text = number.toFixed(2);
						}else{
							fallArray[i].text = num.toFixed(2);
						}
					}
					for(i = 1;i < riseArray.length; i ++){
						num = openingPrice + (increase * i);
						if(i == riseArray.length - 1){
							riseArray[i].text = (Number(riseArray[i - 1].text) + gap).toFixed(2);
						}else{
							riseArray[i].text = num.toFixed(2);
						}
						
					}
				}
				
				
				for(i = 1;i < riseRatioArray.length; i ++){
					var rise:Number = Number(riseArray[i].text);
					riseRatioArray[i].text = Number(Math.abs((rise - openingPrice) / openingPrice * 100)).toFixed(2) + "%";
				}
				
				for(i = 0;i < fallRatioArray.length; i ++){
					var fall:Number = Number(fallArray[i].text);
					fallRatioArray[i].text = Number(Math.abs((fall - openingPrice) / openingPrice * 100)).toFixed(2) + "%";
				}
			}
		}
		
		
		public function init(openingPrice:Number){
			this.openingPrice = openingPrice;
		}
		
		private var interval:Number = 650 / (4 * 3600.0 / timerNum);
//		private var interval:Number = 10;
		public function update(price:Number):void{
			var number:Number = price;
			againSetNumber(openingPrice + number);
			trace(openingPrice + number + " ---");
			lastNumbers.push(number);
			var i:int = 0;
			
			this.group.graphics.clear();
			var lastPoint:Point = null;
			for(i = 0;i < lastNumbers.length; i++){
				if(lastPoint == null){
					lastPoint = new Point();
					lastPoint.x = x;
					lastPoint.y = zhongdian;
				}
				
				var y1:int = 0;
				var cha:Number = lastNumbers[i];
				cha = Number(cha.toFixed(2));
				if(cha > 6 * increase){
					var sumDengfen:Number = Number(((Number(riseArray[riseArray.length - 1].text) - 
						Number(riseArray[riseArray.length - 2].text)) * 100).toFixed(2));
					var dengfen:int = (lastNumbers[i] - 6 * increase) * 100;
					y1 = 6 * spacingX + (spacingX / sumDengfen) * dengfen;
				}else if(cha < -6 * increase){
					var sumDengfen:Number = Number(((Number(fallArray[fallArray.length - 1].text) - 
						Number(fallArray[fallArray.length - 2].text)) * 100).toFixed(2));
					sumDengfen = Math.abs(sumDengfen);
					var dengfen:int = (Math.abs(lastNumbers[i]) - 6 * increase) * 100;
					dengfen = Math.abs(dengfen);
					y1 = -(6 * spacingX + (spacingX / sumDengfen) * dengfen);
				}else{
					y1 = lastNumbers[i] / increase * spacingX;
				}
				
				var newY:Number = zhongdian - y1;
				var newX:Number = lastPoint.x + interval;
				
				var point:Point = new Point();
				point.x = newX;
				point.y = newY;
				
				line(point, lastPoint);
				lastPoint = point;
			}
		}
		/**
		 * 画曲线
		 **/
		private function line(point:Point, lastPoint:Point):void{
			
			var i:int = 0;
			var lsatPointInt:int = 0;
			if(i > 0){
				lsatPointInt = i - 1;
			}
			this.group.graphics.lineStyle(1, curveColor);
			
			this.group.graphics.moveTo(lastPoint.x, lastPoint.y);
			this.group.graphics.lineTo(point.x , point.y);
			
			lastPoint = point;
		}
	}
}