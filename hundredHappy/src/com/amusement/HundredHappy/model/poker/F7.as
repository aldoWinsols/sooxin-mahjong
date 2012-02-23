package com.amusement.HundredHappy.model.poker
{
	public class F7 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/f7.png")]
		private var Fimgs:Class; //手上的牌
		
		public function F7()
		{
			this.sort = "F";
			this.value = 7;
			
			Fimg = new Fimgs();
			
			init();
		}
	}
}