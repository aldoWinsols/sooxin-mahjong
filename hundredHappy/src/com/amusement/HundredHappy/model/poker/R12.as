package com.amusement.HundredHappy.model.poker
{
	public class R12 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/r12.png")]
		private var image:Class; //手上的牌
		
		public function R12()
		{
			this.sort = "R";
			this.value = 12;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}