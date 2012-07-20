package com.mahjongSyncServer.interfaces;

import java.util.ArrayList;

import com.mahjongSyncServer.model.Player;
import com.mahjongSyncServer.model.Room;

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
	void setPlayer(Player player);
	/**
	 * 设置房间实体类
	 * @param room
	 */
	void setRoom(Room room);
	/**
	 * 获得玩家操作的名字
	 * @param azimuth
	 * @param value
	 * @param valueType
	 * @return
	 */
	ArrayList<String> getOperationName(int azimuth, int value, int valueType);
	/**
	 * 
	 * @return
	 */
	int getPutOneMahjong();
	/**
	 * 检测是否该碰
	 * @param value
	 * @return
	 */
	boolean checkPeng(int value);
	/**
	 * 检测是否该杠
	 * @param value
	 * @return
	 */
	boolean checkGang(int value);
	/**
	 * 检测是否是自杠
	 * @param value
	 * @param haveZigang
	 * @return
	 */
	String checkGang(int value , boolean haveZigang);
	/**
	 * 检测是否弯杠
	 * @param value
	 * @return
	 */
	boolean checkWanGang(int value);
	/**
	 * 检测是否胡牌
	 * @param value
	 * @return
	 */
	boolean checkHu(int value);
	/**
	 * 检测玩家比较少的一类麻将
	 * @return
	 */
	int checkLessMahjongType();
	/**
	 * 检测机器是否的闲牌
	 * @return
	 */
	int officialTransformerPutOneMahjong();
	/**
	 * 检测定章是否打完
	 * @return
	 */
	int checkDingzhangIsOver();
	/**
	 * 获得机器人该摸的牌
	 * @return
	 */
	int huoDeMP();
	/**
	 * 获得机器人的牌型
	 * @param sparr1
	 */
	void huoDePaiXing();
}
