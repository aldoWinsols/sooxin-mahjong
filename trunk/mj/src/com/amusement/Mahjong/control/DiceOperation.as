package com.amusement.Mahjong.control
{
	import flash.events.Event;
	
	import mx.controls.SWFLoader;
	import mx.events.FlexEvent;
	
	import spark.components.Group;
	import spark.components.Image;

	public class DiceOperation
	{
		private var main:Group;
		public function DiceOperation(main:Group)
		{
			this.main = main;
			addImage();
		}
		
		[Embed(source="com/amusement/Mahjong/assets/dice/shape1.swf")]
		[Bindable]
		private var image1:Class;
		[Embed(source="com/amusement/Mahjong/assets/dice/shape2.swf")]
		[Bindable]
		private var image2:Class;
		[Embed(source="com/amusement/Mahjong/assets/dice/shape3.swf")]
		[Bindable]
		private var image3:Class;
		[Embed(source="com/amusement/Mahjong/assets/dice/shape4.swf")]
		[Bindable]
		private var image4:Class;
		[Embed(source="com/amusement/Mahjong/assets/dice/shape5.swf")]
		[Bindable]
		private var image5:Class;
		[Embed(source="com/amusement/Mahjong/assets/dice/shape6.swf")]
		[Bindable]
		private var image6:Class;
		[Embed(source="com/amusement/Mahjong/assets/dice/shape7.swf")]
		[Bindable]
		private var image7:Class;
		[Embed(source="com/amusement/Mahjong/assets/dice/shape8.swf")]
		[Bindable]
		private var image8:Class;
		[Embed(source="com/amusement/Mahjong/assets/dice/shape9.swf")]
		[Bindable]
		private var image9:Class;
		[Embed(source="com/amusement/Mahjong/assets/dice/shape10.swf")]
		[Bindable]
		private var image10:Class;
		[Embed(source="com/amusement/Mahjong/assets/dice/shape11.swf")]
		[Bindable]
		private var image11:Class;
		[Embed(source="com/amusement/Mahjong/assets/dice/shape12.swf")]
		[Bindable]
		private var image12:Class;
		[Embed(source="com/amusement/Mahjong/assets/dice/shape13.swf")]
		[Bindable]
		private var image13:Class;
		[Embed(source="com/amusement/Mahjong/assets/dice/shape14.swf")]
		[Bindable]
		private var image14:Class;
		[Embed(source="com/amusement/Mahjong/assets/dice/shape15.swf")]
		[Bindable]
		private var image15:Class;
		[Embed(source="com/amusement/Mahjong/assets/dice/shape16.swf")]
		[Bindable]
		private var image16:Class;
		[Embed(source="com/amusement/Mahjong/assets/dice/shape17.swf")]
		[Bindable]
		private var image17:Class;
		[Embed(source="com/amusement/Mahjong/assets/dice/shape18.swf")]
		[Bindable]
		private var image18:Class;
		[Embed(source="com/amusement/Mahjong/assets/dice/shape22.swf")]
		[Bindable]
		private var image22:Class;
		[Embed(source="com/amusement/Mahjong/assets/dice/shape23.swf")]
		[Bindable]
		private var image23:Class;
		[Embed(source="com/amusement/Mahjong/assets/dice/shape24.swf")]
		[Bindable]
		private var image24:Class;
		[Embed(source="com/amusement/Mahjong/assets/dice/shape25.swf")]
		[Bindable]
		private var image25:Class;
		[Embed(source="com/amusement/Mahjong/assets/dice/shape26.swf")]
		[Bindable]
		private var image26:Class;
		[Embed(source="com/amusement/Mahjong/assets/dice/shape27.swf")]
		[Bindable]
		private var image27:Class;
		[Embed(source="com/amusement/Mahjong/assets/dice/shape28.swf")]
		[Bindable]
		private var image28:Class;
		[Embed(source="com/amusement/Mahjong/assets/dice/shape29.swf")]
		[Bindable]
		private var image29:Class;
		[Embed(source="com/amusement/Mahjong/assets/dice/shape30.swf")]
		[Bindable]
		private var image30:Class;
		[Embed(source="com/amusement/Mahjong/assets/dice/shape31.swf")]
		[Bindable]
		private var image31:Class;
		[Embed(source="com/amusement/Mahjong/assets/dice/shape32.swf")]
		[Bindable]
		private var image32:Class;
		
		private var list:Vector.<SWFLoader> = null;
		
		private function addImage():void{
			list = new Vector.<SWFLoader>();
			var i:int = 0;
			var j:int = 1;
			for(i = 1; i < 19; i ++){
				var image:SWFLoader = new SWFLoader();
				image.source = getSwf(i);
				image.visible = false;
				image.horizontalCenter = 0;
				image.verticalCenter = 0;
				list.push(image);
				main.addElement(image);
				j ++;
			}
		}
		
		public function showSaizi(num:int):void{
			num = 20 + num;
			var image:SWFLoader = new SWFLoader();
			image.source = getSwf(num);
			image.visible = false;
			image.horizontalCenter = 0;
			image.verticalCenter = 0;
			image.id = "lastSaizi";
			list.push(image);
			main.addElement(image);
			
			main.addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function getSwf(name:int):Class{
			switch(name){
				case 1:
					return image1;
					break;
				case 2:
					return image2;
					break;
				case 3:
					return image3;
					break;
				case 4:
					return image4;
					break;
				case 5:
					return image5;
					break;
				case 6:
					return image6;
					break;
				case 7:
					return image7;
					break;
				case 8:
					return image8;
					break;
				case 9:
					return image9;
					break;
				case 10:
					return image10;
					break;
				case 11:
					return image11;
					break;
				case 12:
					return image12;
					break;
				case 13:
					return image13;
					break;
				case 14:
					return image14;
					break;
				case 15:
					return image15;
					break;
				case 16:
					return image16;
					break;
				case 17:
					return image17;
					break;
				case 18:
					return image18;
					break;
				case 22:
					return image22;
					break;
				case 23:
					return image23;
					break;
				case 24:
					return image24;
					break;
				case 25:
					return image25;
					break;
				case 26:
					return image26;
					break;
				case 27:
					return image27;
					break;
				case 28:
					return image28;
					break;
				case 29:
					return image29;
					break;
				case 30:
					return image30;
					break;
				case 31:
					return image31;
					break;
				case 32:
					return image32;
					break;
			}
			return image1;
		}
		private var count:int = 0;
		private var imagenum:int = 0;
		protected function enterFrame(event:Event):void
		{
			// TODO Auto-generated method stub
			if(count % 1 == 0){
				if(imagenum < list.length){
					var i:int = 0;
					for(i = 0; i < list.length; i ++){
						list[i].visible = false;
					}
					list[imagenum].visible = true;
					
					imagenum ++;
				}else{
					count = 0;
					imagenum = 0;
					main.removeEventListener(Event.ENTER_FRAME, enterFrame);
				}
			}
			count ++;
		}
		public function removeLastSaizi():void{
			list.pop();
			for(var i:int = 0; i < main.numElements; i++){
				var image:Object = main.getElementAt(i);
				if(image.id == "lastSaizi"){
					main.removeElementAt(i);
					break;
				}
			}
		}
	}
}