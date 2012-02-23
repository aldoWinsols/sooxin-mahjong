package com.amusement.HundredHappy.model.poker
{
	public class R1 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/r1.png")]
		private var image:Class; //手上的牌
		
		public function R1()
		{
			this.sort = "R";
			this.value = 1;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}