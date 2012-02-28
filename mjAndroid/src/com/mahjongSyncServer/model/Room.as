package com.mahjongSyncServer.model{
	import com.mahjongSyncServer.services.PlayerService;
	import com.mahjongSyncServer.util.Util;
	
	import mx.collections.ArrayList;
	
	/**
	 * 房间实体类
	 * @author Administrator
	 *
	 */
	public class Room {
		
		public var roomNo:String;											//房间编号 
		public var crapsCount:int = 0;										//骰子点数
		public var historyMessage:Vector.<Message> = null;						//历史记录
		public var gameOver:Boolean = false;								//游戏是否结束
		
		public var countOut:int = 0;										//骰子数
		
		public var mahjongs:Vector.<int>;

		public var isHistoryPut:Boolean = true;
		public var putNum:int = 0;
		
		public function Room(){
			historyMessage = new Vector.<Message>();									//历史记录实例化
			mahjongs = new Vector.<int>(); 					// 洗牌
		}
	}
	
}
