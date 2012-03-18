package com.mahjongSyncServer.interfaces;

import com.mahjongSyncServer.model.Player;
import com.mahjongSyncServer.services.PlayerService;

public interface IPlayerService {

	/**
	 * 开始
	 * @return
	 */
	boolean beginGame();
	/**
	 * 定章
	 * @return
	 */
	int dingzhang();
	/**
	 * 摸牌
	 * @return
	 */
	int getOneMahjong();
	/**
	 * 出牌
	 * @param mahjongValue
	 * @return
	 */
	int putOneMahjong(int mahjongValue);
	/**
	 * 碰牌
	 * @param devil
	 * @return
	 */
	int peng(Player devil);
	/**
	 * 杠牌
	 * @param devil
	 * @return
	 */
	boolean gang(Player devil);
	/**
	 * 杠牌(自杠)
	 * @return
	 */
	boolean gang();
	/**
	 * 胡牌
	 * @param devil
	 * @return
	 */
	boolean hu(PlayerService devil, boolean isZihu);

}
