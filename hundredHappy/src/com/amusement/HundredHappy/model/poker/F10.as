package com.amusement.HundredHappy.model.poker
{
	public class F10 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/f10.png")]
		private var image:Class; //手上的牌
		
		public function F10()
		{
			this.sort = "F";
			this.value = 10;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}