package com.amusement.Mahjong.control
{
	import com.amusement.Mahjong.model.Mahjong;
	import com.amusement.Mahjong.service.MahjongPlayerServiceD;
	import com.amusement.Mahjong.view.MahjongPlayer;
	import com.control.MainControl;

	public class MahjongPlayerControlD extends MahjongPlayerControl
	{
		private static var _instance:MahjongPlayerControlD;
		
		public function MahjongPlayerControlD(mahjongPlayer:MahjongPlayer)
		{
			_instance = this;
			this._mahjongPlayerService = new MahjongPlayerServiceD();
			super(mahjongPlayer);
		}

		protected override function initView():void
		{
			//TODO Auto-generated method stub
			super.initView();
			
			this._mahjongPlayer.out.x = 190;
			this._mahjongPlayer.out.y = 72;
			this._mahjongPlayer.out.width = 352;
			this._mahjongPlayer.out.height = 88;
			
			this._mahjongPlayer.pd.x = 25;
			this._mahjongPlayer.pd.y = 60;
			this._mahjongPlayer.pd.width = 462;
			this._mahjongPlayer.pd.height = 50;
			
			this._mahjongPlayer.sp.x = -70;
			this._mahjongPlayer.sp.y = 183.65;
			this._mahjongPlayer.sp.width = 680;
			this._mahjongPlayer.sp.height = 90;
			
			this._mahjongPlayer.dSort.setSize("V");
			this._mahjongPlayer.dSort.x = this._mahjongPlayer.out.x - this._mahjongPlayer.dSort.width - 7;
			this._mahjongPlayer.dSort.y = this._mahjongPlayer.out.y + 40/*this._mahjongPlayer.out.height - this._mahjongPlayer.dSort.height*/;
			
			if(MainControl.instance.main.applicationDPI == 320){
				this._mahjongPlayer.hSort.x = 348;
				this._mahjongPlayer.hSort.y = 280;
			}else if(MainControl.instance.main.applicationDPI == 160){
				this._mahjongPlayer.hSort.x = 320;
				this._mahjongPlayer.hSort.y = 300;
			}else{
				this._mahjongPlayer.hSort.x = -100;
				this._mahjongPlayer.hSort.y = -100;
			}
			
//			this._mahjongPlayer.hSort.x = 389.95;
//			this._mahjongPlayer.hSort.y = 275.25;
		}
		
		public override function reconstruct(player:Object):void
		{
			//TODO Auto-generated method stub
			var px:int = this._mahjongPlayer.out.x;
			var py:int = this._mahjongPlayer.out.y + 40/*this._mahjongPlayer.out.height/2*/;
			super.reconstructDingzhang(player.dingzhangValue, player.isPutDingzhang, px, py, "V");
			
			super.reconstructOprr(player.oprrValues);
			super.reconstructSprr(player.sprrValues, player.sprrLength, "180");
			super.reconstructPprrAndGprr(player.pprrValues, player.gprrValues);
			
			px = this._mahjongPlayer.sp.x + this._mahjongPlayer.sp.width + 10;
			py = this._mahjongPlayer.sp.y;
			super.reconstructHu(player.huValue, px, py, "Pimg180", 3, player.playerAzimuthR, player.haveHuCount);
		}
		
		public override function sortMahjong(mahjong:Mahjong, index:int, count:int):void
		{
			//TODO Auto-generated method stub
			var px:int = this._mahjongPlayer.pd.x + 429;
			var py:int = this._mahjongPlayer.pd.y;
			
			
			_addy = 0;
			
			mahjong.x = px + _addx;
			
			if(MainControl.instance.main.applicationDPI == 160 || MainControl.instance.main.applicationDPI == 320){
				if(count % 2 == 0){
					_addy -= 7;
				}else{
					_addx -= 32;
					mahjong.setFilter("VimgB");
				}
			}else{
				if(count % 2 == 0){
					_addy -= 7;
				}else{
					_addx -= 26;
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
			var px:int = this._mahjongPlayer.dSort.x;
			var py:int = this._mahjongPlayer.dSort.y;
			
			super.dingzhang(dingzhangValue, px, py, "V");
		}
		
		public override function getOneMahjongV(mahjong:Mahjong):void
		{
			//TODO Auto-generated method stub
			var px:int = this._mahjongPlayer.sp.x + this._mahjongPlayer.sp.width + 5;
			var py:int = this._mahjongPlayer.sp.y;
			
			super.getOneMahjong(mahjong, px, py, "Simg180");
		}
		
		public override function putOneMahjongV(putOneMahjongValue:int, isPutDingzhang:Boolean = false):Mahjong
		{
			//TODO Auto-generated method stub
			var outLength:int = this._mahjongPlayerService.getOprr().length;
			var px:int = this._mahjongPlayer.out.x + outLength * 32 - (int(outLength > 9) * this._mahjongPlayer.out.width);
			var py:int = this._mahjongPlayer.out.y + (int(outLength < 10) * 40);
			
			var signX:int = px + 6;
			var signY:int = py - 32;
			
			var mahjong:Mahjong = super.putOneMahjong(putOneMahjongValue, px, py, "180", signX, signY, isPutDingzhang);
			orderIndex1(this._mahjongPlayerService.getOprr(), 1);
			
			for(var i:int = 0; i < this._mahjongPlayerService.getSprr().length; i ++){
				(this._mahjongPlayerService.getSprr()[i] as Mahjong).BigSP.visible = false;
			}
			mahjong.BigSP.visible = false;
			return mahjong;
		}
		
		public function orderIndex1(arr:Array, sortord:int = 0):void{
			for (var i:int=0; i < arr.length; i++)
			{
				this._mahjongPlayer.setElementIndex(arr[i], 0); 
			}
		}
		
		public override function huV(mahjong:Mahjong, huType:int, haveHuCount:int, qiangGangAzimuth:int = 0):void
		{
			//TODO Auto-generated method stub
			var px:int = this._mahjongPlayer.sp.x + this._mahjongPlayer.sp.width + 10;
			var py:int = this._mahjongPlayer.sp.y;
			
			super.hu(mahjong, px, py, "Pimg180", 3, huType, haveHuCount, qiangGangAzimuth);
		}
		
		//--------------------------------------------------------------------------------
		/**
		 * 代替定章 
		 * 
		 */
		public function replaceDingzhang():void{
			this._mahjongPlayerService.replaceDingzhang();
		}
		
		/**
		 * 代替打定章 
		 * 
		 */
		public function replacePutDingzhang():void{
			this._mahjongPlayerService.replacePutDingzhang();
		}
		
		/**
		 * 代替打牌 
		 * 
		 */
		public function replacePutMahjong():void{
			this._mahjongPlayerService.replacePutMahjong();
		}
		
		//------------------------------------------------------------
		public function checkQuemenMine():Array{
			return this._mahjongPlayerService.checkQuemen();
		}
		
		public function checkPutMahjongLegally(mahjongValue:int):Boolean{
			return this._mahjongPlayerService.checkPutMahjongLegally(mahjongValue);
		}
		
		public function checkHuMine():Boolean{
			return this._mahjongPlayerService.checkHu();
		}
		
		public function checkGangMine(mahjongsNum:int):Array{
			return this._mahjongPlayerService.checkGang(mahjongsNum);
		}
		
		//-----------------------------------------------------------------
		protected override function orderForDispenseMahjongs(mahjongs:Array):void{
			for (var i:int=0; i < mahjongs.length; i ++)
			{
				this._mahjongPlayer.addElement(mahjongs[i]);
				
				mahjongs[i].show("Simg180");
				mahjongs[i].x = this._mahjongPlayer.sp.x + this._mahjongPlayer.sp.width - (13 - i) * 44;
				mahjongs[i].y = this._mahjongPlayer.sp.y;
			}
		}
		
		protected override function orderSp(isPeng:Boolean=false):void
		{
			//TODO Auto-generated method stub
			MahjongRoomControl.instance.selectMahjong = null;
			
			var sparr:Array = this._mahjongPlayerService.getSprr();
			
			if(isPeng){
				sparr[sparr.length - 1].x = this._mahjongPlayer.sp.x + this._mahjongPlayer.sp.width + 10;
				sparr[sparr.length - 1].y = this._mahjongPlayer.sp.y;
				
				for(var j:int = 0; j < sparr.length - 1; j ++){
					sparr[j].x = this._mahjongPlayer.sp.x + this._mahjongPlayer.sp.width - (sparr.length - 1 - j) * 44;
					sparr[j].y = this._mahjongPlayer.sp.y;
				}
			}else{
				for(var i:int = 0; i < sparr.length; i ++){
					sparr[i].x = this._mahjongPlayer.sp.x + this._mahjongPlayer.sp.width - (sparr.length - i) * 44;
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
					gprr[i].show("PBackImg");	
				}else{
					gprr[i].show("Pimg180");	
				}
				
				if(i % 4 == 3){
					gprr[i].x = gprr[i-2].x;
					gprr[i].y = gprr[i-2].y - 18;
				}else{
					gprr[i].x = 95 +this._mahjongPlayer.sp.x + (i - int(i / 4)) * 42 + int(i / 4) * 5;
					gprr[i].y = this._mahjongPlayer.sp.y;
				}
			}
			
			for(var j:int = 0; j < pprr.length; j ++){
				pprr[j].show("Pimg180");
				
				pprr[j].x = 95 +this._mahjongPlayer.sp.x + (gprr.length / 4) * (3 * 42 + 5) + (j * 42) + int(j / 3) * 5;
				pprr[j].y = this._mahjongPlayer.sp.y;
			}
			
			var arr:Array=gprr.concat(pprr);
			for (var n:int = 0; n < arr.length; n++){
				this._mahjongPlayer.setElementIndex(arr[n], n);
			}
		}
		
		protected override function orderOp():void{
			var oparr:Array = this._mahjongPlayerService.getOprr();
			
			for(var i:int = 0; i < oparr.length; i ++){
				oparr[i].show("Dimg180");
				oparr[i].x = this._mahjongPlayer.out.x + i * 33 - (int(i > 12) * this._mahjongPlayer.out.width);
				oparr[i].y = this._mahjongPlayer.out.y + (int(i < 13) * 40);
				this._mahjongPlayer.setElementIndex(oparr[i], oparr.length - i);
			}
		}
		
		//--------------------- getter/setter -------------------------
		public static function get instance():MahjongPlayerControlD
		{
			return _instance;
		}


	}
}