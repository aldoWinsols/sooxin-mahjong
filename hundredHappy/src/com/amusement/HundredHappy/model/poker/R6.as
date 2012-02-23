package com.amusement.HundredHappy.model.poker
{
	public class R6 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/r6.png")]
		private var image:Class; //手上的牌
		
		public function R6()
		{
			this.sort = "R";
			this.value = 6;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}