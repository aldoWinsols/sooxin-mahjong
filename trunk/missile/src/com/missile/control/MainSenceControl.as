package com.missile.control
{
	import com.missile.model.Missile;
	import com.missile.view.MainSence;
	import com.missile.view.StateInfo;

	public class MainSenceControl
	{
		private var mainSence:MainSence;
		private var myMissile:Vector.<Missile> = new Vector.<Missile>();
		public static var instance:MainSenceControl;
		
		public function MainSenceControl(mainSence:MainSence)
		{
			this.mainSence = mainSence;
			instance = this;
			
			for(var i:int=0;i<5;i++){
				var missile:Missile = new Missile();
				missile.missileName = "00"+i;
				this.mainSence.missileG.addElement(missile);
				myMissile.push(missile);
				
				var stateInfo:StateInfo = new StateInfo();
				stateInfo.mName = "00"+i;
				
				this.mainSence.stateG.addElement(stateInfo);
				stateInfo.x = 668;
				stateInfo.y = 10+ i*40;
			}
		}
		
		public function changeState(name:String):void{
			for(var i:int = 0; i<myMissile.length; i++){
				if(myMissile[i].missileName == name){
					this.mainSence.missileG.setElementIndex(myMissile[i],myMissile.length-1);
				}
			}
		}
		
	}
}