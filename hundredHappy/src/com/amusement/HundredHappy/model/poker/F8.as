package com.amusement.HundredHappy.model.poker
{
	public class F8 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/f8.png")]
		private var image:Class; //手上的牌
		
		public function F8()
		{
			this.sort = "F";
			this.value = 8;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}