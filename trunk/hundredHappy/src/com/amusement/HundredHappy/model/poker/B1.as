package com.amusement.HundredHappy.model.poker
{
	public class B1 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/b1.png")]
		private var image:Class; //手上的牌
		
		public function B1()
		{
			this.sort = "B";
			this.value = 1;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}