package com.amusement.Mahjong.control
{
	import com.amusement.Mahjong.service.MahjongOperationService;
	import com.amusement.Mahjong.view.MahjongOperation;
	
	import flash.events.MouseEvent;

	public class MahjongOperationControl
	{
		private static var _instance:MahjongOperationControl;
		
		private var _mahjongOperation:MahjongOperation;
		private var _mahjongOperationService:MahjongOperationService;
		
		private var _haveHu:Boolean;
		private var _isZimo:Boolean;
		private var _isZigang:Boolean;
		
		public function MahjongOperationControl(mahjongOperation:MahjongOperation)
		{
			_instance = this;
			
			this._mahjongOperation = mahjongOperation;
			_mahjongOperationService = new MahjongOperationService();
			
			init();
		}
		
		private function init():void{
			addListeners();
		}
		
		private function addListeners():void{
			this._mahjongOperation.pengBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
			this._mahjongOperation.gangBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
			this._mahjongOperation.huBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
			this._mahjongOperation.xiaoBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
		}
		
		private function btnClickHandler(event:MouseEvent):void{
			if(!MahjongRoomControl.instance.isVideo && MahjongRoomControl.instance.putState == 3){
				switch(event.currentTarget.id){
					case "pengBtn":
						_mahjongOperationService.pengClickHandler();
						break;
					case "gangBtn":
						_mahjongOperationService.gangClickHandler(this._isZigang, this._mahjongOperation.parent, (this._mahjongOperation.stage.stageWidth - 1024)/2 + 710, 445);
						break;
					case "huBtn":
						_mahjongOperationService.huClickHandler(this._isZimo);
						break;
					case "xiaoBtn":
						_mahjongOperationService.xiaoClickHandler(this._isZimo, this._isZigang);
						break;
					default:
						break;
				}
			}
		}
		
		public function show(isPeng:Boolean, isGang:Boolean, isHu:Boolean, isZimo:Boolean = false, isZigang:Boolean = false, isXiao:Boolean = true):void{
			this._mahjongOperation.pengBtn.enabled = isPeng;
			this._mahjongOperation.gangBtn.enabled = isGang;
			this._mahjongOperation.huBtn.enabled = isHu;
			this._mahjongOperation.xiaoBtn.enabled = isXiao;
			
			this._haveHu = isHu;
			this._isZimo = isZimo;
			this._isZigang = isZigang;
			
			if(!MahjongRoomControl.instance.isVideo){
				MahjongRoomControl.instance.putState = 3;
				MahjongTimerControl.instance.show(3, 10);
			}
			
			this._mahjongOperation.visible = true;
		}
		
		public function hide():void{
			this._mahjongOperation.visible = false;
			
			this._mahjongOperation.pengBtn.enabled = false;
			this._mahjongOperation.gangBtn.enabled = false;
			this._mahjongOperation.huBtn.enabled = false;
			this._mahjongOperation.xiaoBtn.enabled = true;
		}
		
		public function timeUp():void{
			this._mahjongOperationService.replaceClick(_haveHu, _isZimo, _isZigang);
		}

		//------------------------------------------------------------------------
		public static function get instance():MahjongOperationControl
		{
			return _instance;
		}

	}
}