package com.amusement.HundredHappy.model.poker
{
	public class F1 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/f1.png")]
		private var image:Class; //手上的牌
		
		public function F1()
		{
			this.sort = "F";
			this.value = 1;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}