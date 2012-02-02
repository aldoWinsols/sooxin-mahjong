package com.girlfriend.services{
	import flash.data.SQLConnection;
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
		
		public static var logs:ArrayCollection = new ArrayCollection();
		
		private var sqlc:SQLConnection = new SQLConnection();
		private var sqls:SQLStatement = new SQLStatement();
		private var sqlStrs:Array = new Array();
		private var selectPlayerName:String = null;
		
		private var operation:String = "";
		
		public function DataService(){
			var db:File = File.applicationStorageDirectory.resolvePath("girlfriendData.db");
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
			
			sqls.text = "CREATE TABLE IF NOT EXISTS worklog ( id INTEGER PRIMARY KEY AUTOINCREMENT, workStartTime TEXT, workEndTime TEXT, wordDate TEXT);";
			sqls.execute();
			resault(null);
		}
		
		public function addWorklog(workStartTime:String,workEndTime:String, wordDate:String):void{
			operation = "worklog";
			if(workEndTime == ""){
				sqls.text = "INSERT INTO worklog (workStartTime, workEndTime, wordDate) VALUES('"+workStartTime+"','"+workEndTime+"','" + wordDate + "');";
				sqls.execute();
			}else{
				sqls.text = "UPDATE worklog SET haveMoney = workEndTime+"+workEndTime+" where wordDate='"+wordDate+"'";
				sqls.execute();
			}
		}
		
		private function resault(e:SQLEvent):void
		{
			if(operation == "worklog"){	
				logs = new ArrayCollection(sqls.getResult().data);
				
			}
		}
		
		private function error(e:SQLErrorEvent):void
		{
			
		}
		
		//-----------------------------------------------------------------------------
		
		public function getPlayers():void{
			sqls.text = "SELECT * FROM players";
			sqls.execute();
		}
		
		private function refresh(e:TimerEvent = null):void
		{
			var timer:Timer = new Timer(10,1);
			timer.addEventListener(TimerEvent.TIMER, refresh);
			
			if ( !sqls.executing )
			{
				sqls.text = "SELECT * FROM players"
				sqls.execute();
			}
			else
			{
				timer.start();
			}
		}
		
	}
}
