package com.amusement.Mahjong.service
{
	import mx.core.SoundAsset;
	
	public class MahjongWomanVoiceService
	{
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/1wan.mp3')]
		private var _Wan1:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/1wan0.mp3')]
		private var _Wan1_0:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/1wan1.mp3')]
		private var _Wan1_1:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/2wan.mp3')]
		private var _Wan2:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/2wan0.mp3')]
		private var _Wan2_0:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/3wan.mp3')]
		private var _Wan3:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/3wan0.mp3')]
		private var _Wan3_0:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/4wan.mp3')]
		private var _Wan4:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/4wan0.mp3')]
		private var _Wan4_0:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/4wan1.mp3')]
		private var _Wan4_1:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/5wan.mp3')]
		private var _Wan5:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/6wan.mp3')]
		private var _Wan6:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/7wan.mp3')]
		private var _Wan7:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/8wan.mp3')]
		private var _Wan8:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/9wan.mp3')]
		private var _Wan9:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/9wan0.mp3')]
		private var _Wan9_0:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/1tong.mp3')]
		private var _Tong11:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/1tong0.mp3')]
		private var _Tong11_0:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/1tong1.mp3')]
		private var _Tong11_1:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/1tong2.mp3')]
		private var _Tong11_2:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/2tong.mp3')]
		private var _Tong12:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/2tong0.mp3')]
		private var _Tong12_0:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/3tong.mp3')]
		private var _Tong13:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/3tong0.mp3')]
		private var _Tong13_0:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/3tong1.mp3')]
		private var _Tong13_1:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/4tong.mp3')]
		private var _Tong14:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/4tong0.mp3')]
		private var _Tong14_0:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/4tong1.mp3')]
		private var _Tong14_1:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/5tong.mp3')]
		private var _Tong15:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/5tong0.mp3')]
		private var _Tong15_0:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/5tong1.mp3')]
		private var _Tong15_1:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/6tong.mp3')]
		private var _Tong16:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/7tong.mp3')]
		private var _Tong17:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/8tong.mp3')]
		private var _Tong18:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/8tong0.mp3')]
		private var _Tong18_0:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/9tong.mp3')]
		private var _Tong19:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/9tong0.mp3')]
		private var _Tong19_0:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/9tong1.mp3')]
		private var _Tong19_1:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/1tiao.mp3')]
		private var _Tiao21:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/1tiao0.mp3')]
		private var _Tiao21_0:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/1tiao1.mp3')]
		private var _Tiao21_1:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/1tiao2.mp3')]
		private var _Tiao21_2:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/2tiao.mp3')]
		private var _Tiao22:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/2tiao0.mp3')]
		private var _Tiao22_0:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/2tiao1.mp3')]
		private var _Tiao22_1:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/2tiao2.mp3')]
		private var _Tiao22_2:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/3tiao.mp3')]
		private var _Tiao23:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/4tiao.mp3')]
		private var _Tiao24:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/4tiao0.mp3')]
		private var _Tiao24_0:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/5tiao.mp3')]
		private var _Tiao25:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/6tiao.mp3')]
		private var _Tiao26:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/6tiao0.mp3')]
		private var _Tiao26_0:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/7tiao.mp3')]
		private var _Tiao27:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/8tiao.mp3')]
		private var _Tiao28:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/8tiao0.mp3')]
		private var _Tiao28_0:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/8tiao1.mp3')]
		private var _Tiao28_1:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/8tiao2.mp3')]
		private var _Tiao28_2:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/9tiao.mp3')]
		private var _Tiao29:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/9tiao0.mp3')]
		private var _Tiao29_0:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/peng.mp3')]
		private var _Peng:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/peng0.mp3')]
		private var _Peng_0:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/peng1.mp3')]
		private var _Peng_1:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/peng2.mp3')]
		private var _Peng_2:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/gang.mp3')]
		private var _Gang:Class;
//		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/gang0.mp3')]
//		private var _Gang_0:Class;
//		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/gang1.mp3')]
//		private var _Gang_1:Class;
//		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/gang2.mp3')]
//		private var _Gang_2:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/gang3.mp3')]
		private var _Gang_3:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/hu.mp3')]
		private var _Hu:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/hu0.mp3')]
		private var _Hu_0:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/zimo.mp3')]
		private var _Zimo:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/girl/zimo0.mp3')]
		private var _Zimo_0:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/mjsound/luopai.mp3')]
		private var _Luopai:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/fapai.mp3')]
		private var _Fapai:Class;
		[Embed(source='com/amusement/Mahjong/assets/mjsound/chucard.mp3')]
		private var _Chucard:Class;
		
		public var wan1:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		public var wan2:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		public var wan3:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		public var wan4:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		public var wan5:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		public var wan6:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		public var wan7:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		public var wan8:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		public var wan9:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		
		public var tong1:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		public var tong2:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		public var tong3:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		public var tong4:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		public var tong5:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		public var tong6:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		public var tong7:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		public var tong8:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		public var tong9:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		
		public var tiao1:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		public var tiao2:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		public var tiao3:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		public var tiao4:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		public var tiao5:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		public var tiao6:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		public var tiao7:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		public var tiao8:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		public var tiao9:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		
		public var pengs:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		public var gangs:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		public var hus:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		public var zimos:Vector.<SoundAsset> = new Vector.<SoundAsset>();
		
		public function MahjongWomanVoiceService()
		{
			wan1.push(new _Wan1() as SoundAsset);
			wan1.push(new _Wan1_0() as SoundAsset);
			wan1.push(new _Wan1_1() as SoundAsset);
			
			wan2.push(new _Wan2() as SoundAsset);
			wan2.push(new _Wan2_0() as SoundAsset);
			
			wan3.push(new _Wan3() as SoundAsset);
			wan3.push(new _Wan3_0() as SoundAsset);
			
			wan4.push(new _Wan4() as SoundAsset);
			wan4.push(new _Wan4_0() as SoundAsset);
			wan4.push(new _Wan4_1() as SoundAsset);
			
			wan5.push(new _Wan5() as SoundAsset);
			
			wan6.push(new _Wan6() as SoundAsset);
			
			wan7.push(new _Wan7() as SoundAsset);
			
			wan8.push(new _Wan8() as SoundAsset);
			
			wan9.push(new _Wan9() as SoundAsset);
			wan9.push(new _Wan9_0() as SoundAsset);
			
			
			tong1.push(new _Tong11() as SoundAsset);
			tong1.push(new _Tong11_0() as SoundAsset);
			tong1.push(new _Tong11_1() as SoundAsset);
			tong1.push(new _Tong11_2() as SoundAsset);
			
			tong2.push(new _Tong12() as SoundAsset);
			tong2.push(new _Tong12_0() as SoundAsset);
			
			tong3.push(new _Tong13() as SoundAsset);
			tong3.push(new _Tong13_0() as SoundAsset);
			tong3.push(new _Tong13_1() as SoundAsset);
			
			tong4.push(new _Tong14() as SoundAsset);
			tong4.push(new _Tong14_0() as SoundAsset);
			tong4.push(new _Tong14_1() as SoundAsset);
			
			tong5.push(new _Tong15() as SoundAsset);
			tong5.push(new _Tong15_0() as SoundAsset);
			tong5.push(new _Tong15_1() as SoundAsset);
			
			tong6.push(new _Tong16() as SoundAsset);
			
			tong7.push(new _Tong17() as SoundAsset);
			
			tong8.push(new _Tong18() as SoundAsset);
			tong8.push(new _Tong18_0() as SoundAsset);
			
			tong9.push(new _Tong19() as SoundAsset);
			tong9.push(new _Tong19_0() as SoundAsset);
			tong9.push(new _Tong19_1() as SoundAsset);
			
			
			tiao1.push(new _Tiao21() as SoundAsset);
			tiao1.push(new _Tiao21_0() as SoundAsset);
			tiao1.push(new _Tiao21_1() as SoundAsset);
			tiao1.push(new _Tiao21_2() as SoundAsset);
			
			tiao2.push(new _Tiao22() as SoundAsset);
			tiao2.push(new _Tiao22_0() as SoundAsset);
			tiao2.push(new _Tiao22_1() as SoundAsset);
			tiao2.push(new _Tiao22_2() as SoundAsset);
			
			tiao3.push(new _Tiao23() as SoundAsset);
			
			tiao4.push(new _Tiao24() as SoundAsset);
			tiao4.push(new _Tiao24_0() as SoundAsset);
			
			tiao5.push(new _Tiao25() as SoundAsset);
			
			tiao6.push(new _Tiao26() as SoundAsset);
			tiao6.push(new _Tiao26_0() as SoundAsset);
			
			tiao7.push(new _Tiao27() as SoundAsset);
			
			tiao8.push(new _Tiao28() as SoundAsset);
			tiao8.push(new _Tiao28_0() as SoundAsset);
			tiao8.push(new _Tiao28_1() as SoundAsset);
			tiao8.push(new _Tiao28_2() as SoundAsset);
			
			tiao9.push(new _Tiao29() as SoundAsset);
			tiao9.push(new _Tiao29_0() as SoundAsset);
			
			
			pengs.push(new _Peng() as SoundAsset);
			pengs.push(new _Peng_0() as SoundAsset);
			pengs.push(new _Peng_1() as SoundAsset);
			pengs.push(new _Peng_2() as SoundAsset);
			
			
			gangs.push(new _Gang() as SoundAsset);
//			gangs.push(new _Gang_0() as SoundAsset);
//			gangs.push(new _Gang_1() as SoundAsset);
//			gangs.push(new _Gang_2() as SoundAsset);
			gangs.push(new _Gang_3() as SoundAsset);
			
			
			hus.push(new _Hu() as SoundAsset);
			hus.push(new _Hu_0() as SoundAsset);
			
			
			zimos.push(new _Zimo() as SoundAsset);
			zimos.push(new _Zimo_0() as SoundAsset);
		}
		
		public function getRandom(array:Vector.<SoundAsset>):int{
			var random:int = int(Math.random() * array.length);
			return random;
		}
	}
}