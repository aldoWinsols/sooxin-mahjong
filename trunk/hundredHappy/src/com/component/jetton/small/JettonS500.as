package com.component.jetton.small
{
	public class JettonS500 extends JettonS
	{
		[Embed(source="assets/amusement/jetton/small/js500.png")]
		private var _BmpClass:Class;
		
		public function JettonS500()
		{
			this._value = 500;
			
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