package com.mahjongSyncServer.interfaces{

import com.mahjongSyncServer.model.Player;
import com.mahjongSyncServer.services.PlayerService;

public interface IPlayerService {

	/**
	 * 开始
	 * @return
	 */
	function beginGame():Boolean;
	/**
	 * 定章
	 * @return
	 */
	function dingzhang():int;
	/**
	 * 摸牌
	 * @return
	 */
	function getOneMahjong():int;
	/**
	 * 出牌
	 * @param mahjongValue
	 * @return
	 */
	function putOneMahjong(mahjongValue:int):int;
	/**
	 * 碰牌
	 * @param devil
	 * @return
	 */
	function peng(devil:Player):int;
	/**
	 * 杠牌
	 * @param devil
	 * @return
	 */
	function gang(devil:Player):Boolean;
	/**
	 * 杠牌
	 * @param devil
	 * @return
	 */
	function gangFunction():Boolean;
	/**
	 * 胡牌
	 * @param devil
	 * @return
	 */
	function hu(devil:PlayerService, isZihu:Boolean):Boolean;

}
}
