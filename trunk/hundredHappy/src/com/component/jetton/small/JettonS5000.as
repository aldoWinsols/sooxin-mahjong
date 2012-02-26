package com.component.jetton.small
{
	public class JettonS5000 extends JettonS
	{
		[Embed(source="assets/amusement/jetton/small/js5000.png")]
		private var _BmpClass:Class;
		
		public function JettonS5000()
		{
			this._value = 5000;
			
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