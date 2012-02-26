package com.component.jetton.small
{
	public class JettonS10000 extends JettonS
	{
		[Embed(source="assets/amusement/jetton/small/js10000.png")]
		private var _BmpClass:Class;
		
		public function JettonS10000()
		{
			this._value = 10000;
			
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