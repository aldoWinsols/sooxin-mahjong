package com.amusement.HundredHappy.model.poker
{
	public class F6 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/f6.png")]
		private var image:Class; //手上的牌
		
		public function F6()
		{
			this.sort = "F";
			this.value = 6;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}