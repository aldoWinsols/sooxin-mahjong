package com.component.jetton.small
{
	public class JettonS10 extends JettonS
	{
		[Embed(source="assets/amusement/jetton/small/js10.png")]
		private var _BmpClass:Class;
		
		public function JettonS10()
		{
			this._value = 10;
			
			super();
		}
		
		protected override function init():void
		{
			//TODO Auto-generated method stub
			this._bmp = new _BmpClass();
			
			super.init();
		}
	}
}