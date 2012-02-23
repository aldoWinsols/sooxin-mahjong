package com.amusement.HundredHappy.model.poker
{
	public class R11 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/r11.png")]
		private var image:Class; //手上的牌
		
		public function R11()
		{
			this.sort = "R";
			this.value = 11;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}