package com.amusement.Shark.control
{
	import com.amusement.Shark.main.MainPan;
	import com.amusement.Shark.model.animal.BaseAnimal;
	import com.amusement.Shark.service.SharkSoundService;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class MainPanControl
	{
		public var mainPan:MainPan;
		
		public var fulgurateTimner:Timer; //闪亮timer
		public var resaultAnimalNumber:int;

//		public var animalArr:Array;
		
		public static var instance:MainPanControl;

		public function MainPanControl(mainPan:MainPan)
		{
			this.mainPan=mainPan;

			fulgurateTimner=new Timer(80);
			fulgurateTimner.addEventListener(TimerEvent.TIMER, fulgurateHandler);

//			animalArr=mainPan.getChildren();
			
			if(instance==null){
				instance = this;
			}
		}


		public var t:int=0;
		public function fulgurateHandler(e:TimerEvent):void
		{
			t++;
			if (t % 2 == 0)
			{
				setAllUnlight();
			}
			else
			{
				setAnimalLight(resaultAnimalNumber, false);
			}
		}

		//////////////////////////////////////////////////////////////////////
		public function setFulgurateByAnimal(n:int):void
		{
			this.resaultAnimalNumber=n;
			fulgurateTimner.start();
		}

		public function unFulgurate():void
		{
			fulgurateTimner.stop();
		}

		public function setAnimalLight(n:int, isPlaySound:Boolean=true):void
		{
			setAllUnlight();

			var t:Number=n % 28;
			
			var animal:BaseAnimal;
			for(var i:int = 0; i < this.mainPan.numElements; i ++){
				animal = this.mainPan.getElementAt(i) as BaseAnimal;
				if(animal && animal.px == t){
					animal.showLight(true);
					if(isPlaySound){
						SharkSoundService.instance.paoSound();//播放灯泡跑的声音
					}
				}
			}

			/*for (var i:int=0; i < animalArr.length; i++)
			{
				if (animalArr[i].px == t)
				{
					animalArr[i].light();
					if(isPlaySound){
						SharkSoundService.instance.paoSound();//播放灯泡跑的声音
					}
				}
			}*/
		}

		//所有闪锁 初始状态
		public function setAllUnlight():void
		{
			var animal:BaseAnimal;
			for(var i:int = 0; i < this.mainPan.numElements; i ++){
				animal = this.mainPan.getElementAt(i) as BaseAnimal;
				if(animal){
					animal.showLight(false);
				}
			}
			/*for (var i:int=0; i < animalArr.length; i++)
			{
				animalArr[i].unlight();
			}*/
		}

		//根据number 返回中奖动物
		public function gerResaultAnimal(px:Number):Object
		{
			var animalObj:Object;
			
			var animal:BaseAnimal;
			for(var i:int = 0; i < this.mainPan.numElements; i ++){
				animal = this.mainPan.getElementAt(i) as BaseAnimal;
				if(animal && animal.px == px){
					animalObj = animal;
					break;
				}
			}
			
			return animalObj;
			/*var animal:Object;
			for (var i:int=0; i < animalArr.length; i++)
			{
				if (animalArr[i].px == px)
				{
					animal=animalArr[i];
				}
			}
			return animal;*/
		}

	}
}