package com.amusement.HundredHappy.model.poker
{
	public class M3 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/m3.png")]
		private var image:Class; //手上的牌
		
		public function M3()
		{
			this.sort = "M";
			this.value = 3;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}