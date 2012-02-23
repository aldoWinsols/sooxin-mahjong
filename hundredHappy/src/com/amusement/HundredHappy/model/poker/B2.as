package com.amusement.HundredHappy.model.poker
{
	public class B2 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/b2.png")]
		private var image:Class; //手上的牌
		
		public function B2()
		{
			this.sort = "B";
			this.value = 2;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}