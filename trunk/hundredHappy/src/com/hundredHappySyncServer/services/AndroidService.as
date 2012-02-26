package com.hundredHappySyncServer.services
{
	public class AndroidService extends PlayerService
	{
		private var zdT:int = 0;
		private var xdT:int = 0; 
		private var zT:int = 0;
		private var xT:int = 0; 
		private var hT:int = 0;
		private var bool:Boolean = true;
		private var randow1:int = 0;
		private var randow2:int = 0;
		private var num:Number = 0;
		private var bl:Boolean = true;
		private var ranNum:int = 0;
		public function AndroidService()
		{
			this.player.haveMoney = Math.random()*100 + ((Math.random()*10)>6?0:1)*20000 + ((Math.random()*10)>7?0:1)*40000;
		}
		
		private function calBet():void{
			zdT = 0;
			xdT = 0; 
			zT = 0;
			xT = 0; 
			hT = 0;
			
			if((Math.random() * 10) > 8){
				if((Math.random() * 10) > 5){
					zdT = int(Math.random() * 3)*100;
				}else{
					xdT = int(Math.random() * 3)*100;
				}
			}
			
			//当自己的钱的多少选择一个合适的投住金额
			if(this.player.haveMoney > 10000){
				if((Math.random() * 10) > 3){
					if((Math.random() * 10) > 5){
						//						zT = (Math.random() * 10)*50 + ((Math.random() * 10)>3?0:1)*500 + ((Math.random() * 10)>3?0:1)*500;
						//						if(zT>500){
						//							zT = Math.round(zT/500)*500;
						//						}
						zT = int(Math.random() * 10) * 100;
					}else{
						//						xT = (Math.random() * 10)*50 + ((Math.random() * 10)>3?0:1)*500 + ((Math.random() * 10)>3?0:1)*500;
						//						if(xT>500){
						//							xT = Math.round(xT/500)*500;
						//						}
						xT = int(Math.random() * 10) * 100;
					}
				}
			}else if((this.player.haveMoney <= 10000) && (this.player.haveMoney > 5000)){
				if((Math.random() * 10) > 3){
					if((Math.random() * 10) > 5){
						//						zT = (Math.random() * 10)*50 + ((Math.random() * 10)>3?0:1)*500 + ((Math.random() * 10)>3?0:1)*500;
						//						if(zT>500){
						//							zT = Math.round(zT/500)*500;
						//						}
						zT = int(Math.random() * 10) * 100;
					}else{
						//						xT = (Math.random() * 10)*50 + ((Math.random() * 10)>3?0:1)*500 + ((Math.random() * 10)>3?0:1)*500;
						//						if(xT>500){
						//							xT = Math.round(xT/500)*500;
						//						}
						xT = int(Math.random() * 10) * 100;
					}
				}
			}else if((this.player.haveMoney <= 5000) && (this.player.haveMoney > 2000)){
				if((Math.random() * 10) > 3){
					if((Math.random() * 10) > 5){
						//						zT = (Math.random() * 10)*50 + ((Math.random() * 10)>3?0:1)*500 + ((Math.random() * 10)>3?0:1)*500;
						//						if(zT>500){
						//							zT = Math.round(zT/500)*500;
						//						}
						zT = int(Math.random() * 10) * 100;
					}else{
						//						xT = (Math.random() * 10)*50 + ((Math.random() * 10)>3?0:1)*500 + ((Math.random() * 10)>3?0:1)*500;
						//						if(xT>500){
						//							xT = Math.round(xT/500)*500;
						//						}
						xT = int(Math.random() * 10) * 100;
					}
				}
			}else{
				if((Math.random() * 10) > 3){
					if((Math.random() * 10) > 5){
						//						zT = (Math.random() * 10)*50 + ((Math.random() * 10)>3?0:1)*500 + ((Math.random() * 10)>3?0:1)*500;
						//						if(zT>500){
						//							zT = Math.round(zT/500)*500;
						//						}
						zT = int(Math.random() * 10) * 100;
					}else{
						//						xT = (Math.random() * 10)*50 + ((Math.random() * 10)>3?0:1)*500 + ((Math.random() * 10)>3?0:1)*500;
						//						if(xT>500){
						//							xT = Math.round(xT/500)*500;
						//						}
						xT = int(Math.random() * 10) * 100;
					}
				}
			}
			
			
			if((Math.random() * 10) > 8){
				hT = int(Math.random() * 3)*100;
			}
			
		}
		
		public override function countDown(num:int):void {
			//如果房间为洗牌状态，则退出游戏 2011-11-3 s
			if(this.subRoomService.roomService.room.roomType == 2){
				this.subRoomService.roomService.exitRoom(this.player.playerName);
				return;
			}
			
			if(bool){
				randow1 = 32 + (Math.random() * 10);
				randow2 = 5 + (Math.random() * 25);
				bool = false;
			}
			if(num == randow1){
				if((Math.random() * 10) > 8){
					this.subRoomService.roomService.exitRoom(this.player.playerName);
					var roomService:RoomService = GameHallService.instance.getRoomServiceByRoomNo("00"+(int(Math.random()*4)+1));
					roomService.enterRoom(this);
				}
			}
			
			if(num == randow2){
				calBet(); //随机投住
				this.subRoomService.playerBetting(player.playerName, zdT, xdT, zT, xT, hT);
				
				//更新及时彩池
				this.subRoomService.roomService.allPlayerBetting();
			}
			
			if(num == 44){
				bool = true;
				
				
				//虚拟充值后 重新进房间，更新前台显示
				if(this.player.haveMoney < (100+Math.random()*400)){
					this.player.haveMoney = Math.round(Math.random() * 50)*1000;
				}
				
				this.subRoomService.roomService.exitRoom(this.player.playerName);
				var roomService:RoomService = GameHallService.instance.getRoomServiceByRoomNo("00"+(int(Math.random()*4)+1));
				roomService.enterRoom(this);
			}
		}
		
		public override function roomTimer(roomNo:String, timer:int):void {
			if(bl){
				bl = false;
				ranNum = 1200+Math.random()*7200;
			}
			
			//------------------------------------------
			num++;
			if(num == ranNum){
				num = 0;
				// g 2011-6-23 14:45 添加百家乐机器人的关闭    为false 表示为打开，  为true 表示为关闭
//				if(!GameHallService.instance.gameHall.getIsCloseAndroid()){
					//如果机器人被锁定，则直接退出游戏 2011-11-3 s
//					if(remoteService.getUserService().islock(this.player.getPlayerName())){
//						this.getSubRoomService().getRoomService().exitRoom(this.getPlayer().getPlayerName());
//					}else{
						if((Math.random() * 10) > 4){
							//如果在游戏中就退出游戏，或者就再随机进入一个游戏房间
							if(this.player.game){
								this.subRoomService.roomService.exitRoom(this.player.playerName);
							}else{
								var roomService:RoomService = GameHallService.instance.getRoomServiceByRoomNo("00"+(int(Math.random()*4)+1));
								roomService.enterRoom(this);
							}
							
						}
//					}
					
//				}else{
//					this.getSubRoomService().getRoomService().exitRoom(this.getPlayer().getPlayerName());
//				}
			}
		}
	}
}