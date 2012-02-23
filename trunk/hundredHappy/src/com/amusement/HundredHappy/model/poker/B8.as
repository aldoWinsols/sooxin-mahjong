package com.amusement.HundredHappy.model.poker
{
	public class B8 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/b8.png")]
		private var image:Class; //手上的牌
		
		public function B8()
		{
			this.sort = "B";
			this.value = 8;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}