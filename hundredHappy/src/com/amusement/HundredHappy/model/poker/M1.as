package com.amusement.HundredHappy.model.poker
{
	public class M1 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/m1.png")]
		private var image:Class; //手上的牌
		
		public function M1()
		{
			this.sort = "M";
			this.value = 1;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}