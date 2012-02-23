package com.amusement.HundredHappy.model.poker
{
	public class M5 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/m5.png")]
		private var image:Class; //手上的牌
		
		public function M5()
		{
			this.sort = "M";
			this.value = 5;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}