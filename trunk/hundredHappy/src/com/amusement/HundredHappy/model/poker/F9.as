package com.amusement.HundredHappy.model.poker
{
	public class F9 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/f9.png")]
		private var image:Class; //手上的牌
		
		public function F9()
		{
			this.sort = "F";
			this.value = 9;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}