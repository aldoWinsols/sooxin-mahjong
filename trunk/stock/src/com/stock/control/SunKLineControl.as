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
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.rpc.events.ResultEvent;

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
		private var dayHeight:int = 438;
		private var makeHeight:int = 538;
		
		private var minTurnover:Number = 0;
		
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
			
//			arrays = RemoteService.getInstance().klineService.getKlinesByStockCode("500001");
//			
//			loaderXml();
			loaddata();
		}
		
		public function loaddata(){
			RemoteService.getInstance().klineService.getKlinesByStockCode("500001");
			RemoteService.instance.klineService.addEventListener(ResultEvent.RESULT,resultHandler);
			
		}
		
		private function resultHandler(e:ResultEvent):void{
			RemoteService.instance.klineService.removeEventListener(ResultEvent.RESULT,resultHandler);
			
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
		}
		
		public function graphicsLazhu():void{
			sunKLine.border.graphics.lineStyle(1 ,0xff0000, 1);
			sunKLine.border.graphics.moveTo(0, dayHeight);
			sunKLine.border.graphics.lineTo(823, dayHeight);
			sunKLine.border.graphics.lineStyle(1 ,0xff0000, 1);
			sunKLine.border.graphics.moveTo(0, makeHeight);
			sunKLine.border.graphics.lineTo(823, makeHeight);
			
			sunKLine.addEventListener(MouseEvent.MOUSE_WHEEL, onWheel);
			this.lowest = arrays[0].min;
			this.max = arrays[0].min;
			this.minTurnover = arrays[0].turnover;
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
				multiple = 0.2;
			}
			
			for(var i:int = 0;i < arrays.length; i++){
				graphics(i, arrays[i]);
				graphicsMake(i, arrays[i]);
			}
			trace(lowest);
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
			draw.x = i * 9;
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
			var drawRect:DrawRect = new DrawRect(sunkInfo, minTurnover);
			
			drawRect.x = i * 9;
			drawRect.y = this.makeHeight - drawRect.height;
			sunKLine.border1.addElement(drawRect);
		}
		
		public function onWheel(e:MouseEvent):void{
			if(e.delta > 0){
				sunKLine.border1.scaleX += 0.1;
				sunKLine.border1.scaleY += 0.1;
			}else{
				sunKLine.border1.scaleX -= 0.1;
				sunKLine.border1.scaleY -= 0.1;
			}
		}
	}
}