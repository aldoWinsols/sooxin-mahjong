package com.amusement.Mahjong.control
{
	import com.amusement.Mahjong.util.MahjongUtil;
	import com.amusement.Mahjong.view.MahjongSeat;
	import com.control.MainControl;
	
	import flash.geom.Point;
	
	import spark.components.Image;
	
	public class MahjongSeatControl
	{
		private static var _instance:MahjongSeatControl;
		
		private var _mahjongSeat:MahjongSeat;
		
		private var _seatD:Point;
		private var _seatL:Point;
		private var _seatR:Point;
		private var _seatU:Point;
		
		public function MahjongSeatControl(mahjongSeat:MahjongSeat)
		{
			_instance = this;
			
			this._mahjongSeat = mahjongSeat;
			
			init();
		}
		
		private function init():void{
			if(MainControl.instance.main.applicationDPI == 160){
				_seatD = new Point(450, 700);
				_seatL = new Point(15, 320);
				_seatR = new Point(865, 320);
				_seatU = new Point(450, 15);
			}else if(MainControl.instance.main.applicationDPI == 320){
				_seatD = new Point(400, 590);
				_seatL = new Point(15, 255);
				_seatR = new Point(800, 255);
				_seatU = new Point(400, 5);
			}
			else{
				_seatD = new Point(-100, -100);
				_seatL = new Point(-100, -100);
				_seatR = new Point(-100, -100);
				_seatU = new Point(-100, -100);
			}
		}
		
		public function show():void{
			var img:Image;
			var resPlayerAzimuth:int;
			for(var i:int = 1; i < 5; i ++){
				img = this._mahjongSeat.getChildByName("img" + i) as Image;
				
				resPlayerAzimuth = MahjongUtil.getRemotePlayerAzimuth(MahjongRoomControl.instance.playerAzimuth, i);
				switch(resPlayerAzimuth){
					case 1:
						img.x = _seatU.x;
						img.y = _seatU.y;
						break;
					case 2:
						img.x = _seatL.x;
						img.y = _seatL.y;
						break;
					case 3:
						img.x = _seatD.x;
						img.y = _seatD.y;
						break;
					case 4:
						img.x = _seatR.x;
						img.y = _seatR.y;
						break;
				}
				
				img.visible = true;
			}
		}
		
		public function hide():void{
			this._mahjongSeat.oneImg.visible = false;
			this._mahjongSeat.twoImg.visible = false;
			this._mahjongSeat.threeImg.visible = false;
			this._mahjongSeat.fourImg.visible = false;
		}

		//-------------------------------------------------------------
		public static function get instance():MahjongSeatControl{
			return _instance;
		}

	}
}