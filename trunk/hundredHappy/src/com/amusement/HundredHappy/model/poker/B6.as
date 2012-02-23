package com.amusement.HundredHappy.model.poker
{
	public class B6 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/b6.png")]
		private var image:Class; //手上的牌
		
		public function B6()
		{
			this.sort = "B";
			this.value = 6;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}