package com.amusement.Shark.control
{
	import com.amusement.Shark.main.Resault;
	import com.amusement.Shark.model.betting.BaseBet;
	import com.amusement.Shark.model.result.ResultAnimal;
	
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;

	public class ResaultControl
	{
		public var resault:Resault;
		public static var instance:ResaultControl;

//		public var jieguoPanArr:Array;
//		public var touzhuArr:Array;


		public function ResaultControl(resault:Resault)
		{
			this.resault=resault;

			/*jieguoPanArr=getJieguoPan();
			touzhuArr=getTouzhuArr();*/

			if (instance == null)
			{
				instance=this;
			}



			//监听拖拽
			this.resault.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);
			this.resault.addEventListener(MouseEvent.MOUSE_UP, upHandler);
			
			this.resault.fanhui.addEventListener(MouseEvent.CLICK, btnClickHandler, false);

//			this.resault.stage.addEventListener(KeyboardEvent.KEY_DOWN, keydownHandler);
		}

		//-----------------------------------------------------------------
		public var isshow:Boolean=false; //结果面板是否是通过点击返回游戏按钮关闭的

		
		private function btnClickHandler(event:MouseEvent):void{
			switch(event.currentTarget.id){
				case "fanhui":
					closeResault();
					break;
			}
		}
		
		//监听ESC按键
		public function keydownHandler(e:KeyboardEvent):void
		{
			if (isshow)
			{
				if (e.keyCode == Keyboard.ESCAPE)
				{
					if (this.resault.visible)
					{
						this.resault.visible=false;
					}
					else
					{
						this.resault.visible=true;
					}
				}
			}

		}

		//-------------------------------------------------------------------------
		//拖拽
		public function downHandler(e:MouseEvent):void
		{
			this.resault.startDrag();
		}

		public function upHandler(e:MouseEvent):void
		{
			this.resault.stopDrag();
		}

		//--------------------------------------------------------------------------

		public function closeResault():void
		{
			if (this.resault.visible == true)
			{
//				TouzhuControl.instance.setAllZero();
				BetPanelControl.instance.clear();
				this.resault.visible=false;
			}
			isshow=false;
			
			BetPanelControl.instance.stopResultEffect();
//			TouzhuControl.instance.setAllUnclock(); //打开投住面版,可以进行投注
			BetPanelControl.instance.setLock(false);
		}

		public function show():void
		{
			this.resault.visible=true;
			isshow=true;
		}

		//---------------------------------------------------------------------------
		//----------------------------------------------------------------------------
		//计算结果

		public var resaultAnimal:Object;

		public function calculate(resaultNumber:int, touzhuArr:Array):void
		{
			var resultArr:Array = touzhuArr;
			//返回中奖动物名字
			resaultAnimal = MainPanControl.instance.gerResaultAnimal(resaultNumber);

			var rAnimal:ResultAnimal;
			for(var j:int = 0; j < this.resault.jieguoPan.numElements; j ++){
				rAnimal = this.resault.jieguoPan.getElementAt(j) as ResultAnimal;
				if(rAnimal){
					rAnimal.showLight(false);
					rAnimal.yanzhuNum.text = resultArr[j].currentBetNum + "";
					rAnimal.shuyingNum.text = -resultArr[j].currentBetNum + "";
					
					if(rAnimal.animalName == resaultAnimal.animalName || rAnimal.animalName == resaultAnimal.type){
						rAnimal.shuyingNum.text = resultArr[j].currentBetNum * resultArr[j].pValue - resultArr[j].currentBetNum + "";
						
						rAnimal.showLight(true);
					}
				}
			}
			
			/*for (var i:int=0; i < touzhuArr.length; i++)
			{
				for (var j:int=0; j < jieguoPanArr.length; j++)
				{
					jieguoPanArr[j].setStyle("backgroundColor", "");
					jieguoPanArr[j].yazhuNum.text=touzhuArr[j].yazhuNum;
					jieguoPanArr[j].shuyingNum.text=-touzhuArr[j].yazhuNum + "";
					if (jieguoPanArr[j].jieguoImageAnimal == resaultAnimal.animalName)
					{
						jieguoPanArr[j].shuyingNum.text=touzhuArr[j].yazhuNum * touzhuArr[j].pvalue - touzhuArr[j].yazhuNum + "";
						jieguoPanArr[j].setStyle("backgroundColor", "0xFF4D00");
					}
					if (jieguoPanArr[j].jieguoImageAnimal == resaultAnimal.type)
					{
						jieguoPanArr[j].shuyingNum.text=touzhuArr[j].yazhuNum * touzhuArr[j].pvalue - touzhuArr[j].yazhuNum + "";
						jieguoPanArr[j].setStyle("backgroundColor", "0xFF4D00");
					}
				}
			}*/

//			this.resault.horizontalList.dataProvider=TouzhuControl.instance.getTouzhu();
		}

		//-----------------------------------------------------------
		/*public function getJieguoPan():Array
		{
			return this.resault.jieguoPan.getChildren();
		}*/

		/*public function getTouzhuArr():Array
		{
			return TouzhuControl.instance.touzhu.touzhuPan.getChildren();
		}*/
		//--------------------------------------------------------------

	}
}