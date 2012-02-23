package com.amusement.HundredHappy.model.poker
{
	public class R10 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/r10.png")]
		private var image:Class; //手上的牌
		
		public function R10()
		{
			this.sort = "R";
			this.value = 10;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}