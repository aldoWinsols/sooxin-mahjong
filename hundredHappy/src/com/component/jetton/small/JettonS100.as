package com.component.jetton.small
{
	public class JettonS100 extends JettonS
	{
		[Embed(source="assets/amusement/jetton/small/js100.png")]
		private var _BmpClass:Class;
		
		public function JettonS100()
		{
			this._value = 100;
			
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