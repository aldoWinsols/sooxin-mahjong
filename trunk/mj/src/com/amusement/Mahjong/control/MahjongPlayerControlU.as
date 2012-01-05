package com.amusement.Mahjong.control
{
	import com.amusement.Mahjong.model.Mahjong;
	import com.amusement.Mahjong.service.MahjongPlayerServiceU;
	import com.amusement.Mahjong.view.MahjongPlayer;
	import com.control.MainControl;

	public class MahjongPlayerControlU extends MahjongPlayerControl
	{
		private static var _instance:MahjongPlayerControlU;
		
		public function MahjongPlayerControlU(mahjongPlayer:MahjongPlayer)
		{
			_instance = this;
			this._mahjongPlayerService = new MahjongPlayerServiceU();
			super(mahjongPlayer);
		}

		protected override function initView():void
		{
			//TODO Auto-generated method stub
			super.initView();
			
			this._mahjongPlayer.setElementIndex(this._mahjongPlayer.sp, 0);
			this._mahjongPlayer.setElementIndex(this._mahjongPlayer.out, 2);
			
			this._mahjongPlayer.out.x = -30;
			this._mahjongPlayer.out.y = 68;
			this._mahjongPlayer.out.width = 352;
			this._mahjongPlayer.out.height = 88;
			
			this._mahjongPlayer.pd.x = 0;
			this._mahjongPlayer.pd.y = 30;
			this._mahjongPlayer.pd.width = 462;
			this._mahjongPlayer.pd.height = 50;
			
			this._mahjongPlayer.sp.x = 0;
			this._mahjongPlayer.sp.y = 0;
			this._mahjongPlayer.sp.width = 429;
			this._mahjongPlayer.sp.height = 50;
			
			this._mahjongPlayer.dSort.setSize("V");
			this._mahjongPlayer.dSort.x = this._mahjongPlayer.out.x + this._mahjongPlayer.out.width;
			this._mahjongPlayer.dSort.y = this._mahjongPlayer.out.y;
			
			this._mahjongPlayer.hSort.x = 150;
			this._mahjongPlayer.hSort.y = -25;
//			this._mahjongPlayer.hSort.x = 201.1;
//			this._mahjongPlayer.hSort.y = -39.2;
		}
		
		public override function reconstruct(player:Object):void
		{
			//TODO Auto-generated method stub
			var px:int = this._mahjongPlayer.out.x + this._mahjongPlayer.out.width - 31;
			var py:int = this._mahjongPlayer.out.y;
			super.reconstructDingzhang(player.dingzhangValue, player.isPutDingzhang, px, py, "V");
			
			super.reconstructOprr(player.oprrValues);
			super.reconstructSprr(player.sprrValues, player.sprrLength, "0");
			super.reconstructPprrAndGprr(player.pprrValues, player.gprrValues);
			
			px = this._mahjongPlayer.sp.x - 38;
			py = this._mahjongPlayer.sp.y;
			super.reconstructHu(player.huValue, px, py, "Dimg0", 1, player.playerAzimuthR, player.haveHuCount);
			
		}

		public override function sortMahjong(mahjong:Mahjong, index:int, count:int):void
		{
			//TODO Auto-generated method stub
			var px:int = this._mahjongPlayer.pd.x;
			var py:int = this._mahjongPlayer.pd.y;
			
			_addy = 0;
			
			mahjong.x = px + _addx;
			
			
			if(MainControl.instance.main.applicationDPI == 160 || MainControl.instance.main.applicationDPI == 320){
				if (count % 2 == 0)
				{
					_addy -= 7;
				}else{
					_addx += 32;
					mahjong.setFilter("VimgB");
				}
			}else{
				if (count % 2 == 0)
				{
					_addy -= 7;
				}else{
					_addx += 26;
					mahjong.setFilter("VimgB");
				}
			}
			
			
			mahjong.y = py + _addy;
			mahjong.show("Vimg");
			
			super.sortMahjong(mahjong, index, count);
		}
		
		public override function dingzhangV(dingzhangValue:int):void
		{
			//TODO Auto-generated method stub
			var px:int = this._mahjongPlayer.out.x + this._mahjongPlayer.out.width - 25;
			var py:int = this._mahjongPlayer.out.y;
			
			super.dingzhang(dingzhangValue, px, py, "V");
		}
		
		public override function getOneMahjongV(mahjong:Mahjong):void
		{
			//TODO Auto-generated method stub
			var px:int = this._mahjongPlayer.sp.x - 60;
			var py:int = this._mahjongPlayer.sp.y;
			
			var bmpName:String = "Simg0";
			if(MahjongRoomControl.instance.isVideo){
				bmpName = "Dimg0";
			}
			
			super.getOneMahjong(mahjong, px, py, bmpName);
		}
		
		public override function putOneMahjongV(putOneMahjongValue:int, isPutDingzhang:Boolean = false):Mahjong
		{
			//TODO Auto-generated method stub
			var outLength:int = this._mahjongPlayerService.getOprr().length;
			var px:int = this._mahjongPlayer.out.x + this._mahjongPlayer.out.width - (outLength + 1) * 32 + int(outLength > 9) * this._mahjongPlayer.out.width;
			var py:int = this._mahjongPlayer.out.y + (int(outLength > 9) * 40);
			
			var signX:int = px + 6; 
			var signY:int = py - 32;
			
			var mahjong:Mahjong = super.putOneMahjong(putOneMahjongValue, px, py, "0", signX, signY, isPutDingzhang);
			orderIndex(this._mahjongPlayerService.getOprr());
			return mahjong;
		}
		
		public override function huV(mahjong:Mahjong, huType:int, haveHuCount:int, qiangGangAzimuth:int = 0):void
		{
			//TODO Auto-generated method stub
			var px:int = this._mahjongPlayer.sp.x - 60;
			var py:int = this._mahjongPlayer.sp.y;
			
			super.hu(mahjong, px, py, "Dimg0", 1, huType, haveHuCount, qiangGangAzimuth);
		}
		
		public override function cutV():void{
			super.cut("Dimg0");
		}
		
		//-----------------------------------------------------------------
		protected override function orderForDispenseMahjongs(mahjongs:Array):void{
			var bmpName:String = "Simg0";
			if(MahjongRoomControl.instance.isVideo){
				bmpName = "Dimg0";
			}
			
			for (var i:int=0; i < mahjongs.length; i++)
			{
				mahjongs[i].show(bmpName);
				mahjongs[i].x = -20 + this._mahjongPlayer.sp.x + (13 - (i + 1)) * 33;
				mahjongs[i].y = this._mahjongPlayer.sp.y;
				
				this._mahjongPlayer.addElement(mahjongs[i]);
			}
		}
		
		protected override function orderSp(isPeng:Boolean=false):void
		{
			//TODO Auto-generated method stub
			var sparr:Array = this._mahjongPlayerService.getSprr();
			
			if(isPeng){
				sparr[sparr.length - 1].x = this._mahjongPlayer.sp.x - 33;
				sparr[sparr.length - 1].y = this._mahjongPlayer.sp.y;
				
				for (var j:int=0; j < sparr.length - 1; j++)
				{
					sparr[j].x = -20 + this._mahjongPlayer.sp.x + (sparr.length - 1) * 33 - ((j + 1) * 33);
					sparr[j].y = this._mahjongPlayer.sp.y;
				}
			}else{
				for (var i:int=0; i < sparr.length; i++)
				{
					sparr[i].x = -20 + this._mahjongPlayer.sp.x + sparr.length * 33 - ((i + 1) * 33);
					sparr[i].y = this._mahjongPlayer.sp.y;
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
					gprr[i].show("Vimg");
				}else{
					gprr[i].show("Dimg0");
				}
				
				if(i % 4 == 3){
					gprr[i].x = gprr[i-2].x;
					gprr[i].y = gprr[i-2].y - 10;
				}else{
					gprr[i].x = -50 + this._mahjongPlayer.sp.x + this._mahjongPlayer.sp.width - (i - int(i / 4)) * 32 - int(i / 4) * 5;
					gprr[i].y = this._mahjongPlayer.sp.y;
				}
			}
			
			for(var j:int = 0; j < pprr.length; j ++){
				pprr[j].show("Dimg0");
				
				pprr[j].x = -50 +  this._mahjongPlayer.sp.x + this._mahjongPlayer.sp.width - (gprr.length / 4) * (3 * 32 + 5) - (j * 32) - int(j / 3) * 5;
				pprr[j].y = this._mahjongPlayer.sp.y;
			}
			
			var arr:Array = gprr.concat(pprr);
			for (var n:int=0; n < arr.length; n++){
				this._mahjongPlayer.setElementIndex(arr[n], n);
			}
		}
		
		protected override function orderOp():void{
			var oparr:Array = this._mahjongPlayerService.getOprr();
			
			for(var i:int = 0; i < oparr.length; i ++){
				oparr[i].show("Dimg0");
				oparr[i].x = this._mahjongPlayer.out.x + this._mahjongPlayer.out.width - (i + 1) * 33 + int(i > 12) * this._mahjongPlayer.out.width;
				oparr[i].y = this._mahjongPlayer.out.y + (int(i > 12) * 40);
			}
		}

		//--------------------- getter/setter -------------------------
		public static function get instance():MahjongPlayerControlU
		{
			return _instance;
		}


	}
}