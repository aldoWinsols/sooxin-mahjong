package com.amusement.HundredHappy.model.poker
{
	public class B13 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/b13.png")]
		private var image:Class; //手上的牌
		
		public function B13()
		{
			this.sort = "B";
			this.value = 13;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}