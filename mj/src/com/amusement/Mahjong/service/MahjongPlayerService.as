package com.amusement.Mahjong.service
{
	import com.amusement.Mahjong.control.MahjongPlayerControl;
	import com.amusement.Mahjong.control.MahjongRoomControl;
	import com.amusement.Mahjong.model.Mahjong;
	import com.amusement.Mahjong.model.MahjongPlayerModel;
	import com.amusement.Mahjong.util.MahjongUtil;
	
	import mx.collections.ArrayCollection;
	
	import spark.components.Group;

	public class MahjongPlayerService
	{
		protected var _mahjongPlayerModel:MahjongPlayerModel;
		
		
		public function MahjongPlayerService()
		{
			_mahjongPlayerModel = new MahjongPlayerModel();
		}
		
		public function dealReset():void{
			this._mahjongPlayerModel.sprr.splice(0, this._mahjongPlayerModel.sprr.length);
			this._mahjongPlayerModel.pprr.splice(0, this._mahjongPlayerModel.pprr.length);
			this._mahjongPlayerModel.gprr.splice(0, this._mahjongPlayerModel.gprr.length);
			this._mahjongPlayerModel.oprr.splice(0, this._mahjongPlayerModel.oprr.length);
			
			this._mahjongPlayerModel.dp = null;
			this._mahjongPlayerModel.dpType = -1;
			
			this._mahjongPlayerModel.hp = null;
		}
		
		public function dealDispenseMahjong(mahjongs:Array):Array{
			_mahjongPlayerModel.sprr = _mahjongPlayerModel.sprr.concat(mahjongs);
			if(_mahjongPlayerModel.sprr.length > 12){
				orderSprr();
			}
			return _mahjongPlayerModel.sprr;
		}
		
		public function dealDingzhang(dingzhangValue:int, isVideo:Boolean = false):Mahjong{
			var mahjong:Mahjong;
			if(dingzhangValue != 0 && dingzhangValue != 10 && dingzhangValue != 20){
				mahjong = this.getMahjongBySprr(dingzhangValue, isVideo);
			}
			
			_mahjongPlayerModel.dp = mahjong;
			_mahjongPlayerModel.dpType = dingzhangValue;
			
			orderSprr();
			return mahjong;
		}
		
		public function dealGetOneMahjong(mahjong:Mahjong):void{
			_mahjongPlayerModel.sprr.push(mahjong);
		}
		
		public function dealPutOneMahong(putOneMahjongValue:int, isPutDingzhang:Boolean = false, isVideo:Boolean = false):Mahjong{
			
			var mahjong:Mahjong;
			if(isPutDingzhang){
				if(_mahjongPlayerModel.dp.value == putOneMahjongValue){
					mahjong = _mahjongPlayerModel.dp;
				}
			}else{
				mahjong = this.getMahjongBySprr(putOneMahjongValue, isVideo);
			}
			
			_mahjongPlayerModel.oprr.push(mahjong);	
			
			orderSprr();
			
			return mahjong;
		}
		
		public function dealPeng(mahjong:Mahjong, isVideo:Boolean = false):Array{
			var mahjongs:Array = [];
			if(isVideo){
				for(var i:int = 0; i < _mahjongPlayerModel.sprr.length; i ++){
					if(_mahjongPlayerModel.sprr[i].value == mahjong.value){
						mahjongs.push(_mahjongPlayerModel.sprr.splice(i, 1)[0]);
						if(mahjongs.length >= 2){
							break;
						}
						i --;
					}
				}
			}else{
				var mj:Mahjong;
				for(var j:int = 0; j < 2; j ++){
					mj = _mahjongPlayerModel.sprr.pop();
					if(mj.parent){
						Group(mj.parent).removeElement(mj);
					}
					
					mj = MahjongPoolService.instance.getMahjongByValue(mahjong.value, MahjongRoomControl.instance.mahjongColor);
					mahjongs.push(mj);
				}
				mj = null;
			}
			
			if(mahjongs.length >= 2){
				mahjongs.push(mahjong);
				_mahjongPlayerModel.pprr = _mahjongPlayerModel.pprr.concat(mahjongs);
			}
			
			orderSprr();
			
			return mahjongs;
		}
		
		public function dealGang(mahjong:Mahjong, isZigang:Boolean = false, backIndex:int = 3, isVideo:Boolean = false):Array{
			var mahjongs:Array = [];
			
			if(isZigang){
				for(var j:int = 0; j < _mahjongPlayerModel.pprr.length; j ++){
					if(_mahjongPlayerModel.pprr[j].value == mahjong.value){
						mahjongs.push(_mahjongPlayerModel.pprr.splice(j, 1)[0]);
						if(mahjongs.length >= 3){
							break;
						}
						j --;
					}
				}
			}
			
			if(mahjongs.length < 3){
				if(isVideo){
					for(var i:int = 0; i < _mahjongPlayerModel.sprr.length; i ++){
						if(_mahjongPlayerModel.sprr[i].value == mahjong.value){
							mahjongs.push(_mahjongPlayerModel.sprr.splice(i, 1)[0]);
							if(mahjongs.length >= 3){
								break;
							}
							i --;
						}
					}
				}else{
					var mj:Mahjong;
					for(var n:int = 0; n < 3; n ++){
						mj = _mahjongPlayerModel.sprr.pop();
						if(mj.parent){
							Group(mj.parent).removeElement(mj);
						}
						
						mj = MahjongPoolService.instance.getMahjongByValue(mahjong.value, MahjongRoomControl.instance.mahjongColor);
						mahjongs.push(mj);
					}
					mj = null;
				}
				
				if(mahjongs.length >= 3 && isZigang){
					switch(backIndex){
						case 0:
							mahjongs[0].isGangBack = true;
							break;
						case 3:
							mahjong.isGangBack = true;
							break;
					}
				}
			}
			
			if(mahjongs.length == 3){
				mahjongs.push(mahjong);
				_mahjongPlayerModel.gprr = _mahjongPlayerModel.gprr.concat(mahjongs);
			}
			
			orderSprr();
			
			return mahjongs;
		}
		
		public function dealHu(mahjong:Mahjong):void{
			this._mahjongPlayerModel.hp = mahjong;
		}
		
		public function dealCut(mahjongValues:Array):void{
			var mahjongsLength:int = this._mahjongPlayerModel.sprr.length;
			var mahjong:Mahjong;
			for(var i:int = 0; i < mahjongsLength; i ++){
				mahjong  = this._mahjongPlayerModel.sprr.shift();
				if(mahjong.parent){
					Group(mahjong.parent).removeElement(mahjong);
				}
			}
			mahjong = null;
			
			this._mahjongPlayerModel.sprr = MahjongPoolService.instance.getMahjongsByValues(mahjongValues, MahjongRoomControl.instance.mahjongColor);
			orderSprr();
		}
		
		//----------------------------------------------------------------------------------------
		public function reconstructDingzhang(dingzhangValue:int, state:int):Mahjong{
			var mahjong:Mahjong;
			if(state == 1){
				mahjong = MahjongRoomControl.instance.getMahjongs(1)[0];
				if(mahjong.parent){
					Group(mahjong.parent).removeElement(mahjong);
				}
				mahjong = MahjongPoolService.instance.getMahjongByValue(dingzhangValue, MahjongRoomControl.instance.mahjongColor);
			}
			
			this._mahjongPlayerModel.dp = mahjong;
			this._mahjongPlayerModel.dpType = dingzhangValue;
			
			return mahjong;
		}
		
		public function reconstructSprr(sprrValues:Array, sprrLength:int, state:int):Array{
			var mahjongs:Array = MahjongRoomControl.instance.getMahjongs(sprrLength);
			if(sprrValues && sprrValues.length > 0){
				var mahjong:Mahjong;
				while(mahjongs.length > 0){
					mahjong = mahjongs.shift();
					if(mahjong.parent){
						Group(mahjong.parent).removeElement(mahjong);
					}
				}
				mahjongs = MahjongPoolService.instance.getMahjongsByValues(sprrValues, MahjongRoomControl.instance.mahjongColor);
			}
			
			this._mahjongPlayerModel.sprr = mahjongs;
			if(state == 0){
				orderSprr();
			}
			
			return mahjongs;
		}
		
		public function reconstructOprr(oprrValues:Array):Array{
			var mahjongs:Array = MahjongRoomControl.instance.getMahjongs(oprrValues.length);
			var mahjong:Mahjong;
			while(mahjongs.length > 0){
				mahjong = mahjongs.shift();
				if(mahjong.parent){
					Group(mahjong.parent).removeElement(mahjong);
				}
			}
			mahjongs = MahjongPoolService.instance.getMahjongsByValues(oprrValues, MahjongRoomControl.instance.mahjongColor);
			
			this._mahjongPlayerModel.oprr = mahjongs;
			
			return mahjongs;
		}
		
		public function reconstructPprr(pprrValues:Array):Array{
			var mahjongs:Array = MahjongRoomControl.instance.getMahjongs(pprrValues.length);
			var mahjong:Mahjong;
			while(mahjongs.length > 0){
				mahjong = mahjongs.shift();
				if(mahjong.parent){
					Group(mahjong.parent).removeElement(mahjong);
				}
			}
			mahjongs = MahjongPoolService.instance.getMahjongsByValues(pprrValues, MahjongRoomControl.instance.mahjongColor);
			
			this._mahjongPlayerModel.pprr = mahjongs;
			
			return mahjongs;
		}
		
		public function reconstructGprr(gprrValues:Array):Array{
			var mahjongs:Array = MahjongRoomControl.instance.getMahjongs(gprrValues.length);
			var mahjong:Mahjong;
			while(mahjongs.length > 0){
				mahjong = mahjongs.shift();
				if(mahjong.parent){
					Group(mahjong.parent).removeElement(mahjong);
				}
			}
			mahjongs = MahjongPoolService.instance.getMahjongsByValues(gprrValues, MahjongRoomControl.instance.mahjongColor);
			
			this._mahjongPlayerModel.gprr = mahjongs;
			
			return mahjongs;
		}
		
		public function reconstructHu(huValue:int, playerAzimuthR:int = 0, haveHuCount:int = 0):Mahjong{
			var mahjong:Mahjong;
			if(huValue > 0){
				if(playerAzimuthR == 0 || haveHuCount <= 1){
					mahjong = MahjongRoomControl.instance.getMahjongs(1)[0];
					if(mahjong.parent){
						Group(mahjong.parent).removeElement(mahjong);
					}
					mahjong = MahjongPoolService.instance.getMahjongByValue(huValue, MahjongRoomControl.instance.mahjongColor);
				}else{
					mahjong = MahjongPoolService.instance.getMahjong(huValue, MahjongRoomControl.instance.mahjongColor);
				}
			}
			this._mahjongPlayerModel.hp = mahjong;
			
			return mahjong;
		}
		
		/////////////////////////////////////////////////////////////////////////////////////
		/**
		 * 取出最后一张出牌 
		 * @param mahjongValue
		 * @return 
		 * 
		 */
		public function popOprr(mahjongValue:int):Mahjong{
			var mahjong:Mahjong;
			if(this._mahjongPlayerModel.oprr[this._mahjongPlayerModel.oprr.length - 1].value == mahjongValue){
				mahjong = this._mahjongPlayerModel.oprr.pop();
			}
			return mahjong;
		}
		
		/**
		 * 获取手牌中的一张牌 
		 * @param mahjongValue
		 * @param isVideo
		 * @return 
		 * 
		 */
		public function getMahjongBySprr(mahjongValue:int, isVideo:Boolean = false):Mahjong{
			var mahjong:Mahjong;
			if(isVideo){
				if(this._mahjongPlayerModel.sprr[this._mahjongPlayerModel.sprr.length - 1].value == mahjongValue){
					mahjong = this._mahjongPlayerModel.sprr.pop();
				}else{
					for(var i:int = 0; i < this._mahjongPlayerModel.sprr.length; i ++){
						if(this._mahjongPlayerModel.sprr[i].value == mahjongValue){
							mahjong = this._mahjongPlayerModel.sprr.splice(i, 1)[0];
							break;
						}
					}
				}
			}else{
				mahjong = this._mahjongPlayerModel.sprr.pop();
				if(mahjong.parent){
					Group(mahjong.parent).removeElement(mahjong);
				}
				
				mahjong = MahjongPoolService.instance.getMahjongByValue(mahjongValue, MahjongRoomControl.instance.mahjongColor);
				
			}
			return mahjong;
		}
		
		
		/**
		 * 抢杠后，重构碰牌和杠牌 
		 * @param mahjongValue
		 * @return 
		 * 
		 */
		public function restoreGprrAndPprr(mahjongValue:int):Mahjong{
			var mahjong:Mahjong;
			
			var mahjongs:Array = [];
			for(var i:int = 0; i < this._mahjongPlayerModel.gprr.length; i ++){
				if(this._mahjongPlayerModel.gprr[i].value == mahjongValue){
					mahjong = this._mahjongPlayerModel.gprr.splice(i, 1)[0];
					mahjong.isGangBack = false;
					mahjongs.push(mahjong);
					
					i --
				}
				
				if(mahjongs.length >= 4){
					mahjong = null;
					break;
				}
			}
			
			if(mahjongs.length == 4){
				mahjong = mahjongs.pop();
				this._mahjongPlayerModel.pprr = this._mahjongPlayerModel.pprr.concat(mahjongs);
			}
			
			return mahjong;
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////
		/**
		 * 代替定章 
		 * 
		 */
		public function replaceDingzhang():void{
			var firstW:Mahjong;//第一张万
			var firstT:Mahjong;//第一张筒
			var firstL:Mahjong;//第一张条
			
			var haveWCount:int = 0;//万的张数
			var haveTCount:int = 0;//筒的张数
			var haveLCount:int = 0;//条的张数
			
			for each(var mahjong:Mahjong in this._mahjongPlayerModel.sprr){
				var mahjongType:int = Math.floor(mahjong.value / 10);
				switch(mahjongType){
					case 0:
						haveWCount ++;
						if(haveWCount == 1){
							firstW = mahjong;
						}
						break;
					case 1:
						haveTCount ++;
						if(haveTCount == 1){
							firstT = mahjong;
						}
						break;
					case 2:
						haveLCount ++;
						if(haveLCount == 1){
							firstL = mahjong;
						}
						break;
				}
			}
			
			if(haveWCount == 0){
				MahjongSyncService.instance.dingzhang(0);
			}else if(haveTCount == 0){
				MahjongSyncService.instance.dingzhang(10);
			}else if(haveLCount == 0){
				MahjongSyncService.instance.dingzhang(20);
			}else if(haveWCount <= haveTCount && haveWCount <= haveLCount){
				MahjongSyncService.instance.dingzhang(firstW.value);
			}else if(haveTCount <= haveWCount && haveTCount <= haveLCount){
				MahjongSyncService.instance.dingzhang(firstT.value);
			}else{
				MahjongSyncService.instance.dingzhang(firstL.value);
			}
		}
		
		/**
		 * 代替打定章 
		 * 
		 */
		public function replacePutDingzhang():void{
			//向服务器发送请求
			MahjongSyncService.instance.putOneMahjong(this._mahjongPlayerModel.dp.value, true);
		}
		
		/**
		 * 代替打牌 
		 * 
		 */
		public function replacePutMahjong():void{
			var sprr:Array = this._mahjongPlayerModel.sprr;
			for each(var mahjong:Mahjong in sprr){
				if(Math.floor(mahjong.value / 10) == this._mahjongPlayerModel.dpType){
					MahjongSyncService.instance.putOneMahjong(mahjong.value);
					return;
				}
			}
			
			MahjongSyncService.instance.putOneMahjong(sprr[sprr.length - 1].value);
		}
		
		////////////////////////////////////////////////////////////////////////////////////////
		/**
		 * 检测缺门 
		 * @return 
		 * 
		 */
		public function checkQuemen():Array{
			var quemenTypes:Array = [];
			
			if(this._mahjongPlayerModel.sprr.length >= 13){
				var sprrValues:Array = MahjongUtil.changeIntArr(this._mahjongPlayerModel.sprr);
				
				var haveWCount:int = 0;//万的张数
				var haveTCount:int = 0;//筒的张数
				var haveLCount:int = 0;//条的张数
				
				var mahjongType:int
				for each(var mahjongValue:int in sprrValues){
					mahjongType = Math.floor(mahjongValue / 10);
					switch(mahjongType){
						case 0:
							haveWCount ++;
							break;
						case 1:
							haveTCount ++;
							break;
						case 2:
							haveLCount ++;
							break;
					}
				}
				
				if(haveWCount == 0){
					quemenTypes.push(0);
				}
				
				if(haveTCount == 0){
					quemenTypes.push(10);
				}
				
				if(haveLCount == 0){
					quemenTypes.push(20);
				}
			}
			
			return quemenTypes;
		}
		
		/**
		 * 检测传入麻将是否可以被打出 
		 * @param mahjongValue
		 * @return 
		 * 
		 */
		public function checkPutMahjongLegally(mahjongValue:int):Boolean{
			var flag:Boolean = false;
			
			if(Math.floor(mahjongValue / 10) == this._mahjongPlayerModel.dpType || !MahjongUtil.checkHaveDingzhangType(this._mahjongPlayerModel.sprr, this._mahjongPlayerModel.dpType)){
				flag = true;
			}
			
			return flag;
		}
		
		/**
		 * 检测自摸 
		 * @return 
		 * 
		 */
		public function checkHu():Boolean{
			var flag:Boolean = false;
			
			flag = MahjongUtil.checkHu(this._mahjongPlayerModel.sprr, this._mahjongPlayerModel.pprr, this._mahjongPlayerModel.gprr, this._mahjongPlayerModel.dpType);
			
			return flag;
		}
		
		/**
		 * 检测自杠 
		 * @param mahjongsNum 剩余麻将个数
		 * @return 
		 * 
		 */
		public function checkGang(mahjongsNum:int):Array{
			var gangValues:Array = [];
			
			//最后一张牌不可杠,最后一张时，牌堆已没有没有牌
			if(mahjongsNum > 0 && this._mahjongPlayerModel.dpType >= 0){
				//判断明杠
				var lastMjValue:int = this._mahjongPlayerModel.sprr[this._mahjongPlayerModel.sprr.length - 1].value;
				if(Math.floor(lastMjValue / 10) != this._mahjongPlayerModel.dpType){
					var n:int = 0;
					for each(var mj:Mahjong in this._mahjongPlayerModel.pprr){
						if(mj.value == lastMjValue){
							n ++;
							if(n == 3){
								n = 0;
								gangValues.push(lastMjValue);
								break;
							}
						}
					}
				}
				
				//判断暗杠
				var valueArr:Array = MahjongUtil.changeIntArr(this._mahjongPlayerModel.sprr);
				valueArr.sort(Array.NUMERIC);
				var i:int = 0;
				while(i < valueArr.length - 3){
					if(valueArr[i] == valueArr[i + 1] && valueArr[i + 1] == valueArr[i + 2] && valueArr[i + 2] == valueArr[i + 3] && valueArr[i + 3] == valueArr[i]){
						if(Math.floor(valueArr[i] / 10) != this._mahjongPlayerModel.dpType){
							gangValues.push(valueArr[i]);
						}
						
						i += 4;
					}else{
						i ++;
					}
				}
			}
			
			return gangValues;
		}
		////////////////////////////////////////////////////////////////////////////////////////////
		
		public function getSprr():Array{
			return this._mahjongPlayerModel.sprr;
		}
		
		public function getPprr():Array{
			return this._mahjongPlayerModel.pprr;
		}
		
		public function getGprr():Array{
			return this._mahjongPlayerModel.gprr;
		}
		
		public function getOprr():Array{
			return this._mahjongPlayerModel.oprr;
		}
		
		/**
		 * 获取定章类型名称 
		 * @return 
		 * 
		 */
		public function getDpTypeName():String{
			var typeName:String = "";
			switch(this._mahjongPlayerModel.dpType){
				case 0:
					typeName = "wan";
					break;
				case 1:
					typeName = "tong";
					break;
				case 2:
					typeName = "tiao";
					break;
				default:
					typeName = "que";
					break;
			}
			return typeName;
		}
		
		/**
		 * 获取玩家方位名称 
		 * @param playerAzimuthR
		 * @return 
		 * 
		 */
		public function getPlayerAzimuthName(playerAzimuthR:int):String{
			var playerAzimuthName:String = "";
			switch(playerAzimuthR){
				case 1:
					playerAzimuthName = "壹";
					break;
				case 2:
					playerAzimuthName = "貳";
					break;
				case 3:
					playerAzimuthName = "叁";
					break;
				case 4:
					playerAzimuthName = "肆";
					break;
			}
			return playerAzimuthName;
		}
		
		/////////////////////////////////////////////////////////////////////////////////////
		
		public function orderSprr():void
		{
			this._mahjongPlayerModel.sprr = this._mahjongPlayerModel.sprr.sortOn("value", Array.NUMERIC);
		}
		
		
		
	}
}