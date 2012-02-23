package com.amusement.HundredHappy.model.poker
{
	public class F13 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/f13.png")]
		private var image:Class; //手上的牌
		
		public function F13()
		{
			this.sort = "F";
			this.value = 13;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}