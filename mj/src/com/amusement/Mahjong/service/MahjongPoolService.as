package com.amusement.Mahjong.service
{
	import com.amusement.Mahjong.control.MahjongRoomControl;
	import com.amusement.Mahjong.model.*;

	public class MahjongPoolService
	{
		private static var _instance:MahjongPoolService;
		
//		private var _mahjongValues:Array;
		
		private var _usableMahjongs:Array;//未使用的麻将
		private var _disableMahjongs:Array;//以使用的麻将
		
		public function MahjongPoolService()
		{
			initMahjongs();
		}
		
		public static function get instance():MahjongPoolService
		{
			if(_instance == null){
				_instance = new MahjongPoolService();
			}
			return _instance;
		}
		
		/*public function initMahjongValues():void{
			_mahjongValues = [1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6,7,7,7,7,8,8,8,8,9,9,9,9,
				11,11,11,11,12,12,12,12,13,13,13,13,14,14,14,14,15,15,15,15,16,16,16,16,17,17,17,17,18,18,18,18,19,19,19,19,
				21,21,21,21,22,22,22,22,23,23,23,23,24,24,24,24,25,25,25,25,26,26,26,26,27,27,27,27,28,28,28,28,29,29,29,29];
		}*/
		
		/**
		 * 初始化麻将 
		 * 
		 */
		private function initMahjongs():void{
			_usableMahjongs = [new W1(), new W1(), new W1(), new W1(),
							new W2(), new W2(), new W2(), new W2(), 
							new W3(), new W3(), new W3(), new W3(),
							new W4(), new W4(), new W4(), new W4(),
							new W5(), new W5(), new W5(), new W5(),
							new W6(), new W6(), new W6(), new W6(),
							new W7(), new W7(), new W7(), new W7(),
							new W8(), new W8(), new W8(), new W8(),
							new W9(), new W9(), new W9(), new W9(),
						
							new T1(), new T1(), new T1(), new T1(),
							new T2(), new T2(), new T2(), new T2(),
							new T3(), new T3(), new T3(), new T3(),
							new T4(), new T4(), new T4(), new T4(),
							new T5(), new T5(), new T5(), new T5(),
							new T6(), new T6(), new T6(), new T6(),
							new T7(), new T7(), new T7(), new T7(),
							new T8(), new T8(), new T8(), new T8(),
							new T9(), new T9(), new T9(), new T9(),
							
							new L1(), new L1(), new L1(), new L1(),
							new L2(), new L2(), new L2(), new L2(),
							new L3(), new L3(), new L3(), new L3(),
							new L4(), new L4(), new L4(), new L4(),
							new L5(), new L5(), new L5(), new L5(),
							new L6(), new L6(), new L6(), new L6(),
							new L7(), new L7(), new L7(), new L7(),
							new L8(), new L8(), new L8(), new L8(),
							new L9(), new L9(), new L9(), new L9()];
			
			_disableMahjongs = [];	
		}
		
		/**
		 * 重置麻将 
		 * 
		 */
		public function resetMahjongs():void{
			_usableMahjongs = _usableMahjongs.concat(_disableMahjongs);
			_disableMahjongs.splice(0, _disableMahjongs.length);
		}
		
		/**
		 * 得到规定数量的麻将（麻将父类） 
		 * @param num
		 * @return 
		 * 
		 */
		/*public function getMahjongsByNumber(num:int, color:String):Array{
			var color:String = MahjongRoomControl.instance.mahjongColor;
			
			var mahjongs:Array = [];
			for(var i:int = 0; i < num; i ++){
				var mahjong:Mahjong = new Mahjong();
				mahjong.mjInit(color);
				mahjongs.push(mahjong);
			}
			return mahjongs;
		}*/
		public function getMahjongsByNumber(num:int, color:String):Array{
			var mahjongs:Array = [];
			for(var i:int = 0; i < num; i ++){
				var mahjong:Mahjong = new Mahjong();
				mahjong.setColor(color);
				mahjongs.push(mahjong);
			}
			return mahjongs;
		}
		
		/**
		 * 根据值得到麻将（不验证是否可以创建）
		 * @param value 麻将值
		 * @return 
		 * 
		 */
		/*public function getMahjong(value:int):Mahjong{
			var color:String = MahjongRoomControl.instance.mahjongColor;
			var mahjong:Mahjong;
			switch(value){
				case 1:
					mahjong = new W1(color);
					break;
				
				case 2:
					mahjong = new W2(color);
					break;
				
				case 3:
					mahjong = new W3(color);
					break;
				
				case 4:
					mahjong = new W4(color);
					break;
				
				case 5:
					mahjong = new W5(color);
					break;
				
				case 6:
					mahjong = new W6(color);
					break;
				
				case 7:
					mahjong = new W7(color);
					break;
				
				case 8:
					mahjong = new W8(color);
					break;
				
				case 9:
					mahjong = new W9(color);
					break;
				
				case 11:
					mahjong = new T1(color);
					break;
				
				case 12:
					mahjong = new T2(color);
					break;
				
				case 13:
					mahjong = new T3(color);
					break;
				
				case 14:
					mahjong = new T4(color);
					break;
				
				case 15:
					mahjong = new T5(color);
					break;
				
				case 16:
					mahjong = new T6(color);
					break;
				
				case 17:
					mahjong = new T7(color);
					break;
				
				case 18:
					mahjong = new T8(color);
					break;
				
				case 19:
					mahjong = new T9(color);
					break;
				
				case 21:
					mahjong = new L1(color);
					break;
				
				case 22:
					mahjong = new L2(color);
					break;
				
				case 23:
					mahjong = new L3(color);
					break;
				
				case 24:
					mahjong = new L4(color);
					break;
				
				case 25:
					mahjong = new L5(color);
					break;
				
				case 26:
					mahjong = new L6(color);
					break;
				
				case 27:
					mahjong = new L7(color);
					break;
				
				case 28:
					mahjong = new L8(color);
					break;
				
				case 29:
					mahjong = new L9(color);
					break;
			}
			return mahjong;
		}*/
		public function getMahjong(value:int, color:String):Mahjong{
			var mahjong:Mahjong;
			switch(value){
				case 1:
					mahjong = new W1();
					break;
				
				case 2:
					mahjong = new W2();
					break;
				
				case 3:
					mahjong = new W3();
					break;
				
				case 4:
					mahjong = new W4();
					break;
				
				case 5:
					mahjong = new W5();
					break;
				
				case 6:
					mahjong = new W6();
					break;
				
				case 7:
					mahjong = new W7();
					break;
				
				case 8:
					mahjong = new W8();
					break;
				
				case 9:
					mahjong = new W9();
					break;
				
				case 11:
					mahjong = new T1();
					break;
				
				case 12:
					mahjong = new T2();
					break;
				
				case 13:
					mahjong = new T3();
					break;
				
				case 14:
					mahjong = new T4();
					break;
				
				case 15:
					mahjong = new T5();
					break;
				
				case 16:
					mahjong = new T6();
					break;
				
				case 17:
					mahjong = new T7();
					break;
				
				case 18:
					mahjong = new T8();
					break;
				
				case 19:
					mahjong = new T9();
					break;
				
				case 21:
					mahjong = new L1();
					break;
				
				case 22:
					mahjong = new L2();
					break;
				
				case 23:
					mahjong = new L3();
					break;
				
				case 24:
					mahjong = new L4();
					break;
				
				case 25:
					mahjong = new L5();
					break;
				
				case 26:
					mahjong = new L6();
					break;
				
				case 27:
					mahjong = new L7();
					break;
				
				case 28:
					mahjong = new L8();
					break;
				
				case 29:
					mahjong = new L9();
					break;
			}
			if(mahjong){
				mahjong.setColor(color);
			}
			return mahjong;
		}
		
		/**
		 * 根据值数组得到麻将数组 （不验证是否可以创建） 
		 * @param arr 麻将值数组
		 * @return 
		 * 
		 */
		/*public function getMahjongs(arr:Array):Array{
			var mahjong:Mahjong;
			var mahjongs:Array = [];
			for(var i:int = 0; i < arr.length; i ++){                     
				mahjong = getMahjong(int(arr[i]));
				mahjongs.push(mahjong);
			}
			return mahjongs;
		}*/
		public function getMahjongs(values:Array, color:String):Array{
			var mahjong:Mahjong;
			var mahjongs:Array = [];
			for(var i:int = 0; i < values.length; i ++){                     
				mahjong = getMahjong(int(values[i]), color);
				mahjongs.push(mahjong);
			}
			return mahjongs;
		}
		
		/**
		 * 根据值得到麻将（验证是否可以创建） 
		 * @param value 麻将值
		 * @return 
		 * 
		 */
		/*public function getMahjongByValue(value:int):Mahjong{
			var color:String = MahjongRoomControl.instance.mahjongColor;
			var mahjong:Mahjong;
			if(checkHaveMahjong(value)){
				mahjong = getMahjong(value);
			}
			
			return mahjong;
		}*/
		public function getMahjongByValue(value:int, color:String):Mahjong{
			var mahjong:Mahjong;
			for(var i:int = 0; i < _usableMahjongs.length; i ++){
				if(_usableMahjongs[i].value == value){
					mahjong = _usableMahjongs.splice(i, 1)[0];
					mahjong.setColor(color);
					_disableMahjongs.push(mahjong);
					break;
				}
			}
			/*if(mahjong == null){
				Alert.show("creat_mahjong_value:" + value);
			}*/
			return mahjong;
		}
		
		/**
		 * 根据值数组得到麻将数组 （验证是否可以创建） 
		 * @param arr 麻将值数组
		 * @return 
		 * 
		 */
		/*public function getMahjongsByValues(arr:Array):Array{
			var mahjong:Mahjong;
			var mahjongs:Array = [];
			for(var i:int = 0; i < arr.length; i ++){                     
				mahjong = getMahjongByValue(int(arr[i]));
				mahjongs.push(mahjong);
			}
			return mahjongs;
		}*/
		public function getMahjongsByValues(values:Array, color:String):Array{
			var mahjong:Mahjong;
			var mahjongs:Array = [];
			for(var i:int = 0; i < values.length; i ++){                     
				mahjong = getMahjongByValue(int(values[i]), color);
				mahjongs.push(mahjong);
			}
			return mahjongs;
		}
		
		/**
		 * 检测麻将是否可创建
		 * （如果检测到该值存在，则返回true，并从值数组中删除该值） 
		 * @param value 麻将值
		 * @return 
		 * 
		 */
		/*public function checkHaveMahjong(value:int):Boolean{
			var flag:Boolean = false;
			
			for(var i:int = 0; i < _mahjongValues.length; i ++){
				if(_mahjongValues[i] == value){
					flag = true;
					_mahjongValues.splice(i, 1);
					break;
				}
			}
			
			return flag;
		}*/
		
	}
}