package com.amusement.HundredHappy.model.poker
{
	public class R13 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/r13.png")]
		private var image:Class; //手上的牌
		
		public function R13()
		{
			this.sort = "R";
			this.value = 13;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}