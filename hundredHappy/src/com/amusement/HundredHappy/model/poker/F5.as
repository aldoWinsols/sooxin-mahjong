package com.amusement.HundredHappy.model.poker
{
	public class F5 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/f5.png")]
		private var image:Class; //手上的牌
		
		public function F5()
		{
			this.sort = "F";
			this.value = 5;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}