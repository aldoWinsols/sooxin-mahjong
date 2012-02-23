package com.amusement.HundredHappy.model.poker
{
	import flash.display.Bitmap;
	
	import spark.core.SpriteVisualElement;

	public class Poker extends SpriteVisualElement
	{
		public var sort:String = ""; //类型  F：方块 R：红桃 B：黑桃 M：梅花
		public var value:int = 0;
		
		public var Fimg:Bitmap;
		public var Bimg:Bitmap;
		
		private var FImage:Class; //正面
		
		[Embed(source="com/amusement/HundredHappy/assets/poker/r1.png")]
		private var BImage:Class; //背面
		
		public function Poker()
		{
			
		}
		
		public function init():void{
			
			Bimg=new BImage();
			this.addChild(Bimg);
			
			this.addChild(Fimg);
			
		}
		
		public function show(str:String):void{
			this.Fimg.visible = false;
			this.Bimg.visible = false;
			
			switch(str){
				case "F":
					this.Fimg.visible = true;
					break;
				
				case "B":
					this.Bimg.visible = true;
					break;
			}
		}
	}
}