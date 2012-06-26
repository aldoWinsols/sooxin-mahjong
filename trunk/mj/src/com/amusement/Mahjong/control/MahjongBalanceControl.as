package com.amusement.Mahjong.control
{
	import com.amusement.Mahjong.MahjongAppliction;
	import com.amusement.Mahjong.model.MahjongBalanceGrid;
	import com.amusement.Mahjong.service.MahjongBalanceService;
	import com.amusement.Mahjong.service.MahjongRoomService;
	import com.amusement.Mahjong.service.MahjongSyncService;
	import com.amusement.Mahjong.view.MahjongBalance;
	import com.model.Alert;
	import com.services.GameCenterService;
	import com.services.MainPlayerService;
	import com.view.System;
	
	import flash.events.MouseEvent;

	public class MahjongBalanceControl
	{
		private static var _instance:MahjongBalanceControl;
		
		private var _mahjongRalance:MahjongBalance;
		private var _mahjongRalanceService:MahjongBalanceService;
		
		public function MahjongBalanceControl(mahjongRalance:MahjongBalance)
		{
			_instance = this;
			
			this._mahjongRalance = mahjongRalance;
			this._mahjongRalanceService = new MahjongBalanceService();
			
			init();
		}
		
		private function init():void{
			addListeners();
		}
		
		private function addListeners():void{
			this._mahjongRalance.showRoHideBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
//			this._mahjongRalance.continueBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
//			this._mahjongRalance.exitBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
		}
		
		private function btnClickHandler(event:MouseEvent):void{
			switch(event.currentTarget.id){
				case "showRoHideBtn":
					this._mahjongRalance.resultCont.visible = !this._mahjongRalance.resultCont.visible;
//					this._mahjongRalance.continueBtn.visible = !this._mahjongRalance.continueBtn.visible;
//					this._mahjongRalance.exitBtn.visible = !this._mahjongRalance.exitBtn.visible;
					break;
				case "continueBtn":
					this._mahjongRalanceService.continueClickHandler();
					break;
				case "exitBtn":
					if(MahjongSyncService.instance.isNetwork){
						MahjongApplictionControl.instance._mahjongAppliction.mahjongRoom.visible = false;
//						MahjongApplictionControl.instance._mahjongAppliction.lianwangHome.visible = true;
					}else{					
						MahjongApplictionControl.instance._mahjongAppliction.mahjongRoom.visible = false;
//						MahjongApplictionControl.instance._mahjongAppliction.home.visible = true;
					}
					MahjongRoomControl.instance.clearTabletop();
					break;
			}
		}
		
		public function showBalance():void{
			this._mahjongRalance.resultCont.visible = true;
		}
		
		public function back():void{
			if(MahjongSyncService.instance.isNetwork){
				MahjongApplictionControl.instance._mahjongAppliction.mahjongRoom.visible = false;
				//						MahjongApplictionControl.instance._mahjongAppliction.lianwangHome.visible = true;
			}else{					
				MahjongApplictionControl.instance._mahjongAppliction.mahjongRoom.visible = false;
				//						MahjongApplictionControl.instance._mahjongAppliction.home.visible = true;
			}
			MahjongRoomControl.instance.clearTabletop();
		}
		
		/**
		 * 显示结算条目 
		 * @param result
		 * @return 
		 * 
		 */
		private function showResult(result:Array):Array{
			var total:Array = [0, 0, 0, 0];
			var grid:MahjongBalanceGrid;
			for(var i:int = 0; i<result.length; i ++){
				grid = new MahjongBalanceGrid();
				this._mahjongRalance.resultCont.addElement(grid);
				grid.show(result[i], 150 + i*50, 150);
//				grid.show(result[i], 67 + i*52, 42);
				
				total[0] += result[i].azimuth1;
				total[1] += result[i].azimuth2;
				total[2] += result[i].azimuth3;
				total[3] += result[i].azimuth4;
			}
			grid = null;
			return total;
		}
		
		/**
		 * 显示输赢 
		 * @param result
		 * 
		 */
		private function showShuying(result:Array):void{
			this._mahjongRalance.shuying1.text = result[0].toFixed(2);
			this._mahjongRalance.shuying2.text = result[1].toFixed(2);
			this._mahjongRalance.shuying3.text = result[2].toFixed(2);
			this._mahjongRalance.shuying4.text = result[3].toFixed(2);
			
		}
		
		/**
		 * 显示公点 
		 * @param result
		 * @return 
		 * 
		 */
		private function showGongdian(result:Array):Array{
			var gongdian:Array = [0, 0, 0, 0];
			gongdian[0] = result[0] > 0 ? result[0] * 0.05 : 0;
			gongdian[1] = result[1] > 0 ? result[1] * 0.05 : 0;
			gongdian[2] = result[2] > 0 ? result[2] * 0.05 : 0;
			gongdian[3] = result[3] > 0 ? result[3] * 0.05 : 0;
			
			
//			this._mahjongRalance.gongdian1.text = gongdian[0].toFixed(2);
//			this._mahjongRalance.gongdian2.text = gongdian[1].toFixed(2);
//			this._mahjongRalance.gongdian3.text = gongdian[2].toFixed(2);
//			this._mahjongRalance.gongdian4.text = gongdian[3].toFixed(2);
			
			return gongdian;
		}
		
		/**
		 * 显示最终结果 
		 * @param result
		 * @param gongdian
		 * @return 
		 * 
		 */
		private function showZongji(result:Array, gongdian:Array):Array{
			var zongji:Array = [0, 0, 0, 0];
			zongji[0] = result[0] - gongdian[0];
			zongji[1] = result[1] - gongdian[1];
			zongji[2] = result[2] - gongdian[2];
			zongji[3] = result[3] - gongdian[3];
			
//			this._mahjongRalance.zongji1.text = zongji[0].toFixed(2);
//			this._mahjongRalance.zongji2.text = zongji[1].toFixed(2);
//			this._mahjongRalance.zongji3.text = zongji[2].toFixed(2);
//			this._mahjongRalance.zongji4.text = zongji[3].toFixed(2);
			
			return zongji;
		}
		
		/**
		 * 清理结果 
		 * 
		 */
		private function clearResult():void{
			this._mahjongRalance.roomNum.text = "";
			
			this._mahjongRalance.player1.text = "";
			this._mahjongRalance.player2.text = "";
			this._mahjongRalance.player3.text = "";
			this._mahjongRalance.player4.text = "";
			
//			this._mahjongRalance.zongji1.text = "";
//			this._mahjongRalance.zongji2.text = "";
//			this._mahjongRalance.zongji3.text = "";
//			this._mahjongRalance.zongji4.text = "";
//			
//			this._mahjongRalance.gongdian1.text = "";
//			this._mahjongRalance.gongdian2.text = "";
//			this._mahjongRalance.gongdian3.text = "";
//			this._mahjongRalance.gongdian4.text = "";
			
			this._mahjongRalance.shuying1.text = "";
			this._mahjongRalance.shuying2.text = "";
			this._mahjongRalance.shuying3.text = "";
			this._mahjongRalance.shuying4.text = "";
			
			var grid:MahjongBalanceGrid;
			for(var i:int = 0; i < this._mahjongRalance.resultCont.numElements; i ++){
				if(this._mahjongRalance.resultCont.getElementAt(i) is MahjongBalanceGrid){
					grid = MahjongBalanceGrid(this._mahjongRalance.resultCont.removeElementAt(i));
					grid.clear();
					
					i --;
				}
			}
			grid = null;
		}
		
		/**
		 * 设置玩家名 
		 * @param playerNames
		 * 
		 */
		public function setPlayerName(playerNames:Array):void{
			if(playerNames.length>4){
				playerNames.shift();
			}
			if(playerNames){
				for(var i:int = 0; i < playerNames.length; i ++){
					switch(i){
						case 0:
							this._mahjongRalance.player1.text = this._mahjongRalanceService.subPlayerName(playerNames[i]);
							break;
						case 1:
							this._mahjongRalance.player2.text = this._mahjongRalanceService.subPlayerName(playerNames[i]);
							break;
						case 2:
							this._mahjongRalance.player3.text = this._mahjongRalanceService.subPlayerName(playerNames[i]);
							break;
						case 3:
							this._mahjongRalance.player4.text = this._mahjongRalanceService.subPlayerName(playerNames[i]);
							break;
					}
				}
			}
		}
		
		public function show(roomNum:Number, result:Array, playerNames:Array):void{
			
			if(MahjongRoomControl.instance.isVideo){
				MahjongRoomControl.instance._mahjongRoom.jiesuanOperation.visible = false;
			}
			
			
			this._mahjongRalance.roomNum.text = roomNum.toString();
			this.setPlayerName(playerNames);
			if(result){
				var total:Array = showResult(result);
				showShuying(total);
				var gongdian:Array = showGongdian(total);
				var zongji:Array = showZongji(total, gongdian);
				if(!MahjongRoomControl.instance.isVideo){
					this._mahjongRalanceService.updataPlayerMoney(zongji);
				}
			}
			
			
			if(!MahjongRoomControl.instance.isVideo){
				
				if(MahjongRoomControl.instance.isNetwork){
					MainPlayerService.getInstance().mainPlayer.haveMoney += total[i];
					this._mahjongRalance.nandu.visible = false;
					this._mahjongRalance.nanduL.visible = false;
					this._mahjongRalance.jifen.visible = false;
					this._mahjongRalance.jifenL.visible = false;
					
				}else{
					var gg:Number = 0;
					for(var i:int=0;i<4;i++){
						if(playerNames[i] == "player"){
							gg = total[i]*0.01*MahjongSyncService.instance.level;
							//						Alert.show(gg.toString());
							try{
								GameCenterService.instance.changeScore(gg);
							}catch(e:Error){
								
							}
						}
					}
					
					this._mahjongRalance.nandu.text = (MahjongSyncService.instance.level*0.01).toString();
					this._mahjongRalance.jifen.text = gg.toString();
				}
				
			}
			
			if(MahjongRoomControl.instance.isVideo){
//				this._mahjongRalance.continueBtn.visible = false;
//				this._mahjongRalance.exitBtn.visible = false;
			}else{
//				this._mahjongRalance.continueBtn.visible = true;
//				this._mahjongRalance.exitBtn.visible = true;
			}
			this._mahjongRalance.resultCont.visible = true;
			this._mahjongRalance.visible = true;
		}
		
		public function hide():void{
			this._mahjongRalance.visible = false;
			this._mahjongRalance.resultCont.visible = true;
//			this._mahjongRalance.continueBtn.visible = true;
//			this._mahjongRalance.exitBtn.visible = true;
			clearResult();
		}
		
		//-------------------------------------------------------------------
		public static function get instance():MahjongBalanceControl
		{
			return _instance;
		}
	}
}