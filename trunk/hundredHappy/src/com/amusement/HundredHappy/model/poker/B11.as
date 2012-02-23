package com.amusement.HundredHappy.model.poker
{
	public class B11 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/b11.png")]
		private var image:Class; //手上的牌
		
		public function B11()
		{
			this.sort = "B";
			this.value = 11;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}