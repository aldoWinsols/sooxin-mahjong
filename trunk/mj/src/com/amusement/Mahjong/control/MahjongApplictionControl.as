package com.amusement.Mahjong.control
{
	import com.amusement.Mahjong.MahjongAppliction;
//	import com.control.MainSceneControl;
//	import com.view.MahjongVideo;
//	
	import flash.events.MouseEvent;
	
	import mx.events.StateChangeEvent;

	public class MahjongApplictionControl
	{
		private static var _instance:MahjongApplictionControl;
		
		public var _mahjongAppliction:MahjongAppliction;
		
		public function MahjongApplictionControl(mahjongAppliction:MahjongAppliction)
		{
			_instance = this;
			
			this._mahjongAppliction = mahjongAppliction;
			
			init();
		}
		
		private function init():void{
			this._mahjongAppliction.addEventListener(MouseEvent.MOUSE_UP, dragHandler);
			
//			if(MahjongVideo.insance && MahjongVideo.insance.isPopUp){
//				playVideo(MahjongVideo.insance.gameContent, Number(MahjongVideo.insance.gameMoney));
//			}else{
//				enterGame(MainSceneControl.instance.roomType);
//			}
		}
		
		public function dragHandler(event:MouseEvent):void{
			switch(event.type){
				case MouseEvent.MOUSE_DOWN:
					this._mahjongAppliction.startDrag();
					break;
				case MouseEvent.MOUSE_UP:
					this._mahjongAppliction.stopDrag();
					break;
			}
		}
		
		public function resetXY():void{
			this._mahjongAppliction.x = 0;
			this._mahjongAppliction.y = 0;
		}
		
		public function playMahjong():void{
//			this._mahjongAppliction.currentState = "SelectMahjongRoomState";
		}
		
		public function enterGame(roomType:int):void{
//			this._mahjongAppliction.currentState = "MahjongRoomState";
			MahjongRoomControl.instance.enterGame(roomType);
		}
		
		public function exitGame():void{
//			this._mahjongAppliction.currentState = "SelectMahjongRoomState";
		}
		
		public function playVideo(content:String, money:Number):void{
//			this._mahjongAppliction.currentState = "MahjongRoomState";
			MahjongVideoControl.instance.constructVideo(content, money);
			MahjongVideoControl.instance.playVideo();
		}

		public function backHall():void{
//			MainSceneControl.instance.mainSceneApp.gameModule.unloadModule();
//			MainSceneControl.instance.mainSceneApp.gameModule.visible=false;
//			MainSceneControl.instance.setZezhaoVisible(false);
		}
		
		//-----------------------------------------------------------------------------------
		public static function get instance():MahjongApplictionControl
		{
			return _instance;
		}

	}
}