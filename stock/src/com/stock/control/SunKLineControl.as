package com.stock.control
{
	import com.stock.model.DrawCandle;
	import com.stock.model.DrawRect;
	import com.stock.model.SunKInfo;
	import com.stock.services.RemoteService;
	import com.stock.view.SunKLine;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import mx.core.UIComponent;
	import mx.rpc.events.ResultEvent;
	
	import spark.components.Button;

	public class SunKLineControl
	{
		public var sunKLine:SunKLine = null;
		private var lowest:Number = 0;
		private var max:Number = 0;
		private var multiple:Number = 0;
		private var lazhuArr:Vector.<SunKInfo> = null;
		private var arrays:Vector.<SunKInfo> = null;
		private var kXmlStr:String = "http://image.wolun.com.cn/stock_k.php?code=00001&type=day";
		private var kXml:XML = new XML();
		private var netLoader:URLLoader = null;
		public var urlList:XMLList;
		private var fiveDayPoint:Point = null;
		private var tenDayPoint:Point = null;
		private var twentyFiveDayPoint:Point = null;
		private var dayHeight:int = 480;
		private var makeHeight:int = 580;
		private var x:Number = 750;
		private var interval:int = 8;
		private var lineColor:uint = 0xff0000;
		
		private var minTurnover:Number = 0;
		private var maxTurnover:Number = 0;
		private var makeNum:Number = 0;
		private var makeInterval:Number = 4;
		
		private var todaySunKInfo:SunKInfo = null;
		
		private var timer:Timer = null;
		
		public static var instance:SunKLineControl;
		
		public function SunKLineControl(sunKLine:SunKLine)
		{
			this.sunKLine = sunKLine;
			instance = this;
			
			lazhuArr = new Vector.<SunKInfo>();
			arrays = new Vector.<SunKInfo>();
			
			fiveDayPoint = new Point();
			tenDayPoint = new Point();
			twentyFiveDayPoint = new Point();
			
//			loaderXml();
//			initTimer();
			loaddata();
		}
		
		public function loaddata(){
			RemoteService.getInstance().lineService.getKlinesByStockCode("500001");
			RemoteService.instance.lineService.addEventListener(ResultEvent.RESULT,resultHandler);
			
		}
		
		private function resultHandler(e:ResultEvent):void{
			RemoteService.instance.lineService.removeEventListener(ResultEvent.RESULT,resultHandler);
			
			var arr = e.result;
			for each(var obj:Object in arr){
				var sunk:SunKInfo = new SunKInfo(obj.date, obj.startNum, obj.finistNum, obj.topNum, obj.lastNum, obj.turnover);
				arrays.push(sunk);
			}
			graphicsLazhu();
		}
		
		private function loaderXml():void{
			
			netLoader = new URLLoader(new URLRequest(kXmlStr));
			netLoader.addEventListener(Event.COMPLETE, netLoadCompleteHandler, false, 0, true);
			netLoader.addEventListener(IOErrorEvent.IO_ERROR,netErrorHandler);
		}
		
		private function netErrorHandler(e:IOErrorEvent):void{
			
		}
		
		private function netLoadCompleteHandler(event:Event):void{
			var loader:URLLoader = URLLoader(event.currentTarget);
			var configXML:XML = XML(loader.data);
			urlList = configXML.detail;
			
			for each(var xml:XML in urlList){
				var sunk:SunKInfo = new SunKInfo(xml.@date, xml.@startNum, xml.@finistNum, xml.@topNum, xml.@lastNum, xml.@turnover);
				arrays.push(sunk);
			}
			
			graphicsLazhu();
			
			var btn:Button = new Button();
			btn.label = "clear";
			btn.addEventListener(MouseEvent.CLICK, onMouse);
			sunKLine.addElement(btn);
			
			var btn:Button = new Button();
			btn.label = "data";
			btn.x = 30;
			btn.addEventListener(MouseEvent.CLICK, onMouse1);
			sunKLine.addElement(btn);
		}
		
		private function onMouse(e:MouseEvent):void{
			clearData();
		}
		
		private function onMouse1(e:MouseEvent):void{
			graphicsLazhu();
		}
		
		public function graphicsLazhu():void{
//			timer.start();
			
			sunKLine.border.graphics.lineStyle(1 ,lineColor, 1);
			sunKLine.border.graphics.moveTo(5, dayHeight);
			sunKLine.border.graphics.lineTo(x, dayHeight);
			sunKLine.border.graphics.lineStyle(1 ,lineColor, 1);
			sunKLine.border.graphics.moveTo(5, makeHeight);
			sunKLine.border.graphics.lineTo(x, makeHeight);
			
			sunKLine.border.graphics.lineStyle(1 ,lineColor, 1);
			sunKLine.border.graphics.moveTo(x, 0);
			sunKLine.border.graphics.lineTo(x, makeHeight);
			
			sunKLine.addEventListener(MouseEvent.MOUSE_WHEEL, onWheel);
			this.lowest = arrays[0].min;
			this.max = arrays[0].min;
			this.minTurnover = arrays[0].turnover;
			this.maxTurnover = arrays[0].turnover;
			for(var i:int = 0;i < arrays.length; i++){
				if(arrays[i].min < lowest){
					lowest = arrays[i].min;
				}
				if(arrays[i].min > max){
					max = arrays[i].min;
				}
				if(arrays[i].turnover < minTurnover){
					minTurnover = arrays[i].turnover;
				}
				if(arrays[i].turnover > maxTurnover){
					maxTurnover = arrays[i].turnover;
				}
			}
			
			var num:Number = max - lowest;
			if(num < 1){
				multiple = 2;
			}else if(num >= 1 && num < 2){
				multiple = 1.5;
			}else if(num >= 2 && num < 3){
				multiple = 1;
			}else if(num >= 3 && num < 4){
				multiple = 0.5;
			}else{
				multiple = 0.1;
			}
			graphicsScale();
			
			makeNum = maxTurnover / (this.makeHeight - this.dayHeight);
			
			graphicsMakeScale();
			
			for(var i:int = 0;i < arrays.length; i++){
				graphics(i, arrays[i]);
				graphicsMake(i, arrays[i]);
			}
			trace(lowest);
		}
		
		private function graphicsScale():void{
			
			var num:Number = max - lowest;
			num = num / interval;
			var text:TextField = null;
			var ui:UIComponent = new UIComponent();
			sunKLine.border1.addElement(ui);
			
			text = new TextField();
			text.selectable = false;
			text.text = Number(lowest).toFixed(2);
			text.textColor = lineColor;
			text.x = x + 20;
			text.y = dayHeight - text.textHeight / 2;
			ui.addChild(text);
			
			var i:int = 0;
			for(i = 1;i <= interval; i++){
				
				var yControl:Number = dayHeight - num * i;
				yControl = dayHeight - num * i * 100 * multiple;
				
				sunKLine.border.graphics.lineStyle(1 ,lineColor, 1);
				sunKLine.border.graphics.moveTo(x, yControl);
				sunKLine.border.graphics.lineTo(x + 5, yControl);
				
				text = new TextField();
				text.selectable = false;
				text.text = Number(lowest + num * i).toFixed(2);
				text.textColor = lineColor;
				text.x = x + 20;
				text.y = yControl - text.textHeight / 2;
				
				ui.addChild(text);
			}
		}
		
		private function graphics(i:Number, sunkInfo:SunKInfo):void{
			var yControl:Number = 0;
//			trace("-- " + sunkInfo.min);
			if(sunkInfo.min > lowest && lowest != 0){
				yControl = (sunkInfo.min - lowest) * 100 * multiple;
				yControl = Number(yControl.toFixed(2));
				yControl = dayHeight - yControl;
			}else{
				lowest = sunkInfo.min;
				yControl = dayHeight;
			}
			
			var draw:DrawCandle = new DrawCandle(sunkInfo.kaipan, sunkInfo.shoupan, sunkInfo.max, sunkInfo.min);
			draw.x = i * 9 + 10;
			draw.y = yControl - draw.height;
			sunKLine.border1.addElement(draw);
			
			var num:int = i + 1;
			var xControl:Number = 0;
			var averageNum:Number = 0;
			if(num >= 5){
				averageNum = fiveDayAverage(num, 5);
				yControl = (averageNum - lowest) * 100 * multiple;
				yControl = dayHeight - yControl;
				xControl = i * 9 + draw.width / 2;
				
				if(fiveDayPoint.x > 0){
					sunKLine.border1.graphics.lineStyle(1, 0xffffff,1);
					sunKLine.border1.graphics.moveTo(fiveDayPoint.x, fiveDayPoint.y);
					sunKLine.border1.graphics.lineTo(xControl, yControl);
				}
				fiveDayPoint.x = xControl;
				fiveDayPoint.y = yControl;
				
			}
			if(num >= 10){
				averageNum = fiveDayAverage(num, 10);
				yControl = (averageNum - lowest) * 100 * multiple;
				yControl = dayHeight - yControl;
				xControl = i * 9 + draw.width / 2;
				
				if(tenDayPoint.x > 0){
					sunKLine.border1.graphics.lineStyle(1, 0xfff000,1);
					sunKLine.border1.graphics.moveTo(tenDayPoint.x, tenDayPoint.y);
					sunKLine.border1.graphics.lineTo(xControl, yControl);
				}
				tenDayPoint.x = xControl;
				tenDayPoint.y = yControl;
				
			}
			if(num >= 25){
				averageNum = fiveDayAverage(num, 25);
				yControl = (averageNum - lowest) * 100 * multiple;
				yControl = dayHeight - yControl;
				xControl = i * 9 + draw.width / 2;
				
				if(twentyFiveDayPoint.x > 0){
					sunKLine.border1.graphics.lineStyle(1, 0xf000ff,1);
					sunKLine.border1.graphics.moveTo(twentyFiveDayPoint.x, twentyFiveDayPoint.y);
					sunKLine.border1.graphics.lineTo(xControl, yControl);
				}
				twentyFiveDayPoint.x = xControl;
				twentyFiveDayPoint.y = yControl;
				
			}
		}
		
		/**
		 * 5日平均数 
		 * @param i
		 * @return 
		 * 
		 */
		private function fiveDayAverage(i:int, num:int):Number{
			var sumNumber:Number = 0;
			for(var j:int = i - num;j < i; j++){
				sumNumber += arrays[j].shoupan;
			}
			
			sumNumber = sumNumber / num;
			
			return Number(sumNumber.toFixed(2));
		}
		
		private function graphicsMake(i:int, sunkInfo:SunKInfo):void{
			var num:Number = sunkInfo.turnover / makeNum;
			
			var drawRect:DrawRect = new DrawRect(sunkInfo, num);
			
			drawRect.x = i * 9;
			drawRect.y = this.makeHeight - drawRect.height;
			sunKLine.border1.addElement(drawRect);
		}
		
		private function graphicsMakeScale():void{
			var num:Number = (this.makeHeight - this.dayHeight) / makeInterval;
			var text:TextField = null;
			var ui:UIComponent = new UIComponent();
			sunKLine.border1.addElement(ui);
			
			var i:int = 0;
			for(i = 1;i < makeInterval; i++){
				
				var yControl:Number = makeHeight - num * i;
				
				sunKLine.border.graphics.lineStyle(1 ,lineColor, 1);
				sunKLine.border.graphics.moveTo(x, yControl);
				sunKLine.border.graphics.lineTo(x + 5, yControl);
				
				text = new TextField();
				text.selectable = false;
				text.text = Number(makeNum * i * num).toFixed(0);
				text.textColor = lineColor;
				text.x = x + 20;
				text.y = yControl - text.textHeight / 2;
				
				ui.addChild(text);
			}
		}
		
		public function onWheel(e:MouseEvent):void{
			if(e.delta > 0){
				sunKLine.border1.scaleX += 0.1;
//				sunKLine.border1.scaleY += 0.1;
			}else{
				sunKLine.border1.scaleX -= 0.1;
//				sunKLine.border1.scaleY -= 0.1;
			}
		}
		
		/**
		 * 初始化timer
		 * 
		 */
		private function initTimer():void{
			timer = new Timer(6000, 0);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		
		private function onTimer(e:TimerEvent):void{
			if(todaySunKInfo == null){
				var sk:SunKInfo = arrays[arrays.length - 1];
				todaySunKInfo = new SunKInfo("", sk.kaipan, sk.shoupan, sk.max, sk.min);
				arrays.push(todaySunKInfo);
			}else{
				var num = 0.1;
				if(int(Math.random() * 10) > 5){
					num = num * -1;
				}
				todaySunKInfo.kaipan += num;
				todaySunKInfo.shoupan += num;
				todaySunKInfo.max += num;
				todaySunKInfo.min += num;
				sunKLine.border1.removeElementAt(sunKLine.border1.numElements - 1);
			}
			
			graphics(arrays.length - 1, todaySunKInfo);
		}
		
		/**
		 * 清楚所有数据
		 * 
		 */
		private function clearData():void{
//			arrays = new Vector.<SunKInfo>();
			fiveDayPoint = new Point();
			tenDayPoint = new Point();
			twentyFiveDayPoint = new Point();
			sunKLine.border1.removeAllElements();
			sunKLine.border1.graphics.clear();
			timer.stop();
		}
	}
}