package com.amusement.Mahjong.control
{
	import com.amusement.Mahjong.model.Mahjong;
	import com.amusement.Mahjong.service.MahjongPlayerServiceL;
	import com.amusement.Mahjong.view.MahjongPlayer;
	import com.control.MainControl;

	public class MahjongPlayerControlL extends MahjongPlayerControl
	{
		private static var _instance:MahjongPlayerControlL;
		
		public function MahjongPlayerControlL(mahjongPlayer:MahjongPlayer)
		{
			_instance = this;
			this._mahjongPlayerService = new MahjongPlayerServiceL();
			super(mahjongPlayer);
		}

		protected override function initView():void
		{
			//TODO Auto-generated method stub
			super.initView();
			
			this._mahjongPlayer.out.x = 60;
			this._mahjongPlayer.out.y = 85;
			this._mahjongPlayer.out.width = 88;
			this._mahjongPlayer.out.height = 280;
			
			this._mahjongPlayer.pd.x = 40;
			this._mahjongPlayer.pd.y = -20;
			this._mahjongPlayer.pd.width = 44;
			this._mahjongPlayer.pd.height = 375;
			
			this._mahjongPlayer.sp.x = -10;
			this._mahjongPlayer.sp.y = -105;
			this._mahjongPlayer.sp.width = 44;
			this._mahjongPlayer.sp.height = 420;
			
			this._mahjongPlayer.dSort.setSize("H");
			this._mahjongPlayer.dSort.x = this._mahjongPlayer.out.x;
			this._mahjongPlayer.dSort.y = this._mahjongPlayer.out.y - this._mahjongPlayer.dSort.height +2;
			
			if(MainControl.instance.main.applicationDPI == 160 || MainControl.instance.main.applicationDPI == 320){
				this._mahjongPlayer.hSort.x = -74;
				this._mahjongPlayer.hSort.y = 185;
			}else{
				this._mahjongPlayer.hSort.x = -100;
				this._mahjongPlayer.hSort.y = -100;
			}
			
//			this._mahjongPlayer.hSort.x = -68;
//			this._mahjongPlayer.hSort.y = 278.15;
		}
		
		public override function reconstruct(player:Object):void
		{
			//TODO Auto-generated method stub
			var px:int = this._mahjongPlayer.out.x;
			var py:int = this._mahjongPlayer.out.y;
			super.reconstructDingzhang(player.dingzhangValue, player.isPutDingzhang, px, py, "H");
			
			super.reconstructOprr(player.oprrValues);
			super.reconstructSprr(player.sprrValues, player.sprrLength, "270");
			super.reconstructPprrAndGprr(player.pprrValues, player.gprrValues);
			
			px = this._mahjongPlayer.sp.x + 1;
			py = this._mahjongPlayer.sp.y + this._mahjongPlayer.sp.height + 8;
			super.reconstructHu(player.huValue, px, py, "Dimg270", 2, player.playerAzimuthR, player.haveHuCount);
		}

		public override function sortMahjong(mahjong:Mahjong, index:int, count:int):void
		{
			//TODO Auto-generated method stub
			var px:int = this._mahjongPlayer.pd.x;
			var py:int = this._mahjongPlayer.pd.y + this._mahjongPlayer.pd.height - 22;
			
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
					_addy -= 27;
				}else{
					_addy -= 22;
				}
				
				mahjong.setFilter("HimgB");
				
			}
			
			mahjong.x = px;
			mahjong.show("Himg");
			
			if(index % 2 != 0){
				index -= 1;
			}
			
			super.sortMahjong(mahjong,index% 2,count);
//			this._mahjongPlayer.addElementAt(mahjong, index % 2);
		}
		
		public override function dingzhangV(dingzhangValue:int):void
		{
			//TODO Auto-generated method stub
			var px:int = this._mahjongPlayer.out.x;
			var py:int = this._mahjongPlayer.out.y;
			
			super.dingzhang(dingzhangValue, px, py, "H");
		}
		
		public override function getOneMahjongV(mahjong:Mahjong):void
		{
			//TODO Auto-generated method stub
			var px:int = this._mahjongPlayer.sp.x + 1;
			var py:int = this._mahjongPlayer.sp.y + this._mahjongPlayer.sp.height + 8;
			
			var bmpName:String = "Simg270";
			if(MahjongRoomControl.instance.isVideo){
				bmpName = "Dimg270";
			}
			
			super.getOneMahjong(mahjong, px, py, bmpName);
			
			orderIndex(this._mahjongPlayerService.getSprr());
		}
		
		public override function putOneMahjongV(putOneMahjongValue:int, isPutDingzhang:Boolean = false):Mahjong
		{
			var outLength:int = this._mahjongPlayerService.getOprr().length;
			var px:int = this._mahjongPlayer.out.x + int(outLength > 8) * 43;
			var py:int = this._mahjongPlayer.out.y + (outLength * 28) - int(outLength > 8) * this._mahjongPlayer.out.height;
			
			var signX:int = px + 12;
			var signY:int = py + 16 - 50;
			
			//TODO Auto-generated method stub
			var mahjong:Mahjong = super.putOneMahjong(putOneMahjongValue, px, py, "270", signX, signY, isPutDingzhang);
			orderIndex(this._mahjongPlayerService.getOprr());
			return mahjong;
		}
		
		public override function huV(mahjong:Mahjong, huType:int, haveHuCount:int, qiangGangAzimuth:int = 0):void
		{
			//TODO Auto-generated method stub
			var px:int = this._mahjongPlayer.sp.x + 1;
			var py:int = this._mahjongPlayer.sp.y + this._mahjongPlayer.sp.height + 8;
			
			super.hu(mahjong, px, py, "Dimg270", 2, huType, haveHuCount, qiangGangAzimuth);
			
			orderIndex(this._mahjongPlayerService.getSprr());
		}
		
		public override function cutV():void{
			super.cut("Dimg270");
		}
		
		//-----------------------------------------------------------------
		protected override function orderForDispenseMahjongs(mahjongs:Array):void{
			var bmpName:String = "Simg270";
			if(MahjongRoomControl.instance.isVideo){
				bmpName = "Dimg270";
			}
			for (var i:int=0; i < mahjongs.length; i ++)
			{
				this._mahjongPlayer.addElementAt(mahjongs[i], i); 
				
				mahjongs[i].show(bmpName);
				mahjongs[i].x = this._mahjongPlayer.sp.x;
				
				if(MainControl.instance.main.applicationDPI == 160 || MainControl.instance.main.applicationDPI == 320){
					mahjongs[i].y = this._mahjongPlayer.sp.y + this._mahjongPlayer.sp.height - (13 - i) * 33;
				}else{
					mahjongs[i].y = this._mahjongPlayer.sp.y + this._mahjongPlayer.sp.height - (13 - i) * 25;
				}
				
			}
		}
		
		protected override function orderSp(isPeng:Boolean=false):void
		{
			//TODO Auto-generated method stub
			var sparr:Array = this._mahjongPlayerService.getSprr();
			
			if(isPeng){
				sparr[sparr.length - 1].x = this._mahjongPlayer.sp.x + 1;
				sparr[sparr.length - 1].y = this._mahjongPlayer.sp.y + this._mahjongPlayer.sp.height + 8;
				this._mahjongPlayer.setElementIndex(sparr[sparr.length - 1], sparr.length - 1);
				
				for (var j:int=0; j < sparr.length - 1; j++)
				{
					sparr[j].x = this._mahjongPlayer.sp.x;
					
					if(MainControl.instance.main.applicationDPI == 160 || MainControl.instance.main.applicationDPI == 320){
						sparr[j].y = this._mahjongPlayer.sp.y + this._mahjongPlayer.sp.height - (sparr.length - 1) * 33 + (j * 33);
					}else{
						sparr[j].y = this._mahjongPlayer.sp.y + this._mahjongPlayer.sp.height - (sparr.length - 1) * 25 + (j * 25);
					}
					
					this._mahjongPlayer.setElementIndex(sparr[j], j); 
				}
			}else{
				for (var i:int=0; i < sparr.length; i++)
				{
					sparr[i].x = this._mahjongPlayer.sp.x;
					
					if(MainControl.instance.main.applicationDPI == 160 || MainControl.instance.main.applicationDPI == 320){
						sparr[i].y = this._mahjongPlayer.sp.y + this._mahjongPlayer.sp.height - sparr.length * 33 + (i * 33);
					}else{
						sparr[i].y = this._mahjongPlayer.sp.y + this._mahjongPlayer.sp.height - sparr.length * 25 + (i * 25);
					}
					
					this._mahjongPlayer.setElementIndex(sparr[i], i); 
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
					gprr[i].show("Dimg270");
				}
				
				
				if(i % 4 == 3){
					gprr[i].x = gprr[i-2].x;
					gprr[i].y = gprr[i-2].y - 9;
				}else{
					gprr[i].x = this._mahjongPlayer.sp.x;
					
					if(MainControl.instance.main.applicationDPI == 160 || MainControl.instance.main.applicationDPI == 320){
						gprr[i].y = this._mahjongPlayer.sp.y + (i - int(i / 4)) * 22 + int(i / 4) * 3;
					}else{
						gprr[i].y = 95+this._mahjongPlayer.sp.y + (i - int(i / 4)) * 28 + int(i / 4) * 3;	
					}
					
				}
			}
			
			for(var j:int = 0; j < pprr.length; j ++){
				pprr[j].show("Dimg270");
				
				pprr[j].x = this._mahjongPlayer.sp.x;
				
				if(MainControl.instance.main.applicationDPI == 160 || MainControl.instance.main.applicationDPI == 320){
					pprr[j].y = this._mahjongPlayer.sp.y + (gprr.length / 4) * (3 * 28 + 3) + (j * 28) + int(j / 3) * 3;
				}else{
					pprr[j].y = 95+this._mahjongPlayer.sp.y + (gprr.length / 4) * (3 * 22 + 3) + (j * 22) + int(j / 3) * 3;
				}
				
			}
			
			var arr:Array=gprr.concat(pprr);
			for (var n:int = 0; n < arr.length; n++){
				this._mahjongPlayer.setElementIndex(arr[n], n);
			}
		}
		
		protected override function orderOp():void{
			var oparr:Array = this._mahjongPlayerService.getOprr();
			
			for(var i:int = 0; i < oparr.length; i ++){
				oparr[i].show("Dimg270");
				oparr[i].x = this._mahjongPlayer.out.x + int(i > 10) * 44;
				oparr[i].y = this._mahjongPlayer.out.y + (i * 28) - int(i > 10) * this._mahjongPlayer.out.height;
			}
		}
		

		//--------------------- getter/setter -------------------------
		public static function get instance():MahjongPlayerControlL
		{
			return _instance;
		}


	}
}