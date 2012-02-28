package com.amusement.Mahjong.service
{
	import flash.events.Event;
	import flash.media.SoundChannel;
	
	import mx.core.SoundAsset;

	public class MahjongSoundService
	{

		private static var _instance:MahjongSoundService;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/luopai.mp3')]
		private var _Luopai:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/fapai.mp3')]
		private var _Fapai:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/chucard.mp3')]
		private var _Chucard:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/saizi.mp3')]
		private var _Saizi:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/bg.mp3')]
		private var bg:Class;
		
		private var _luopai_mp3:SoundAsset;
		private var _fapai_mp3:SoundAsset;
		private var _chucard_mp3:SoundAsset;
		
		private var _saizi_mp3:SoundAsset;
		
		private var _bg:SoundAsset;
		
		public var _bgChannel:SoundChannel;
		private var _channel:SoundChannel;
		private var _chucardChannel:SoundChannel;
		
		private var _soundSwitch:Boolean = true;
		
		public var mahjongManVoiceService:MahjongManVoiceService;
		public var mahjongWomanVoiceService:MahjongWomanVoiceService;
		
		public var soundType:Boolean = false;
		
		public var bgSoundType:Boolean = true;
		
		public function MahjongSoundService():void
		{
			mahjongManVoiceService = new MahjongManVoiceService();
			mahjongWomanVoiceService = new MahjongWomanVoiceService();
			
			_luopai_mp3 = new _Luopai() as SoundAsset;
			_fapai_mp3 = new _Fapai() as SoundAsset;
			_chucard_mp3 = new _Chucard() as SoundAsset;
			
			_saizi_mp3 = new _Saizi() as SoundAsset;
			
			_bg = new bg() as SoundAsset;
		}
		
		public static function get instance():MahjongSoundService
		{
			if (_instance == null){
				_instance = new MahjongSoundService();
			}
			return _instance;
		}
		
		private function soundPlay1(n:*):void{
			if(!soundType){
				switch (n)
				{
					case 1:
						mahjongWomanVoiceService.wan1[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.wan1)].play();
						//					_wan1_mp3.play();
						break;
					case 2:
						mahjongWomanVoiceService.wan2[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.wan2)].play();
						//					_wan2_mp3.play();
						break;
					case 3:
						mahjongWomanVoiceService.wan3[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.wan3)].play();
						//					_wan3_mp3.play();
						break;
					case 4:
						mahjongWomanVoiceService.wan4[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.wan4)].play();
						//					_wan4_mp3.play();
						break;
					case 5:
						mahjongWomanVoiceService.wan5[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.wan5)].play();
						//					_wan5_mp3.play();
						break;
					case 6:
						mahjongWomanVoiceService.wan6[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.wan6)].play();
						//					_wan6_mp3.play();
						break;
					case 7:
						mahjongWomanVoiceService.wan7[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.wan7)].play();
						//					_wan7_mp3.play();
						break;
					case 8:
						mahjongWomanVoiceService.wan8[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.wan8)].play();
						//					_wan8_mp3.play();
						break;
					case 9:
						mahjongWomanVoiceService.wan9[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.wan9)].play();
						//					_wan9_mp3.play();
						break;
					case 11:
						mahjongWomanVoiceService.tong1[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.tong1)].play();
						//					_tong11_mp3.play();
						break;
					case 12:
						mahjongWomanVoiceService.tong2[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.tong2)].play();
						//					_tong12_mp3.play();
						break;
					case 13:
						mahjongWomanVoiceService.tong3[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.tong3)].play();
						//					_tong13_mp3.play();
						break;
					case 14:
						mahjongWomanVoiceService.tong4[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.tong4)].play();
						//					_tong14_mp3.play();
						break;
					case 15:
						mahjongWomanVoiceService.tong5[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.tong5)].play();
						//					_tong15_mp3.play();
						break;
					case 16:
						mahjongWomanVoiceService.tong6[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.tong6)].play();
						//					_tong16_mp3.play();
						break;
					case 17:
						mahjongWomanVoiceService.tong7[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.tong7)].play();
						//					_tong17_mp3.play();
						break;
					case 18:
						mahjongWomanVoiceService.tong8[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.tong8)].play();
						//					_tong18_mp3.play();
						break;
					case 19:
						mahjongWomanVoiceService.tong9[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.tong9)].play();
						//					_tong19_mp3.play();
						break;
					case 21:
						mahjongWomanVoiceService.tiao1[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.tiao1)].play();
						//					_tiao21_mp3.play();
						break;
					case 22:
						mahjongWomanVoiceService.tiao2[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.tiao2)].play();
						//					_tiao22_mp3.play();
						break;
					case 23:
						mahjongWomanVoiceService.tiao3[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.tiao3)].play();
						//					_tiao23_mp3.play();
						break;
					case 24:
						mahjongWomanVoiceService.tiao4[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.tiao4)].play();
						//					_tiao24_mp3.play();
						break;
					case 25:
						mahjongWomanVoiceService.tiao5[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.tiao5)].play();
						//					_tiao25_mp3.play();
						break;
					case 26:
						mahjongWomanVoiceService.tiao6[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.tiao6)].play();
						//					_tiao26_mp3.play();
						break;
					case 27:
						mahjongWomanVoiceService.tiao7[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.tiao7)].play();
						//					_tiao27_mp3.play();
						break;
					case 28:
						mahjongWomanVoiceService.tiao8[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.tiao8)].play();
						//					_tiao28_mp3.play();
						break;
					case 29:
						mahjongWomanVoiceService.tiao9[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.tiao9)].play();
						//					_tiao29_mp3.play();
						break;
					case "peng":
						mahjongWomanVoiceService.pengs[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.pengs)].play();
						//					_peng_mp3.play();
						break;
					case "gang":
						mahjongWomanVoiceService.gangs[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.gangs)].play();
						//					_gang_mp3.play();
						break;
					case "hu":
						mahjongWomanVoiceService.hus[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.hus)].play();
						//					_hu_mp3.play();
						break;
					case "zimo":
						mahjongWomanVoiceService.zimos[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.zimos)].play();
						//					_zimo_mp3.play();
						break;
					case "gangshanghua":
//						_gangshanghua_mp3.play();
						mahjongWomanVoiceService.zimos[1].play();
						break;
					case "gangshangpao":
//						_gangshangpao_mp3.play();
						mahjongWomanVoiceService.hus[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.hus)].play();
						break;
					case "qianggang":
//						_qianggang_mp3.play();
						break;
					case "luopai":
						_luopai_mp3.play();
						break;
					case "fapai":
						_fapai_mp3.play();
						break;
					case "saizi":
						_saizi_mp3.play();
						break;
					case "chat":
						mahjongWomanVoiceService.chat[mahjongWomanVoiceService.getRandom(mahjongWomanVoiceService.chat)].play();
						break;
					case "qingdingzhang":
//						_qingdingzhang_mp3.play();
						break;
				}
				
			}else{
				switch (n)
				{
					case 1:
						mahjongManVoiceService.wan1[mahjongManVoiceService.getRandom(mahjongManVoiceService.wan1)].play();
	//					_wan1_mp3.play();
						break;
					case 2:
						mahjongManVoiceService.wan2[mahjongManVoiceService.getRandom(mahjongManVoiceService.wan2)].play();
	//					_wan2_mp3.play();
						break;
					case 3:
						mahjongManVoiceService.wan3[mahjongManVoiceService.getRandom(mahjongManVoiceService.wan3)].play();
	//					_wan3_mp3.play();
						break;
					case 4:
						mahjongManVoiceService.wan4[mahjongManVoiceService.getRandom(mahjongManVoiceService.wan4)].play();
	//					_wan4_mp3.play();
						break;
					case 5:
						mahjongManVoiceService.wan5[mahjongManVoiceService.getRandom(mahjongManVoiceService.wan5)].play();
	//					_wan5_mp3.play();
						break;
					case 6:
						mahjongManVoiceService.wan6[mahjongManVoiceService.getRandom(mahjongManVoiceService.wan6)].play();
	//					_wan6_mp3.play();
						break;
					case 7:
						mahjongManVoiceService.wan7[mahjongManVoiceService.getRandom(mahjongManVoiceService.wan7)].play();
	//					_wan7_mp3.play();
						break;
					case 8:
						mahjongManVoiceService.wan8[mahjongManVoiceService.getRandom(mahjongManVoiceService.wan8)].play();
	//					_wan8_mp3.play();
						break;
					case 9:
						mahjongManVoiceService.wan9[mahjongManVoiceService.getRandom(mahjongManVoiceService.wan9)].play();
	//					_wan9_mp3.play();
						break;
					case 11:
						mahjongManVoiceService.tong1[mahjongManVoiceService.getRandom(mahjongManVoiceService.tong1)].play();
	//					_tong11_mp3.play();
						break;
					case 12:
						mahjongManVoiceService.tong2[mahjongManVoiceService.getRandom(mahjongManVoiceService.tong2)].play();
	//					_tong12_mp3.play();
						break;
					case 13:
						mahjongManVoiceService.tong3[mahjongManVoiceService.getRandom(mahjongManVoiceService.tong3)].play();
	//					_tong13_mp3.play();
						break;
					case 14:
						mahjongManVoiceService.tong4[mahjongManVoiceService.getRandom(mahjongManVoiceService.tong4)].play();
	//					_tong14_mp3.play();
						break;
					case 15:
						mahjongManVoiceService.tong5[mahjongManVoiceService.getRandom(mahjongManVoiceService.tong5)].play();
	//					_tong15_mp3.play();
						break;
					case 16:
						mahjongManVoiceService.tong6[mahjongManVoiceService.getRandom(mahjongManVoiceService.tong6)].play();
	//					_tong16_mp3.play();
						break;
					case 17:
						mahjongManVoiceService.tong7[mahjongManVoiceService.getRandom(mahjongManVoiceService.tong7)].play();
	//					_tong17_mp3.play();
						break;
					case 18:
						mahjongManVoiceService.tong8[mahjongManVoiceService.getRandom(mahjongManVoiceService.tong8)].play();
	//					_tong18_mp3.play();
						break;
					case 19:
						mahjongManVoiceService.tong9[mahjongManVoiceService.getRandom(mahjongManVoiceService.tong9)].play();
	//					_tong19_mp3.play();
						break;
					case 21:
						mahjongManVoiceService.tiao1[mahjongManVoiceService.getRandom(mahjongManVoiceService.tiao1)].play();
	//					_tiao21_mp3.play();
						break;
					case 22:
						mahjongManVoiceService.tiao2[mahjongManVoiceService.getRandom(mahjongManVoiceService.tiao2)].play();
	//					_tiao22_mp3.play();
						break;
					case 23:
						mahjongManVoiceService.tiao3[mahjongManVoiceService.getRandom(mahjongManVoiceService.tiao3)].play();
	//					_tiao23_mp3.play();
						break;
					case 24:
						mahjongManVoiceService.tiao4[mahjongManVoiceService.getRandom(mahjongManVoiceService.tiao4)].play();
	//					_tiao24_mp3.play();
						break;
					case 25:
						mahjongManVoiceService.tiao5[mahjongManVoiceService.getRandom(mahjongManVoiceService.tiao5)].play();
	//					_tiao25_mp3.play();
						break;
					case 26:
						mahjongManVoiceService.tiao6[mahjongManVoiceService.getRandom(mahjongManVoiceService.tiao6)].play();
	//					_tiao26_mp3.play();
						break;
					case 27:
						mahjongManVoiceService.tiao7[mahjongManVoiceService.getRandom(mahjongManVoiceService.tiao7)].play();
	//					_tiao27_mp3.play();
						break;
					case 28:
						mahjongManVoiceService.tiao8[mahjongManVoiceService.getRandom(mahjongManVoiceService.tiao8)].play();
	//					_tiao28_mp3.play();
						break;
					case 29:
						mahjongManVoiceService.tiao9[mahjongManVoiceService.getRandom(mahjongManVoiceService.tiao9)].play();
	//					_tiao29_mp3.play();
						break;
					case "peng":
						mahjongManVoiceService.pengs[mahjongManVoiceService.getRandom(mahjongManVoiceService.pengs)].play();
	//					_peng_mp3.play();
						break;
					case "gang":
						mahjongManVoiceService.gangs[mahjongManVoiceService.getRandom(mahjongManVoiceService.gangs)].play();
	//					_gang_mp3.play();
						break;
					case "hu":
						mahjongManVoiceService.hus[mahjongManVoiceService.getRandom(mahjongManVoiceService.hus)].play();
	//					_hu_mp3.play();
						break;
					case "zimo":
						mahjongManVoiceService.zimos[mahjongManVoiceService.getRandom(mahjongManVoiceService.zimos)].play();
	//					_zimo_mp3.play();
						break;
					case "gangshanghua":
						mahjongManVoiceService.zimos[1].play();
//						_gangshanghua_mp3.play();
						break;
					case "gangshangpao":
//						_gangshangpao_mp3.play();
						mahjongManVoiceService.hus[mahjongManVoiceService.getRandom(mahjongManVoiceService.hus)].play();
						break;
					case "qianggang":
//						_qianggang_mp3.play();
						break;
					case "luopai":
						_luopai_mp3.play();
						break;
					case "fapai":
						_fapai_mp3.play();
						break;
					case "saizi":
						_saizi_mp3.play();
						break;
					case "chat":
						mahjongManVoiceService.chat[mahjongManVoiceService.getRandom(mahjongManVoiceService.chat)].play();
						break;
					case "qingdingzhang":
//						_qingdingzhang_mp3.play();
						break;
				}
			}
		}
		
		public function soundSwitch(soundSwitch:Boolean):void{
			_soundSwitch = soundSwitch;
		}
		
		public function playBg():void{
			if(bgSoundType){
				_bgChannel = _bg.play(0, 10000);
			}else{
				_bgChannel.stop();
			}
		}
		
		public function soundPlay(n:*):void
		{
			if(!_soundSwitch){
				return;
			}
			if(n is Number){
				_chucardChannel = _chucard_mp3.play();
				_chucardChannel.addEventListener(Event.SOUND_COMPLETE,chucardPlayComplete,false,0,true);
			}else{
				soundPlay1(n);
			}
			
			function chucardPlayComplete(e:Event):void{
				_chucard_mp3.removeEventListener(Event.COMPLETE,chucardPlayComplete);
				soundPlay1(n);
			}
		}
		
		
	}
}