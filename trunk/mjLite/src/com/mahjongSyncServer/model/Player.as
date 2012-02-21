package com.mahjongSyncServer.model{
import com.mahjongSyncServer.services.PlayerService;

import mx.collections.ArrayList;

public class Player {
	
	public var playerName:String = null;								//用户
	
	public var roomNo:String = null;									//玩家所在的房间编号
	
	public var azimuth:int = 0;										//玩家所在当前房间的座位号
	
	public var lastValue:int = 0;										//玩家最后一次摸牌的值
	public var ishu:Boolean = false;									//玩家是否胡牌
	public var isZihu:Boolean = false;
	public var lastGang:Boolean = false;
	public var xiaoIsZihu:Boolean = false;
	
	public var isDingzhang:Boolean = false;							//玩家是否定章
	public var isDingzhangFanpai:Boolean = false;					//玩家是否定章翻牌
	public var dingzhangValue:int = -1;								//玩家定章的值
	public var haveDingzhangFanpai:Boolean = false;					//玩家是否定章翻牌
	public var isShowDingzhang:Boolean = false;
	
	public var zigangValue:int = 0;									//玩家自杠的值
	public var haveWanGang:Boolean = false;							//是否为弯杠

	public var playerType:int = 0;										//玩家类型
	public var isDealOver:Boolean = false;								//是否发牌完毕
	public var operationMahjongNum:int = 0;							//操作次数
	public var dingzhangFanpai:int = 0;								//定章翻牌标识
	public var sparrStr:String = "";									//手牌数组的字符串
	
	public var isFangTuiDa:Boolean = false;							//是否放牛
	public var lastFangFanNum:int = 0;									//放牛的番数
	
	public var dianhuAzimuth:int = 0;									//点炮的方位
	public var huCount:int = 0;										//多家同时胡牌的顺序编号
	public var huMahjongValue:int = 0;									//胡牌的麻将值
	
	public var fanNum:int = 0;											//玩家胡牌的翻数
	public var haveJiao:Boolean = false;								//玩家是否下叫
	public var peiNum:int = 0;											//玩家配叫的翻数
	
	public var couldOperationNames:Array; 					 		//可以操作的方法
	public var needOperationName:String = "";							//需要操作的方法
	public var isPutDingzhang:Boolean = false;
	public var needOperationPlayerService:PlayerService;				//被碰 杠 胡 的玩家
	public var lastNeedOperationName:String = "";						//上一次操作的方法
	
	public var nowOperationMahjongValue:int = 0;						//当前操作的麻将值
	
//	public var PlayLog playLog = null;									//用户日志
	public var changeMoney:Number = 0;									//玩家的输赢
	public var haveMoney:Number = 0;
	
	public var sparr:Vector.<int>;						//玩家手上未打的牌
	public var pparr:Vector.<int>;						//玩家的碰牌
	public var gparr:Vector.<int>;						//玩家杠牌
	public var outarr:Vector.<int>;						//玩家已经出了的牌
	
	public function Player(){
		//实例化
		sparr = new Vector.<int>();
		pparr = new Vector.<int>();
		gparr = new Vector.<int>();
		outarr = new Vector.<int>();
		
		couldOperationNames = new Array();
	}
	/**
	 * 清除所有数据
	 */
	public function clearAllData():void{

		roomNo = null;									//玩家所在的房间编号
		PlayerService.huCount = 0;
		lastValue = 0;										//玩家最后一次摸牌的值
		ishu = false;									//玩家是否胡牌
		isZihu = false;
		lastGang = false;
		
		isDingzhang = false;							//玩家是否定章
		isDingzhangFanpai = false;
		dingzhangValue = -1;								//玩家定章的值
		haveDingzhangFanpai = false;					//玩家是否定章翻牌
		isShowDingzhang = false;
		
		zigangValue = 0;									//玩家自杠的值
		haveWanGang = false;							//是否弯杠
		xiaoIsZihu = false;
		
		isDealOver = false;								//是否发牌完毕
		operationMahjongNum = 0;							//操作次数
		dingzhangFanpai = 0;								//定章翻牌标识
		sparrStr = "";									//手牌数组的字符串
		
		isFangTuiDa = false;							//是否放牛
		lastFangFanNum = 0;									//放牛的番数
		
		dianhuAzimuth = 0;									//点炮的方位
		huCount = 0;										//多家同时胡牌的顺序编号
		huMahjongValue = 0;									//胡牌的麻将值
		
		fanNum = 0;											//玩家胡牌的翻数
		haveJiao = false;								//玩家是否下叫
		peiNum = 0;											//玩家配叫的翻数
		
		couldOperationNames = new Array(); 					 		//可以操作的方法
		needOperationName = "";							//需要操作的方法
		isPutDingzhang = false;
		needOperationPlayerService = null;				//被碰 杠 胡 的玩家
		lastNeedOperationName = "";						//上一次操作的方法
		
		nowOperationMahjongValue = 0;						//当前操作的麻将值
		
		//	PlayLog playLog = null;									//用户日志
		changeMoney = 0;									//玩家的输赢
		haveMoney = 0;
		
		sparr = new Vector.<int>();						//玩家手上未打的牌
		pparr = new Vector.<int>();						//玩家的碰牌
		gparr = new Vector.<int>();						//玩家杠牌
		outarr = new Vector.<int>();						//玩家已经出了的牌
	}
}
}
