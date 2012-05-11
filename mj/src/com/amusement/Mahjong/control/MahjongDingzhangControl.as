package com.amusement.Mahjong.control
{
	import com.amusement.Mahjong.service.MahjongDingzhangService;
	import com.amusement.Mahjong.service.MahjongSoundService;
	import com.amusement.Mahjong.view.MahjongDingzhang;
//	import com.control.MainSceneControl;
	
	import flash.events.MouseEvent;

	public class MahjongDingzhangControl
	{
		private static var _instance:MahjongDingzhangControl;
		
		private var _mahjongDingzhang:MahjongDingzhang;
		private var _mahjongDingzhangService:MahjongDingzhangService;
		
		public function MahjongDingzhangControl(mahjongDingzhang:MahjongDingzhang)
		{
			_instance = this;
			
			this._mahjongDingzhang = mahjongDingzhang;
			this._mahjongDingzhangService = new MahjongDingzhangService();
			
			init();
		}
		
		private function init():void{
			addListeners();
		}
		
		private function addListeners():void{
			this._mahjongDingzhang.quemenBtn.addEventListener(MouseEvent.CLICK, quemenClickHandler, false, 0, true);
		}
		
		
		private function quemenClickHandler(event:MouseEvent):void{
			if(!MahjongRoomControl.instance.isVideo && MahjongRoomControl.instance.putState == 1){
				this._mahjongDingzhangService.quemenClickHandler(this._mahjongDingzhang.parent, (this._mahjongDingzhang.stage.stageWidth - 1024)/2 + 478, 435);
			}
		}
		
		public function show():void{
			this._mahjongDingzhang.quemenBtn.visible = false;
			
			this._mahjongDingzhang.visible = true;
			var quemenTypes:Array = MahjongPlayerControlD.instance.checkQuemenMine();
			if(quemenTypes.length > 0){
				this._mahjongDingzhang.quemenBtn.visible = true;
			}
			
			MahjongSoundService.instance.soundPlay("qingdingzhang");
			
			if(!MahjongRoomControl.instance.isVideo){
				MahjongRoomControl.instance.putState = 1;
				MahjongTimerControl.instance.show();
			}
			
		}
		
		public function hide():void{
			this._mahjongDingzhang.quemenBtn.visible = false;
			this._mahjongDingzhang.visible = false;
		}

		public static function get instance():MahjongDingzhangControl
		{
			return _instance;
		}

	}
}