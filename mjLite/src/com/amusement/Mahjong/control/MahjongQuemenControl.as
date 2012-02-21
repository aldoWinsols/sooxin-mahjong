package com.amusement.Mahjong.control
{
	import com.amusement.Mahjong.service.MahjongQuemenService;
	import com.amusement.Mahjong.view.MahjongQuemen;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import mx.managers.PopUpManager;

	public class MahjongQuemenControl
	{
		private static var _instance:MahjongQuemenControl;
		
		private var _mahjongQuemen:MahjongQuemen;
		private var _mahjongQuemenService:MahjongQuemenService;
		
		public function MahjongQuemenControl()
		{
			this._mahjongQuemen = new MahjongQuemen();
			this._mahjongQuemenService = new MahjongQuemenService();
			
			init();
		}
		
		private function init():void{
			
		}
		
		private function addListeners():void{
			this._mahjongQuemen.wangBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
			this._mahjongQuemen.tongBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
			this._mahjongQuemen.tiaoBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
		}
		
		private function removeListeners():void{
			if(this._mahjongQuemen.wangBtn){
				this._mahjongQuemen.wangBtn.removeEventListener(MouseEvent.CLICK, btnClickHandler);
			}
			
			if(this._mahjongQuemen.tongBtn){
				this._mahjongQuemen.tongBtn.removeEventListener(MouseEvent.CLICK, btnClickHandler);
			}
			
			if(this._mahjongQuemen.tiaoBtn){
				this._mahjongQuemen.tiaoBtn.removeEventListener(MouseEvent.CLICK, btnClickHandler);
			}
		}
		
		private function btnClickHandler(event:MouseEvent):void{
			if(MahjongRoomControl.instance.putState == 1){
				MahjongRoomControl.instance.putState = 0;
				
				MahjongTimerControl.instance.hide();
				
				this.hide();
				MahjongDingzhangControl.instance.hide();
				
				switch(event.currentTarget.id){
					case "wangBtn":
						this._mahjongQuemenService.wangClickHandler();
						break;
					case "tongBtn":
						this._mahjongQuemenService.tongClickHandler();
						break;
					case "tiaoBtn":
						this._mahjongQuemenService.tiaoClickHandler();
						break;
				}
			}
		}
		
		private function setBtnEnable(quemenTypes:Array):void{
			this._mahjongQuemen.wangBtn.enabled = false;
			this._mahjongQuemen.tongBtn.enabled = false;
			this._mahjongQuemen.tiaoBtn.enabled = false;
			
			for each(var quemenType:int in quemenTypes){
				switch(quemenType){
					case 0:
						this._mahjongQuemen.wangBtn.enabled = true;
						break;
					case 10:
						this._mahjongQuemen.tongBtn.enabled = true;
						break;
					case 20:
						this._mahjongQuemen.tiaoBtn.enabled = true;
						break;
				}
			}
		}
		
		public function show(quemenTypes:Array, parent:DisplayObject, px:int, py:int):void{
			if(!this._mahjongQuemen.isPopUp){
				this._mahjongQuemen.x = px;
				this._mahjongQuemen.y = py;
				PopUpManager.addPopUp(this._mahjongQuemen, parent);
				
				setBtnEnable(quemenTypes);
				addListeners();
			}
		}
		
		public function hide():void{
			removeListeners();
			
			if(this._mahjongQuemen.wangBtn){
				this._mahjongQuemen.wangBtn.enabled = false;
			}
			
			if(this._mahjongQuemen.tongBtn){
				this._mahjongQuemen.tongBtn.enabled = false;
			}
			
			if(this._mahjongQuemen.tiaoBtn){
				this._mahjongQuemen.tiaoBtn.enabled = false;
			}
			
			PopUpManager.removePopUp(this._mahjongQuemen);
		}

		public static function get instance():MahjongQuemenControl
		{
			if(_instance == null){
				_instance = new MahjongQuemenControl();
			}
			return _instance;
		}

	}
}