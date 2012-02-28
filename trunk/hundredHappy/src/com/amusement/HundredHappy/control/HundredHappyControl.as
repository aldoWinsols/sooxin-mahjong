package com.amusement.HundredHappy.control
{
	import com.amusement.HundredHappy.HundredHappy;
	import com.amusement.HundredHappy.services.HundredHappySyncService;
	import com.amusement.HundredHappy.services.PokerService;
	import com.hundredHappySyncServer.services.GameHallService;
	import com.service.PlayerService;
	
	import flash.events.MouseEvent;

	/**
	 * 2012-2-23 9:39 gmr start 删除游戏退出监听事件
	 * */
	public class HundredHappyControl
	{
		private static var _instance:HundredHappyControl;
		
		private var _hundredHappy:HundredHappy;
		
		public function HundredHappyControl(hundredHappy:HundredHappy)
		{
			_instance = this;
			
			this._hundredHappy = hundredHappy;
			
			init();
		}
		
		private function init():void{
			addListeners();
		}
		
		private function addListeners():void{
			this._hundredHappy.addEventListener(MouseEvent.MOUSE_UP, dragHandler);
//			this._hundredHappy.addEventListener(MouseEvent.ROLL_OUT, dragHandler);
		}
		
		public function dragHandler(event:MouseEvent):void{
			switch(event.type){
				case MouseEvent.MOUSE_DOWN:
					this._hundredHappy.startDrag();
					break;
				case MouseEvent.MOUSE_UP:
					this._hundredHappy.stopDrag();
					break;
				case MouseEvent.ROLL_OUT:
					this._hundredHappy.stopDrag();
					break;
			}
		}
		
		public function unload():void{
			// 2012-2-23 9:39 gmr start 删除游戏退出监听事件
//			MainSceneControl.instance.mainSceneApp.addEventListener(GameTypeEvent.HUNDREDHAPPY_EXITGAME, HundredHappySyncService.instance.onDisconnection);
//			// 2012-2-23 9:39 gmr end
//			MainSceneControl.instance.mainSceneApp.gameModule.unloadModule();
//			MainSceneControl.instance.mainSceneApp.gameModule.visible=false;
//			MainSceneControl.instance.setZezhaoVisible(false);
//			//导航进入用
//			TopControl.insance.toIndexState(null);
//			
//			PlayerService.instance.playerEnterSomeGame();
		}
		
		public function resetXY():void{
			this._hundredHappy.stopDrag();
			this._hundredHappy.x = 0;
			this._hundredHappy.y = 0;
		}
		
		/*public function updateNotice(x:Number, verticalCenter:Number, width:Number = 0, fontSize:int = 0):void{
			this._hundredHappy.notice.x = x;
			this._hundredHappy.notice.verticalCenter = verticalCenter;
			if(width > 0){
				this._hundredHappy.notice.width = width;
			}
			if(fontSize > 0){
				this._hundredHappy.notice.setStyle("fontSize", fontSize);
			}
		}*/

		public static function get instance():HundredHappyControl
		{
			return _instance;
		}

	}
}