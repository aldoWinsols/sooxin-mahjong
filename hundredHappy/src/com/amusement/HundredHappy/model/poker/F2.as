package com.amusement.HundredHappy.model.poker
{
	public class F2 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/f2.png")]
		private var image:Class; //手上的牌
		
		public function F2()
		{
			this.sort = "F";
			this.value = 2;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}