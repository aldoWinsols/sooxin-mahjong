package com.amusement.HundredHappy.model.poker
{
	public class R9 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/r9.png")]
		private var image:Class; //手上的牌
		
		public function R9()
		{
			this.sort = "R";
			this.value = 9;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}