package com.hundredHappySyncServer.util
{
	import com.hundredHappySyncServer.model.Poker;
	import com.hundredHappySyncServer.model.Record;

	public class Util
	{
		public var pokers:Vector.<Poker> = new Vector.<Poker>();
		private static var _instance:Util = null;
		
		public function set instance():Util{
			if(_instance == null){
				_instance = new Util();
			}
			return _instance;
		}
		
		public function Util()
		{
			//方块
			pokers.push(new Poker("F",1));
			pokers.push(new Poker("F",2));
			pokers.push(new Poker("F",3));
			pokers.push(new Poker("F",4));
			pokers.push(new Poker("F",5));
			pokers.push(new Poker("F",6));
			pokers.push(new Poker("F",7));
			pokers.push(new Poker("F",8));
			pokers.push(new Poker("F",9));
			pokers.push(new Poker("F",10));
			pokers.push(new Poker("F",11));
			pokers.push(new Poker("F",12));
			pokers.push(new Poker("F",13));
			
			//红桃
			pokers.push(new Poker("R",1));
			pokers.push(new Poker("R",2));
			pokers.push(new Poker("R",3));
			pokers.push(new Poker("R",4));
			pokers.push(new Poker("R",5));
			pokers.push(new Poker("R",6));
			pokers.push(new Poker("R",7));
			pokers.push(new Poker("R",8));
			pokers.push(new Poker("R",9));
			pokers.push(new Poker("R",10));
			pokers.push(new Poker("R",11));
			pokers.push(new Poker("R",12));
			pokers.push(new Poker("R",13));
			
			//黑桃
			pokers.push(new Poker("B",1));
			pokers.push(new Poker("B",2));
			pokers.push(new Poker("B",3));
			pokers.push(new Poker("B",4));
			pokers.push(new Poker("B",5));
			pokers.push(new Poker("B",6));
			pokers.push(new Poker("B",7));
			pokers.push(new Poker("B",8));
			pokers.push(new Poker("B",9));
			pokers.push(new Poker("B",10));
			pokers.push(new Poker("B",11));
			pokers.push(new Poker("B",12));
			pokers.push(new Poker("B",13));
			
			//梅花
			pokers.push(new Poker("M",1));
			pokers.push(new Poker("M",2));
			pokers.push(new Poker("M",3));
			pokers.push(new Poker("M",4));
			pokers.push(new Poker("M",5));
			pokers.push(new Poker("M",6));
			pokers.push(new Poker("M",7));
			pokers.push(new Poker("M",8));
			pokers.push(new Poker("M",9));
			pokers.push(new Poker("M",10));
			pokers.push(new Poker("M",11));
			pokers.push(new Poker("M",12));
			pokers.push(new Poker("M",13));
		}
		
		
		/**
		 * 洗牌，不限洗牌的张数
		 * @param pokers
		 * @return
		 */
		public function getRandow(pokers:Vector.<Poker>, bool:Boolean):Vector.<Poker>{
			var newPokers:Vector.<Poker> = pokers.concat();
			var randow1:int = 0;
			var randow2:int = 0;
			var t:int;
			
			for(var i:int=0; i<1000; i++){
				randow1 = int(Math.random()* newPokers.length);
				randow2 = int(Math.random()* newPokers.length)
				t = newPokers[randow1];
				newPokers[randow1] = newPokers[randow2];
				newPokers[randow2] = t;
			}
			return newPokers;
		}
		
		/**
		 * 数组转换为字符串
		 * @param arr
		 * @return
		 */
		public function changeArrToString(arr:Vector.<Record>):String{
			var str:String = "";
			var i:int = 0;
			for(i=0; i<arr.length; i++){
				str += arr[i].result + ";" + arr[i].type + ",";
			}
			return str;
		}
		
		/**
		 * 牌的值转换为字符串
		 * @param arr
		 * @return
		 */
		public function changePokersToString(arr:Vector.<Poker>):String{
			var str:int = "";
			var i:int = 0;
			for(i=0; i<arr.length; i++){
				str += arr[i].sort + arr[i].value + ",";
			}
			return str;
		}
	}
}