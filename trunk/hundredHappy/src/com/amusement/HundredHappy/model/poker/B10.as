package com.amusement.HundredHappy.model.poker
{
	public class B10 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/b10.png")]
		private var image:Class; //手上的牌
		
		public function B10()
		{
			this.sort = "B";
			this.value = 10;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}