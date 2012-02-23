package com.amusement.HundredHappy.model.poker
{
	public class R5 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/r5.png")]
		private var image:Class; //手上的牌
		
		public function R5()
		{
			this.sort = "R";
			this.value = 5;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}