package com.mahjongSyncServer.util;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import com.mahjongSyncServer.model.Balance;
import com.mahjongSyncServer.model.Message;
import com.mahjongSyncServer.services.BalanceService;
import com.mahjongSyncServer.services.PlayerService;
/**
 * 公共类(洗牌...等)
 * @author Administrator
 *
 */
public class Util {
	
	private int[] mahjongs = null;				//麻将初始值
	private int onlineNum = 0;
	private double TransformerWinGailv = 90;
	public static Util insance = new Util();
	private String[] strs = null;
	
	/**
	 * 使用单例模式
	 * @return
	 */
	public static Util getInsance(){
		return insance;
	}
	
	private Util(){
		
		//所有麻将
		mahjongs = new int[]{1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 
							 6, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8, 8, 9, 9, 9, 9, 11, 11, 11, 11,
							 12, 12, 12, 12, 13, 13, 13, 13, 14, 14, 14, 14, 15, 15, 15, 15,
							 16, 16, 16, 16, 17, 17, 17, 17, 18, 18, 18, 18, 19, 19, 19, 19,
							 21, 21, 21, 21, 22, 22, 22, 22, 23, 23, 23, 23, 24, 24, 24, 24,
							 25, 25, 25, 25, 26, 26, 26, 26, 27, 27, 27, 27, 28, 28, 28, 28,
							 29, 29, 29, 29};
		
		strs = new String[]{
			"1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
		};
		
//		mahjongs = new int[]{1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 
//							 6, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8, 8, 9, 9, 9, 9, 11, 11, 11, 11,
//							 12, 12, 12, 12, 13, 13, 13, 13, 14, 14, 14, 14, 15, 15, 15, 15,
//							 16, 16, 16, 16, 17, 17, 17, 17, 18, 18, 18, 18, 19, 19, 19, 19,
//							 21, 21, 21, 21, 22, 22, 22, 22, 23, 23, 23, 23, 24, 24, 24, 24,
//							 25, 25, 25, 25, 26, 26, 26, 26, 27, 27, 27, 27, 28, 28, 28, 28,
//							 29, 29, 29, 29};
//		
//		//强杠测试数组
//		mahjongs = new int[]{1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 
//							 6, 6, 6, 6, 7, 12, 7, 7, 8, 8, 18, 18, 9, 9, 9, 19, 19, 16, 17, 19,
//							 7, 8, 12, 12, 13, 13, 13, 13, 14, 14, 14, 14, 15, 15, 15, 15,
//							 16, 16, 16, 11, 11, 17, 17, 17, 18, 18, 12, 8, 11, 11, 19, 19,
//							 21, 21, 21, 21, 22, 22, 22, 22, 23, 23, 23, 23, 24, 24, 24, 24,
//							 25, 25, 25, 25, 26, 26, 26, 26, 27, 27, 27, 27, 28, 28, 28, 28,
//							 29, 29, 29, 29};
	}
	
	/**
	 * int数组转换为List集合
	 * @param mahjongs
	 * @return
	 */
	public ArrayList<Integer> intChangeList(int[] mahjongs){
		
		ArrayList<Integer> mahjongList = new ArrayList<Integer>();
		
		for (int i = 0; i < mahjongs.length; i++) {
			mahjongList.add(mahjongs[i]);
		}
		
		return mahjongList;
		
	}
	/**
	 * 洗牌，不限洗牌的张数
	 * @param mahjongList
	 * @return
	 */
	public ArrayList<Integer> getRandow(){
		ArrayList<Integer> mahjongList = intChangeList(mahjongs);
		Collections.shuffle(mahjongList,new Random());
		return mahjongList;
	}
	/**
	 * 小数点后取2位 2位后的截去不要
	 * 
	 * @param value
	 * @return
	 */
	public double fixed(double value) {
		value = value * Math.pow(10, 2);
		String s = String.valueOf(value);
		String need = s.split("\\.")[0];
		value = Double.valueOf(need) / Math.pow(10, 2);
		return value;
	}
	/**
	 * 对集合排序
	 * 
	 * @param list
	 */
	public static void sort(ArrayList<Integer> list) {
		Collections.sort(list, new Comparator<Integer>() {
			public int compare(Integer o1, Integer o2) {
				// 按代理级别从上到下排序
				if (o1 > o2) {
					return 1;
				} else {
					return -1;
				}
			}

		});
	}
	
	/**
	 * 随机获得三个字母
	 * @return
	 */
	public String getRandomStr(){
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < 3; i++) {
			int romderNum = (int)(Math.random() * strs.length);
			sb.append(strs[romderNum]);
		}
		sb.append("*");
		sb.append("*");
		sb.append("*");
		sb.append("*");
		for (int i = 0; i < 3; i++) {
			int romderNum = (int)(Math.random() * strs.length);
			sb.append(strs[romderNum]);
		}
		return "G:"+sb.toString();
	}
	
	public int getOnlineNum() {
		return onlineNum;
	}

	public void setOnlineNum(int onlineNum) {
		this.onlineNum = onlineNum;
	}

	/**
	 * 机器人执行智能摸牌的概率
	 * @return
	 */
	public double getTransformerWinGailv() {
		return TransformerWinGailv;
	}
	/**
	 * 设置机器人执行智能摸牌的概率
	 * @param transformerWinGailv
	 */
	public void setTransformerWinGailv(double transformerWinGailv) {
		TransformerWinGailv = transformerWinGailv;
	}
	
	
	public static void main(String[] args){
		
		String context = "h1102!1!22.28.4.26.4.6.4.27.14.8.15.7.9.;m001!2!28.12.7.24.6.17.3.15.16.1.15.18.4.;m003!3!24.29.26.11.21.25.27.2.16.13.8.2.11.;m002!4!11.2.29.2.1.16.15.18.9.14.19.18.26.;beg,1314174256910,3,5;get,3,28;sd,4;sd,2;sd,1;din,2,24;din,4,26;din,1,14;sd,3;din,3,2;put,3,2,1;so,4,peng;pen,4,2;put,4,26,1;get,1,1;put,1,14,1;get,2,17;put,2,24,1;get,3,3;put,3,2,0;get,4,23;put,4,29,0;get,1,23;put,1,15,0;so,2,peng;pen,2,15;put,2,28,0;get,3,22;put,3,3,0;get,4,21;put,4,23,0;get,1,19;put,1,19,0;get,2,8;put,2,1,0;get,3,6;put,3,8,0;get,4,13;put,4,21,0;get,1,5;put,1,5,0;get,2,7;put,2,7,0;get,3,22;put,3,6,0;get,4,12;put,4,1,0;get,1,7;put,1,7,0;get,2,19;put,2,12,0;get,3,24;put,3,16,0;get,4,19;put,4,9,0;get,1,9;put,1,9,0;get,2,3;put,2,4,0;so,1,peng,gang;get,3,23;put,3,13,0;get,4,8;put,4,8,0;get,1,5;put,1,5,0;get,2,27;put,2,27,0;get,3,29;put,3,11,0;get,4,21;put,4,21,0;get,1,17;put,1,17,0;so,2,peng;pen,2,17;put,2,19,0;so,4,hu,peng;huI,4,19,0,1,0,0;get,1,6;put,1,6,0;get,2,13;put,2,13,0;get,3,26;put,3,11,0;get,1,3;put,1,3,0;so,2,peng;pen,2,3;put,2,18,0;get,3,25;put,3,25,0;get,1,5;put,1,5,0;get,2,5;put,2,5,0;get,3,14;put,3,14,0;get,1,1;put,1,1,0;get,2,27;put,2,27,0;get,3,23;so,3,zihu;huI,3,23,1,0,0,0;get,1,12;put,1,12,0;get,2,11;put,2,11,0;get,1,9;put,1,9,0;get,2,22;put,2,22,0;get,1,17;put,1,17,0;get,2,13;put,2,13,0;get,1,21;put,1,21,0;get,2,14;put,2,14,0;get,1,25;put,1,25,0;get,2,25;put,2,25,0;get,1,12;put,1,12,0;get,2,18;put,2,18,0;get,1,29;put,1,29,0;get,2,28;put,2,28,0;get,1,16;put,1,16,0;so,2,hu;huI,2,16,0,1,0,0;over,放炮"
		+"平胡  :0.0:-5.0:0.0:5.0,自摸"
		+"清一色  :-40.0:-40.0:80.0:0.0,放炮"
		+"平胡  :-5.0:5.0:0.0:0.0;";
		
		System.out.println("最后输赢：" + dd(context, "h1102"));
		
	}
	
	/**
	 * 
	 * @param content 游戏内容
	 * @param name 玩家名字（他的最后输赢）
	 * @return
	 */
	public static double dd(String content, String name){
		
		String[] strs = content.split(";");
		String[] names = new String[4];

		for (int i = 0; i < 4; i++) {
			names[i] = strs[i];
		}
		
		HashMap<String, String> map = new HashMap<String, String>();
		
		for (int i = 0; i < names.length; i++) {
			String[] ss = names[i].split("!");
			map.put(ss[0], ss[1]);
		}
		
		int azimuth = 0;
		
		for (String string : map.keySet()) {
			if(string.equals(name)){
				azimuth = Integer.valueOf(map.get(string));
				break;
			}
		}
		
		String result = strs[strs.length - 1];
		String[] results = result.split(",");
	
		double r = 0;
		for (int i = 1; i < results.length; i++) {
			String[] re = results[i].split(":");
			r += Double.valueOf(re[azimuth]);
		}
		
		return r;
	}
	
	public String getHistoryMessage(ArrayList<Message> historyMessages,ArrayList<PlayerService> playerServices){
		String str = "";
		
		for (int i = 0; i < playerServices.size(); i++) {
			if(playerServices.get(i).getPlayer().getPlayerType() == 3){
				str += playerServices.get(i).getPlayer().getRandomPlayerName() + "!" + 
					playerServices.get(i).getPlayer().getAzimuth() + "!" + 
					playerServices.get(i).getPlayer().getSparrStr() + ";";	
			}else{
				str += playerServices.get(i).getPlayer().getPlayerName() + "!" + 
					playerServices.get(i).getPlayer().getAzimuth() + "!" + 
					playerServices.get(i).getPlayer().getSparrStr() + ";";
			}
		}
		
		for (int i = 0; i < historyMessages.size(); i++) {
			ArrayList<Object> list = (ArrayList<Object>)historyMessages.get(i).getContent();
			if(historyMessages.get(i).getHead().equals("showOperationI")){
				str += "so,";
			}else if(historyMessages.get(i).getHead().equals("gangI")){
				str += "gan,";
			}else if(historyMessages.get(i).getHead().equals("putOneMahjongI")){
				str += "put,";
			}else if(historyMessages.get(i).getHead().equals("getOneMahjongI")){
				str += "get,";
			}else if(historyMessages.get(i).getHead().equals("huI")){
				str += "huI,";
			}else if(historyMessages.get(i).getHead().equals("beginGameI")){
				str += "beg," + list.get(0) + "," + list.get(1) + "," + UtilProperties.instance.getRoomNo();
			}else if(historyMessages.get(i).getHead().equals("pengI")){
				str += "pen,";
			}else if(historyMessages.get(i).getHead().equals("showDingzhangI")){
				str += "sd," + list.get(0);
			}else if(historyMessages.get(i).getHead().equals("dingzhangI")){
				str += "din,";
			}
			if(!historyMessages.get(i).getHead().equals("beginGameI") &&
					!historyMessages.get(i).getHead().equals("gameOverI") &&
					!historyMessages.get(i).getHead().equals("showDingzhangI")){
				for (int j = 0; j < list.size(); j++) {
					if(j == list.size() - 1){
						str += list.get(j);
					}else{
						str += list.get(j) + ",";
					}
				}
			}
			if(!historyMessages.get(i).getHead().equals("gameOverI")){
				str += ";";
			}
		}
		
		str += " 玩家当前的牌： "; 
		for (int i = 0; i < playerServices.size(); i++) {
			String spstr = playerServices.get(i).getPlayer().getPlayerName() + ", 牌字符串: ";
			for (int j = 0; j < playerServices.get(i).getPlayer().getSparr().size(); j++) {				
				spstr += playerServices.get(i).getPlayer().getSparr().get(j) + ",";
			}
			
			str += spstr + ";";
		}
		return str;
	}
	
}
