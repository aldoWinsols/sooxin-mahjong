package com.mahjongSyncServer.util{
	import com.mahjongSyncServer.model.Balance;
	
	import mx.collections.ArrayList;
	
	public class Util {
		
		private var mahjongs:Vector.<int>;				//麻将初始值
		private static var _instance:Util;
		
		public function Util(){
			
			//所有麻将
			mahjongs = new Vector.<int>();
			
			//所有麻将
			mahjongs.push(1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 
				6, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8, 8, 9, 9, 9, 9, 11, 11, 11, 11,
				12, 12, 12, 12, 13, 13, 13, 13, 14, 14, 14, 14, 15, 15, 15, 15,
				16, 16, 16, 16, 17, 17, 17, 17, 18, 18, 18, 18, 19, 19, 19, 19,
				21, 21, 21, 21, 22, 22, 22, 22, 23, 23, 23, 23, 24, 24, 24, 24,
				25, 25, 25, 25, 26, 26, 26, 26, 27, 27, 27, 27, 28, 28, 28, 28,
				29, 29, 29, 29);
			
			// 放留的牌型
//			mahjongs.push(1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 21, 21, 4, 23, 23, 23, 23, 
//				24, 24, 24, 24, 22, 22, 7, 7, 8, 8, 8, 8, 9, 9, 9, 9, 11, 11, 11, 11,
//				12, 12, 12, 12, 13, 13, 13, 13, 14, 14, 14, 14, 22, 26, 27, 29,
//				16, 25, 16, 16, 28, 17, 17, 29, 28, 18, 18, 18, 19, 19, 19, 19,
//				21, 21, 21, 21, 22, 22, 22, 22, 23, 23, 23, 23, 24, 24, 24, 24,
//				25, 25, 25, 25, 26, 26, 26, 26, 27, 27, 27, 27, 28, 28, 28, 28,
//				29, 29, 29, 29);
			
			// 抢杠
//			mahjongs.push(1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 
//				6, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8, 8, 9, 9, 9, 9, 11, 11, 11, 18,
//				12, 12, 12, 12, 13, 13, 13, 13, 14, 14, 14, 14, 15, 15, 15, 15,
//				16, 16, 18, 19, 17, 17, 16, 18, 17, 16, 19, 18, 19, 19, 19, 19,
//				21, 21, 21, 21, 22, 22, 22, 22, 23, 23, 23, 23, 24, 24, 24, 24,
//				25, 25, 25, 25, 26, 26, 26, 26, 27, 27, 27, 27, 28, 28, 28, 28,
//				29, 29, 29, 29);
			//杠上花和杠上炮
//			mahjongs.push(1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 6, 
//				4, 27, 27, 27, 28, 26, 28, 29, 29, 29,21, 4, 4,
//				7, 4, 8, 8, 8, 8, 9, 9, 9, 9, 11, 11, 13,
//				11,12, 16, 12, 12, 13, 13, 13, 14, 14, 15, 15, 15, 14, 15, 19, 14,
//				16, 12, 16, 16, 17, 4, 4, 5, 5, 5, 5, 
//				6, 6, 6, 6, 19, 19,
//				21, 21, 21, 21, 22, 22, 22, 22, 23, 23, 23, 23, 24, 24, 24, 24,
//				25, 25, 25, 25, 26, 26, 26, 26, 27, 27, 27, 27, 28, 28, 28, 28,
//				29, 29, 29, 29);
			
			
//			mahjongs.push(1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 
//				6, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8, 8, 9, 9, 9, 9, 11, 11, 11, 11,
//				12, 12, 12, 12, 13, 13, 13, 13, 14, 14, 14, 14, 15, 15, 15, 15,
//				16, 16, 16, 16, 17, 17, 17, 17, 18, 18, 18, 18, 19, 19, 19, 19,
//				21, 21, 21, 21);
			
//			mahjongs.push(24, 24, 4, 5, 19, 5, 5, 1, 6, 2, 6, 7, 7,
//				1, 1, 2, 2, 3, 3, 14, 14, 15, 15, 16, 16, 19,
//				7, 7, 8, 8, 18, 8, 9, 9, 9, 29, 11, 11, 11,
//				11,12, 2, 2, 12, 13, 7, 7, 13, 4, 14, 
//				14, 14, 15, 15, 15, 15,
//				16, 16, 16, 16, 17, 17, 17, 17, 18, 18, 18, 18, 19, 19, 19, 19,
//				21, 21, 21, 21, 22, 22, 22, 22, 23, 23, 23, 23, 24, 24, 24, 24,
//				25, 25, 25, 25, 26, 26, 26, 26, 27, 27, 27, 27, 28, 28, 28, 28,
//				29, 29, 29, 29);
		}
		
		public static function get instance():Util
		{
			if(_instance == null){
				_instance = new Util();
			}
			return _instance;
		}

		public function set instance(value:Util):void
		{
			_instance = value;
		}
		
		/**
		 * 洗牌，不限洗牌的张数
		 * @param mahjongList
		 * @return
		 */
		public function getRandowMahjongs():Vector.<int>{
			var newMahjongs:Vector.<int> = mahjongs.concat();
			var randow1:int = 0;
			var randow2:int = 0;
			var t:int;
			
			for(var i:int=0; i<1000; i++){
				randow1 = int(Math.random()*newMahjongs.length);
				randow2 = int(Math.random()*newMahjongs.length)
				t = newMahjongs[randow1];
				newMahjongs[randow1] = newMahjongs[randow2];
				newMahjongs[randow2] = t;
			}
			return newMahjongs;
		}      

		public static function changeVectoryToArray(vector:Vector.<int>):Array{
			var newArray:Array = new Array();
			
			for(var i:int =0; i<vector.length;i++){
				newArray.push(vector[i]);
			}
			return newArray ;
		}
		
		public static function changeBalanceVectoryToArray(vector:Vector.<Balance>):Array{
			var newArray:Array = new Array();
			
			for(var i:int =0; i<vector.length;i++){
				newArray.push(vector[i]);
			}
			return newArray ;
		}
		
		public function fixed(num:Number):Number{
			return Number(num.toFixed(2));
		}
		public static function sort(arr:ArrayList):void{
			
		}
		public static function sortVector(arr:Vector.<int>):Vector.<int>{
			return arr.sort(sortInts);
		}
		/**
		 * 对集合排序
		 * 
		 * @param list
		 */
		private static function sortInts(x:int, y:int):int
		{
			if (x < y)
			{
				return -1;
			}
			else if (x > y)
			{
				return 1;
			}
			else
			{
				return 0;
			}
		}
		
	}
}
