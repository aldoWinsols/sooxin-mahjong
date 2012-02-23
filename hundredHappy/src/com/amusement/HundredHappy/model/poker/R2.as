package com.amusement.HundredHappy.model.poker
{
	public class R2 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/r2.png")]
		private var image:Class; //手上的牌
		
		public function R2()
		{
			this.sort = "R";
			this.value = 2;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}