package com.services{
	
	import flash.data.SQLConnection;
	import flash.data.SQLMode;
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
		[Bindable]
		public static var menus:ArrayCollection = new ArrayCollection();
		public static var logs:ArrayCollection = new ArrayCollection();
		
		private var sqlc:SQLConnection = new SQLConnection();
		private var sqls:SQLStatement = new SQLStatement();
		private var sqlStrs:Array = new Array();
		private var selectPlayerName:String = null;
		
		private var table:String = "";
		
		public function DataService(){
			var db:File = File.applicationStorageDirectory.resolvePath("menu.db");
			sqlc.openAsync(db);
//			sqlc.open(db);
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
			
//			sqlStrs.push("CREATE TABLE IF NOT EXISTS players ( id INTEGER PRIMARY KEY AUTOINCREMENT, playerName TEXT, email TEXT, haveMoney DOUBLE);");
//			sqlStrs.push("CREATE TABLE IF NOT EXISTS gamelog ( id INTEGER PRIMARY KEY AUTOINCREMENT, playerName TEXT, roomNo TEXT, gameTime TEXT, preMoney DOUBLE, winLossMoneyAfterTax DOUBLE, afterMoney DOUBLE, gameContent TEXT);");
//			table = "create";
//			resault(null);
			
			refresh(null);
		}
		
		public static function getPlayerByIndex(index:int):Object{
			return menus.getItemAt(index);
		}
		
		private function resault(e:SQLEvent):void
		{
			if(table == "menuTable"){
				menus = new ArrayCollection(sqls.getResult().data);
				
				var arr:Array = new Array();
				for(var i:int=0; i<menus.length;i++){
					var pl:Object = menus.getItemAt(i);
//					arr.push("ID:"+pl.playerName+"      EMAIL:"+pl.email+"      积分:"+pl.haveMoney);
				}
				menu.instance.dg.dataProvider = menus;
//				HomeControl.instance.home.players.dataProvider = new ArrayList(arr);
			}else if(table == "gamelog"){
				logs = new ArrayCollection(sqls.getResult().data);
//				HomeControl.instance.home.history.showHistory(logs.toArray());
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
//			Alert.show(e.toString());
		}
		
		//-----------------------------------------------------------------------------
		
		
		public function getMenus():void{
			table = "menuTable";
			sqls.text = "SELECT * FROM menuTable";
			sqls.execute();
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
				table = "menuTable";
				sqls.text = "SELECT * FROM menuTable"
				sqls.execute();
			}
			else
			{
				timer.start();
			}
		}
	}
}
