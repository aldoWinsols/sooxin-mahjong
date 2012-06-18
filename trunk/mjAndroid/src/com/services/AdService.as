package  com.services
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.placeplay.*;
	import com.placeplay.targeting.*;
	import com.placeplay.events.*;
	
	public class AdService extends Sprite
	{
		
		/** Place Play App ID - replace with your own app ID.  Email info@placeplay.com to get a personal ID. */
		public static const PP_APP_ID:String="32389372";
		
		/** Create New PlacePlayExample */
		public function AdService() 
		{	
			if (!PlacePlay.isSupported())
			{
				log("PlacePlay is not supported on this platform (not android or ios!)");
				return;
			}
			
			log("Init PlacePlay...");
			try
			{
				// these tracking parameters are completely optional- but the demographic information
				// will help increase your CPMs.
				var targetingParams:PlacePlayParams=new PlacePlayParams();
				targetingParams.keywords=["action","adventure"];
				targetingParams.gender=PPGender.MALE;
				targetingParams.age=25;
				targetingParams.maritalStatus=PPMaritalStatus.MARRIED;
				targetingParams.incomeLevel=PPIncomeLevel.fromNumber(35000);
				targetingParams.educationLevel=PPEducationLevel.BACHELOR;
				targetingParams.ethnicGroup=PPEthnicGroup.EASTERN_EUROPEAN;
				
				PlacePlay.create(PP_APP_ID,targetingParams);
			}
			catch (e:Error)
			{
				log("Failed create:"+e.message);
			}
			
			PlacePlay.placePlay.addEventListener(PlacePlayEvent.AD_FAILED,onAdFailed);
			PlacePlay.placePlay.addEventListener(PlacePlayEvent.AD_LOADED,onAdLoaded);
			PlacePlay.placePlay.addEventListener(PlacePlayEvent.WILL_LEAVE_APPLICATION,onLeaveApplication);
			PlacePlay.placePlay.addEventListener(PlacePlayEvent.FULL_SCREEN_MODAL_DISMISSED,onModalDismissed);
			PlacePlay.placePlay.addEventListener(PlacePlayEvent.FULL_SCREEN_MODAL_PRESENTED,onModalPresented);
			
			log("ready.");	
			
			createBannerAdTopLeft();
			adVisibilityOn();
		}
		
		/** Create Banner Ad */
		public function createBannerAdTopCenter():void
		{
			log("Creating ad topcenter..");
			PlacePlay.placePlay.createBannerAd(PPBannerAlignment.TOP,PPBannerAlignment.CENTER);
			log("Ad Created.");
		}
		
		/** Create Banner Ad */
		public function createBannerAdTopLeft():void
		{
			log("Creating ad topcenter..");
			PlacePlay.placePlay.createBannerAd(PPBannerAlignment.TOP,PPBannerAlignment.LEFT);
			log("Ad Created.");
		}
		
		/** Create Banner Ad Bottom Right */
		public function createBannerBottomRight():void
		{
			log("Creating ad bottom right...");
			PlacePlay.placePlay.createBannerAd(PPBannerAlignment.BOTTOM,PPBannerAlignment.RIGHT);
			log("Ad created.");
		}
		
		/** Destroy Banner Ad */
		public function destroyBannerAd():void
		{
			log("Destroying ad...");
			PlacePlay.placePlay.destroyBannerAd();
			log("Ad Destroyed.");
		}
		
		/** Refresh Banner Ad */
		public function refreshBannerAd():void
		{
			log("Refreshing Ad...");
			PlacePlay.placePlay.refreshBannerAd();
			log("Ad refreshed.");
		}
		
		/** Hide Banner Ad */
		public function adVisibilityOn():void
		{
			log("Setting visibility...");
			PlacePlay.placePlay.setBannerVisibility(true,true);
			log("Ad visibility ON.");
		}
		
		/** Show Banner Ad */
		public function adVisibilityOff():void
		{
			log("Setting visibility...");
			PlacePlay.placePlay.setBannerVisibility(false,true);
			log("Ad Visibility OFF.");
		}	
		
		//
		// Events
		//	
		
		/** Ad Loaded */
		private function onAdLoaded(e:PlacePlayEvent):void
		{
			log("Ad loaded!");
		}
		
		/** Ad Failed to Load */
		private function onAdFailed(e:PlacePlayEvent):void
		{
			log("Ad failed!");
		}
		
		
		/** Modal Presented */
		public function onModalPresented(e:PlacePlayEvent):void
		{
			log("modal shown!");
			// here you might want to pause music or otherwise suspend your app
		}
		
		/** Modal Dismissed */
		public function onModalDismissed(e:PlacePlayEvent):void
		{
			log("modal dismissed.");
			// here you would resume your app
		}
		
		/** Leaving Application */
		public function onLeaveApplication(e:PlacePlayEvent):void
		{
			log("Leaving app for ad!");
		}
		
		/** Log */
		private function log(msg:String):void
		{
			trace("[PPExample] "+msg);
		}	
		
	}
}