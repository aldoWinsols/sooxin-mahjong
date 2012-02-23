package com.amusement.HundredHappy.model.poker
{
	public class R4 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/r4.png")]
		private var image:Class; //手上的牌
		
		public function R4()
		{
			this.sort = "R";
			this.value = 4;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}