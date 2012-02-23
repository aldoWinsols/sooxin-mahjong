package com.amusement.HundredHappy.control
{
	import com.amusement.HundredHappy.model.HistoryBig;
	import com.amusement.HundredHappy.model.HistorySmall;
	import com.amusement.HundredHappy.view.HistoryPanel;
	
	import flash.geom.Point;

	public class HistoryPanelControl
	{
		private static var _instance:HistoryPanelControl;
		
		private var _historyPanel:HistoryPanel;
		
		private var _bigMaxRow:int = 6;
		private var _bigSize:Number = 21.5;
		private var _smallMaxRow:int = 12;
		private var _smallMaxColumu:int = 50;
		private var _smallSize:Number = 10.75;
		
		private var _bigCurrentRow:int = 0;
		private var _bigCurrentColumn:int = 0;
		
		private var _smallLimitRow:int;
		private var _smallLimitColumn:int;
		private var _smallCurrentRow:int = 0;
		private var _smallCurrentColumn:int = 0;
		
		private var _lastSmallHistory:HistorySmall;
		private var _lastStr:String = "";
		
		private var _smallArr:Array;
		
		private var _askZhangBig:HistoryBig;
		private var _askXianBig:HistoryBig;
		private var _askZhangSmall:HistorySmall;
		private var _askXianSmall:HistorySmall;
		
		public function HistoryPanelControl(historyPanel:HistoryPanel)
		{
			_instance = this;
			
			this._historyPanel = historyPanel;
			
			init();
		}
		
		private function init():void{
			_askZhangBig = new HistoryBig("z", 0, true);
			_askXianBig = new HistoryBig("x", 0, true);
			_askZhangSmall = new HistorySmall("z", 0, true);
			_askXianSmall = new HistorySmall("x", 0, true);
			
			_smallLimitRow = _smallMaxRow;
			_smallLimitColumn = 0;
			
			_smallArr = [];
			for(var i:int = 0; i < _smallMaxColumu; i ++){
				_smallArr[i] = [];
			}
		}
		
		public function askWay(str:String):void{
			var askBig:HistoryBig;
			var askSmall:HistorySmall;
			switch(str){
				case "z":
					askBig = _askZhangBig;
					askSmall = _askZhangSmall;
					break;
				case "x":
					askBig = _askXianBig;
					askSmall = _askXianSmall;
					break;
			}
			
			if(_bigCurrentRow == _bigMaxRow){
				askBig.x = (_bigCurrentColumn + 1) * _bigSize;
				askBig.y = 0;
			}else{
				askBig.x = _bigCurrentColumn * _bigSize;
				askBig.y = _bigCurrentRow * _bigSize;
			}
			
			if(str == _lastStr){
				var row:int = _smallCurrentRow + 1;
				var col:int = _smallCurrentColumn;
				if(row >= _smallLimitRow){
					row = _smallLimitRow - 1;
					col = _smallCurrentColumn - (_smallCurrentRow - row + 1);
					if(col < _smallLimitColumn){
						if(_smallLimitColumn - col == 1){
							col = _smallCurrentColumn + 1;
						}else{
							col = _smallCurrentColumn + (_smallCurrentRow - row + 1);
							if(col >= _smallMaxColumu){
								col = _smallCurrentColumn - (col - _smallMaxColumu + 1);
							}
						}
					}
				}
				
				askSmall.x = col * _smallSize;
				askSmall.y = row * _smallSize;
			}else{
				if(_lastStr != ""){
					askSmall.x = (_smallCurrentColumn + 1) * _smallSize;
				}
				askSmall.y = 0;
			}
			
			this._historyPanel.shu.addElement(askBig);
			this._historyPanel.heng.addElement(askSmall);
			
			askBig.startTwinkle();
			askSmall.startTwinkle();
		}
		
		public function addHistory(str:String, type:int):void{
			addHistoryBig(str, type);
			addHistorySmall(str);
		}
		
		public function addHistoryBig(str:String, type:int):void{
			if(_bigCurrentRow == _bigMaxRow){
				_bigCurrentColumn ++;
				_bigCurrentRow = 0;
			}
			
			var historyBig:HistoryBig = new HistoryBig(str, type);
			this._historyPanel.shu.addElement(historyBig);
			historyBig.x = _bigCurrentColumn * _bigSize;
			historyBig.y = _bigCurrentRow * _bigSize;
			
			_bigCurrentRow ++;
		}
		
		public function addHistorySmall(str:String):void{
			var historySmall:HistorySmall;
			
			var realRow:int;
			var realCol:int;
			
			if(str == "h"){
				//判断是否有第一个路珠
				if(_lastSmallHistory){
					//判断上个路珠是否是代表和
//					if(_lastSmallHistory.hCount == 0){
//						historySmall = new HistorySmall(_lastStr, 1);
//						
//						var pt:Point = getRealPoint();
//						realRow = pt.y;
//						realCol = pt.x;
//					}else{
						historySmall = _lastSmallHistory;
						historySmall.updateHCount();
						
						realRow = _lastSmallHistory.y / _smallSize;
						realCol = _lastSmallHistory.x / _smallSize;
//					}
				}else{
					historySmall = new HistorySmall(str, 1);
					realRow = 0;
					realCol = 0;
				}
			}else{
				historySmall = new HistorySmall(str);
				
				if(str == _lastStr){
					var realPt:Point = getRealPoint();
					realRow = realPt.y;
					realCol = realPt.x;
				}else{
					if(_lastStr == ""){
						//判断有第一个路珠（为和），用本次路珠类型替换
						if(_lastSmallHistory){
							//替换原和
							this._historyPanel.heng.removeElement(_lastSmallHistory);
							
							historySmall = new HistorySmall(str, _lastSmallHistory.hCount);
							
							//替换原和，增加新路珠
//							var hs:HistorySmall = new HistorySmall(str, _lastSmallHistory.hCount);
//							this._historyPanel.heng.addElement(hs);
							
//							_smallArr[0][0] = hs;
							
//							_smallCurrentRow ++;
						}
						
						_smallLimitRow = _smallMaxRow;
						_smallLimitColumn = 0;
						
						realRow = _smallCurrentRow;
						realCol = _smallCurrentColumn;
					}else{
						_smallCurrentColumn ++;
						_smallCurrentRow = 0;
						
						for(_smallLimitRow = 0; _smallLimitRow < _smallMaxRow; _smallLimitRow ++){
							if(_smallArr[_smallCurrentColumn][_smallLimitRow] != null){
								break;
							}
						}
						
						for(_smallLimitColumn = _smallCurrentColumn; _smallLimitColumn > 0; _smallLimitColumn --){
							if(_smallArr[_smallLimitColumn - 1][_smallLimitRow - 1] != null){
								break;
							}
						}
						
						realRow = _smallCurrentRow;
						realCol = _smallCurrentColumn;
					}
				}
				
				_lastStr = str;
			}
			
			if(historySmall){
				this._historyPanel.heng.addElement(historySmall);
				historySmall.x = realCol * _smallSize;
				historySmall.y = realRow * _smallSize;
				
				_smallArr[realCol][realRow] = historySmall;
				
				_lastSmallHistory = historySmall;
			}
			
		}
		
		public function clearHistory():void{
			this._historyPanel.heng.removeAllElements();
			this._historyPanel.shu.removeAllElements();
			
			for(var i:int = 0; i < _smallMaxColumu; i ++){
				for(var j:int = 0; j < _smallMaxRow; j ++){
					_smallArr[i][j] = null;
				}
			}
			
			_bigCurrentColumn = 0;
			_bigCurrentRow = 0;
			
			_smallLimitRow = _smallMaxRow;
			_smallLimitColumn = 0;
			_smallCurrentColumn = 0;
			_smallCurrentRow = 0;
			
			_lastSmallHistory = null;
			_lastStr = "";
		}
		
		/**
		 * 获取路珠真实位置 
		 * @return 
		 * 
		 */
		private function getRealPoint():Point{
			var realPoint:Point = new Point();
			
			_smallCurrentRow ++;
			if(_smallCurrentRow < _smallLimitRow){
				realPoint.y = _smallCurrentRow;
				realPoint.x = _smallCurrentColumn;
			}else{
				realPoint.y = _smallLimitRow - 1;
				realPoint.x = _smallCurrentColumn - (_smallCurrentRow - realPoint.y);
				if(realPoint.x < _smallLimitColumn){
					var px:Number;
					for(var col:int = _smallLimitColumn; col < _smallCurrentColumn; col ++){
						px = 2 * _smallCurrentColumn - col;
						if(_smallArr[col][realPoint.y] != null && _smallArr[px][realPoint.y] == null){
							var hs:HistorySmall = _smallArr[col][realPoint.y];
							_smallArr[px][realPoint.y] = hs;
							_smallArr[col][realPoint.y] = null;
							hs.x = px * _smallSize;
						}
					}
					
					realPoint.x = _smallCurrentColumn + (_smallCurrentRow - realPoint.y);
					if(realPoint.x >= _smallMaxColumu){
						realPoint.x = _smallCurrentColumn - (realPoint.x - _smallMaxColumu + 1);
						//极端情况 -- 极限行占完仍有新纪录（未考虑）
					}
				}
			}
			
			return realPoint;
		}
		
		public static function get instance():HistoryPanelControl
		{
			return _instance;
		}
	}
}