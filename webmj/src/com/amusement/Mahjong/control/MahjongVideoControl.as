package com.amusement.Mahjong.control
{
	import com.amusement.Mahjong.service.MahjongMessageService;
	import com.amusement.Mahjong.service.MahjongVideoService;
	import com.amusement.Mahjong.view.MahjongVideo;
	
	import flash.events.MouseEvent;

	public class MahjongVideoControl
	{
		private static var _instance:MahjongVideoControl;
		
		private var _mahjongVideo:MahjongVideo;
		private var _mahjongVideoService:MahjongVideoService;
		
		public function MahjongVideoControl(mahjongVideo:MahjongVideo)
		{
			_instance = this;
			
			this._mahjongVideo = mahjongVideo;
			this._mahjongVideoService = new MahjongVideoService();
			
			init();
		}
		
		private function init():void{
			addListeners();
		}
		
		private function addListeners():void{
			this._mahjongVideo.addEventListener(MouseEvent.MOUSE_DOWN, mouseEventHandler, false, 0, true);
			this._mahjongVideo.addEventListener(MouseEvent.MOUSE_UP, mouseEventHandler, false, 0, true);
			
			this._mahjongVideo.slowBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
			this._mahjongVideo.playOrPauseBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
			this._mahjongVideo.fastBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
			
			this._mahjongVideo.exitBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
		}
		
		private function mouseEventHandler(event:MouseEvent):void{
			switch(event.type){
				case MouseEvent.MOUSE_DOWN:
					this._mahjongVideo.startDrag();
					break;
				case MouseEvent.MOUSE_UP:
					this._mahjongVideo.stopDrag();
					break;
			}
		}
		
		private function btnClickHandler(event:MouseEvent):void{
			this._mahjongVideo.stateTxt.text = this._mahjongVideoService.btnClickHandler(event.currentTarget.id);
		}
		
		public function show():void{
			this._mahjongVideo.visible = true;
			this._mahjongVideo.stateTxt.text = "正常播放";
			this._mahjongVideoService.startVideo();
		}
		
		public function hide():void{
			this._mahjongVideoService.stopVideo();
			this._mahjongVideo.stateTxt.text = "正常播放";
			this._mahjongVideo.visible = false;
		}
		
		/**
		 * 播放录像 
		 * 
		 */
		public function playVideo():void{
			this._mahjongVideoService.playBeginGame();
		}
		
		/**
		 * 构建录像
		 * @param content
		 * 
		 */
		public function constructVideo(content:String, money:Number):void{
			this._mahjongVideoService.constructVideo(content, money);
		}

		//---------------------------------------------------------------
		public static function get instance():MahjongVideoControl
		{
			return _instance;
		}

	}
}