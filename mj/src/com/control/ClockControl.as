package com.control
{
	import com.view.Clock;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class ClockControl
	{
		private var clock:Clock;
		public function ClockControl(clock:Clock)
		{
			this.clock = clock;
			var timer:Timer = new Timer(60000);
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
			timer.start();
		}
		
		private function timerHandler(e:TimerEvent):void{
			var date:Date = new Date();
			if(date.getMinutes() < 10){
				clock.time.text = date.getHours()+":0"+date.getMinutes();
			}else{
				clock.time.text = date.getHours()+":"+date.getMinutes();
			}
		}
	}
}