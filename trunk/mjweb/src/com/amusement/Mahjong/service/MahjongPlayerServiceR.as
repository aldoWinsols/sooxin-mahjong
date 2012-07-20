package com.amusement.Mahjong.service
{
	import com.amusement.Mahjong.control.MahjongRoomControl;
	import com.amusement.Mahjong.model.Mahjong;

	public class MahjongPlayerServiceR extends MahjongPlayerService
	{
		public function MahjongPlayerServiceR()
		{
			super();
		}
		
		public override function dealDingzhang(dingzhangValue:int, isVideo:Boolean=false):Mahjong
		{
			//TODO Auto-generated method stub
			return super.dealDingzhang(dingzhangValue,MahjongRoomControl.instance.isVideo);
		}
		
		public override function dealPutOneMahong(putOneMahjongValue:int, isPutDingzhang:Boolean=false, isVideo:Boolean=false):Mahjong
		{
			//TODO Auto-generated method stub
			return super.dealPutOneMahong(putOneMahjongValue,isPutDingzhang, MahjongRoomControl.instance.isVideo);
		}
		
		public override function dealPeng(mahjong:Mahjong, isVideo:Boolean=false):Array
		{
			//TODO Auto-generated method stub
			return super.dealPeng(mahjong,MahjongRoomControl.instance.isVideo);
		}
		
		public override function dealGang(mahjong:Mahjong, isZigang:Boolean=false, backIndex:int=3, isVideo:Boolean=false):Array
		{
			//TODO Auto-generated method stub
			return super.dealGang(mahjong,isZigang,backIndex,MahjongRoomControl.instance.isVideo);
		}
		
		public override function getMahjongBySprr(mahjongValue:int, isVideo:Boolean=false):Mahjong
		{
			//TODO Auto-generated method stub
			return super.getMahjongBySprr(mahjongValue,MahjongRoomControl.instance.isVideo);
		}

	}
}