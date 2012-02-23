package com.amusement.HundredHappy.model.poker
{
	public class B3 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/b3.png")]
		private var image:Class; //手上的牌
		
		public function B3()
		{
			this.sort = "B";
			this.value = 3;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}