package com.amusement.Mahjong.control
{
	import com.amusement.Mahjong.MahjongSetting;
	import com.amusement.Mahjong.service.MahjongSyncServer100;
	import com.amusement.Mahjong.service.MahjongSyncServer10;
	import com.amusement.Mahjong.service.MahjongSyncServer20;
	import com.amusement.Mahjong.service.MahjongSyncServer5;
	import com.amusement.Mahjong.service.MahjongSyncServer50;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.containers.Form;
	import mx.events.CloseEvent;
	import mx.formatters.DateFormatter;
	import mx.managers.PopUpManager;
	import mx.rpc.events.ResultEvent;

	public class MahjongSettingControl
	{
		public static var instance:MahjongSettingControl;
		private var mahjongSetting:MahjongSetting;
		private var timerControl:TimerControl;
		
		private var room1Result:Boolean = false;
		private var room5Result:Boolean = false;
		private var room10Result:Boolean = false;
		private var room20Result:Boolean = false;
		private var room50Result:Boolean = false;
		private var df:DateFormatter = new DateFormatter();
		
		// g 2011-5-19 10:50  所有在线用户
		private var _playerList:ArrayList = new ArrayList();
		private var playerNames:String = "";
		
		private var _userHierarchys:Array;

		public function MahjongSettingControl(mahjongSetting:MahjongSetting)
		{
			instance=this;
			this.mahjongSetting=mahjongSetting;

			df.formatString = 'YYYY-MM-DD HH:NN:SS'; 
			
			MahjongSyncServer5.getInstance();
			MahjongSyncServer10.getInstance();
			MahjongSyncServer20.getInstance();
			MahjongSyncServer50.getInstance();

			this.mahjongSetting.mahjongB100.addEventListener(MouseEvent.CLICK, mahjongB100Click);
			this.mahjongSetting.mahjongB5.addEventListener(MouseEvent.CLICK, mahjongB5Click);
			this.mahjongSetting.mahjongB10.addEventListener(MouseEvent.CLICK, mahjongB10Click);
			this.mahjongSetting.mahjongB20.addEventListener(MouseEvent.CLICK, mahjongB20Click);
			this.mahjongSetting.mahjongB50.addEventListener(MouseEvent.CLICK, mahjongB50Click);
			
//			this.mahjongSetting.checkIpEqual1.addEventListener(MouseEvent.CLICK, checkMahjongEqual1);
//			this.mahjongSetting.checkIpEqual5.addEventListener(MouseEvent.CLICK, checkMahjongEqual5);
//			this.mahjongSetting.checkIpEqual10.addEventListener(MouseEvent.CLICK, checkMahjongEqual10);
//			this.mahjongSetting.checkIpEqual20.addEventListener(MouseEvent.CLICK, checkMahjongEqual20);
//			this.mahjongSetting.checkIpEqual50.addEventListener(MouseEvent.CLICK, checkMahjongEqual50);
			
			this.mahjongSetting.addEventListener(CloseEvent.CLOSE,closeHandler);
			
			timerControl = new TimerControl();
		}
		
//		private function checkMahjongEqual1(e:MouseEvent):void{
//			MahjongSyncServer1.getInstance().updateAgencyEqualAndIpEqual(this.mahjongSetting.checkIpEqual1.selected, this.mahjongSetting.checkAgencyEqual1.selected);
//		}
//		
//		private function checkMahjongEqual5(e:MouseEvent):void{
//			MahjongSyncServer5.getInstance().updateAgencyEqualAndIpEqual(this.mahjongSetting.checkIpEqual5.selected, this.mahjongSetting.checkAgencyEqual5.selected);
//		}
//		
//		private function checkMahjongEqual10(e:MouseEvent):void{
//			MahjongSyncServer10.getInstance().updateAgencyEqualAndIpEqual(this.mahjongSetting.checkIpEqual10.selected, this.mahjongSetting.checkAgencyEqual10.selected);
//		}
//		
//		private function checkMahjongEqual20(e:MouseEvent):void{
//			MahjongSyncServer20.getInstance().updateAgencyEqualAndIpEqual(this.mahjongSetting.checkIpEqual20.selected, this.mahjongSetting.checkAgencyEqual20.selected);
//		}
//		
//		private function checkMahjongEqual50(e:MouseEvent):void{
//			MahjongSyncServer50.getInstance().updateAgencyEqualAndIpEqual(this.mahjongSetting.checkIpEqual50.selected, this.mahjongSetting.checkAgencyEqual50.selected);
//		}
		
		private function closeHandler(e:CloseEvent):void{
			PopUpManager.removePopUp(this.mahjongSetting);
			
			timerControl.stopTimer();
			timerControl = null;
			instance = null;
			
			MahjongSyncServer100.getInstance().disConnServer();
			MahjongSyncServer5.getInstance().disConnServer();
			MahjongSyncServer10.getInstance().disConnServer();
			MahjongSyncServer20.getInstance().disConnServer();
			MahjongSyncServer50.getInstance().disConnServer();
		}
		
		public function get userHierarchys():Array{
			return this._userHierarchys;
		}
		
		public function clearPlayerList():void{
			this._playerList.removeAll();
			playerNames = "";
		}
		
		// g 2011-5-19 10:50  添加用户
		private function addPlayerList(array:Array):void{
			for(var i:int=0;i < array.length; i++){
				var strs:Array = String(array[i]).split(",");
				var obj:Object = new Object();
				obj.name = strs[0];
				obj.isOnline = strs[1];
				obj.roomNo = strs[2];
				obj.roomNoo = strs[3];
				var str:String = df.format(new Date(Number(obj.roomNoo)));
				obj.gameStartTime = str;
				_playerList.addItem(obj);
				playerNames += obj.name + ",";
			}
			
		}

		private function mahjongB100Click(e:MouseEvent):void
		{
			MahjongSyncServer100.getInstance().updateTransformerState(int(this.mahjongSetting.winOnlineNum100.value), this.mahjongSetting.winGailv100.value);
		}
		
		private function mahjongB5Click(e:MouseEvent):void
		{
			MahjongSyncServer5.getInstance().updateTransformerState(int(this.mahjongSetting.winOnlineNum5.value), this.mahjongSetting.winGailv5.value);
		}

		private function mahjongB10Click(e:MouseEvent):void
		{
			MahjongSyncServer10.getInstance().updateTransformerState(int(this.mahjongSetting.winOnlineNum10.value), this.mahjongSetting.winGailv10.value);
		}

		private function mahjongB20Click(e:MouseEvent):void
		{
			MahjongSyncServer20.getInstance().updateTransformerState(int(this.mahjongSetting.winOnlineNum20.value), this.mahjongSetting.winGailv20.value);
		}

		private function mahjongB50Click(e:MouseEvent):void
		{
			MahjongSyncServer50.getInstance().updateTransformerState(int(this.mahjongSetting.winOnlineNum50.value), this.mahjongSetting.winGailv50.value);

		}

		//=====================================================================
		public function updateMahjong1(transformerWinGailv:Number):void
		{
			this.mahjongSetting.winGailv100.value=transformerWinGailv;
		}
		public function updateMahjong5(transformerWinGailv:Number):void
		{
			this.mahjongSetting.winGailv5.value=transformerWinGailv;
		}

		public function updateMahjong10(transformerWinGailv:Number):void
		{
			this.mahjongSetting.winGailv10.value=transformerWinGailv;
		}

		public function updateMahjong20(transformerWinGailv:Number):void
		{
			this.mahjongSetting.winGailv20.value=transformerWinGailv;
		}

		public function updateMahjong50(transformerWinGailv:Number):void
		{
			this.mahjongSetting.winGailv50.value=transformerWinGailv;
		}
		
		public function updateEqual1(isIpEqual:Boolean, isAgencyEqual:Boolean):void{
			this.mahjongSetting.checkIpEqual100.selected = isIpEqual;
		}
		
		public function updateEqual5(isIpEqual:Boolean, isAgencyEqual:Boolean):void{
			this.mahjongSetting.checkIpEqual5.selected = isIpEqual;
		}
		
		public function updateEqual10(isIpEqual:Boolean, isAgencyEqual:Boolean):void{
			this.mahjongSetting.checkIpEqual10.selected = isIpEqual;
		}
		
		public function updateEqual20(isIpEqual:Boolean, isAgencyEqual:Boolean):void{
			this.mahjongSetting.checkIpEqual20.selected = isIpEqual;
		}
		
		public function updateEqual50(isIpEqual:Boolean, isAgencyEqual:Boolean):void{
			this.mahjongSetting.checkIpEqual50.selected = isIpEqual;
		}
		
		//========================================================================
		public function getOnlineNum1(onlineNumResult : String):void{
			this.mahjongSetting.onlineNum_100.text = onlineNumResult;
			this.mahjongSetting.winOnlineNum100.value = Number(onlineNumResult.split("--")[1]);
		}
		
		public function getOnlineNum5(onlineNumResult : String):void{
			this.mahjongSetting.onlineNum_5.text = onlineNumResult;
			this.mahjongSetting.winOnlineNum5.value = Number(onlineNumResult.split("--")[1]);
		}
		
		public function getOnlineNum10(onlineNumResult : String):void{
			this.mahjongSetting.onlineNum_10.text = onlineNumResult;
			this.mahjongSetting.winOnlineNum10.value = Number(onlineNumResult.split("--")[1]);
		}
		
		public function getOnlineNum20(onlineNumResult : String):void{
			this.mahjongSetting.onlineNum_20.text = onlineNumResult;
			this.mahjongSetting.winOnlineNum20.value = Number(onlineNumResult.split("--")[1]);
		}
		
		public function getOnlineNum50(onlineNumResult : String):void{
			this.mahjongSetting.onlineNum_50.text = onlineNumResult;
			this.mahjongSetting.winOnlineNum50.value = Number(onlineNumResult.split("--")[1]);
		}
		
		public function serverDisconnectClient(roomNo:String, playerName:String):void{
			switch(roomNo){
				case "1":
					MahjongSyncServer100.getInstance().serverDisconnectClient(playerName);
					break;
				case "5":
					MahjongSyncServer5.getInstance().serverDisconnectClient(playerName);
					break;
				case "10":
					MahjongSyncServer10.getInstance().serverDisconnectClient(playerName);
					break;
				case "20":
					MahjongSyncServer20.getInstance().serverDisconnectClient(playerName);
					break;
				case "50":
					MahjongSyncServer50.getInstance().serverDisconnectClient(playerName);
					break;
			}
		}
	}
}