package com.amusement.Mahjong.control
{
	import com.amusement.Mahjong.model.Mahjong;
	import com.amusement.Mahjong.service.MahjongRoomService;
	import com.amusement.Mahjong.service.MahjongSoundService;
	import com.amusement.Mahjong.service.MahjongSyncService;
	import com.amusement.Mahjong.util.MahjongUtil;
	import com.amusement.Mahjong.view.MahjongInfo;
	import com.amusement.Mahjong.view.MahjongQuemen;
	import com.amusement.Mahjong.view.MahjongRoom;
	import com.control.MainControl;
	import com.model.Alert;
	
	import flash.display.StageDisplayState;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	public class MahjongRoomControl
	{
		private static var _instance:MahjongRoomControl;
		
		public var _mahjongRoom:MahjongRoom;
		private var _mahjongRoomService:MahjongRoomService;
		
		private var _isVideo:Boolean = false;
		
		private var _roomType:int;
		private var _mahjongColor:String = "blue";
		
		private var _mahjongs:Array;
		
		private var _roomNo:Number;
		private var _playerAzimuth:int;
		public static var soundType:int = 0;
		
		private var _nowPutPlayerAzimuth:int;
		private var _nowPutMahjong:Mahjong;
		
		private var _putState:int = 0;//打牌状态：0--不可打牌  1--可定章  2--可打牌  3--显示操作面板
		private var _selectMahjong:Mahjong = null;
		
		public function MahjongRoomControl(mahjongRoom:MahjongRoom)
		{
			_instance = this;
			
			_mahjongRoom = mahjongRoom;
			
			_mahjongRoomService = new MahjongRoomService();
			
			init();
		}
		
		private function init():void{
//			this._mahjongRoom.notice.start(14);
			
			addListeners();
		}
		
		private function addListeners():void{
//			this._mahjongRoom.mjRoomBgImg.addEventListener(MouseEvent.MOUSE_DOWN, dragHandler, false, 0, true);
//			this._mahjongRoom.reConnBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
		}
		
		private function dragHandler(event:MouseEvent):void{
			MahjongApplictionControl.instance.dragHandler(event);
		}
		
		/**
		 * 进入游戏 
		 * @param roomType 房间类型
		 * 
		 */
		public function enterGame(roomType:int):void{
			_isVideo = false;
			
			this.initTabletop(roomType);
			
//			MahjongSyncService.instance.connServer(roomType);
		}
		
		/**
		 * 重连进行游戏 
		 * @param obj
		 * 
		 */
		public function restartGame(obj:Object):void{
			MahjongRoomControl.instance._mahjongRoom.roomTabletop.width = MainControl.instance.main.width;
			MahjongRoomControl.instance._mahjongRoom.roomTabletop.height = MainControl.instance.main.height;
			
			if(MainControl.instance.main.applicationDPI == 160){
				MahjongRoomControl.instance._mahjongRoom.mahjongPlayerU.top = 80;
				MahjongRoomControl.instance._mahjongRoom.mahjongPlayerD.bottom = 50;
				MahjongRoomControl.instance._mahjongRoom.mahjongPlayerL.left = 80;
				MahjongRoomControl.instance._mahjongRoom.mahjongPlayerR.right = 160;
				
				MahjongRoomControl.instance._mahjongRoom.mahjongOperation.x = 500;
				MahjongRoomControl.instance._mahjongRoom.mahjongOperation.y = 500;
				MahjongPlayerControlL.instance._mahjongPlayer.out.x = 100;
				MahjongPlayerControlL.instance._mahjongPlayer.sp.y = -50;
				MahjongPlayerControlL.instance._mahjongPlayer.pd.x = 20;
				MahjongPlayerControlL.instance._mahjongPlayer.pd.y = 0;
				MahjongPlayerControlL.instance._mahjongPlayer.dSort.x = MahjongPlayerControlL.instance._mahjongPlayer.out.x;
				
				MahjongPlayerControlR.instance._mahjongPlayer.out.x = -30;
				MahjongPlayerControlR.instance._mahjongPlayer.sp.y = -20;
				MahjongPlayerControlR.instance._mahjongPlayer.pd.x = 40;
				MahjongPlayerControlR.instance._mahjongPlayer.pd.y = 0;
				MahjongPlayerControlR.instance._mahjongPlayer.dSort.x = MahjongPlayerControlR.instance._mahjongPlayer.out.x+43;
				
				
				MahjongPlayerControlU.instance._mahjongPlayer.out.y = 133;
				MahjongPlayerControlU.instance._mahjongPlayer.pd.x = -20;
				MahjongPlayerControlU.instance._mahjongPlayer.dSort.y = MahjongPlayerControlU.instance._mahjongPlayer.out.y;
				
				MahjongPlayerControlD.instance._mahjongPlayer.out.y = 8;
				MahjongPlayerControlD.instance._mahjongPlayer.pd.x = 40;
				MahjongPlayerControlD.instance._mahjongPlayer.dSort.y = MahjongPlayerControlD.instance._mahjongPlayer.out.y+40;
				
				MahjongWordControl.instance._azimuth1 = new Point(420,46);
				MahjongWordControl.instance._azimuth2 = new Point(64,300);
				MahjongWordControl.instance._azimuth3 = new Point(420,500);
				MahjongWordControl.instance._azimuth4 = new Point(674,300);
				
				MahjongPlayerControlL.instance.soundType = Math.random() * 2;
				MahjongPlayerControlR.instance.soundType = Math.random() * 2;
				MahjongPlayerControlD.instance.soundType = Math.random() * 2;
				MahjongPlayerControlU.instance.soundType = Math.random() * 2;
			}else if(MainControl.instance.main.applicationDPI == 320){
				MahjongRoomControl.instance._mahjongRoom.mahjongPlayerU.top = 80;
				MahjongRoomControl.instance._mahjongRoom.mahjongPlayerD.bottom = 50;
				MahjongRoomControl.instance._mahjongRoom.mahjongPlayerL.left = 80;
				MahjongRoomControl.instance._mahjongRoom.mahjongPlayerR.right = 160;
				
				MahjongRoomControl.instance._mahjongRoom.mahjongOperation.x = 500;
				MahjongRoomControl.instance._mahjongRoom.mahjongOperation.y = 500;
				
				MahjongPlayerControlL.instance._mahjongPlayer.out.x = 70;
				MahjongPlayerControlL.instance._mahjongPlayer.sp.y = -50;
				MahjongPlayerControlL.instance._mahjongPlayer.pd.x = 20;
				MahjongPlayerControlL.instance._mahjongPlayer.pd.y = 0;
				MahjongPlayerControlL.instance._mahjongPlayer.dSort.x = MahjongPlayerControlL.instance._mahjongPlayer.out.x;
				
				MahjongPlayerControlR.instance._mahjongPlayer.out.x = 5;
				MahjongPlayerControlR.instance._mahjongPlayer.sp.y = -20;
				MahjongPlayerControlR.instance._mahjongPlayer.pd.x = 40;
				MahjongPlayerControlR.instance._mahjongPlayer.pd.y = 0;
				MahjongPlayerControlR.instance._mahjongPlayer.dSort.x = MahjongPlayerControlR.instance._mahjongPlayer.out.x+43;
				
				MahjongPlayerControlU.instance._mahjongPlayer.sp.y = -30;
				MahjongPlayerControlU.instance._mahjongPlayer.out.y = 88;
				MahjongPlayerControlU.instance._mahjongPlayer.pd.x = -20;
				MahjongPlayerControlU.instance._mahjongPlayer.dSort.y = MahjongPlayerControlU.instance._mahjongPlayer.out.y;
				
				MahjongPlayerControlD.instance._mahjongPlayer.sp.y = 200;
				MahjongPlayerControlD.instance._mahjongPlayer.sp.x = -85;
				MahjongPlayerControlD.instance._mahjongPlayer.out.y = 53;
				MahjongPlayerControlD.instance._mahjongPlayer.pd.x = 40;
				MahjongPlayerControlD.instance._mahjongPlayer.dSort.y = MahjongPlayerControlD.instance._mahjongPlayer.out.y+40;
				
				MahjongWordControl.instance._azimuth1 = new Point(370,46);
				MahjongWordControl.instance._azimuth2 = new Point(64,250);
				MahjongWordControl.instance._azimuth3 = new Point(370,400);
				MahjongWordControl.instance._azimuth4 = new Point(674,250);
				
				MahjongPlayerControlL.instance.soundType = Math.random() * 2;
				MahjongPlayerControlR.instance.soundType = Math.random() * 2;
				MahjongPlayerControlD.instance.soundType = Math.random() * 2;
				MahjongPlayerControlU.instance.soundType = Math.random() * 2;
				
				
			}
			
			if(MainControl.instance.main.applicationDPI != 160){
				MahjongPlayerControlU.instance._mahjongPlayer.pd.visible = false;
				MahjongPlayerControlD.instance._mahjongPlayer.pd.visible = false;
				MahjongPlayerControlL.instance._mahjongPlayer.pd.visible = false;
				MahjongPlayerControlR.instance._mahjongPlayer.pd.visible = false;
			}
			
			this._mahjongRoomService.initRoom(obj.roomNo, obj.playerAzimuth);
			
			this._mahjongRoomService.updateMahjongsByDice(obj.diceNum);
			
			this._mahjongRoomService.reconstructTabletop(obj.players);
			
			this._nowPutPlayerAzimuth = obj.nowPutPlayerAzimuth;
			this._nowPutMahjong = this._mahjongRoomService.getLastPutMahjong(obj.nowPutPlayerAzimuth);
			
			this._mahjongRoomService.doPlayAfterRestart(obj.isShowOperation, obj.operationContent);
			
			this._mahjongRoom.roomTabletop.visible = true;
			
			MahjongSoundService.instance.playBg();
		}
		
		/**
		 * 播放录像 
		 * @param obj
		 * 
		 */
		public function playVideo(obj:Object):void{
			_isVideo = true;
			MahjongRoomControl.instance._mahjongRoom.roomTabletop.width = MainControl.instance.main.width;
			MahjongRoomControl.instance._mahjongRoom.roomTabletop.height = MainControl.instance.main.height;
			if(MainControl.instance.main.applicationDPI == 160){
				MahjongRoomControl.instance._mahjongRoom.mahjongPlayerU.top = 80;
				MahjongRoomControl.instance._mahjongRoom.mahjongPlayerD.bottom = 50;
				MahjongRoomControl.instance._mahjongRoom.mahjongPlayerL.left = 80;
				MahjongRoomControl.instance._mahjongRoom.mahjongPlayerR.right = 160;
				
				MahjongRoomControl.instance._mahjongRoom.mahjongOperation.x = 500;
				MahjongRoomControl.instance._mahjongRoom.mahjongOperation.y = 500;
				
				MahjongPlayerControlL.instance._mahjongPlayer.out.x = 100;
				MahjongPlayerControlL.instance._mahjongPlayer.sp.y = -50;
				MahjongPlayerControlL.instance._mahjongPlayer.pd.x = 20;
				MahjongPlayerControlL.instance._mahjongPlayer.pd.y = 0;
				MahjongPlayerControlL.instance._mahjongPlayer.dSort.x = MahjongPlayerControlL.instance._mahjongPlayer.out.x;
				
				MahjongPlayerControlR.instance._mahjongPlayer.out.x = -30;
				MahjongPlayerControlR.instance._mahjongPlayer.sp.y = -20;
				MahjongPlayerControlR.instance._mahjongPlayer.pd.x = 40;
				MahjongPlayerControlR.instance._mahjongPlayer.pd.y = 0;
				MahjongPlayerControlR.instance._mahjongPlayer.dSort.x = MahjongPlayerControlR.instance._mahjongPlayer.out.x+43;
				
				
				MahjongPlayerControlU.instance._mahjongPlayer.out.y = 133;
				MahjongPlayerControlU.instance._mahjongPlayer.pd.x = -20;
				MahjongPlayerControlU.instance._mahjongPlayer.dSort.y = MahjongPlayerControlU.instance._mahjongPlayer.out.y;
				
				MahjongPlayerControlD.instance._mahjongPlayer.out.y = 8;
				MahjongPlayerControlD.instance._mahjongPlayer.pd.x = 40;
				MahjongPlayerControlD.instance._mahjongPlayer.dSort.y = MahjongPlayerControlD.instance._mahjongPlayer.out.y+40;
				
				MahjongWordControl.instance._azimuth1 = new Point(420,46);
				MahjongWordControl.instance._azimuth2 = new Point(64,300);
				MahjongWordControl.instance._azimuth3 = new Point(420,500);
				MahjongWordControl.instance._azimuth4 = new Point(674,300);
				
				MahjongPlayerControlL.instance.soundType = Math.random() * 2;
				MahjongPlayerControlR.instance.soundType = Math.random() * 2;
				MahjongPlayerControlD.instance.soundType = Math.random() * 2;
				MahjongPlayerControlU.instance.soundType = Math.random() * 2;
			}else if(MainControl.instance.main.applicationDPI == 320){
				MahjongRoomControl.instance._mahjongRoom.mahjongPlayerU.top = 80;
				MahjongRoomControl.instance._mahjongRoom.mahjongPlayerD.bottom = 50;
				MahjongRoomControl.instance._mahjongRoom.mahjongPlayerL.left = 80;
				MahjongRoomControl.instance._mahjongRoom.mahjongPlayerR.right = 160;
				
				MahjongRoomControl.instance._mahjongRoom.mahjongOperation.x = 500;
				MahjongRoomControl.instance._mahjongRoom.mahjongOperation.y = 500;
				
				MahjongPlayerControlL.instance._mahjongPlayer.out.x = 70;
				MahjongPlayerControlL.instance._mahjongPlayer.sp.y = -50;
				MahjongPlayerControlL.instance._mahjongPlayer.pd.x = 20;
				MahjongPlayerControlL.instance._mahjongPlayer.pd.y = 0;
				MahjongPlayerControlL.instance._mahjongPlayer.dSort.x = MahjongPlayerControlL.instance._mahjongPlayer.out.x;
				
				MahjongPlayerControlR.instance._mahjongPlayer.out.x = 5;
				MahjongPlayerControlR.instance._mahjongPlayer.sp.y = -20;
				MahjongPlayerControlR.instance._mahjongPlayer.pd.x = 40;
				MahjongPlayerControlR.instance._mahjongPlayer.pd.y = 0;
				MahjongPlayerControlR.instance._mahjongPlayer.dSort.x = MahjongPlayerControlR.instance._mahjongPlayer.out.x+43;
				
				MahjongPlayerControlU.instance._mahjongPlayer.sp.y = -30;
				MahjongPlayerControlU.instance._mahjongPlayer.out.y = 88;
				MahjongPlayerControlU.instance._mahjongPlayer.pd.x = -20;
				MahjongPlayerControlU.instance._mahjongPlayer.dSort.y = MahjongPlayerControlU.instance._mahjongPlayer.out.y;
				
				MahjongPlayerControlD.instance._mahjongPlayer.sp.y = 200;
				MahjongPlayerControlD.instance._mahjongPlayer.sp.x = -85;
				MahjongPlayerControlD.instance._mahjongPlayer.out.y = 53;
				MahjongPlayerControlD.instance._mahjongPlayer.pd.x = 40;
				MahjongPlayerControlD.instance._mahjongPlayer.dSort.y = MahjongPlayerControlD.instance._mahjongPlayer.out.y+40;
				
				MahjongWordControl.instance._azimuth1 = new Point(370,46);
				MahjongWordControl.instance._azimuth2 = new Point(64,250);
				MahjongWordControl.instance._azimuth3 = new Point(370,400);
				MahjongWordControl.instance._azimuth4 = new Point(674,250);
				
				MahjongPlayerControlL.instance.soundType = Math.random() * 2;
				MahjongPlayerControlR.instance.soundType = Math.random() * 2;
				MahjongPlayerControlD.instance.soundType = Math.random() * 2;
				MahjongPlayerControlU.instance.soundType = Math.random() * 2;
			}
			this.initTabletop(obj.roomType);
			
			this._mahjongRoomService.initRoom(obj.roomNo, obj.playerAzimuth);
			for(var i:int = 1; i < obj.playerMahjongValues.length; i ++){
				this._mahjongRoomService.setPlayerMahjongValues(i, obj.playerMahjongValues[i]);
			}
			MahjongPlayerControlU.instance._mahjongPlayer.pd.visible = true;
			MahjongPlayerControlD.instance._mahjongPlayer.pd.visible = true;
			MahjongPlayerControlL.instance._mahjongPlayer.pd.visible = true;
			MahjongPlayerControlR.instance._mahjongPlayer.pd.visible = true;
			
			this._mahjongRoom.roomTabletop.visible = true;
			
			this._mahjongRoomService.showDice(obj.diceNum);
		}
		
		/**
		 * 开始游戏 
		 * @param obj
		 * 
		 */
		var playNum:int = 0;
		public function beginGame(roomNo:Number,diceNum:Number,playerAzimuth:int,playerMahjongValues:Array):void{
			
			playNum++;
			if(playNum == 2){
				MahjongSoundService.instance._soundSwitch = false;
				Alert.show("游戏配音只支持一局播放，如您喜欢，请尝试完整版！");
			}
			
			_mahjongRoom.limit.init();
			
			if(playNum == 1){
				_mahjongRoom.limit.visible = false;
			}
			
			MahjongRoomControl.instance._mahjongRoom.roomTabletop.width = MainControl.instance.main.width;
			MahjongRoomControl.instance._mahjongRoom.roomTabletop.height = MainControl.instance.main.height;
			
			if(MainControl.instance.main.applicationDPI == 160){
				MahjongRoomControl.instance._mahjongRoom.mahjongPlayerU.top = 80;
				MahjongRoomControl.instance._mahjongRoom.mahjongPlayerD.bottom = 50;
				MahjongRoomControl.instance._mahjongRoom.mahjongPlayerL.left = 80;
				MahjongRoomControl.instance._mahjongRoom.mahjongPlayerR.right = 160;
				
				MahjongRoomControl.instance._mahjongRoom.mahjongOperation.x = 500;
				MahjongRoomControl.instance._mahjongRoom.mahjongOperation.y = 500;
				MahjongPlayerControlL.instance._mahjongPlayer.out.x = 100;
				MahjongPlayerControlL.instance._mahjongPlayer.sp.y = -50;
				MahjongPlayerControlL.instance._mahjongPlayer.pd.x = 20;
				MahjongPlayerControlL.instance._mahjongPlayer.pd.y = 0;
				MahjongPlayerControlL.instance._mahjongPlayer.dSort.x = MahjongPlayerControlL.instance._mahjongPlayer.out.x;
					
				MahjongPlayerControlR.instance._mahjongPlayer.out.x = -30;
				MahjongPlayerControlR.instance._mahjongPlayer.sp.y = -20;
				MahjongPlayerControlR.instance._mahjongPlayer.pd.x = 40;
				MahjongPlayerControlR.instance._mahjongPlayer.pd.y = 0;
				MahjongPlayerControlR.instance._mahjongPlayer.dSort.x = MahjongPlayerControlR.instance._mahjongPlayer.out.x+43;
				
				
				MahjongPlayerControlU.instance._mahjongPlayer.out.y = 133;
				MahjongPlayerControlU.instance._mahjongPlayer.pd.x = -20;
				MahjongPlayerControlU.instance._mahjongPlayer.dSort.y = MahjongPlayerControlU.instance._mahjongPlayer.out.y;
				
				MahjongPlayerControlD.instance._mahjongPlayer.out.y = 8;
				MahjongPlayerControlD.instance._mahjongPlayer.pd.x = 40;
				MahjongPlayerControlD.instance._mahjongPlayer.dSort.y = MahjongPlayerControlD.instance._mahjongPlayer.out.y+40;
				
				MahjongWordControl.instance._azimuth1 = new Point(420,46);
				MahjongWordControl.instance._azimuth2 = new Point(64,300);
				MahjongWordControl.instance._azimuth3 = new Point(420,500);
				MahjongWordControl.instance._azimuth4 = new Point(674,300);
				
				MahjongPlayerControlL.instance.soundType = Math.random() * 2;
				MahjongPlayerControlR.instance.soundType = Math.random() * 2;
				MahjongPlayerControlD.instance.soundType = Math.random() * 2;
				MahjongPlayerControlU.instance.soundType = Math.random() * 2;
			}else if(MainControl.instance.main.applicationDPI == 320){
				MahjongRoomControl.instance._mahjongRoom.mahjongPlayerU.top = 80;
				MahjongRoomControl.instance._mahjongRoom.mahjongPlayerD.bottom = 50;
				MahjongRoomControl.instance._mahjongRoom.mahjongPlayerL.left = 80;
				MahjongRoomControl.instance._mahjongRoom.mahjongPlayerR.right = 160;
				
				MahjongRoomControl.instance._mahjongRoom.mahjongOperation.x = 500;
				MahjongRoomControl.instance._mahjongRoom.mahjongOperation.y = 500;
				
				MahjongPlayerControlL.instance._mahjongPlayer.out.x = 70;
				MahjongPlayerControlL.instance._mahjongPlayer.sp.y = -50;
				MahjongPlayerControlL.instance._mahjongPlayer.pd.x = 20;
				MahjongPlayerControlL.instance._mahjongPlayer.pd.y = 0;
				MahjongPlayerControlL.instance._mahjongPlayer.dSort.x = MahjongPlayerControlL.instance._mahjongPlayer.out.x;
				
				MahjongPlayerControlR.instance._mahjongPlayer.out.x = 5;
				MahjongPlayerControlR.instance._mahjongPlayer.sp.y = -20;
				MahjongPlayerControlR.instance._mahjongPlayer.pd.x = 40;
				MahjongPlayerControlR.instance._mahjongPlayer.pd.y = 0;
				MahjongPlayerControlR.instance._mahjongPlayer.dSort.x = MahjongPlayerControlR.instance._mahjongPlayer.out.x+43;
				
				MahjongPlayerControlU.instance._mahjongPlayer.sp.y = -30;
				MahjongPlayerControlU.instance._mahjongPlayer.out.y = 88;
				MahjongPlayerControlU.instance._mahjongPlayer.pd.x = -20;
				MahjongPlayerControlU.instance._mahjongPlayer.dSort.y = MahjongPlayerControlU.instance._mahjongPlayer.out.y;
				
				MahjongPlayerControlD.instance._mahjongPlayer.sp.y = 200;
				MahjongPlayerControlD.instance._mahjongPlayer.sp.x = -85;
				MahjongPlayerControlD.instance._mahjongPlayer.out.y = 53;
				MahjongPlayerControlD.instance._mahjongPlayer.pd.x = 40;
				MahjongPlayerControlD.instance._mahjongPlayer.dSort.y = MahjongPlayerControlD.instance._mahjongPlayer.out.y+40;
				
				MahjongWordControl.instance._azimuth1 = new Point(370,46);
				MahjongWordControl.instance._azimuth2 = new Point(64,250);
				MahjongWordControl.instance._azimuth3 = new Point(370,400);
				MahjongWordControl.instance._azimuth4 = new Point(674,250);
				
				MahjongPlayerControlL.instance.soundType = Math.random() * 2;
				MahjongPlayerControlR.instance.soundType = Math.random() * 2;
				MahjongPlayerControlD.instance.soundType = Math.random() * 2;
				MahjongPlayerControlU.instance.soundType = Math.random() * 2;
				
				
			}
				
			
			initTabletop(5);
			
			this._mahjongRoom.roomTabletop.visible = true;
			
			this._mahjongRoomService.initRoom(roomNo, playerAzimuth);
			this._mahjongRoomService.setPlayerMahjongValues(this._playerAzimuth, playerMahjongValues);
			
			this._mahjongRoomService.showDice(diceNum);
			
			MahjongSoundService.instance.playBg();
			
			//初期测试
			//			for(var i:int = 0; i < 4; i ++){
			//				this._mahjongRoomService.dispenseMahjongs(i + 1, 13);
			//			}
			//			MahjongSyncService.instance.readyGame();
		}
		
		public function setPlayerSoundType():void{
			var resPlayerAzimuth:int = MahjongUtil.getRemotePlayerAzimuth(MahjongRoomControl.instance.playerAzimuth, MahjongRoomControl.instance.playerAzimuth);
			switch (resPlayerAzimuth){
				case 1:
					MahjongPlayerControlU.instance.soundType = MahjongRoomControl.soundType;
					break;
				case 2:
					MahjongPlayerControlL.instance.soundType = MahjongRoomControl.soundType;
					break;
				case 3:
					MahjongPlayerControlD.instance.soundType = MahjongRoomControl.soundType;
					break;
				case 4:
					MahjongPlayerControlR.instance.soundType = MahjongRoomControl.soundType;
					break;
			}
		}
		/**
		 * 结束游戏 
		 * @param obj
		 * 
		 */
		public function endGame(obj:Object):void{
			if(!_isVideo){
				MahjongTimerControl.instance.hide();
				this._mahjongRoomService.cut(obj.playerMahjongValues);
				//测试
//				MahjongVideoControl.instance.constructVideo(obj.videoContent, PlayerService.instance.player.acctMoney);
				
				MahjongSoundService.instance._bgChannel.stop();
			}
			
			MahjongBalanceControl.instance.show(this.roomNo, obj.result, obj.playerNames);
		}
		
		public function dingzhang(obj:Object):void{
			this._mahjongRoomService.dingzhang(obj.playerAzimuthR, obj.dingzhangValue);
		}
		
		public function getOneMahjong(obj:Object):void{
			this._mahjongRoomService.getOneMahjong(obj.playerAzimuthR, obj.getOneMahjongValue);
		}
		
		public function putOneMahjong(obj:Object):void{
			this._mahjongRoomService.putOneMahjong(obj.playerAzimuthR, obj.putOneMahjongValue, obj.isPutDingzhang);
		}
		
		public function peng(obj:Object):void{
			this._mahjongRoomService.peng(obj.playerAzimuthR, obj.pengValue);
		}
		
		public function gang(obj:Object):void{
			this._mahjongRoomService.gang(obj.playerAzimuthR, obj.gangValue, obj.isZigang);
		}
		
		public function hu(obj:Object):void{
			this._mahjongRoomService.hu(obj.playerAzimuthR, obj.huValue, obj.huType, obj.isAfterGang, obj.haveHuCount, obj.qiangGangAzimuth);
		}
		
		public function showDingzhang(obj:Object):void{
			this._mahjongRoomService.showDingzhang(obj.playerAzimuthR);
		}
		
		public function showOperation(obj:Object):void{
			this._mahjongRoomService.showOperation(obj.playerAzimuthR, obj.isPeng, obj.isGang, obj.isHu, obj.isZimo, obj.isZigang);
		}
		
		//--------------------------------------------------------------------
		private function initTabletop(roomType:int):void{
			this._mahjongRoom.roomTabletop.visible = false;
			
			_roomType = roomType;
			
			switch(roomType){
				case 1:
				case 5:
				case 10:
//					this._mahjongRoom.MahjongRoomBg = _MahjongRoomBg5;
					_mahjongColor = "blue";
					break;
				case 20:
//					this._mahjongRoom.MahjongRoomBg = _MahjongRoomBg20;
					_mahjongColor = "green";
					break;
				case 50:
//					this._mahjongRoom.MahjongRoomBg = _MahjongRoomBg50;
					_mahjongColor = "yellow";
					break;
			}
			
			this._mahjongRoomService.updateMahjongsColor(_mahjongColor);
			
			MahjongInfoControl.instance.setRoomType(roomType);
		}
		
		public function clearTabletop():void{
			this._mahjongRoomService.reset();
			
			this._mahjongRoom.roomTabletop.visible = false;
			MahjongApplictionControl.instance.resetXY();
		}
		
		public function getMahjong():Mahjong{
			return this._mahjongRoomService.getMahjong();
		}
		
		public function getMahjongs(num:int):Array{
			return this._mahjongRoomService.getMahjongsByNumber(num);
		}
		
		/**
		 * 更新网络质量 
		 * @param value
		 * 
		 */
		public function updateNetworkWidth(value:int):void{
//			this._mahjongRoom.network.setStateWidth(value);
		}
		
		//--------------------- getter/setter --------------------------------
		public static function get instance():MahjongRoomControl
		{
			return _instance;
		}
		
		public function get isVideo():Boolean
		{
			return _isVideo;
		}
		
		public function set isVideo(value:Boolean):void
		{
			_isVideo = value;
		}
		
		public function get roomType():int
		{
			return _roomType;
		}
		
		/*public function set roomType(value:int):void
		{
			_roomType = value;
		}*/

		public function get mahjongColor():String
		{
			return _mahjongColor;
		}

		/*public function set mahjongColor(value:String):void
		{
			_mahjongColor = value;
		}*/
		
		public function get mahjongs():Array
		{
			return _mahjongs;
		}
		
		public function set mahjongs(value:Array):void
		{
			_mahjongs = value;
		}
		
		public function get roomNo():Number
		{
			return _roomNo;
		}
		
		public function set roomNo(value:Number):void
		{
			_roomNo = value;
		}

		public function get playerAzimuth():int
		{
			return _playerAzimuth;
		}

		public function set playerAzimuth(value:int):void
		{
			_playerAzimuth = value;
		}

		public function get nowPutPlayerAzimuth():int
		{
			return _nowPutPlayerAzimuth;
		}

		public function set nowPutPlayerAzimuth(value:int):void
		{
			_nowPutPlayerAzimuth = value;
		}

		public function get nowPutMahjong():Mahjong
		{
			return _nowPutMahjong;
		}

		public function set nowPutMahjong(value:Mahjong):void
		{
			_nowPutMahjong = value;
		}
		
		public function get putState():int
		{
			return _putState;
		}
		
		public function set putState(value:int):void
		{
			_putState = value;
		}

		public function get selectMahjong():Mahjong
		{
			return _selectMahjong;
		}

		public function set selectMahjong(value:Mahjong):void
		{
			_selectMahjong = value;
		}
	}
}