package com.component.jetton.small
{
	public class JettonS5 extends JettonS
	{
		[Embed(source="assets/amusement/jetton/small/js5.png")]
		private var _BmpClass:Class;
		
		public function JettonS5()
		{
			this._value = 5;
			
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