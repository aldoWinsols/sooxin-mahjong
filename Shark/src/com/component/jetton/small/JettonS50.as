package com.component.jetton.small
{
	public class JettonS50 extends JettonS
	{
		[Embed(source="assets/amusement/jetton/small/js50.png")]
		private var _BmpClass:Class;
		
		public function JettonS50()
		{
			this._value = 50;
			
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