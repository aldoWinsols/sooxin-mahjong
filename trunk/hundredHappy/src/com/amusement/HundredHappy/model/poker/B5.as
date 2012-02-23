package com.amusement.HundredHappy.model.poker
{
	public class B5 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/b5.png")]
		private var image:Class; //手上的牌
		
		public function B5()
		{
			this.sort = "B";
			this.value = 5;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}