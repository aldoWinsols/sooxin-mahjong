package com.component.jetton.small
{
	public class JettonS1000 extends JettonS
	{
		[Embed(source="assets/amusement/jetton/small/js1000.png")]
		private var _BmpClass:Class;
		
		public function JettonS1000()
		{
			this._value = 1000;
			
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