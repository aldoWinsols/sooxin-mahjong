package com.amusement.HundredHappy.model.poker
{
	public class B12 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/b12.png")]
		private var image:Class; //手上的牌
		
		public function B12()
		{
			this.sort = "B";
			this.value = 12;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}