package com.amusement.Shark.service
{
	import flash.events.Event;
	import flash.media.SoundChannel;
	import flash.utils.Timer;
	
	import mx.core.SoundAsset;


	public class SharkSoundService
	{
		public static var instance:SharkSoundService;

		public static function getInstance():SharkSoundService
		{
			if (instance == null)
			{
				instance=new SharkSoundService();
			}
			return instance;
		}

		//-------------------------------------------------------------------
		[Bindable]
		[Embed(source='com/amusement/Shark/assets/sound/feiqin.mp3')]
		public var feiqinS:Class;
		[Embed(source='com/amusement/Shark/assets/sound/zoushou.mp3')]
		public var zoushouS:Class;
		[Embed(source="com/amusement/Shark/assets/sound/dabaisha.mp3")]
		public var dabaishaS:Class;
		[Embed(source="com/amusement/Shark/assets/sound/gezi.mp3")]
		public var geziS:Class;
		[Embed(source="com/amusement/Shark/assets/sound/houzi.mp3")]
		public var houziS:Class;
		[Embed(source="com/amusement/Shark/assets/sound/kongque.mp3")]
		public var kongqueS:Class;
		[Embed(source="com/amusement/Shark/assets/sound/laohu.mp3")]
		public var laohuS:Class;
		[Embed(source="com/amusement/Shark/assets/sound/laoying.mp3")]
		public var laoyingS:Class;
		[Embed(source="com/amusement/Shark/assets/sound/lieqiang.mp3")]
		public var lieqiangS:Class;
		[Embed(source="com/amusement/Shark/assets/sound/shizi.mp3")]
		public var shiziS:Class;
		[Embed(source="com/amusement/Shark/assets/sound/xiongmao.mp3")]
		public var xiongmaoS:Class;
		[Embed(source="com/amusement/Shark/assets/sound/yanzi.mp3")]
		public var yanziS:Class;
		[Embed(source="com/amusement/Shark/assets/sound/m_shark.mp3")]
		public var sharkBj:Class;
		[Embed(source="com/amusement/Shark/assets/sound/sfx_bet1.mp3")]
		public var paoBj:Class;
		[Embed(source="com/amusement/Shark/assets/sound/action.mp3")]
		public var actionS:Class;
		[Embed(source="com/amusement/Shark/assets/sound/backone.mp3")]
		public var backoneS:Class;
		[Embed(source="com/amusement/Shark/assets/sound/backtwo.mp3")]
		public var backtwoS:Class;
		[Embed(source="com/amusement/Shark/assets/sound/backthree.mp3")]
		public var backthreeS:Class;

		//----------------------------------------------------------------------------
		public var feiqin_mp3:SoundAsset=new feiqinS() as SoundAsset;
		public var zoushou_mp3:SoundAsset=new zoushouS() as SoundAsset;
		public var dabaisha_mp3:SoundAsset=new dabaishaS() as SoundAsset;
		public var gezi_mp3:SoundAsset=new geziS() as SoundAsset;
		public var houzi_mp3:SoundAsset=new houziS() as SoundAsset;
		public var kongque_mp3:SoundAsset=new kongqueS() as SoundAsset;
		public var laohu_mp3:SoundAsset=new laohuS() as SoundAsset;
		public var laoying_mp3:SoundAsset=new laoyingS() as SoundAsset;
		public var lieqiang_mp3:SoundAsset=new lieqiangS() as SoundAsset;
		public var shizi_mp3:SoundAsset=new shiziS() as SoundAsset;
		public var xiongmao_mp3:SoundAsset=new xiongmaoS() as SoundAsset;
		public var yanzi_mp3:SoundAsset=new yanziS() as SoundAsset;
		public var sharkBj_mp3:SoundAsset=new sharkBj() as SoundAsset;
		public var paoBj_mp3:SoundAsset=new paoBj() as SoundAsset;
		public var action_mp3:SoundAsset=new actionS() as SoundAsset;
		public var backone_mp3:SoundAsset=new backoneS() as SoundAsset;
		public var backtwo_mp3:SoundAsset=new backtwoS() as SoundAsset;
		public var backthree_mp3:SoundAsset=new backthreeS() as SoundAsset;

		//--------------------------------------------------------------------------------
		public var channelBackMusic:SoundChannel; // 背景音乐channel
		public var channelPapBj:SoundChannel;
		private var timer:Timer;
//		public var sharkBjBool:Boolean=false;
		
		private var _isPlaySound:Boolean=true; //音乐是否正在播放
		private var _isPlayMusic:Boolean=true;

		//播放倒计时声音
		public function backCountSound(n:int):void
		{
			if (_isPlaySound)
			{
				action_mp3.play();
			}

		}

		//关闭所有音乐
		/*public function stopAllMusic():void //关闭所有音乐
		{
			channelBackMusic.stop(); //关闭背景音乐
			isPlaySound=false;
		}*/

		//打开声音
		/*public function openAllMusic():void 
		{
			channelBackMusic=sharkBj_mp3.play(0, 10000);
			isPlaySound=true;
		}*/


//		public var isPlaySound:Boolean=true;

		//播放旋转时的声音
		public function paoSound():void //动物跑动的音乐
		{
			if (_isPlaySound)
			{
				channelPapBj=paoBj_mp3.play();
			}
		}

		//播放人报中奖动物的声音
		public function playResultSound(animalType:String, animalName:String):void
		{
			if (_isPlaySound)
			{
				if (animalName == "dabaisha")
				{
					dabaisha_mp3.play();
				}
				if (animalName == "lieqiang")
				{
					lieqiang_mp3.play();
				}
				switch (animalType)
				{
					case "feiqin":
						feiqin_mp3.play();
						feiqin_mp3.play().addEventListener(Event.SOUND_COMPLETE,animalSound);
						break;
					case "zoushou":
						zoushou_mp3.play();
						zoushou_mp3.play().addEventListener(Event.SOUND_COMPLETE,animalSound);
						break;
				}
				function animalSound(e:Event):void
				{
					switch (animalName)
					{
						case "gezi":
							gezi_mp3.play();
							break;

						case "yanzi":
							yanzi_mp3.play();
							break;

						case "kongque":
							kongque_mp3.play();
							break;

						case "laoying":
							laoying_mp3.play();
							break;

						case "shizi":
							shizi_mp3.play();
							break;

						case "laohu":
							laohu_mp3.play();
							break;

						case "xiongmao":
							xiongmao_mp3.play();
							break;

						case "houzi":
							houzi_mp3.play();
							break;
					}
				}
			}
		}

		/*public function get isPlaySound():Boolean
		{
			return _isPlaySound;
		}*/

		public function set isPlaySound(value:Boolean):void
		{
			_isPlaySound = value;
		}

		/*public function get isPlayMusic():Boolean
		{
			return _isPlayMusic;
		}*/

		public function set isPlayMusic(value:Boolean):void
		{
			_isPlayMusic = value;
			
			if(_isPlayMusic){
				if(channelBackMusic){
					channelBackMusic.stop();
				}
				channelBackMusic = sharkBj_mp3.play(0, int.MAX_VALUE);
			}else{
				channelBackMusic.stop();
			}
		}


	}
}