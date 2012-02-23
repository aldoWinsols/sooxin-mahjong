package com.amusement.HundredHappy.model.poker
{
	public class F4 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/f4.png")]
		private var image:Class; //手上的牌
		
		public function F4()
		{
			this.sort = "F";
			this.value = 4;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}