package com.amusement.HundredHappy.model.poker
{
	public class M9 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/m9.png")]
		private var image:Class; //手上的牌
		
		public function M9()
		{
			this.sort = "M";
			this.value = 9;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}