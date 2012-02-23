package com.amusement.HundredHappy.services
{
	import flash.media.Sound;
	import flash.media.SoundChannel;

	public class HundredHappySoundService
	{
		[Embed(source="com/amusement/HundredHappy/assets/sound/01zl000.mp3")]
		private var _Chime:Class;//报时声
		[Embed(source="com/amusement/HundredHappy/assets/sound/sqtz.mp3")]
		private var _StartBet:Class;
		[Embed(source="com/amusement/HundredHappy/assets/sound/stztz.mp3")]
		private var _StopBet:Class;
		[Embed(source="com/amusement/HundredHappy/assets/sound/z0.mp3")]
		private var _Z0:Class;
		[Embed(source="com/amusement/HundredHappy/assets/sound/z1.mp3")]
		private var _Z1:Class;
		[Embed(source="com/amusement/HundredHappy/assets/sound/z2.mp3")]
		private var _Z2:Class;
		[Embed(source="com/amusement/HundredHappy/assets/sound/z3.mp3")]
		private var _Z3:Class;
		[Embed(source="com/amusement/HundredHappy/assets/sound/x0.mp3")]
		private var _X0:Class;
		[Embed(source="com/amusement/HundredHappy/assets/sound/x1.mp3")]
		private var _X1:Class;
		[Embed(source="com/amusement/HundredHappy/assets/sound/x2.mp3")]
		private var _X2:Class;
		[Embed(source="com/amusement/HundredHappy/assets/sound/x3.mp3")]
		private var _X3:Class;
		[Embed(source="com/amusement/HundredHappy/assets/sound/h0.mp3")]
		private var _H0:Class;
		[Embed(source="com/amusement/HundredHappy/assets/sound/h1.mp3")]
		private var _H1:Class;
		[Embed(source="com/amusement/HundredHappy/assets/sound/h2.mp3")]
		private var _H2:Class;
		[Embed(source="com/amusement/HundredHappy/assets/sound/h3.mp3")]
		private var _H3:Class;
		
		private static var _instance:HundredHappySoundService;
		
		private var _sounds:Array;
		private var _channel:SoundChannel;
		
		private var _isPlay:Boolean;
		
		public function HundredHappySoundService()
		{
			_sounds = [];
			_isPlay = true;
			
			_sounds.push({name:"chime", sound:new _Chime() as Sound});
			_sounds.push({name:"startBet", sound:new _StartBet() as Sound});
			_sounds.push({name:"stopBet", sound:new _StopBet() as Sound});
			_sounds.push({name:"z0", sound:new _Z0() as Sound});
			_sounds.push({name:"z1", sound:new _Z1() as Sound});
			_sounds.push({name:"z2", sound:new _Z2() as Sound});
			_sounds.push({name:"z3", sound:new _Z3() as Sound});
			_sounds.push({name:"x0", sound:new _X0() as Sound});
			_sounds.push({name:"x1", sound:new _X1() as Sound});
			_sounds.push({name:"x2", sound:new _X2() as Sound});
			_sounds.push({name:"x3", sound:new _X3() as Sound});
			_sounds.push({name:"h0", sound:new _H0() as Sound});
			_sounds.push({name:"h1", sound:new _H1() as Sound});
			_sounds.push({name:"h2", sound:new _H2() as Sound});
			_sounds.push({name:"h3", sound:new _H3() as Sound});
		}

		public static function get instance():HundredHappySoundService
		{
			if(_instance == null){
				_instance = new HundredHappySoundService();
			}
			return _instance;
		}
		
		public function play(soundName:String):void{
			if(_isPlay){
				var sound:Sound;
				for each(var obj:Object in _sounds){
					if(obj.name == soundName){
						sound = obj.sound;
						_channel = sound.play();
						return;
					}
				}
			}
		}
		
		public function stop():void{
			if(_channel){
				_channel.stop();
			}
		}

		public function set isPlay(value:Boolean):void
		{
			_isPlay = value;
		}


	}
}