package com.amusement.HundredHappy.model.poker
{
	public class M4 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/m4.png")]
		private var image:Class; //手上的牌
		
		public function M4()
		{
			this.sort = "M";
			this.value = 4;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}