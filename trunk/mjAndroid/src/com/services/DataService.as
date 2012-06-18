package com.services{
	import com.control.HomeControl;
	import com.mahjongSyncServer.model.Balance;
	import com.mahjongSyncServer.model.Message;
	import com.mahjongSyncServer.model.Player;
	import com.mahjongSyncServer.services.BalanceService;
	import com.mahjongSyncServer.services.PlayerService;
	import com.mahjongSyncServer.util.PlayerTypeEnum;
	import com.model.Alert;
	
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	
	
	public class DataService {
		private static var _instance:DataService;
		
		public static var players:ArrayCollection = new ArrayCollection();
		public static var logs:ArrayCollection = new ArrayCollection();
		
		private var sqlc:SQLConnection = new SQLConnection();
		private var sqls:SQLStatement = new SQLStatement();
		private var sqlStrs:Array = new Array();
		private var selectPlayerName:String = null;
		
		private var table:String = "";
		
		public function DataService(){
			var db:File = File.applicationStorageDirectory.resolvePath("data2.db");
			sqlc.openAsync(db);
			sqlc.addEventListener(SQLEvent.OPEN, db_opened);
			sqlc.addEventListener(SQLErrorEvent.ERROR, error);
			sqls.addEventListener(SQLEvent.RESULT, resault);
		}
		
		public static function get instance():DataService
		{
			if(_instance == null){
				_instance = new DataService();
			}
			return _instance;
		}
		
		public static function set instance(value:DataService):void
		{
			_instance = value;
		}
		
		private function db_opened(e:SQLEvent):void
		{
			sqls.sqlConnection = sqlc;
			
			sqlStrs.push("CREATE TABLE IF NOT EXISTS players ( id INTEGER PRIMARY KEY AUTOINCREMENT, playerName TEXT, email TEXT, haveMoney DOUBLE);");
			sqlStrs.push("CREATE TABLE IF NOT EXISTS gamelog ( id INTEGER PRIMARY KEY AUTOINCREMENT, playerName TEXT, roomNo TEXT, gameTime TEXT, preMoney DOUBLE, winLossMoneyAfterTax DOUBLE, afterMoney DOUBLE, gameContent TEXT);");
			
			sqlStrs.push("INSERT INTO players (playerName, email, haveMoney) VALUES('player','','10000');");
			
			table = "create";
			resault(null);
		}
		
		public static function getPlayerByIndex(index:int):Object{
			return players.getItemAt(index);
		}
		
		private function resault(e:SQLEvent):void
		{
			if(table == "player"){
				players = new ArrayCollection(sqls.getResult().data);
				
				var arr:Array = new Array();
				for(var i:int=0; i<players.length;i++){
					var pl:Object = players.getItemAt(i);
					arr.push("ID:"+pl.playerName+"      EMAIL:"+pl.email+"      积分:"+pl.haveMoney);
				}
				
				//				DanjiHomeControl.instance.danjiHome.players.dataProvider = new ArrayList(arr);
			}else if(table == "gamelog"){
				logs = new ArrayCollection(sqls.getResult().data);
				HomeControl.instance.home.currentState = "log";
				HomeControl.instance.home.history.showHistory(logs.toArray());
			}else if(table == "create"){
				sqls.text = sqlStrs.shift();
				sqls.execute();
				if(sqlStrs.length == 0){
					table = "";
					refresh();
				}
			}
		}
		
		private function error(e:SQLErrorEvent):void
		{
			Alert.show(e.toString());
		}
		
		//-----------------------------------------------------------------------------
		
		public function addPlayer(playerName:String,email:String):void{
			sqls.text = "INSERT INTO players (playerName, email, haveMoney) VALUES('"+playerName+"','"+email+"','10000');";
			sqls.execute();
			refresh();
			
//			DanjiHomeControl.instance.danjiHome.playerAdd.visible = false;
		}
		
		public function removePlayer(id:Number, playerName:String):void
		{
			table = "create";
			sqlStrs.push("DELETE FROM players WHERE id="+id);
			sqlStrs.push("DELETE FROM gamelog WHERE playerName='"+playerName+"'");
			resault(null);
		}
		
		public function removeGameLog(id:Number,playerName:String):void{
			sqls.text = "DELETE FROM gamelog WHERE id="+id;
			sqls.execute();
			selectPlayerName = playerName;
			refresh1();
		}
		
		public function getPlayers():void{
			table = "player";
			sqls.text = "SELECT * FROM players";
			sqls.execute();
		}
		
		public function updatePlayerMoney(playerName:String,changeMoney:int):void{
			//			sqls.text = "UPDATE players SET haveMoney = haveMoney+"+changeMoney+" where playerName='"+playerName+"'";
			//			sqls.execute();
			//			table = "create";
			//			sqlStrs.push("UPDATE players SET haveMoney = haveMoney+"+changeMoney+" where playerName='"+playerName+"'");
			//			resault(null);
			//			refresh();
		}
		
		public function saveGameHistory(playerName:String, gameContent:String, roomNo:String, gameTime:String, preMoney:Number, winLossMoneyAfterTax:Number, afterMoney:Number):void
		{
			//			table = "create";
			//			sqls.text = "INSERT INTO gamelog (playerName, roomNo, gameTime, preMoney, winLossMoneyAfterTax, afterMoney, gameContent) VALUES('"+playerName + "','" + roomNo + "','" + gameTime + "','" + preMoney + "','" + winLossMoneyAfterTax + "','" + afterMoney +"','"+ gameContent +"');";
			//			sqlStrs.push("INSERT INTO gamelog (playerName, roomNo, gameTime, preMoney, winLossMoneyAfterTax, afterMoney, gameContent) VALUES('"+playerName + "','" + roomNo + "','" + gameTime + "','" + preMoney + "','" + winLossMoneyAfterTax + "','" + afterMoney +"','"+ gameContent +"');");
			//			sqls.execute();
			//			refresh();
		}
		
		public function afterData(playerName:String,changeMoney:int, gameContent:String, roomNo:String, gameTime:String, preMoney:Number, winLossMoneyAfterTax:Number, afterMoney:Number):void{
			table = "create";
			sqlStrs.push("UPDATE players SET haveMoney = haveMoney+"+changeMoney+" where playerName='"+playerName+"'");
			sqlStrs.push("INSERT INTO gamelog (playerName, roomNo, gameTime, preMoney, winLossMoneyAfterTax, afterMoney, gameContent) VALUES('"+playerName + "','" + roomNo + "','" + gameTime + "','" + preMoney + "','" + winLossMoneyAfterTax + "','" + afterMoney +"','"+ gameContent +"');");
			resault(null);
		}
		
		public function getGameHistory(playerName:String):void{
			table = "gamelog";
			sqls.text = "SELECT * FROM gamelog where playerName='"+playerName+"'";
			sqls.execute();
		}
		
		private function refresh(e:TimerEvent = null):void
		{
			var timer:Timer = new Timer(10,1);
			timer.addEventListener(TimerEvent.TIMER, refresh);
			
			if ( !sqls.executing )
			{
				table = "player";
				sqls.text = "SELECT * FROM players"
				sqls.execute();
			}
			else
			{
				timer.start();
			}
		}
		
		private function refresh1(e:TimerEvent = null):void
		{
			var timer:Timer = new Timer(10,1);
			timer.addEventListener(TimerEvent.TIMER, refresh1);
			
			if ( !sqls.executing )
			{
				table = "gamelog";
				sqls.text = "SELECT * FROM gamelog where playerName='"+selectPlayerName+"'";
				sqls.execute();
			}
			else
			{
				timer.start();
			}
		}
		
		public function getHistoryMessage(historyMessages:Vector.<Message>,playerServices:Vector.<PlayerService>):String{
			var str:String = "";
			
			for (var i:int = 0; i < playerServices.length; i++) {
				if(playerServices[i].player.playerType == PlayerTypeEnum.ANDROID){
					str += playerServices[i].player.playerName + "!" + 
						playerServices[i].player.azimuth + "!" + 
						playerServices[i].player.sparrStr + ";";
				}else{
					str += playerServices[i].player.playerName + "!" + 
						playerServices[i].player.azimuth + "!" + 
						playerServices[i].player.sparrStr + ";";
				}
			}
			
			for (var i:int = 0; i < historyMessages.length; i++) {
				var list:Array = Array(historyMessages[i].content);
				if(historyMessages[i].head == "showOperationI"){
					str += "so,";
				}else if(historyMessages[i].head == "gangI"){
					str += "gan,";
				}else if(historyMessages[i].head == "putOneMahjongI"){
					str += "put,";
				}else if(historyMessages[i].head == "getOneMahjongI"){
					str += "get,";
				}else if(historyMessages[i].head == "huI"){
					str += "huI,";
				}else if(historyMessages[i].head == "beginGameI"){
					str += "beg," + list[0] +",5";
				}else if(historyMessages[i].head == "pengI"){
					str += "pen,";
				}else if(historyMessages[i].head == "showDingzhangI"){
					str += "sd," + list[0];
				}else if(historyMessages[i].head == "dingzhangI"){
					str += "din,";
				}
				if(!(historyMessages[i].head == "beginGameI") &&
					!(historyMessages[i].head == "gameOverI") &&
					!(historyMessages[i].head == "showDingzhangI")){
					for (var j:int = 0; j < list.length; j++) {
						if(j == list.length - 1){
							str += list[j];
						}else{
							str += list[j] + ",";
						}
					}
				}
				if(!(historyMessages[i].head == "gameOverI")){
					str += ";";
				}
			}
			
			var balanceList:Vector.<Balance> = BalanceService.instance.balanceList;
			str += "over,";
			for (var i:int = 0; i < balanceList.length; i++) {
				if(i == balanceList.length - 1){
					str += balanceList[i].balanceName + ":" + balanceList[i].azimuth1 + ":" + 
						balanceList[i].azimuth2 + ":" + balanceList[i].azimuth3 + ":" + balanceList[i].azimuth4 + ";";
				}else{
					str += balanceList[i].balanceName + ":" + balanceList[i].azimuth1 + ":" + 
						balanceList[i].azimuth2 + ":" + balanceList[i].azimuth3 + ":" + balanceList[i].azimuth4 + ",";
				}
			}
			if(balanceList.length == 0){
				str += ";";
			}
			return str;
		}
		
	}
}
