package com.amusement.HundredHappy.model.poker
{
	public class F12 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/f12.png")]
		private var image:Class; //手上的牌
		
		public function F12()
		{
			this.sort = "F";
			this.value = 12;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}