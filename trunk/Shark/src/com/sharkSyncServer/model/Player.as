package com.sharkSyncServer.model
{
	import com.sharkSyncServer.util.Util;
	/**
	 * 
	 * @author Administrator
	 * 2012-3-2 14:54 gmr start 保留上次投注的金额
	 */
	public class Player {
		public var playername:String;
	
		public var dabaishaT:int = 0;
		public var shiziT:int = 0;
		public var laoyingT:int = 0;
		public var laohuT:int = 0;
		public var xiongmaoT:int = 0;
		public var kongqueT:int = 0;
		public var geziT:int = 0;
		public var yanziT:int = 0;
		public var houziT:int = 0;
		public var feiqinT:int = 0;
		public var zoushouT:int = 0;	
		
		// 2012-3-2 14:54 gmr start 保留上次投注的金额
		public var lastTouzhu:int = 0;
		// 2012-3-2 14:54 gmr end
		
		public function allTouzhu():int{
			return dabaishaT+shiziT+laoyingT+laohuT+xiongmaoT+kongqueT+geziT+yanziT+houziT+feiqinT+zoushouT;
		}
		
		public function clear():void{
			lastTouzhu = 0;
			dabaishaT = 0;
			shiziT = 0;
			laoyingT = 0;
			laohuT = 0;
			xiongmaoT = 0;
			kongqueT = 0;
			geziT = 0;
			yanziT = 0;
			houziT = 0;
			feiqinT = 0;
			zoushouT = 0;
		}
		
		public function gameContent(ran:int):String{
			var str:String = "";
			str += "大白鲨:"+dabaishaT+",";
			str += "狮子:"+shiziT+",";
			str += "老鹰:"+laoyingT+",";
			str += "老虎:"+laohuT+",";
			str += "熊猫:"+xiongmaoT+",";
			str += "孔雀:"+kongqueT+",";
			str += "鸽子:"+geziT+",";
			str += "燕子:"+yanziT+",";
			str += "猴子:"+houziT+",";
			str += "飞禽:"+feiqinT+",";
			str += "走兽:"+zoushouT+",";
			str += "中奖动物:"+Util.getResultAnimal(ran);
			
			return str;
		}
		
		//获得投住情况
		public function getTouzhu():Object{
			var array:Array = [ yanziT,geziT,kongqueT,laoyingT,feiqinT,dabaishaT,zoushouT,shiziT,laohuT,xiongmaoT,houziT];
			return array;
		}
	
		
		public function changeNum(ran:int):int{
				var resAnimal:String = "";
	
				var pValue:int = 0;
				var changeNum:int = 0;
				
				if(ran == 0 || ran == 6 ||ran == 19 ){
					resAnimal = "xiongmao";
					pValue = 8;
					changeNum = pValue * xiongmaoT + 2* zoushouT;
				}else if(ran == 1|| ran == 10){
					resAnimal = "shizi";
					pValue = 12;
					changeNum = pValue * shiziT + 2* zoushouT;
				}
				else if(ran == 3|| ran == 8 || ran == 14 || ran == 21){
					resAnimal = "houzi";
					pValue = 6;
					changeNum = pValue * houziT + 2* zoushouT;
				}
				else if(ran == 4|| ran == 11 || ran == 17){
					resAnimal = "laohu";
					pValue = 8;
					changeNum = pValue * laohuT + 2* zoushouT;
				}
				else if(ran == 2|| ran == 9 || ran ==15 || ran == 20){
					resAnimal = "yanzi";
					pValue = 6;
					changeNum = pValue * yanziT + 2* feiqinT;
				}
				else if(ran == 5|| ran == 16 || ran == 23){
					resAnimal = "kongque";
					pValue = 8;
					changeNum = pValue * kongqueT + 2* feiqinT;
				}
				else if(ran == 7|| ran == 12 || ran == 18){
					resAnimal = "gezi";
					pValue = 8;
					changeNum = pValue * geziT + 2* feiqinT;
				}
				else if(ran == 13|| ran == 22){
					resAnimal = "laoyin";
					pValue = 12;
					changeNum = pValue * laoyingT + 2* feiqinT;
				}
				else if(ran == 24|| ran == 26 ){
					resAnimal = "dabaisha";
					pValue = 24;
					changeNum = pValue * dabaishaT;
				}
				else if(ran == 25|| ran == 27 ){
					resAnimal = "lieqiang";
					changeNum = 0;
				}
				return changeNum - allTouzhu();
			}
	}
}