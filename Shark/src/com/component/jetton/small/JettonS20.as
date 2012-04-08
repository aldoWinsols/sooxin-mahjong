package com.component.jetton.small
{
	public class JettonS20 extends JettonS
	{
		[Embed(source="assets/amusement/jetton/small/js20.png")]
		private var _BmpClass:Class;
		
		public function JettonS20()
		{
			this._value = 20;
			
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