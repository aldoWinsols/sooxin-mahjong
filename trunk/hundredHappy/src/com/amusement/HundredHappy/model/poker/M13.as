package com.amusement.HundredHappy.model.poker
{
	public class M13 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/m13.png")]
		private var image:Class; //手上的牌
		
		public function M13()
		{
			this.sort = "M";
			this.value = 13;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}