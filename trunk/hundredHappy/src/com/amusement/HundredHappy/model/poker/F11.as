package com.amusement.HundredHappy.model.poker
{
	public class F11 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/f11.png")]
		private var image:Class; //手上的牌
		
		public function F11()
		{
			this.sort = "F";
			this.value = 11;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}