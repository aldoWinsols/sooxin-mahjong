package com.amusement.HundredHappy.model.poker
{
	public class F3 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/f3.png")]
		private var image:Class; //手上的牌
		
		public function F3()
		{
			this.sort = "F";
			this.value = 3;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}