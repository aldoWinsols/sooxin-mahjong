package com.amusement.HundredHappy.model.poker
{
	public class M11 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/m11.png")]
		private var image:Class; //手上的牌
		
		public function M11()
		{
			this.sort = "M";
			this.value = 11;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}