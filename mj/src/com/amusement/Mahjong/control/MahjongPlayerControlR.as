package com.amusement.Mahjong.control
{
	import com.amusement.Mahjong.model.Mahjong;
	import com.amusement.Mahjong.service.MahjongPlayerServiceR;
	import com.amusement.Mahjong.view.MahjongPlayer;
	import com.control.MainControl;

	public class MahjongPlayerControlR extends MahjongPlayerControl
	{
		private static var _instance:MahjongPlayerControlR;
		
		public function MahjongPlayerControlR(mahjongPlayer:MahjongPlayer)
		{
			_instance = this;
			this._mahjongPlayerService = new MahjongPlayerServiceR();
			super(mahjongPlayer);
		}

		protected override function initView():void
		{
			//TODO Auto-generated method stub
			super.initView();
			
			this._mahjongPlayer.setElementIndex(this._mahjongPlayer.sp, 0);
			this._mahjongPlayer.setElementIndex(this._mahjongPlayer.out, 2);
			
			this._mahjongPlayer.out.x = 25;
			this._mahjongPlayer.out.y = 30;
			this._mahjongPlayer.out.width = 88;
			this._mahjongPlayer.out.height = 280;
			
			this._mahjongPlayer.pd.x = 20;
			this._mahjongPlayer.pd.y = 18;
			this._mahjongPlayer.pd.width = 44;
			this._mahjongPlayer.pd.height = 375;
			
			this._mahjongPlayer.sp.x = 140;
			this._mahjongPlayer.sp.y = 15;
			this._mahjongPlayer.sp.width = 44;
			this._mahjongPlayer.sp.height = 420;
			
			this._mahjongPlayer.dSort.setSize("H");
			this._mahjongPlayer.dSort.x = this._mahjongPlayer.out.x  + 43;
			this._mahjongPlayer.dSort.y = this._mahjongPlayer.out.y + this._mahjongPlayer.out.height;
			
			this._mahjongPlayer.hSort.x = 200;
			this._mahjongPlayer.hSort.y = 214;
//			this._mahjongPlayer.hSort.x = 201.5;
//			this._mahjongPlayer.hSort.y = 237.2;
		}
		
		public override function reconstruct(player:Object):void
		{
			//TODO Auto-generated method stub
			var px:int = this._mahjongPlayer.out.x + this._mahjongPlayer.out.width/2;
			var py:int = this._mahjongPlayer.out.y + this._mahjongPlayer.out.height - 28;
			super.reconstructDingzhang(player.dingzhangValue, player.isPutDingzhang, px, py, "H");
			
			super.reconstructOprr(player.oprrValues);
			
			px = this._mahjongPlayer.sp.x;
			py = this._mahjongPlayer.sp.y - 38;
			super.reconstructHu(player.huValue, px, py, "Dimg90", 4, player.playerAzimuthR, player.haveHuCount);
			
			super.reconstructSprr(player.sprrValues, player.sprrLength, "90");
			super.reconstructPprrAndGprr(player.pprrValues, player.gprrValues);
			
		}
		
		public override function sortMahjong(mahjong:Mahjong, index:int, count:int):void
		{
			//TODO Auto-generated method stub
			var px:int = this._mahjongPlayer.pd.x;
			var py:int = this._mahjongPlayer.pd.y;
			
			_addx = 0;
			_pc = 0;
			
			if (count % 2 != 0)
			{
				_pc -= 6;
			}
			mahjong.y = py + _addy - _pc;
			if (count % 2 != 0)
			{
				if(MainControl.instance.main.applicationDPI == 160 || MainControl.instance.main.applicationDPI == 320){
					_addy += 27;
				}else{
					_addy += 22;
				}
				
				mahjong.setFilter("HimgB");
				
			}
			
			mahjong.x = px;
			mahjong.show("Himg");
			
			super.sortMahjong(mahjong,index,count);
		}
		
		public override function dingzhangV(dingzhangValue:int):void
		{
			//TODO Auto-generated method stub
			var px:int = this._mahjongPlayer.out.x + this._mahjongPlayer.out.width - this._mahjongPlayer.dSort.width -10;
			var py:int = this._mahjongPlayer.out.y + this._mahjongPlayer.out.height + 10;
			
			super.dingzhang(dingzhangValue, px, py, "H");
		}
		
		public override function getOneMahjongV(mahjong:Mahjong):void
		{
			//TODO Auto-generated method stub
			var px:int = this._mahjongPlayer.sp.x;
			var py:int = this._mahjongPlayer.sp.y - 29;
			
			var bmpName:String = "Simg90";
			if(MahjongRoomControl.instance.isVideo){
				bmpName = "Dimg90";
			}
			
			super.getOneMahjong(mahjong, px, py, bmpName);
			
			orderIndex(this._mahjongPlayerService.getSprr(), 1);
		}
		
		public override function putOneMahjongV(putOneMahjongValue:int, isPutDingzhang:Boolean = false):Mahjong
		{
			
			//TODO Auto-generated method stub
			var outLength:int = this._mahjongPlayerService.getOprr().length;
			var px:int = this._mahjongPlayer.out.x + int(outLength < 9) * 43;
			var py:int = this._mahjongPlayer.out.y + this._mahjongPlayer.out.height - (outLength + 1) * 28 + int(outLength > 8) * this._mahjongPlayer.out.height;
			
			var signX:int = px + 12;
			var signY:int = py + 16 - 50;
			
			var mahjong:Mahjong = super.putOneMahjong(putOneMahjongValue, px, py, "90", signX, signY, isPutDingzhang);
			
			this._mahjongPlayer.setElementIndex(this._mahjongPlayer.dSort, this._mahjongPlayer.getElementIndex(mahjong));
			
			orderIndex(this._mahjongPlayerService.getOprr(), 1);
	
			return mahjong;
		}
		
		public override function gangV(mahjong:Mahjong, isZigang:Boolean):void
		{
			//TODO Auto-generated method stub
			super.gang(mahjong, isZigang, 0)
		}
		
		public override function huV(mahjong:Mahjong, huType:int, haveHuCount:int, qiangGangAzimuth:int = 0):void
		{
			//TODO Auto-generated method stub
			var px:int = this._mahjongPlayer.sp.x;
			var py:int = this._mahjongPlayer.sp.y - 38;
			
			super.hu(mahjong, px, py, "Dimg90", 4, huType, haveHuCount, qiangGangAzimuth);
			orderIndex(this._mahjongPlayerService.getSprr(), 1);
		}
		
		public override function cutV():void{
			super.cut("Dimg90");
		}
		
		//-----------------------------------------------------------------
		protected override function orderForDispenseMahjongs(mahjongs:Array):void{
			var bmpName:String = "Simg90";
			if(MahjongRoomControl.instance.isVideo){
				bmpName = "Dimg90";
			}
			
			for (var i:int=0; i < mahjongs.length; i ++)
			{
//				this._mahjongPlayer.addElementAt(mahjongs[i], mahjongs.length - 1 - i); 
				this._mahjongPlayer.addElementAt(mahjongs[i], 0); 
				
				mahjongs[i].show(bmpName);
				mahjongs[i].x = this._mahjongPlayer.sp.x;
				
				if(MainControl.instance.main.applicationDPI == 160 || MainControl.instance.main.applicationDPI == 320){
					mahjongs[i].y = this._mahjongPlayer.sp.y + (13 - (i + 1)) * 33;
				}else{
					mahjongs[i].y = this._mahjongPlayer.sp.y + (13 - (i + 1)) * 25;
				}
				
			}
		}
		
		protected override function orderSp(isPeng:Boolean=false):void
		{
			//TODO Auto-generated method stub
			var sparr:Array = this._mahjongPlayerService.getSprr();
			
			if(isPeng){
				sparr[sparr.length - 1].x = this._mahjongPlayer.sp.x;
				sparr[sparr.length - 1].y = this._mahjongPlayer.sp.y - 35;
				this._mahjongPlayer.setElementIndex(sparr[sparr.length - 1], 0);
				
				for (var j:int=0; j < sparr.length - 1; j++)
				{
					sparr[j].x = this._mahjongPlayer.sp.x;
					
					if(MainControl.instance.main.applicationDPI == 160 || MainControl.instance.main.applicationDPI == 320){
						sparr[j].y = this._mahjongPlayer.sp.y + (sparr.length - 1) * 33 - ((j + 1) * 33);
					}else{
						sparr[j].y = this._mahjongPlayer.sp.y + (sparr.length - 1) * 25 - ((j + 1) * 25);
					}
					
					this._mahjongPlayer.setElementIndex(sparr[j], sparr.length - 1 - j);
				}
			}else{
				for (var i:int=0; i < sparr.length; i++)
				{
					sparr[i].x = this._mahjongPlayer.sp.x;
					
					if(MainControl.instance.main.applicationDPI == 160 || MainControl.instance.main.applicationDPI == 320){
						sparr[i].y = this._mahjongPlayer.sp.y + sparr.length * 33 - ((i + 1) * 33);
					}else{
						sparr[i].y = this._mahjongPlayer.sp.y + sparr.length * 25 - ((i + 1) * 25);
					}
					
					this._mahjongPlayer.setElementIndex(sparr[i], sparr.length - 1 - i);
				}
			}
		}
		
		protected override function orderGpAndPp():void
		{
			//TODO Auto-generated method stub
			var gprr:Array = this._mahjongPlayerService.getGprr();
			var pprr:Array = this._mahjongPlayerService.getPprr();
			
			for(var i:int = 0; i < gprr.length; i ++){
				if(gprr[i].isGangBack){
					gprr[i].show("Himg");
				}else{
					gprr[i].show("Dimg90");
				}
				
				if(i % 4 == 0){
					gprr[i].x = this._mahjongPlayer.sp.x;
					
					if(MainControl.instance.main.applicationDPI == 160 || MainControl.instance.main.applicationDPI == 320){
						gprr[i].y = this._mahjongPlayer.sp.y + this._mahjongPlayer.sp.height - int(i / 4) * (3* 28 + 3) - 2*28 - 9;
					}else{
						gprr[i].y = -100 + this._mahjongPlayer.sp.y + this._mahjongPlayer.sp.height - int(i / 4) * (3* 22 + 3) - 2*22 - 9;
					}
					
				}else{
					gprr[i].x = this._mahjongPlayer.sp.x;
					
					if(MainControl.instance.main.applicationDPI == 160 || MainControl.instance.main.applicationDPI == 320){
						gprr[i].y = this._mahjongPlayer.sp.y + this._mahjongPlayer.sp.height - (i - int(i / 4)) * 28 - int(i / 4) * 3;
					}else{
						gprr[i].y = -100 + this._mahjongPlayer.sp.y + this._mahjongPlayer.sp.height - (i - int(i / 4)) * 22 - int(i / 4) * 3;
					}
					
				}
			}
			
			for(var j:int = 0; j < pprr.length; j ++){
				pprr[j].show("Dimg90");
				
				pprr[j].x = this._mahjongPlayer.sp.x;
				
				if(MainControl.instance.main.applicationDPI == 160 || MainControl.instance.main.applicationDPI == 320){
					pprr[j].y = this._mahjongPlayer.sp.y + this._mahjongPlayer.sp.height - (gprr.length / 4) * (3 * 28 + 3) - ((j + 1) * 28) - int(j / 3) * 3;
				}else{
					pprr[j].y = -100 + this._mahjongPlayer.sp.y + this._mahjongPlayer.sp.height - (gprr.length / 4) * (3 * 22 + 3) - ((j + 1) * 22) - int(j / 3) * 3;
				}
				
			} 
			
			var arr:Array=gprr.concat(pprr);
			var sprrLength:int = this._mahjongPlayerService.getSprr().length;
			for (var n:int=0; n < arr.length; n ++){
				this._mahjongPlayer.setElementIndex(arr[n], sprrLength + arr.length - 1 - n);
			}  
		}
		
		protected override function orderOp():void{
			var oparr:Array = this._mahjongPlayerService.getOprr();
			
			for(var i:int = 0; i < oparr.length; i ++){
				oparr[i].show("Dimg90");
				oparr[i].x = this._mahjongPlayer.out.x + int(i < 11) * 44;
				oparr[i].y = this._mahjongPlayer.out.y + this._mahjongPlayer.out.height - (i + 1) * 28 + int(i > 10) * this._mahjongPlayer.out.height;
				this._mahjongPlayer.setElementIndex(oparr[i], oparr.length - i);
			}
		}

		//--------------------- getter/setter -------------------------
		public static function get instance():MahjongPlayerControlR
		{
			return _instance;
		}


	}
}