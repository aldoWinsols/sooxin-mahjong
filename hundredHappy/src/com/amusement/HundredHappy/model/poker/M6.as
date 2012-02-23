package com.amusement.HundredHappy.model.poker
{
	public class M6 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/m6.png")]
		private var image:Class; //手上的牌
		
		public function M6()
		{
			this.sort = "M";
			this.value = 6;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}