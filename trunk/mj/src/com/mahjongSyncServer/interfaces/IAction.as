package com.mahjongSyncServer.interfaces{

import com.mahjongSyncServer.model.Player;
import com.mahjongSyncServer.model.Room;
import com.mahjongSyncServer.services.PlayerService;

import mx.collections.ArrayList;

/**
 * 用户逻辑接口
 * @author Administrator
 *
 */
public interface IAction {

	/**
	 * 设置玩家实体类
	 * @param player
	 */
	function setPlayer(player:Player):void;
	/**
	 * 设置房间实体类
	 * @param room
	 */
	function setRoom(room:Room):void;
	/**
	 * 获得玩家操作的名字
	 * @param azimuth
	 * @param value
	 * @param valueType
	 * @return
	 */
	function getOperationName(devil:PlayerService = null):Array;

	/**
	 * 检测是否该碰
	 * @param value
	 * @return
	 */
	function checkPeng(value:int):Boolean;
	/**
	 * 检测是否该杠
	 * @param value
	 * @return
	 */
	function checkGang(value:int):Boolean;
	/**
	 * 检测是否胡牌
	 * @param value
	 * @return
	 */
	function checkHu(value:int):Boolean;
	/**
	 * 检测玩家比较少的一类麻将
	 * @return
	 */
	function checkLessMahjongType():int;
	/**
	 * 检测机器是否的闲牌
	 * @return
	 */
	function getPutOneMahjongValue():int;
	/**
	 * 检测定章是否打完
	 * @return
	 */
	function checkDingzhangIsOver():int;
	/**
	 * 获得机器人该摸的牌
	 * @return
	 */
	function huoDeMP():int;
	/**
	 * 获得机器人的牌型
	 * @param sparr1
	 */
	function huoDePaiXing():void;
}
}
