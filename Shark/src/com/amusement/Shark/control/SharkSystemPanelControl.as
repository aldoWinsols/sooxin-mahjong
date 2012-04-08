package com.amusement.Shark.control
{
	import com.amusement.Shark.main.SharkSystemPanel;
	import com.amusement.Shark.service.SharkSoundService;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import mx.managers.PopUpManager;

	public class SharkSystemPanelControl
	{
		private static var _instance:SharkSystemPanelControl;
		private var _sharkSystemPanel:SharkSystemPanel;
		
		public function SharkSystemPanelControl()
		{
			_sharkSystemPanel = new SharkSystemPanel();
		}

		public static function get instance():SharkSystemPanelControl
		{
			if(_instance == null){
				_instance = new SharkSystemPanelControl();
			}
			return _instance;
		}
		
		private function addListeners():void{
			this._sharkSystemPanel.confirmBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
			this._sharkSystemPanel.presetBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
			this._sharkSystemPanel.soundBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
			this._sharkSystemPanel.musicBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
		}
		
		private function removeListeners():void{
			this._sharkSystemPanel.confirmBtn.removeEventListener(MouseEvent.CLICK, btnClickHandler);
			this._sharkSystemPanel.presetBtn.removeEventListener(MouseEvent.CLICK, btnClickHandler);
			this._sharkSystemPanel.musicBtn.removeEventListener(MouseEvent.CLICK, btnClickHandler);
			this._sharkSystemPanel.soundBtn.removeEventListener(MouseEvent.CLICK, btnClickHandler);
			
		}
		
		private function btnClickHandler(event:MouseEvent):void{
			switch(event.currentTarget.id){
				case "confirmBtn":
					hide();
					break;
				case "presetBtn":
					preset();
					break;
				case "musicBtn":
					SharkSoundService.instance.isPlayMusic = _sharkSystemPanel.musicBtn.selected;
					break;
				case "soundBtn":
					SharkSoundService.instance.isPlaySound = _sharkSystemPanel.soundBtn.selected;
					break;
			}
		}
		
		private function preset():void{
			_sharkSystemPanel.musicBtn.selected = true;
			_sharkSystemPanel.soundBtn.selected = true;
			SharkSoundService.instance.isPlayMusic = true;
			SharkSoundService.instance.isPlaySound = true;
		}
		
		public function init():void{
			SharkSoundService.instance.isPlayMusic = _sharkSystemPanel.musicBtn ? _sharkSystemPanel.musicBtn.selected : true;
			SharkSoundService.instance.isPlaySound = _sharkSystemPanel.soundBtn ? _sharkSystemPanel.soundBtn.selected : true;
		}
		
		public function finish():void{
			hide();
			
			SharkSoundService.instance.isPlayMusic = false;
			SharkSoundService.instance.isPlaySound = false;
		}
		
		public function show(parent:DisplayObject):void{
			if(_sharkSystemPanel.isPopUp){
				PopUpManager.bringToFront(_sharkSystemPanel);
			}else{
				PopUpManager.addPopUp(this._sharkSystemPanel, parent);
				addListeners();
			}
			PopUpManager.centerPopUp(this._sharkSystemPanel);
		}
		
		public function hide():void{
			removeListeners();
			
			PopUpManager.removePopUp(this._sharkSystemPanel);
		}
	}
}