package com.component.jetton.small
{
	public class JettonS200 extends JettonS
	{
		[Embed(source="assets/amusement/jetton/small/js200.png")]
		private var _BmpClass:Class;
		
		public function JettonS200()
		{
			this._value = 200;
			
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