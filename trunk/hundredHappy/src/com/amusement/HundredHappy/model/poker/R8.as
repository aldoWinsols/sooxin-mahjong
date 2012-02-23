package com.amusement.HundredHappy.model.poker
{
	public class R8 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/r8.png")]
		private var image:Class; //手上的牌
		
		public function R8()
		{
			this.sort = "R";
			this.value = 8;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}