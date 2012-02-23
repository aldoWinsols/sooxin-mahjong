package com.amusement.HundredHappy.model.poker
{
	public class M12 extends Poker
	{
		[Embed(source="com/amusement/HundredHappy/assets/poker/m12.png")]
		private var image:Class; //手上的牌
		
		public function M12()
		{
			this.sort = "M";
			this.value = 12;
			
			this.Fimg = new image();
			
			this.init();
		}
	}
}