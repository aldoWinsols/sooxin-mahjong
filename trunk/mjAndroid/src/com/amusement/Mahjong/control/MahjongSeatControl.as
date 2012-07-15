package com.amusement.Mahjong.control
{
	import com.amusement.Mahjong.util.MahjongUtil;
	import com.amusement.Mahjong.view.MahjongSeat;
	import com.control.MainControl;
	import com.services.ChatService;
	
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import mx.controls.ToolTip;
	import mx.managers.ToolTipManager;
	import mx.styles.StyleManager;
	
	import spark.components.Image;
	
	public class MahjongSeatControl
	{
		private static var _instance:MahjongSeatControl;
		
		private var _mahjongSeat:MahjongSeat;
		
		private var _seatD:Point;
		private var _seatL:Point;
		private var _seatR:Point;
		private var _seatU:Point;
		
		public var point:Vector.<Point> = new Vector.<Point>();
		public var showTimer:Timer;
		
		public function MahjongSeatControl(mahjongSeat:MahjongSeat)
		{
			_instance = this;
			
			this._mahjongSeat = mahjongSeat;
			
			init();
		}
		
		private function init():void{
			if(MainControl.instance.main.applicationDPI == 320){
				point.push(new Point(50,250));
				point.push(new Point(600,250));
				point.push(new Point(300,50));
			}else{
				point.push(new Point(50,300));
				point.push(new Point(650,300));
				point.push(new Point(350,100));
			}
			showTimer = new Timer(8000);
			showTimer.addEventListener(TimerEvent.TIMER,showHandler)
				
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
		
		var myTip:ToolTip;
		private function showHandler(e:TimerEvent):void{
			
			//如果是录象查看状态，则返回
			if(MahjongRoomControl.instance.isVideo){
				return;
			}
			
			if(myTip == null){
				if(Math.round(Math.random()*10)%2 == 0){
					try{
						var len:int = Math.random()*ChatService.instance.chatList.length();
						var len2:int = Math.random()*point.length;
						myTip = ToolTipManager.createToolTip(ChatService.instance.chatList[len].@text, point[len2].x, point[len2].y,"",this._mahjongSeat) as ToolTip; 
						StyleManager.getStyleDeclaration("mx.controls.ToolTip").setStyle("fontSize","14");

					}catch(e:Error){
						
					}
					
				}
			}else{
				ToolTipManager.destroyToolTip(myTip);
				myTip = null;
			}
			
		}
		
		public function destroyToolTip():void{
			try{
				ToolTipManager.destroyToolTip(myTip);
				myTip = null;
			}catch(e:Error){
				
			}
			
		}
		
		public function startShowChat():void{
//			showTimer.start();
		}
		public function stopShowChat():void{
//			showTimer.stop();
//			destroyToolTip();
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