package com.amusement.HundredHappy.services
{
	import com.amusement.HundredHappy.model.HundredHappyPlayer;
	import com.service.PlayerService;

	public class HundredHappyPlayerService
	{
		private var _hundredHappyPlayer:HundredHappyPlayer;
		
		public function HundredHappyPlayerService()
		{
			_hundredHappyPlayer = new HundredHappyPlayer();
		}
		
		public function playerEnter(authz:int, playerName:String, currentPoint:Number):void{
			this._hundredHappyPlayer.authz = authz;
			this._hundredHappyPlayer.acctName = playerName;
			this._hundredHappyPlayer.playerName = subPlayerName(playerName);
			this._hundredHappyPlayer.currentPoint = currentPoint;
		}
		
		public function playerLeave():void{
			clearTou();
			
			this._hundredHappyPlayer.playerName = "";
			this._hundredHappyPlayer.currentPoint = 0;
		}
		
		public function getPlayerBetTotal():Number{
			var total:Number = this._hundredHappyPlayer.zhuangduiT 
				+ this._hundredHappyPlayer.xianduiT 
				+ this._hundredHappyPlayer.zhuangT 
				+ this._hundredHappyPlayer.xianT 
				+ this._hundredHappyPlayer.heT;
			return total
		}
		
		public function getCurrentBetTotal():Number{
			var total:Number = this._hundredHappyPlayer.zhuangduiC
				+ this._hundredHappyPlayer.xianduiC
				+ this._hundredHappyPlayer.zhuangC
				+ this._hundredHappyPlayer.xianC
				+ this._hundredHappyPlayer.heC;
			return total
		}
		
		public function updateBet(value:int, type:String):Boolean{
			var isAboveMax:Boolean = false;
			
			var total:Number = this._hundredHappyPlayer.zhuangduiC 
				+ this._hundredHappyPlayer.xianduiC 
				+ this._hundredHappyPlayer.zhuangC 
				+ this._hundredHappyPlayer.xianC 
				+ this._hundredHappyPlayer.heC 
				+ value;
			if(total > this._hundredHappyPlayer.currentPoint){
				//余额不足
				DeskPanelService.instance.updatePrompt("yebz");
				isAboveMax = true;
			}else{
				switch(type){
					case "zd":
						total = this._hundredHappyPlayer.zhuangduiT + this._hundredHappyPlayer.zhuangduiC + value;
						if(total > DeskPanelService.instance.maxBet * 0.2){
							isAboveMax = true;
						}else{
							this._hundredHappyPlayer.zhuangduiC += value;
						}
						break;
					case "xd":
						total = this._hundredHappyPlayer.xianduiT + this._hundredHappyPlayer.xianduiC + value;
						if(total > DeskPanelService.instance.maxBet * 0.2){
							isAboveMax = true;
						}else{
							this._hundredHappyPlayer.xianduiC += value;
						}
						break;
					case "z":
						total = this._hundredHappyPlayer.zhuangT + this._hundredHappyPlayer.zhuangC + value;
						if(total > DeskPanelService.instance.maxBet){
							isAboveMax = true;
						}else{
							this._hundredHappyPlayer.zhuangC += value;
						}
						break;
					case "x":
						total = this._hundredHappyPlayer.xianT + this._hundredHappyPlayer.xianC + value;
						if(total > DeskPanelService.instance.maxBet){
							isAboveMax = true;
						}else{
							this._hundredHappyPlayer.xianC += value;
						}
						break;
					case "h":
						total = this._hundredHappyPlayer.heT + this._hundredHappyPlayer.heC + value;
						if(total > DeskPanelService.instance.maxBet * 0.2){
							isAboveMax = true;
						}else{
							this._hundredHappyPlayer.heC += value;
						}
						break;		
				}
				
				if(isAboveMax){
					DeskPanelService.instance.updatePrompt("gysx");
				}else{
					BettingPanelService.instance.updateSmallJettons(type, this._hundredHappyPlayer.authz, total);
				}
			}
			return !isAboveMax;
		}
		
		public function updateTou(zhuangduiT:Number, xianduiT:Number, zhuangT:Number, xianT:Number, heT:Number, currentPoint:Number):void{
			this._hundredHappyPlayer.zhuangduiT = zhuangduiT;
			BettingPanelService.instance.updateSmallJettons("zd", this._hundredHappyPlayer.authz, zhuangduiT);
			
			this._hundredHappyPlayer.xianduiT = xianduiT;
			BettingPanelService.instance.updateSmallJettons("xd", this._hundredHappyPlayer.authz, xianduiT);
			
			this._hundredHappyPlayer.zhuangT = zhuangT;
			BettingPanelService.instance.updateSmallJettons("z", this._hundredHappyPlayer.authz, zhuangT);
			
			this._hundredHappyPlayer.xianT = xianT;
			BettingPanelService.instance.updateSmallJettons("x", this._hundredHappyPlayer.authz, xianT);
			
			this._hundredHappyPlayer.heT = heT;
			BettingPanelService.instance.updateSmallJettons("h", this._hundredHappyPlayer.authz, heT);
			
			this._hundredHappyPlayer.currentPoint = currentPoint;
		}
		
		public function restoreLastTou():void{
			BettingPanelService.instance.updateSmallJettons("zd", this._hundredHappyPlayer.authz, this._hundredHappyPlayer.zhuangduiT);
			BettingPanelService.instance.updateSmallJettons("xd", this._hundredHappyPlayer.authz, this._hundredHappyPlayer.xianduiT);
			BettingPanelService.instance.updateSmallJettons("z", this._hundredHappyPlayer.authz, this._hundredHappyPlayer.zhuangT);
			BettingPanelService.instance.updateSmallJettons("x", this._hundredHappyPlayer.authz, this._hundredHappyPlayer.xianT);
			BettingPanelService.instance.updateSmallJettons("h", this._hundredHappyPlayer.authz, this._hundredHappyPlayer.heT);
		}
		
		public function clearBetCurrent():void{
			clearTouC();
			updateBet(0 , "zd");
			updateBet(0 , "xd");
			updateBet(0 , "z");
			updateBet(0 , "x");
			updateBet(0 , "h");
		}
		
		public function clearTou():void{
			clearTouT();
			clearBetCurrent();
		}
		
		public function clearTouC():void{
			this._hundredHappyPlayer.zhuangduiC = 0;
			this._hundredHappyPlayer.xianduiC = 0;
			this._hundredHappyPlayer.zhuangC = 0;
			this._hundredHappyPlayer.xianC = 0;
			this._hundredHappyPlayer.heC = 0;
		}
		
		private function clearTouT():void{
			this._hundredHappyPlayer.zhuangduiT = 0;
			this._hundredHappyPlayer.xianduiT = 0;
			this._hundredHappyPlayer.zhuangT = 0;
			this._hundredHappyPlayer.xianT = 0;
			this._hundredHappyPlayer.heT = 0;
		}
		
		public function checkBelowMin():Boolean{
			var isBelowMin:Boolean = false;
			
			if(this._hundredHappyPlayer.zhuangC > 0 && this._hundredHappyPlayer.zhuangT + this._hundredHappyPlayer.zhuangC < DeskPanelService.instance.minBet 
				|| this._hundredHappyPlayer.xianC > 0 && this._hundredHappyPlayer.xianT + this._hundredHappyPlayer.xianC < DeskPanelService.instance.minBet){
				isBelowMin = true;
			}
			
			return isBelowMin;
		}
		
		//12-02-02 隱藏其他玩家名
		private function subPlayerName(playerName:String):String{
			if(playerName != PlayerService.instance.player.acctName){
				playerName = playerName.substr(0,2) + "****";
			}
			return playerName;
		}

		//------------------------------------------------------------------
		public function get hundredHappyPlayer():HundredHappyPlayer
		{
			return _hundredHappyPlayer;
		}
	}
}