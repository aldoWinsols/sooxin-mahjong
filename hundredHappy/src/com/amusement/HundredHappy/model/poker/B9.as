package com.amusement.HundredHappy.model.poker
{
	public class B9 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/b9.png")]
		private var image:Class; //手上的牌
		
		public function B9()
		{
			this.sort = "B";
			this.value = 9;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}