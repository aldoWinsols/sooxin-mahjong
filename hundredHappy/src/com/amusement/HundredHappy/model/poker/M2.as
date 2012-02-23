package com.amusement.HundredHappy.model.poker
{
	public class M2 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/m2.png")]
		private var image:Class; //手上的牌
		
		public function M2()
		{
			this.sort = "M";
			this.value = 2;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}