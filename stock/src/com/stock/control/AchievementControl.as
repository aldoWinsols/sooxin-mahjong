package com.stock.control
{
	import com.stock.services.BargainService;
	import com.stock.services.RemoteService;
	import com.stock.view.Achievement;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;

	public class AchievementControl
	{
		public static var instance:AchievementControl;
		private var achievement:Achievement;
		public function AchievementControl(achievement:Achievement)
		{
			this.achievement = achievement;
			instance = this;
		}
		
		public function getAchievements(){
			RemoteService.instance.stockInfoService.getAchievements(BargainService.instance.stock.stockCode);
			RemoteService.instance.stockInfoService.addEventListener(ResultEvent.RESULT,getAchievementsResultHandler);
		}
		
		protected function getAchievementsResultHandler(event:ResultEvent):void
		{
			// TODO Auto-generated method stub
			RemoteService.instance.stockInfoService.removeEventListener(ResultEvent.RESULT,getAchievementsResultHandler);
			this.achievement.dg.dataProvider = event.result as ArrayCollection;
		}
	}
}