package com.control
{
	import com.model.Alert;
	import com.services.DataService;
	import com.services.GameCenterService;
	import com.view.DanjiHome;
	import com.view.PlayerAdd;
	
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;

	public class DanjiHomeControl
	{
		public static var instance:DanjiHomeControl;
		public var danjiHome:DanjiHome;
		public function DanjiHomeControl(danjiHome:DanjiHome)
		{
			this.danjiHome = danjiHome;
			instance = this;
			
			DataService.instance;
			
			this.danjiHome.danji_exitB.addEventListener(MouseEvent.CLICK,danji_exitBClickHandler);
			this.danjiHome.backB.addEventListener(MouseEvent.CLICK,backBClickHandler);
			
//			GameCenterService.getInstance();
			
//			this.home.addPlayerB.addEventListener(MouseEvent.CLICK,addPlayerBClickHandler);
		}
		
		private function backBClickHandler(e:MouseEvent):void{
			MainSenceControl.instance.mainSence.currentState = "login";
		}
		
		public function setStateMain():void{
			this.danjiHome.currentState = "main";
		}
		
		private function danji_exitBClickHandler(e:MouseEvent):void{
			MainSenceControl.instance.mainSence.currentState = "login";
		}

		private function addPlayerBClickHandler(e:MouseEvent):void{
			danjiHome.playerAdd.visible = true;
		}
	}
}