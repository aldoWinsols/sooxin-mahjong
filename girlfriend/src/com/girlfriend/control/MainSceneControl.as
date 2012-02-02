package com.girlfriend.control
{
	import com.girlfriend.services.DataService;
	import com.girlfriend.view.MainScene;
	
	import flash.events.MouseEvent;

	public class MainSceneControl
	{
		public var mainScene:MainScene = null;
		public static var instance:MainSceneControl = null;
		private var isWorkStart:Boolean = false;
		public function MainSceneControl(mainScene1:MainScene)
		{
			DataService.instance;
			this.mainScene = mainScene1;
			instance = this;
			
			addEventListener();
		}
		
		private function addEventListener():void{
			mainScene.workBtn.addEventListener(MouseEvent.CLICK, onWorkBtn);
		}
		
		private function onWorkBtn(e:MouseEvent):void{
			var date:Date = new Date();
			
			var hours:int = date.hours;
			
			var beforeOneTime:String = hours + ":" + date.minutes + ":" + date.seconds;
			var todayDate:String = date.fullYear + "-" + (date.month + 1) + "-" + date.date;
			
			if(hours < 9 && hours >= 6){
				isWorkStart = true;
				DataService.instance.addWorklog(beforeOneTime, "", todayDate);
				return;
			}
			if(hours < 6){
				trace("不到打卡时间");
				return;
			}
			if(hours > 17 && hours <= 23 && isWorkStart){
				DataService.instance.addWorklog("", beforeOneTime, todayDate);
				return;
			}
			if(hours <= 17){
				trace("不到下班时间，不能打卡");
			}
		}
	}
}