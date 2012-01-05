package com.amusement.Mahjong.service
{
	import flash.events.Event;
	import flash.media.SoundChannel;
	
	import mx.core.SoundAsset;

	public class MahjongSoundService
	{

		private static var _instance:MahjongSoundService;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/1.mp3')]
		private var _Wan1:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/2.mp3')]
		private var _Wan2:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/3.mp3')]
		private var _Wan3:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/4.mp3')]
		private var _Wan4:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/5.mp3')]
		private var _Wan5:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/6.mp3')]
		private var _Wan6:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/7.mp3')]
		private var _Wan7:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/8.mp3')]
		private var _Wan8:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/9.mp3')]
		private var _Wan9:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/11.mp3')]
		private var _Tong11:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/12.mp3')]
		private var _Tong12:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/13.mp3')]
		private var _Tong13:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/14.mp3')]
		private var _Tong14:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/15.mp3')]
		private var _Tong15:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/16.mp3')]
		private var _Tong16:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/17.mp3')]
		private var _Tong17:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/18.mp3')]
		private var _Tong18:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/19.mp3')]
		private var _Tong19:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/21.mp3')]
		private var _Tiao21:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/22.mp3')]
		private var _Tiao22:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/23.mp3')]
		private var _Tiao23:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/24.mp3')]
		private var _Tiao24:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/25.mp3')]
		private var _Tiao25:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/26.mp3')]
		private var _Tiao26:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/27.mp3')]
		private var _Tiao27:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/28.mp3')]
		private var _Tiao28:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/29.mp3')]
		private var _Tiao29:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/peng.mp3')]
		private var _Peng:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/gang.mp3')]
		private var _Gang:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/hu.mp3')]
		private var _Hu:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/zimo.mp3')]
		private var _Zimo:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/gangshanghua.mp3')]
		private var _Gangshanghua:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/gangshangpao.mp3')]
		private var _Gangshangpao:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/qianggang.mp3')]
		private var _Qianggang:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/luopai.mp3')]
		private var _Luopai:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/fapai.mp3')]
		private var _Fapai:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/chucard.mp3')]
		private var _Chucard:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/saizi.mp3')]
		private var _Saizi:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/qingdingzhang.mp3')]
		private var _Qingdingzhang:Class;
		
		private var _wan1_mp3:SoundAsset;
		private var _wan2_mp3:SoundAsset;
		private var _wan3_mp3:SoundAsset;
		private var _wan4_mp3:SoundAsset;
		private var _wan5_mp3:SoundAsset;
		private var _wan6_mp3:SoundAsset;
		private var _wan7_mp3:SoundAsset;
		private var _wan8_mp3:SoundAsset;
		private var _wan9_mp3:SoundAsset;
		
		private var _tong11_mp3:SoundAsset;
		private var _tong12_mp3:SoundAsset;
		private var _tong13_mp3:SoundAsset;
		private var _tong14_mp3:SoundAsset;
		private var _tong15_mp3:SoundAsset;
		private var _tong16_mp3:SoundAsset;
		private var _tong17_mp3:SoundAsset;
		private var _tong18_mp3:SoundAsset;
		private var _tong19_mp3:SoundAsset;
		
		private var _tiao21_mp3:SoundAsset;
		private var _tiao22_mp3:SoundAsset;
		private var _tiao23_mp3:SoundAsset;
		private var _tiao24_mp3:SoundAsset;
		private var _tiao25_mp3:SoundAsset;
		private var _tiao26_mp3:SoundAsset;
		private var _tiao27_mp3:SoundAsset;
		private var _tiao28_mp3:SoundAsset;
		private var _tiao29_mp3:SoundAsset;
		
		private var _peng_mp3:SoundAsset;
		private var _gang_mp3:SoundAsset;
		private var _hu_mp3:SoundAsset;
		
		private var _zimo_mp3:SoundAsset;
		private var _gangshanghua_mp3:SoundAsset;
		private var _gangshangpao_mp3:SoundAsset;
		private var _qianggang_mp3:SoundAsset;
		
		private var _luopai_mp3:SoundAsset;
		private var _fapai_mp3:SoundAsset;
		private var _chucard_mp3:SoundAsset;
		
		private var _saizi_mp3:SoundAsset;
		
		private var _qingdingzhang_mp3:SoundAsset;
		
		private var _channel:SoundChannel;
		private var _chucardChannel:SoundChannel;
		
		private var _soundSwitch:Boolean = true;
		
		public function MahjongSoundService():void
		{
			_wan1_mp3 = new _Wan1() as SoundAsset;
			_wan2_mp3 = new _Wan2() as SoundAsset;
			_wan3_mp3 = new _Wan3() as SoundAsset;
			_wan4_mp3 = new _Wan4() as SoundAsset;
			_wan5_mp3 = new _Wan5() as SoundAsset;
			_wan6_mp3 = new _Wan6() as SoundAsset;
			_wan7_mp3 = new _Wan7() as SoundAsset;
			_wan8_mp3 = new _Wan8() as SoundAsset;
			_wan9_mp3 = new _Wan9() as SoundAsset;
			
			_tong11_mp3 = new _Tong11() as SoundAsset;
			_tong12_mp3 = new _Tong12() as SoundAsset;
			_tong13_mp3 = new _Tong13() as SoundAsset;
			_tong14_mp3 = new _Tong14() as SoundAsset;
			_tong15_mp3 = new _Tong15() as SoundAsset;
			_tong16_mp3 = new _Tong16() as SoundAsset;
			_tong17_mp3 = new _Tong17() as SoundAsset;
			_tong18_mp3 = new _Tong18() as SoundAsset;
			_tong19_mp3 = new _Tong19() as SoundAsset;
			
			_tiao21_mp3 = new _Tiao21() as SoundAsset;
			_tiao22_mp3 = new _Tiao22() as SoundAsset;
			_tiao23_mp3 = new _Tiao23() as SoundAsset;
			_tiao24_mp3 = new _Tiao24() as SoundAsset;
			_tiao25_mp3 = new _Tiao25() as SoundAsset;
			_tiao26_mp3 = new _Tiao26() as SoundAsset;
			_tiao27_mp3 = new _Tiao27() as SoundAsset;
			_tiao28_mp3 = new _Tiao28() as SoundAsset;
			_tiao29_mp3 = new _Tiao29() as SoundAsset;
			
			_peng_mp3 = new _Peng() as SoundAsset;
			_gang_mp3 = new _Gang() as SoundAsset;
			_hu_mp3 = new _Hu() as SoundAsset;
			
			_zimo_mp3 = new _Zimo() as SoundAsset;
			_gangshanghua_mp3 = new _Gangshanghua() as SoundAsset;
			_gangshangpao_mp3 = new _Gangshangpao() as SoundAsset;
			_qianggang_mp3 = new _Qianggang() as SoundAsset;
			
			_luopai_mp3 = new _Luopai() as SoundAsset;
			_fapai_mp3 = new _Fapai() as SoundAsset;
			_chucard_mp3 = new _Chucard() as SoundAsset;
			
			_saizi_mp3 = new _Saizi() as SoundAsset;
			
			_qingdingzhang_mp3 = new _Qingdingzhang() as SoundAsset;
		}
		
		public static function get instance():MahjongSoundService
		{
			if (_instance == null){
				_instance = new MahjongSoundService();
			}
			return _instance;
		}
		
		private function soundPlay1(n:*):void{
			
			switch (n)
			{
				case 1:
					_wan1_mp3.play();
					break;
				case 2:
					_wan2_mp3.play();
					break;
				case 3:
					_wan3_mp3.play();
					break;
				case 4:
					_wan4_mp3.play();
					break;
				case 5:
					_wan5_mp3.play();
					break;
				case 6:
					_wan6_mp3.play();
					break;
				case 7:
					_wan7_mp3.play();
					break;
				case 8:
					_wan8_mp3.play();
					break;
				case 9:
					_wan9_mp3.play();
					break;
				case 11:
					_tong11_mp3.play();
					break;
				case 12:
					_tong12_mp3.play();
					break;
				case 13:
					_tong13_mp3.play();
					break;
				case 14:
					_tong14_mp3.play();
					break;
				case 15:
					_tong15_mp3.play();
					break;
				case 16:
					_tong16_mp3.play();
					break;
				case 17:
					_tong17_mp3.play();
					break;
				case 18:
					_tong18_mp3.play();
					break;
				case 19:
					_tong19_mp3.play();
					break;
				case 21:
					_tiao21_mp3.play();
					break;
				case 22:
					_tiao22_mp3.play();
					break;
				case 23:
					_tiao23_mp3.play();
					break;
				case 24:
					_tiao24_mp3.play();
					break;
				case 25:
					_tiao25_mp3.play();
					break;
				case 26:
					_tiao26_mp3.play();
					break;
				case 27:
					_tiao27_mp3.play();
					break;
				case 28:
					_tiao28_mp3.play();
					break;
				case 29:
					_tiao29_mp3.play();
					break;
				case "peng":
					_peng_mp3.play();
					break;
				case "gang":
					_gang_mp3.play();
					break;
				case "hu":
					_hu_mp3.play();
					break;
				case "zimo":
					_zimo_mp3.play();
					break;
				case "gangshanghua":
					_gangshanghua_mp3.play();
					break;
				case "gangshangpao":
					_gangshangpao_mp3.play();
					break;
				case "qianggang":
					_qianggang_mp3.play();
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
				case "qingdingzhang":
					_qingdingzhang_mp3.play();
					break;
			}
		}
		
		public function soundSwitch(soundSwitch:Boolean):void{
			_soundSwitch = soundSwitch;
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