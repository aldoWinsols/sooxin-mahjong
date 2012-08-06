package com.control
{
	import com.view.Weihu;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class WeihuControl
	{
		public static var instance:WeihuControl;
		private var weihu:Weihu;
		var timer:Timer;
		var n:int = 0;
		public function WeihuControl(weihu:Weihu)
		{
			this.weihu = weihu;
			instance = this;
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
		}
		
		private function timerHandler(e:TimerEvent):void{
			n++;
			this.weihu.timerNum.text = (600-n)+"";
			
			if(n==600){
				timer.stop();
				n=0;
				this.weihu.visible = false;
				MainSenceControl.instance.mainSence.currentState = "lianwangHome";
			}
		}
		
		public function startWeihu():void{
			this.weihu.visible = true;
			timer.start();
		}
	}
}