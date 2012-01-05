package com.amusement.Mahjong.control
{
	import com.amusement.Mahjong.Interface.IMahjongPlayerControl;
	import com.amusement.Mahjong.model.Mahjong;
	import com.amusement.Mahjong.service.MahjongPlayerService;
	import com.amusement.Mahjong.service.MahjongPoolService;
	import com.amusement.Mahjong.view.MahjongPlayer;
	import com.amusement.Mahjong.view.MahjongSign;
	
	import spark.components.Group;
	
	public class MahjongPlayerControl implements IMahjongPlayerControl
	{
		public var _mahjongPlayer:MahjongPlayer;
		protected var _mahjongPlayerService:MahjongPlayerService;
		
		protected var _addx:int;
		protected var _addy:int;
		protected var _pc:int;
		
		protected var _state:int = 0;//游戏所处阶段：0--未定章  1--已定章但未翻牌  2--缺门  3--已显示定章类型（已翻定章）  4--胡
		
		private var _mahjongValues:Array;
		
		public function MahjongPlayerControl(mahjongPlayer:MahjongPlayer)
		{
			//TODO: implement function
			this._mahjongPlayer = mahjongPlayer;
			
			init();
		}

		protected function init():void{
			_state = 0;
			
			initView();
		}
		
		/**
		 * 初始化界面 
		 * 
		 */
		protected function initView():void{
			this._mahjongPlayer.hSort.visible = false;
		}
		
		public function reset():void{
			this._mahjongPlayerService.dealReset();
			
			_state = 0;
			
			if(_mahjongValues){
				_mahjongValues.splice(0, _mahjongValues.length);
			}
			
			_addx = 0;
			_addy = 0;
			_pc = 0;
			
//			this._mahjongPlayer.hSort.text = "";
			this._mahjongPlayer.hSort.sortTxt.text = "";
			this._mahjongPlayer.hSort.visible = false;
			
			this._mahjongPlayer.dSort.hide();
			
			var mahjong:Mahjong;
			for(var i:int = 0; i < this._mahjongPlayer.numElements; i ++){
				mahjong = this._mahjongPlayer.getElementAt(i) as Mahjong;
				if(mahjong){
					mahjong.isGangBack = false;
					this._mahjongPlayer.removeElement(mahjong);
					i --;
				}
			}
			mahjong = null;
		}
		
		/**
		 * 重构牌局 
		 * @param player
		 * 
		 */
		public function reconstruct(player:Object):void{
		}
		
		/**
		 * 码牌 
		 * @param mahjong
		 * @param index
		 * @param count
		 * 
		 */
		public function sortMahjong(mahjong:Mahjong, index:int, count:int):void
		{
			//TODO Auto-generated method stub
			if(index % 2 != 0){
				index -= 1;
			}
			this._mahjongPlayer.pd.addElementAt(mahjong, index);
		}
		
		/**
		 * 发牌 
		 * @param mahjongs
		 * 
		 */
		public function dispenseMahjong(mahjongs:Array):void{
			//TODO Auto-generated method stub
			var mahjongs:Array= this._mahjongPlayerService.dealDispenseMahjong(mahjongs);
			orderForDispenseMahjongs(mahjongs);
		}
		
		/**
		 * 定章 
		 * @param dingzhangValue
		 * @param px
		 * @param py
		 * @param bmpName
		 * 
		 */
		public function dingzhang(dingzhangValue:int, px:int, py:int, bmpName:String):void{
			//TODO Auto-generated method stub
			var mahjong:Mahjong = this._mahjongPlayerService.dealDingzhang(dingzhangValue);
			if(mahjong){
				this._mahjongPlayer.addElement(mahjong);
				
				mahjong.show(bmpName + "img");
				mahjong.x = px;
				mahjong.y = py;
				_state = 1;
			}else if(dingzhangValue == 0 || dingzhangValue == 10 || dingzhangValue == 20){
				this._mahjongPlayer.dSort.show("que" + bmpName);
				_state = 2;
			}
			
			var spLength:int = this._mahjongPlayerService.getSprr().length;
			if(spLength > 13){
				orderSp(true);
			}else{
				orderSp();
			}
			
		}
		
		/**
		 * 摸牌 
		 * @param mahjong
		 * @param px
		 * @param py
		 * @param bmpName
		 * 
		 */
		public function getOneMahjong(mahjong:Mahjong, px:int, py:int, bmpName:String):void
		{
			//TODO Auto-generated method stub
			this._mahjongPlayerService.dealGetOneMahjong(mahjong);
			mahjong.x = px;
			mahjong.y = py;
			mahjong.show(bmpName);
			this._mahjongPlayer.addElement(mahjong);
		}
		
		/**
		 * 出牌 
		 * @param putOneMahjongValue
		 * @param px
		 * @param py
		 * @param bmpName
		 * @param signX
		 * @param signY
		 * @param isPutDingzhang
		 * @return 
		 * 
		 */
		public function putOneMahjong(putOneMahjongValue:int, px:int, py:int, bmpName:String, signX:int, signY:int, isPutDingzhang:Boolean = false):Mahjong
		{
			//TODO Auto-generated method stub
			var mahjong:Mahjong = this._mahjongPlayerService.dealPutOneMahong(putOneMahjongValue, isPutDingzhang);
			if(mahjong){
				this._mahjongPlayer.addElement(mahjong);
				
				mahjong.show("Dimg" + bmpName);
				mahjong.x = px;
				mahjong.y = py;
				
				MahjongSignControl.instance.show(this._mahjongPlayer.x + signX, this._mahjongPlayer.y + signY);
				
				if(_state == 1 || _state == 2){
					this._mahjongPlayer.dSort.show(this._mahjongPlayerService.getDpTypeName() + bmpName);
					_state = 3;
				}
				
				orderSp();
			}
			return mahjong;
		}
		
		/**
		 * 碰 
		 * @param mahjong
		 * 
		 */
		public function peng(mahjong:Mahjong):void
		{
			//TODO Auto-generated method stub
			var mahjongs:Array = this._mahjongPlayerService.dealPeng(mahjong);
			for each(var mahjong:Mahjong in mahjongs){
				this._mahjongPlayer.addElement(mahjong);
			}
			
			orderSp(true);
			orderGpAndPp();
		}
		
		/**
		 * 杠 
		 * @param mahjong
		 * @param isZigang
		 * @param backIndex
		 * 
		 */
		public function gang(mahjong:Mahjong, isZigang:Boolean, backIndex:int = 3):void
		{
			//TODO Auto-generated method stub
			var mahjongs:Array = this._mahjongPlayerService.dealGang(mahjong, isZigang, backIndex);
			for each(var mahjong:Mahjong in mahjongs){
				this._mahjongPlayer.addElement(mahjong);
			}
			
			orderSp();
			orderGpAndPp();
		}
		
		/**
		 * 胡 
		 * @param mahjong
		 * @param px
		 * @param py
		 * @param bmpName
		 * @param azimuth
		 * @param huType
		 * @param haveHuCount
		 * @param qiangGangAzimuth
		 * 
		 */
		public function hu(mahjong:Mahjong, px:int, py:int, bmpName:String, azimuth:int, huType:int, haveHuCount:int, qiangGangAzimuth:int = 0):void
		{
			//TODO Auto-generated method stub
			this._mahjongPlayerService.dealHu(mahjong);
			
			if(haveHuCount > 1){
				mahjong.drawShade(azimuth);
			}
			mahjong.x = px;
			mahjong.y = py;
			mahjong.show(bmpName);
			this._mahjongPlayer.addElement(mahjong);
			
			this._state = 4;
			
			this._mahjongPlayer.hSort.visible = true;
			switch(huType){
				case 0:
//					this._mahjongPlayer.hSort.text = this._mahjongPlayerService.getPlayerAzimuthName(MahjongRoomControl.instance.nowPutPlayerAzimuth) + "點炮";
					this._mahjongPlayer.hSort.sortTxt.text = this._mahjongPlayerService.getPlayerAzimuthName(MahjongRoomControl.instance.nowPutPlayerAzimuth) + "點炮";
					break;
				case 1:
//					this._mahjongPlayer.hSort.text = "自摸";
					this._mahjongPlayer.hSort.sortTxt.text = "自摸";
					break;
				case 2:
//					this._mahjongPlayer.hSort.text = this._mahjongPlayerService.getPlayerAzimuthName(qiangGangAzimuth) + "點炮";
					this._mahjongPlayer.hSort.sortTxt.text = this._mahjongPlayerService.getPlayerAzimuthName(qiangGangAzimuth) + "點炮";
					break;
			}
		}
		
		/**
		 * 倒牌 
		 * @param bmpName
		 * 
		 */
		public function cut(bmpName:String):void{
			this._mahjongPlayerService.dealCut(_mahjongValues);
			
			var sprr:Array = _mahjongPlayerService.getSprr();
			for each(var mahjong:Mahjong in sprr){
				mahjong.show(bmpName);
				this._mahjongPlayer.addElement(mahjong);
			}
			orderSp();
		}

		//--------------------------------------------------
		public function dingzhangV(dingzhangValue:int):void{
			//TODO Auto-generated method stub
		}
		
		public function getOneMahjongV(mahjong:Mahjong):void
		{
			//TODO Auto-generated method stub
		}
		
		public function putOneMahjongV(putOneMahjongValue:int, isPutDingzhang:Boolean = false):Mahjong
		{
			//TODO Auto-generated method stub
			return null;
		}

		public function pengV(mahjong:Mahjong):void
		{
			//TODO Auto-generated method stub
			this.peng(mahjong);
		}
		public function gangV(mahjong:Mahjong, isZigang:Boolean):void
		{
			//TODO Auto-generated method stub
			this.gang(mahjong, isZigang);
		}
		
		public function huV(mahjong:Mahjong, huType:int, haveHuCount:int, qiangGangAzimuth:int = 0):void
		{
			//TODO Auto-generated method stub
		}
		
		public function cutV():void{
			//TODO Auto-generated method stub
		}
		
		//-----------------------------------------------------------------------------------------------
		/**
		 * 重构定章 
		 * @param dingzhangValue
		 * @param isPutDingzhang
		 * @param px
		 * @param py
		 * @param bmpName
		 * 
		 */
		protected function reconstructDingzhang(dingzhangValue:int, isPutDingzhang:Boolean, px:int, py:int, bmpName:String):void{
			if(isPutDingzhang){
				_state = 3;
			}else if(dingzhangValue == 0 || dingzhangValue == 10 || dingzhangValue == 20){
				_state = 2;
			}else if(dingzhangValue > 0){
				_state = 1;
			}
			
			var dp:Mahjong = this._mahjongPlayerService.reconstructDingzhang(dingzhangValue, _state);
			switch(_state){
				case 1:
					if(dp){
						dp.x = px;
						dp.y = py;
						dp.show(bmpName + "img");
						this._mahjongPlayer.addElement(dp);
					}
					break;
				case 2:
					this._mahjongPlayer.dSort.show("que" + bmpName);
					break;
				case 3:
					this._mahjongPlayer.dSort.show(this._mahjongPlayerService.getDpTypeName() + bmpName);
					break;
			}
		}
		
		/**
		 * 重构出牌 
		 * @param oprrValues
		 * @param sortord
		 * 
		 */
		protected function reconstructOprr(oprrValues:Array):void{
			var oprr:Array = this._mahjongPlayerService.reconstructOprr(oprrValues);
			for each(var mahjong:Mahjong in oprr){
				this._mahjongPlayer.addElement(mahjong);
			}
			orderOp();
		}
		
		/**
		 * 重构手牌 
		 * @param sprrValues
		 * @param sprrLength
		 * 
		 */
		protected function reconstructSprr(sprrValues:Array, sprrLength:int, bmpName:String):void{
			var sprr:Array = this._mahjongPlayerService.reconstructSprr(sprrValues, sprrLength, _state);
			for each(var mahjong:Mahjong in sprr){
				mahjong.show("Simg" + bmpName);
				this._mahjongPlayer.addElement(mahjong);
			}
			if(sprrLength == 14 || sprrLength == 11 || sprrLength == 8 || sprrLength == 5 || sprrLength == 2){
				orderSp(true);
			}else{
				orderSp()
			}
		}
		
		/**
		 * 重构碰牌和杠牌 
		 * @param pprrValues
		 * @param gprrValues
		 * 
		 */
		protected function reconstructPprrAndGprr(pprrValues:Array, gprrValues:Array):void{
			var mahjong:Mahjong;
			
			var pprr:Array = this._mahjongPlayerService.reconstructPprr(pprrValues);
			for each(mahjong in pprr){
				this._mahjongPlayer.addElement(mahjong);
			}
			
			var gprr:Array = this._mahjongPlayerService.reconstructGprr(gprrValues);
			for each(mahjong in gprr){
				this._mahjongPlayer.addElement(mahjong);
			}
			
			orderGpAndPp();
		}
		
		/**
		 * 重构胡牌 
		 * @param huValue
		 * @param px
		 * @param py
		 * @param bmpName
		 * @param azimuth
		 * @param isZimo
		 * @param playerAzimuthR
		 * @param haveHuCount
		 * 
		 */
		protected function reconstructHu(huValue:int, px:int, py:int, bmpName:String, azimuth:int, playerAzimuthR:int = 0, haveHuCount:int = 0):void{
			var hp:Mahjong = this._mahjongPlayerService.reconstructHu(huValue, playerAzimuthR, haveHuCount);
			if(hp){
				_state = 4;
				
				hp.x = px;
				hp.y = py;
				hp.show(bmpName);
				if(haveHuCount > 1){
					hp.drawShade(azimuth);
				}
				this._mahjongPlayer.addElement(hp);
				
				this._mahjongPlayer.hSort.visible = true;
				if(playerAzimuthR == 0){
//					this._mahjongPlayer.hSort.text = "自摸";
					this._mahjongPlayer.hSort.sortTxt.text = "自摸";
				}else{
//					this._mahjongPlayer.hSort.text = this._mahjongPlayerService.getPlayerAzimuthName(playerAzimuthR) + "點炮";
					this._mahjongPlayer.hSort.sortTxt.text = this._mahjongPlayerService.getPlayerAzimuthName(playerAzimuthR) + "點炮";
				}
			}
		}
		
		//----------------------------------------------------------------------------------------------
		public function popOutMahjong(mahjongValue:int):Mahjong{
			return this._mahjongPlayerService.popOprr(mahjongValue);
		}
		
		public function getMahjongBySp(mahjongValue:int):Mahjong{
			return this._mahjongPlayerService.getMahjongBySprr(mahjongValue);
		}
		
		public function restoreMahjongsByGpAndPp(mahjongValue:int):Mahjong{
			var mahjong:Mahjong = this._mahjongPlayerService.restoreGprrAndPprr(mahjongValue);
			orderGpAndPp();
			return mahjong;
		}
		
		public function getSpLength():int{
			return this._mahjongPlayerService.getSprr().length;
		}
		
		public function getLastOutMahjong():Mahjong{
			var oprr:Array = this._mahjongPlayerService.getOprr();
			return oprr[oprr.length - 1];
		}
		//-------------------------------------------------
		protected function orderIndex(arr:Array, sortord:int = 0):void
		{
			if (arr.length > 1)
			{	
				switch(sortord){
					case 0:
						for (var i:int = arr.length-2; i > -1; i --){
							if(this._mahjongPlayer.getElementIndex(arr[arr.length - 1]) < this._mahjongPlayer.getElementIndex(arr[i])){
								this._mahjongPlayer.setElementIndex(arr[arr.length - 1], this._mahjongPlayer.getElementIndex(arr[i]));
							}
						}
						break;
					case 1:
						for (var j:int = arr.length-2; j > -1; j --){
							if(this._mahjongPlayer.getElementIndex(arr[arr.length - 1]) > this._mahjongPlayer.getElementIndex(arr[j])){
								this._mahjongPlayer.setElementIndex(arr[arr.length - 1], this._mahjongPlayer.getElementIndex(arr[j]));
							}
						}
						break;
					default:
						break;
				}
				
			}
		}
		
		protected function orderForDispenseMahjongs(mahjongs:Array):void{
			
		}
		
		protected function orderSp(isPeng:Boolean = false):void{
			
		}
		
		protected function orderGpAndPp():void{
			
		}
		
		protected function orderOp():void{
			
		}

		//------------------------- getter / setter ---------------------------------
		public function get state():int
		{
			return _state;
		}

		public function get mahjongValues():Array
		{
			return _mahjongValues;
		}

		public function set mahjongValues(value:Array):void
		{
			_mahjongValues = value;
		}

		
	}
}