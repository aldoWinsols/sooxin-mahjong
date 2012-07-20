package com.amusement.Mahjong.util
{
	import flash.net.LocalConnection;
	
	public class MahjongUtil
	{
		public function MahjongUtil()
		{
		}

		//--------------------------------------------------------------------
		/**
		 * 根据玩家实际方向，获得显示方向 
		 * @param playerAzimuth 自己实际方向
		 * @param playerAzimuthR 玩家实际方向
		 * @return 显示方向
		 * 
		 */
		public static function getRemotePlayerAzimuth(playerAzimuth:int, playerAzimuthR:int):int
		{
			var realAzimuth:int = ((playerAzimuthR + (7 - playerAzimuth) % 4) > 4) ? (playerAzimuthR + (7 - playerAzimuth) % 4 - 4) : (playerAzimuthR + (7 - playerAzimuth) % 4);
			return realAzimuth;
		}

		/**
		 * 根据显示方向，获得玩家实际方向
		 * @param playerAzimuth 自己实际方向
		 * @param playerAzimuthR 显示方向
		 * @return  玩家实际方向
		 * 
		 */
		public static function getRemoteOperationPlayerAzimuth(playerAzimuth:int, playerAzimuthR:int):int
		{
			var realAzimuth:int =((playerAzimuthR + (playerAzimuth+1) % 4) > 4) ? (playerAzimuthR + (playerAzimuth + 1) % 4 - 4) : (playerAzimuthR + (playerAzimuth + 1) % 4);
			return realAzimuth;
		}

		public static function checkHu(spArr:Array, ppArr:Array, gpArr:Array, dingzhangType:int):Boolean{
			var spValueArr:Array = changeIntArr(spArr.concat(ppArr).concat(gpArr));
			
			 /* if(dingzhangType < 0){
				return false;
			}else */ if(dingzhangType > -1 && checkHaveDingzhangType(spArr.concat(ppArr).concat(gpArr), dingzhangType)){//是否将定张类牌出完
				return false;
			}else{//是否三类牌都有
				var haveW:Boolean = false;
				var haveT:Boolean = false;
				var haveL:Boolean = false;

				for each(var spValue:int in spValueArr){
					if(Math.floor(spValue / 10) == 0){
						haveW = true;
					}else if(Math.floor(spValue / 10) == 1){
						haveT = true;
					}else if(Math.floor(spValue / 10) == 2){
						haveL = true;
					}

				}
				
				if(haveW && haveT && haveL){
					return false;
				}
			}
			
			spValueArr = changeIntArr(spArr);
			trace("before:"+spValueArr);
			spValueArr.sort(valueSortOn);
			trace("after:"+spValueArr);
			return spValueArr.some(chenkHuSome);

		}

		public static function chenkHuSome(element:*, index:int, arr:Array):Boolean
		{
			var bool:Boolean=false;
			if (arr[index] == arr[index + 1])
			{
				bool=checkKan(arr.slice(0, index).concat(arr.slice(index + 2, arr.length)));
			}
			return bool;
		}

		//判断是否成坎
		public static function checkKan(arr:Array):Boolean
		{
			var copyMajiangArr:Array=arr;
			////////////////////////////////////////     		
			if(copyMajiangArr.length>12)
			{
				return  false;
			}
			/////////////////////////////////////
			if(copyMajiangArr.length == 12)
			{
				var xiaojidui:Boolean=true;
				for(var j:int = 0; j < 12; j += 2)
				{
					if(copyMajiangArr[j] != copyMajiangArr[j+1])
					{
						xiaojidui = false;
						break;
					}
				}
				if(xiaojidui)
				{
					return xiaojidui;
				}
			}
			
			/////////////////////////////
			var huPai:Boolean=false;
			var flag1:Boolean=true;
			var flag2:Boolean=false;
			var flag3:Boolean=false;
			////////////////////////////
			while(copyMajiangArr.length >= 3 && copyMajiangArr[0] == copyMajiangArr[1] && copyMajiangArr[1] == copyMajiangArr[2])
			{
				copyMajiangArr.splice(0,3);
//				trace(copyMajiangArr);
			}
			///////////////////////////////
			while(flag1)
			{
				var t:int = 0;
				flag2 = false;
				flag3 = false;
				for(var i:int = 1; i < copyMajiangArr.length; i ++)
				{
					if(!flag2 && copyMajiangArr[i] == copyMajiangArr[0] + 1)
					{
						flag2 = true;
						t = copyMajiangArr[i];
						copyMajiangArr[i] = copyMajiangArr[copyMajiangArr.length-1];
						copyMajiangArr[copyMajiangArr.length-1] = t;
					}
					if(!flag3 && copyMajiangArr[i] == copyMajiangArr[0]+2)
					{
						flag3 = true;
						t=copyMajiangArr[i];
						copyMajiangArr[i] = copyMajiangArr[copyMajiangArr.length-2];
						copyMajiangArr[copyMajiangArr.length-1] = t;
					}
				}     			  
				if(flag2 && flag3)
				{
					flag1 = true
					copyMajiangArr.splice(copyMajiangArr.length-2,2);
					copyMajiangArr.splice(0,1);
					copyMajiangArr.sort();
//					trace(copyMajiangArr);
					////////////////////////////
					while(copyMajiangArr.length >= 3 && copyMajiangArr[0] == copyMajiangArr[1] && copyMajiangArr[1] == copyMajiangArr[2])
					{
						copyMajiangArr.splice(0,3);
//						trace(copyMajiangArr);
					}
						///////////////////////////////
				}
				else
				{
					flag1 = false;
				}
			}
			//////////////////////////////////////////////////////////
			if(copyMajiangArr.length == 0)
			{
				huPai=true;
			}	     			
			return huPai;
		}


		//-------------------------------------------------------------------
		//判断是否小七对
		public static function checkQidui(arr:Array):Boolean
		{
			if (arr.length != 14)
			{
				return false;
			}
			else
			{
				for (var i:int=0; i < arr.length; i=i + 2)
				{
					//判断是否相等 成对
					if (arr[i] != arr[i + 1])
					{
						return false;
					}
				}
			}
			return true;
		}

		//-------------------------------------------------------------------
		//转换整数数组(不会改变原有数组)
		public static function changeIntArr(arr:Array):Array
		{
			var valueArr:Array = new Array();
//			trace(arr.length);
			for (var i:int=0; i < arr.length; i++)
			{
				valueArr[i]=int(arr[i].value);
			}
			return valueArr;
		}

		//值排序，不影响外部麻将对象数组的排序
		private static function valueSortOn(a:Object, b:Object):Number
		{
			if (a > b)
			{
				return 1;
			}
			else
			{
				return -1;
			}
			return 0;
		}
		
		//牌数组中是否含有定章类的牌
		public static function checkHaveDingzhangType(arr:Array, dingzhangType:int):Boolean{
			//var dingzhangType:int = Math.floor(dingzhangMahjong.value / 10);
			for each(var mj:Object in arr){
				if(Math.floor(mj.value / 10) == dingzhangType){
					return true;
				}
			}
			
			return false;
		}
		
		//强制执行垃圾清理
		public static function cleaning():void{
			try{
			  new LocalConnection().connect("foo");
              new LocalConnection().connect("foo");
			}catch(e:Error){
				
			}
		}
	}
}
