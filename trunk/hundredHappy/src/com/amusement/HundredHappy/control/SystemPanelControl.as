package com.amusement.HundredHappy.control
{
	import com.amusement.HundredHappy.services.HundredHappyMusicService;
	import com.amusement.HundredHappy.services.HundredHappySoundService;
	import com.amusement.HundredHappy.view.SystemPanel;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import mx.managers.PopUpManager;

	public class SystemPanelControl
	{
		/*[Embed(source="com/amusement/HundredHappy/assets/system/hh_system_open_btn.png")]
		private var _OpenSkin:Class;
		[Embed(source="com/amusement/HundredHappy/assets/system/hh_system_open_down.png")]
		private var _OpenDownSkin:Class;
		[Embed(source="com/amusement/HundredHappy/assets/system/hh_system_open_over.png")]
		private var _OpenOverSkin:Class;
		[Embed(source="com/amusement/HundredHappy/assets/system/hh_system_close_btn.png")]
		private var _CloseSkin:Class;
		[Embed(source="com/amusement/HundredHappy/assets/system/hh_system_close_down.png")]
		private var _CloseDownSkin:Class;
		[Embed(source="com/amusement/HundredHappy/assets/system/hh_system_close_over.png")]
		private var _CloseOverSkin:Class;*/
		
		private static var _instance:SystemPanelControl;
		
		private var _systemPanel:SystemPanel;
		
//		private var _isPlayMusic:Boolean;
//		private var _isPlaySound:Boolean;
		
		public function SystemPanelControl()
		{
			_systemPanel = new SystemPanel();
			
			/*setPlayAndSkin("music", true);
			setPlayAndSkin("sound", true);*/
		}

		public static function get instance():SystemPanelControl
		{
			if(_instance == null){
				_instance = new SystemPanelControl();
			}
			return _instance;
		}
		
		private function addListeners():void{
			this._systemPanel.confirmBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
			this._systemPanel.presetBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
			this._systemPanel.rightBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
			this._systemPanel.leftBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
			this._systemPanel.soundBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
			this._systemPanel.musicBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
		}
		
		private function removeListeners():void{
			this._systemPanel.confirmBtn.removeEventListener(MouseEvent.CLICK, btnClickHandler);
			this._systemPanel.presetBtn.removeEventListener(MouseEvent.CLICK, btnClickHandler);
			this._systemPanel.rightBtn.removeEventListener(MouseEvent.CLICK, btnClickHandler);
			this._systemPanel.leftBtn.removeEventListener(MouseEvent.CLICK, btnClickHandler);
			this._systemPanel.musicBtn.removeEventListener(MouseEvent.CLICK, btnClickHandler);
			this._systemPanel.soundBtn.removeEventListener(MouseEvent.CLICK, btnClickHandler);
			
		}
		
		private function btnClickHandler(event:MouseEvent):void{
			switch(event.currentTarget.id){
				case "confirmBtn":
					hide();
					break;
				case "presetBtn":
					preset();
					break;
				case "rightBtn":
					HundredHappyMusicService.instance.changeMusic(1);
					break;
				case "leftBtn":
					HundredHappyMusicService.instance.changeMusic(0);
					break;
				case "musicBtn":
					HundredHappyMusicService.instance.isPlay = _systemPanel.musicBtn.selected;
					/*setPlayAndSkin("music", !_isPlayMusic);
					HundredHappyMusicService.instance.isPlay = _isPlayMusic;*/
					break;
				case "soundBtn":
					HundredHappySoundService.instance.isPlay = _systemPanel.soundBtn.selected;
					/*setPlayAndSkin("sound", !_isPlaySound);
					HundredHappySoundService.instance.isPlay = _isPlaySound;*/
					break;
			}
		}
		
		/*private function setPlayAndSkin(type:String, isPlay:Boolean):void{
			switch(type){
				case "music":
					_isPlayMusic = isPlay;
					if(_isPlayMusic){
						this._systemPanel.musicSkin = _CloseSkin;
						this._systemPanel.musicDownSkin = _CloseDownSkin;
						this._systemPanel.musicOverSkin = _CloseOverSkin;
					}else{
						this._systemPanel.musicSkin = _OpenSkin;
						this._systemPanel.musicDownSkin = _OpenDownSkin;
						this._systemPanel.musicOverSkin = _OpenOverSkin;
					}
					break;
				case "sound":
					_isPlaySound = isPlay;
					if(_isPlaySound){
						this._systemPanel.soundSkin = _CloseSkin;
						this._systemPanel.soundDownSkin = _CloseDownSkin;
						this._systemPanel.soundOverSkin = _CloseOverSkin;
					}else{
						this._systemPanel.soundSkin = _OpenSkin;
						this._systemPanel.soundDownSkin = _OpenDownSkin;
						this._systemPanel.soundOverSkin = _OpenOverSkin;
					}
					break;
			}
		}*/
		
		private function preset():void{
			_systemPanel.musicBtn.selected = true;
			_systemPanel.soundBtn.selected = true;
			/*setPlayAndSkin("music", true);
			setPlayAndSkin("sound", true);*/
			HundredHappyMusicService.instance.reset(true);
			HundredHappySoundService.instance.isPlay = true;
		}
		
		public function init():void{
			HundredHappyMusicService.instance.isPlay = _systemPanel.musicBtn ? _systemPanel.musicBtn.selected : true;
			HundredHappySoundService.instance.isPlay = _systemPanel.soundBtn ? _systemPanel.soundBtn.selected : true;
			/*HundredHappyMusicService.instance.isPlay = _isPlayMusic;
			HundredHappySoundService.instance.isPlay = _isPlaySound;*/
		}
		
		public function finish():void{
			hide();
			
			HundredHappyMusicService.instance.isPlay = false;
			HundredHappySoundService.instance.stop();
		}
		
		public function show(parent:DisplayObject):void{
			if(_systemPanel.isPopUp){
				PopUpManager.bringToFront(_systemPanel);
			}else{
				PopUpManager.addPopUp(this._systemPanel, parent);
				
				addListeners();
			}
			PopUpManager.centerPopUp(this._systemPanel);
		}
		
		public function hide():void{
			removeListeners();
			
			PopUpManager.removePopUp(this._systemPanel);
		}

	}
}