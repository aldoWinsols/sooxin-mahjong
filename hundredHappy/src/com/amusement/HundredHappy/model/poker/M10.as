package com.amusement.HundredHappy.model.poker
{
	public class M10 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/m10.png")]
		private var image:Class; //手上的牌
		
		public function M10()
		{
			this.sort = "M";
			this.value = 10;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}