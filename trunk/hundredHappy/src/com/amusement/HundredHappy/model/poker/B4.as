package com.amusement.HundredHappy.model.poker
{
	public class B4 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/b4.png")]
		private var image:Class; //手上的牌
		
		public function B4()
		{
			this.sort = "B";
			this.value = 4;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}