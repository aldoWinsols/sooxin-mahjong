package com.stock.control
{
	import com.stock.model.DashLine;
	import com.stock.model.TimeShareData;
	import com.stock.view.Linechart;
	
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
		private var y:int = 100;
		private var spacingX:int = 25;
		private var spacingY:int = 81;
		
		private var wight:int = 650;
		private var height:int = 500;
		
		private var color:uint = 0xFF3232;			//涨颜色
		private var fallColor:uint = 0x00E600;		//跌颜色
		private var curveColor:uint = 0xffffff;		//曲线颜色
		private var makeColor:uint = 0xfff000;		//成交量颜色
		private var junlineColor:uint = 0xfff000;	//均价颜色
		
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
		
		private var averageNumbers:Vector.<Number> = null;
		
		private var timeShareDatas:Vector.<TimeShareData> = null;
		
		private var maxMake:Number = spacingX;
		
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
			averageNumbers = new Vector.<Number>();
			
			timeShareDatas = new Vector.<TimeShareData>();
			
			graphics();
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
			for(i = 1;i < 20; i ++){
				
				var y1:int = y + spacingX * i;
				if(i == 7){
					zhongdian = y1;
					lastPoint1.y = zhongdian;
					this.linechart.graphics.lineStyle(2, color);
				}else if(i == 14){					
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

		private var interval:Number = 650 / (4 * 3600.0 / 60);
		//		private var interval:Number = 10;
		public function update(timeStr:String,price:Number,turnover:Number){
			againSetNumber(openingPrice + price);
			
			var num:int = int(Math.random() * 5) + 1;
			
			if(timeShareDatas.length == 0 || timeShareDatas[timeShareDatas.length - 1].time != timeStr){
				var timeShareData:TimeShareData = new TimeShareData();
				timeShareData.time = timeStr;
				timeShareData.price = price;
				timeShareData.turnover = turnover;
				
				trace(timeStr + " == ");
				
				timeShareDatas.push(timeShareData);
				averageNumbers.push(price + (num / 100));
			}else{
				timeShareDatas[timeShareDatas.length - 1].time = timeStr;
				timeShareDatas[timeShareDatas.length - 1].price = price;
				timeShareDatas[timeShareDatas.length - 1].turnover += turnover;
				trace(timeStr + " -- ");
			}
			var i:int = 0;
			
			this.group.graphics.clear();
			
			var lastPoint:Point = null;
			var junlinePoint:Point = null;
			
			for(i = 0;i < timeShareDatas.length; i++){
				if(lastPoint == null){
					lastPoint = new Point();
					lastPoint.x = x;
					lastPoint.y = zhongdian;
				}
				
				var y1:int = 0;
				var cha:Number = timeShareDatas[i].price;
				cha = Number(cha.toFixed(2));
				if(cha > 6 * increase){
					var sumDengfen:Number = Number(((Number(riseArray[riseArray.length - 1].text) - 
						Number(riseArray[riseArray.length - 2].text)) * 100).toFixed(2));
					var dengfen:int = (timeShareDatas[i].price - 6 * increase) * 100;
					y1 = 6 * spacingX + (spacingX / sumDengfen) * dengfen;
				}else if(cha < -6 * increase){
					var sumDengfen:Number = Number(((Number(fallArray[fallArray.length - 1].text) - 
						Number(fallArray[fallArray.length - 2].text)) * 100).toFixed(2));
					sumDengfen = Math.abs(sumDengfen);
					var dengfen:int = (Math.abs(timeShareDatas[i].price) - 6 * increase) * 100;
					dengfen = Math.abs(dengfen);
					y1 = -(6 * spacingX + (spacingX / sumDengfen) * dengfen);
				}else{
					y1 = timeShareDatas[i].price / increase * spacingX;
				}
				
				var newY:Number = zhongdian - y1;
				var newX:Number = lastPoint.x + interval;
				
				var point:Point = new Point();
				point.x = newX;
				point.y = newY;
				
				line(point, lastPoint, curveColor);
				
				for(var j:int = 0;j < timeShareDatas.length; j ++){
					if(timeShareDatas[j].turnover > maxMake * 6){
						maxMake = timeShareDatas[j].turnover / 6;
						maxMake = Number(maxMake.toFixed(2));
					}
				}
				
				lineMake(timeShareDatas[i].turnover, point);
				lastPoint = point;
			}
			
			// 平均值
			for(i = 0;i < averageNumbers.length; i++){
				if(junlinePoint == null){
					junlinePoint = new Point();
					junlinePoint.x = x;
					junlinePoint.y = zhongdian;
				}
				
				var y1:int = 0;
				var cha:Number = averageNumbers[i];
				cha = Number(cha.toFixed(2));
				if(cha > 6 * increase){
					var sumDengfen:Number = Number(((Number(riseArray[riseArray.length - 1].text) - 
						Number(riseArray[riseArray.length - 2].text)) * 100).toFixed(2));
					var dengfen:int = (averageNumbers[i] - 6 * increase) * 100;
					y1 = 6 * spacingX + (spacingX / sumDengfen) * dengfen;
				}else if(cha < -6 * increase){
					var sumDengfen:Number = Number(((Number(fallArray[fallArray.length - 1].text) - 
						Number(fallArray[fallArray.length - 2].text)) * 100).toFixed(2));
					sumDengfen = Math.abs(sumDengfen);
					var dengfen:int = (Math.abs(averageNumbers[i]) - 6 * increase) * 100;
					dengfen = Math.abs(dengfen);
					y1 = -(6 * spacingX + (spacingX / sumDengfen) * dengfen);
				}else{
					y1 = averageNumbers[i] / increase * spacingX;
				}
				
				var newY:Number = zhongdian - y1;
				var newX:Number = junlinePoint.x + interval;
				
				var point:Point = new Point();
				point.x = newX;
				point.y = newY;
				
				line(point, junlinePoint, junlineColor);
				junlinePoint = point;
			}
		}
		/**
		 * 画曲线
		 **/
		private function line(point:Point, lastPoint:Point, color:uint):void{
			
			var i:int = 0;
			var lsatPointInt:int = 0;
			if(i > 0){
				lsatPointInt = i - 1;
			}
			this.group.graphics.lineStyle(1, color);
			
			this.group.graphics.moveTo(lastPoint.x, lastPoint.y);
			this.group.graphics.lineTo(point.x , point.y);
		}
		
		private function lineMake(makeNum:Number, point:Point):void{
			var num:Number = makeNum / maxMake;
			makeNum = spacingX * num;
			if(makeNum > spacingX * 6){
				makeNum = spacingX * 6;
			}
			
			this.group.graphics.lineStyle(1, makeColor);
			
			this.group.graphics.moveTo(point.x, height + y);
			this.group.graphics.lineTo(point.x , height + y - makeNum);
		} 
	}
}