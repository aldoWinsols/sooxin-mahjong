package com.amusement.HundredHappy.model.poker
{
	public class M7 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/m7.png")]
		private var image:Class; //手上的牌
		
		public function M7()
		{
			this.sort = "M";
			this.value = 7;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}