package com.amusement.HundredHappy.model.poker
{
	public class M8 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/m8.png")]
		private var image:Class; //手上的牌
		
		public function M8()
		{
			this.sort = "M";
			this.value = 8;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}