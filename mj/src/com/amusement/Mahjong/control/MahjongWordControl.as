package com.amusement.Mahjong.control
{
	import com.amusement.Mahjong.view.MahjongWord;
	
	import flash.geom.Point;

	public class MahjongWordControl
	{
		private static var _instance:MahjongWordControl;
		
		private var _mahjongWord:MahjongWord;
		
		[Embed(source='com/amusement/Mahjong/assets/word/mj_peng.png')]
		private var _PengImg:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/word/mj_gang.png')]
		private var _GangImg:Class;
		
		[Embed(source='com/amusement/Mahjong/assets/word/mj_hu.png')]
		private var _HuImg:Class;
		
		public var _azimuth1:Point;
		public var _azimuth2:Point;
		public var _azimuth3:Point;
		public var _azimuth4:Point;
		
		public function MahjongWordControl(mahjongWord:MahjongWord)
		{
			_instance = this;
			
			this._mahjongWord = mahjongWord;
			
			init();
		}
		
		private function init():void{
			_azimuth1 = new Point(364, 46);
			_azimuth2 = new Point(64, 196);
			_azimuth3 = new Point(364, 306);
			_azimuth4 = new Point(674, 196);
		}
		
		public function show(wordName:String, azimuth:int,isZigang:Boolean):void{
			switch(wordName){
				case "peng":
					this._mahjongWord.WordImg = _PengImg;
					break
				case "gang":
					this._mahjongWord.WordImg = _GangImg;
					
					if(isZigang){
						MahjongRoomControl.instance._mahjongRoom.guafeng.visible = true;
					}else{
						MahjongRoomControl.instance._mahjongRoom.xiayu.visible = true;
					}
					
					break;
				case "hu":
					this._mahjongWord.WordImg = _HuImg;
					break;
			}
			
			switch(azimuth){
				case 1:
					this._mahjongWord.x = this._azimuth1.x;
					this._mahjongWord.y = this._azimuth1.y;
					break;
				case 2:
					this._mahjongWord.x = this._azimuth2.x;
					this._mahjongWord.y = this._azimuth2.y;
					break;
				case 3:
					this._mahjongWord.x = this._azimuth3.x;
					this._mahjongWord.y = this._azimuth3.y;
					break;
				case 4:
					this._mahjongWord.x = this._azimuth4.x;
					this._mahjongWord.y = this._azimuth4.y;
					break;
				default:
					this._mahjongWord.x = 0;
					this._mahjongWord.y = 0;
					break;
			}
			this._mahjongWord.visible = true;
		}
		
		public function hide():void{
			this._mahjongWord.WordImg = null;
			this._mahjongWord.visible = false;
			
			MahjongRoomControl.instance._mahjongRoom.xiayu.visible = false;
			MahjongRoomControl.instance._mahjongRoom.guafeng.visible = false;
		}
		
		
		
		//--------------------------------------------------------------
		public static function get instance():MahjongWordControl
		{
			return _instance;
		}
		
		
	}
}