package com.panda.inter;

import com.panda.dao.Playlog;

/**
 * 棋牌遊戲結算服務,可限制ip访问
 * 
 * @author Pan Jin Feng
 * 
 * 	when				what	who				comments	 
 * 
 * [2011-6-8_09:43:56	mod		Pan Jin Feng] 棋牌分为5元麻将、10元麻将、20元麻将、50元麻将保存记录
 */
public interface IBalanceChessGameService {

	/**
	 * 麻將結算
	 * 
	 * <pre>
	 * 	注意：調用此方法時須要對playlog做以下設置,
	 * 		playLog.setGameContent(String(&quot;遊戲內容&quot;));
	 * 		playLog.setGameName(String(&quot;遊戲名稱&quot;));
	 * 		playLog.setGameNo(String(&quot;局號&quot;));
	 * 		playLog.setPlayerName(String(&quot玩家名稱&quot;));
	 * 		playLog.setWinLossMoneyBeforeTax(Number(輸贏點數-稅前));
	 * 		playLog.setGameIp(String(IP地址));
	 * 
	 * 		[reversion 2011-6-8_10:02:33 Pan Jin Feng]
	 * 		playLog.setGameSubClass(String(游戏子类型)),参考{@link com.the4thcity.model.AbstractGameClass};
	 * 
	 * </pre>
	 * 
	 * @param playLogA
	 *            玩家A遊戲記錄
	 * @param playLogB
	 *            玩家B遊戲記錄
	 * @param playLogC
	 *            玩家C遊戲記錄
	 * @param playLogD
	 *            玩家D遊戲記錄
	 * @return true:結算成功<br/>
	 *         flase:結算失敗<br/>
	 */
	public boolean balanceMajong(Playlog playLogA, Playlog playLogB, Playlog playLogC, Playlog playLogD);

	public void setPlayerOfflineGameNo(String playerName, int offlineGameNo);
}
