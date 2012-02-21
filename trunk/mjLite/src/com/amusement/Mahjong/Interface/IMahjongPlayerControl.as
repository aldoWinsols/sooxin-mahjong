package com.amusement.Mahjong.Interface
{
	import com.amusement.Mahjong.model.Mahjong;

	public interface IMahjongPlayerControl
	{
		function reset():void;
			
		function reconstruct(player:Object):void;
		
		function sortMahjong(mahjong:Mahjong, index:int, count:int):void;
		
		function dispenseMahjong(mahjongs:Array):void;
		
		function dingzhang(dingzhangValue:int, px:int, py:int, hmpName:String):void;
		
		function getOneMahjong(mahjong:Mahjong, px:int, py:int, bmpName:String):void;
		
		function putOneMahjong(putOneMahjongValue:int, px:int, py:int, bmpName:String, signX:int, signY:int, isPutDingzhang:Boolean = false):Mahjong;
		
		function peng(mahjong:Mahjong):void;
		
		function gang(mahjong:Mahjong, isZigang:Boolean, backIndex:int = 3):void;
		
		function hu(mahjong:Mahjong, px:int, py:int, bmpName:String, azimuth:int, huType:int, haveHuCount:int, qiangGangAzimuth:int = 0):void;
		
		function cut(bmpName:String):void;
		
		//----------------------------------------
		function dingzhangV(dingzhangValue:int):void;
		
		function getOneMahjongV(mahjong:Mahjong):void;
		
		function putOneMahjongV(putOneMahjongValue:int, isPutDingzhang:Boolean = false):Mahjong;
		
		function pengV(mahjong:Mahjong):void;
		
		function gangV(mahjong:Mahjong, isZigang:Boolean):void;
		
		function huV(mahjong:Mahjong, huType:int, haveHuCount:int, qiangGangAzimuth:int = 0):void;
		
		function cutV():void;
		
	}
}