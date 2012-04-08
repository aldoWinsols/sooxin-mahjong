package com.component.jetton.small
{
	import flash.display.Bitmap;
	
	import spark.core.SpriteVisualElement;

	public class JettonS extends SpriteVisualElement
	{
		protected var _value:int;
		
		protected var _bmp:Bitmap;
		
		protected var _thick:int = 2;
		
		public function JettonS()
		{
			init();
		}
		
		protected function init():void{
			if(_bmp){
				this.addChild(_bmp);
			}
		}

		public function get value():int
		{
			return _value;
		}

		public function get thick():int
		{
			return _thick;
		}


	}
}