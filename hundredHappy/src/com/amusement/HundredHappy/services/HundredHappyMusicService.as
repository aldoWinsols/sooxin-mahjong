package com.amusement.HundredHappy.services
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class HundredHappyMusicService
	{
		private static var _instance:HundredHappyMusicService;
		
		private var _sound:Sound;
		private var _channel:SoundChannel;
		
		private var _musics:Array;
		private var _currentMusicNo:int = 0;
		
		[Bindable]
		public var currentMusicName:String = "";
		
		private var _isPlay:Boolean;
		
		public function HundredHappyMusicService()
		{
			currentMusicName = "";
			_musics = [];
			
			var loader:URLLoader =new URLLoader(new URLRequest("com/amusement/HundredHappy/assets/baccarat_musics.xml"));
			loader.addEventListener(Event.COMPLETE, loaderCompleteHandler, false, 0, true);
		}

		public static function get instance():HundredHappyMusicService
		{
			if(_instance == null){
				_instance = new HundredHappyMusicService();
			}
			return _instance;
		}
		
		private function loaderCompleteHandler(event:Event):void{
			var musicList:XMLList = XML(event.target.data).music;
			
			var request:URLRequest = new URLRequest();
			var music:Object;
			for each(var xml:XML in musicList){
				music = {};
				music.name = xml.@name;
				request.url = xml.@url;
				music.sound = new Sound(request);
				_musics.push(music);
			}
			
			init();
		}
		
		private function init():void{
			_currentMusicNo = 0;
			if( _musics[_currentMusicNo]/* && _sound != _musics[_currentMusicNo].sound*/){
				if(_channel){
					_channel.stop();
				}
				_sound = _musics[_currentMusicNo].sound;
				if(_isPlay){
					_channel = _sound.play(0, int.MAX_VALUE);
				}
				currentMusicName = _musics[_currentMusicNo].name;
			}
		}
		
		public function reset(value:Boolean):void{
			_isPlay = value;
			init();
		}
		
		public function changeMusic(type:int):void{
			switch(type){
				case 0://减
					_currentMusicNo = -- _currentMusicNo >= 0 ? _currentMusicNo : _musics.length - 1;
					break;
				case 1://加
					_currentMusicNo = ++ _currentMusicNo < _musics.length ? _currentMusicNo : 0;
					break;
			}
			
			if(_channel){
				_channel.stop();
			}
			
			if(_musics[_currentMusicNo]){
				_sound = _musics[_currentMusicNo].sound;
				if(_isPlay){
					_channel = _sound.play(0, int.MAX_VALUE);
				}
				currentMusicName = _musics[_currentMusicNo].name;
			}
		}
		
		public function set isPlay(value:Boolean):void
		{
			_isPlay = value;
			if(_isPlay){
				if(_sound){
					_channel = _sound.play(0, int.MAX_VALUE);
				}
			}else{
				if(_channel){
					_channel.stop();
				}
				
			}
		}
	}
}