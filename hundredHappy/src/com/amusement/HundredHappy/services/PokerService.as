package com.amusement.HundredHappy.services
{
	import com.amusement.HundredHappy.model.poker.*;
	
	import flash.utils.getDefinitionByName;

	public class PokerService
	{
		private static var _instance:PokerService;
		
		public function PokerService()
		{
			new R1();
			new R2();
			new R3();
			new R4();
			new R5();
			new R6();
			new R7();
			new R8();
			new R9();
			new R10();
			new R11();
			new R12();
			new R13();
			
			new B1();
			new B2();
			new B3();
			new B4();
			new B5();
			new B6();
			new B7();
			new B8();
			new B9();
			new B10();
			new B11();
			new B12();
			new B13();
			
			new F1();
			new F2();
			new F3();
			new F4();
			new F5();
			new F6();
			new F7();
			new F8();
			new F9();
			new F10();
			new F11();
			new F12();
			new F13();
			
			new M1();
			new M2();
			new M3();
			new M4();
			new M5();
			new M6();
			new M7();
			new M8();
			new M9();
			new M10();
			new M11();
			new M12();
			new M13();
		}
		
		public static function get instance():PokerService{
			if(_instance == null){
				_instance = new PokerService();
			}
			return _instance;
		}
		
		public function getPokerByName(pokerName:String):Poker{
			var cls:Class = getDefinitionByName("com.amusement.HundredHappy.model.poker." + pokerName) as Class;
			return new cls() as Poker;
		}
	}
}