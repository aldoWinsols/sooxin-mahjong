package com.amusement.HundredHappy.model.poker
{
	public class R3 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/r3.png")]
		private var image:Class; //手上的牌
		
		public function R3()
		{
			this.sort = "R";
			this.value = 3;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}