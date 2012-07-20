package com.amusement.Mahjong.Interface
{
	public interface IMahjongSyncService
	{
		function connServer(roomType:int):void;
		
		function disConnServer():void;
		
		//---------------------------------------------------------------
		function restartGameI(obj:Object):void;
		
		function beginGameI(obj:Object):void;
		
		function gameOverI(obj:Object):void;
		
		function dingzhangI(obj:Object):void;
		
		function getOneMahjongI(obj:Object):void;
		
		function putOneMahjongI(obj:Object):void;
		
		function pengI(obj:Object):void;
		
		function gangI(obj:Object):void;
		
		function huI(obj:Object):void;
		
		function showDingzhangI(obj:Object):void;
		
		function showOperationI(obj:Object):void;
		
		//------------------------------------------------------------------
		function continueGame():void;
		
		function dealOver():void;
		
		function dingzhang(dingzhangValue:int):void;
		
		function putOneMahjong(putOneMahjongValue:int, isPutDingzhang:Boolean = false):void;
		
		function peng():void;
		
		function gang(gangValue:int, isZigang:Boolean):void;
		
		function hu(isZimo:Boolean):void;
		
		function xiao(isZimo:Boolean, isZigang:Boolean):void;
	}
	
}