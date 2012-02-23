package com.amusement.HundredHappy.model.poker
{
	public class R7 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/r7.png")]
		private var image:Class; //手上的牌
		
		public function R7()
		{
			this.sort = "R";
			this.value = 7;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}