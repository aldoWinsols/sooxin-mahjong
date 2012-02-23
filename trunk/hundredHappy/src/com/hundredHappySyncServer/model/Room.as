package com.hundredHappySyncServer.model
{
	import com.hundredHappySyncServer.services.SubRoomService;

	public class Room
	{
		public var gameNo:String = "";											//局号
		public var roomNo:String = null;									//台桌编号
		
		public var subRoomServices:Vector.<SubRoomService> = null;				//所有子房间
		public var pokers:Vector.<Poker> = null;							//房间里的扑克牌
		public var historyRecord.<Record> = null;				//本桌在没有重新洗牌的情况下的每一局记录集合
		
		public var xPokers:Vector.<Poker> = null;					//闲家牌
		public var xNum:int = 0;										//闲家点数
		
		public var zPokers:Vector.<Poker> = null;					//庄家牌
		public var zNum:int = 0;										//庄家点数
		
		public var roomType:int = 0;									//当前状态
		
		public var timers:int = 0;										//发送发牌消息倒计时
		public var operationType:int = 0;										//操作类型
		
		public var whiteCardNum:int = 0;								//白色卡片位置
		
		public var isBetting:Boolean = true;							//是否可以下注
		
		public var shuffleTimer:int = 120;								//洗牌时间
		public var bettingTimer:int = 45;								//下注时间
		
		public var shuffleStr:String = "";								// g 2011-6-1 9:25   保存洗牌的数组字符串
		
		public var totalZdT:int = 0;									//总的庄对下注
		public var totalXdT:int = 0;									//总的闲对下注
		public var totalZT:int = 0;									//总的庄下注
		public var totalXT:int = 0;									//总的闲下注
		public var totalHT:int = 0;									//总的和下注
		public function Room()
		{
		}
	}
}