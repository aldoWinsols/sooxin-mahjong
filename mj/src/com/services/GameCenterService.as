package com.services
{
	import com.control.MainControl;
	import com.milkmangames.nativeextensions.ios.GameCenter;
	import com.milkmangames.nativeextensions.ios.events.GameCenterErrorEvent;
	import com.milkmangames.nativeextensions.ios.events.GameCenterEvent;
	
	import flash.net.SharedObject;

	public class GameCenterService
	{
		public static var instance:GameCenterService;
		private static const LEADERBOARD_ID:String="sichuanmahjong3";
		
		
		private static const ACHIEVEMENT_JP:String="jp";
		private static const ACHIEVEMENT_QYS:String="qys";
		private static const ACHIEVEMENT_XQD:String="xqd";
		private static const ACHIEVEMENT_DDZ:String="ddz";
		
		private var sharedObject:SharedObject;
		/** Score */
		private var score:int;
		public function GameCenterService()
		{
			
			loadScore();
			
//			createUI();
			init();
		}
		
		public static function getInstance():GameCenterService{
			if(instance == null){
				instance = new GameCenterService();
			}
			return instance;
		}
		
		/** Load Score */
		private function loadScore():void
		{
			sharedObject=SharedObject.getLocal("airgc");
			this.score=sharedObject.data["score"]||0;
		}
		
		/** Init */
		public function init():void
		{
			// check if gameCenter is supported.  note that this just determines platform support- iOS- and NOT whether
			// the user's os version has gamecenter installed!
			if (!GameCenter.isSupported())
			{
				log("GameCenter is not supported on this platform.");
//				removeChild(buttonContainer);
				return;
			}
			
			var gameCenter:GameCenter;
			log("initializing GameCenter...");		
			try
			{			
				gameCenter=GameCenter.create(MainControl.instance.main.stage);
			}
			catch (e:Error)
			{
				log("ERROR:"+e.message);
				return;
			}
			log("GameCenter Initialized.");
			
			log("Checking os level support...");
			
			
			// GameCenter doesn't work on iOS versions < 4.1, so always check this first!
			if (!gameCenter.isGameCenterAvailable())
			{
				log("this ios version doesn't have gameCenter.");
//				removeChild(buttonContainer);
				return;
			} 
			
			log("Game Center is ready.");
			
			// this is the complete suite of supported events.  you may not need to listen to all of them for your app,
			// however you should always listen for at least the 'failed' error events to avoid your app throwing errors.
			gameCenter.addEventListener(GameCenterEvent.AUTH_SUCCEEDED,onAuthSucceeded);
			
			gameCenter.addEventListener(GameCenterEvent.ACHIEVEMENTS_VIEW_OPENED,onViewOpened);
			gameCenter.addEventListener(GameCenterEvent.ACHIEVEMENTS_VIEW_CLOSED,onViewClosed);
			gameCenter.addEventListener(GameCenterEvent.LEADERBOARD_VIEW_OPENED,onViewOpened);
			gameCenter.addEventListener(GameCenterEvent.LEADERBOARD_VIEW_CLOSED,onViewClosed);
			gameCenter.addEventListener(GameCenterEvent.ACHIEVEMENT_REPORT_SUCCEEDED,onAchievementReported);
			gameCenter.addEventListener(GameCenterEvent.ACHIEVEMENT_RESET_SUCCEEDED,onAchievementReset);
			gameCenter.addEventListener(GameCenterEvent.SCORE_REPORT_SUCCEEDED,onScoreReported);
			
			gameCenter.addEventListener(GameCenterErrorEvent.AUTH_FAILED,onAuthFailed);
			gameCenter.addEventListener(GameCenterErrorEvent.SCORE_REPORT_FAILED,onScoreFailed);
			gameCenter.addEventListener(GameCenterErrorEvent.ACHIEVEMENT_REPORT_FAILED,onAchievementFailed);
			gameCenter.addEventListener(GameCenterErrorEvent.ACHIEVEMENT_RESET_FAILED,onResetFailed);		
		}
		
		private function onAuthSucceeded(e:GameCenterEvent):void
		{
			log("Auth succeeded!");
//			showFullUI();
			log("auth player:"+GameCenter.gameCenter.getPlayerAlias()+"="+GameCenter.gameCenter.getPlayerID()+",underage?"+GameCenter.gameCenter.isPlayerUnderage());
		}
		private function onAchievementReset(e:GameCenterEvent):void
		{
			log("achievements reset.");
			this.score=50000;
			saveScore();
//			this.txtScore.text="Score: "+score;
		}
		
		private function onAuthFailed(e:GameCenterErrorEvent):void
		{
			log("Auth failed:"+e.message);
//			showAuthUI();
		}
		private function onViewOpened(e:GameCenterEvent):void
		{
			log("gamecenter view opened.");
		}
		private function onViewClosed(e:GameCenterEvent):void
		{
			log("gamecenter view closed.");
		}
		private function onAchievementReported(e:GameCenterEvent):void
		{
			log("achievement report success:"+e.achievementID);
		}
		private function onAchievementFailed(e:GameCenterErrorEvent):void
		{
			log("achievement report failed:msg="+e.message+",cd="+e.errorID+",ach="+e.achievementID);
		}
		private function onScoreReported(e:GameCenterEvent):void
		{
			log("score report success:"+e.score+"/"+e.category);
		}
		private function onScoreFailed(e:GameCenterErrorEvent):void
		{
			log("score report failed:msg="+e.message+",cd="+e.errorID+",scr="+e.score+",cat="+e.category);
		}
		private function onResetFailed(e:GameCenterErrorEvent):void
		{
			log("failed to reset:"+e.message);
		}
		
		/** Save Score */
		private function saveScore():void
		{
			sharedObject.data["score"]=this.score;
			sharedObject.flush();
		}
		
		/** Log */
		private function log(msg:String):void
		{
			trace("[GameCenterExample] "+msg);
		}
		
		/** Check Authentication */
		private function checkAuthentication():Boolean
		{
			if (!GameCenter.gameCenter.isUserAuthenticated())
			{
				log("not logged in!");
				return false;
			}
			return true;
		}
		
		/** Show Leaderboards */
		public function showLeaderboard():void
		{
			if (!checkAuthentication()) return;
			GameCenter.gameCenter.showLeaderboardForCategory(LEADERBOARD_ID);
		}
		
		public function reportAchievement(ACHIEVEMENT_ID:String):void
		{
			if (!checkAuthentication()) return;
			
			// the '1.0' is a float (Number) value from 0.0-100.0 the percent completion of the achievement.
			GameCenter.gameCenter.reportAchievement(ACHIEVEMENT_ID,100.0);
		}
	}
}