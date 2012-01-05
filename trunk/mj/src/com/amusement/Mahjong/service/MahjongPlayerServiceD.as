package com.amusement.Mahjong.service
{
	import com.amusement.Mahjong.model.Mahjong;

	public class MahjongPlayerServiceD extends MahjongPlayerService
	{
		public function MahjongPlayerServiceD()
		{
			super();
		}

		public override function dealDingzhang(dingzhangValue:int, isVideo:Boolean=false):Mahjong
		{
			//TODO Auto-generated method stub
			return super.dealDingzhang(dingzhangValue,true);
		}

		public override function dealPutOneMahong(putOneMahjongValue:int, isPutDingzhang:Boolean=false, isVideo:Boolean=false):Mahjong
		{
			//TODO Auto-generated method stub
			return super.dealPutOneMahong(putOneMahjongValue,isPutDingzhang, true);
		}

		public override function dealPeng(mahjong:Mahjong, isVideo:Boolean=false):Array
		{
			//TODO Auto-generated method stub
			return super.dealPeng(mahjong,true);
		}
		
		public override function dealGang(mahjong:Mahjong, isZigang:Boolean=false, backIndex:int=3, isVideo:Boolean=false):Array
		{
			//TODO Auto-generated method stub
			return super.dealGang(mahjong,isZigang,backIndex,true);
		}
		
		public override function getMahjongBySprr(mahjongValue:int, isVideo:Boolean=false):Mahjong
		{
			//TODO Auto-generated method stub
			return super.getMahjongBySprr(mahjongValue,true);
		}
	}
}