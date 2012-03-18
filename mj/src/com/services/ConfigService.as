package com.service
{
	import com.amusement.CustomerServiceChat.service.CustomerServiceSyncService;
	import com.control.MainSceneControl;
	import com.control.RightControl;
	import com.control.RollAreaControl;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class ConfigService
	{
		private static var _instance:ConfigService;
		
		private var _mainDataServerURL:String = "";
		private var _mainSyncServerURL:String = "";
		private var _customerServiceSyncServerURL:String = "";
		
//		private var _goURL:String = "";
		
		private var _mahjongSyncServerURL1:String = "";
		private var _mahjongSyncServerURL5:String = "";
		private var _mahjongSyncServerURL10:String = "";
		private var _mahjongSyncServerURL20:String = "";
		private var _mahjongSyncServerURL50:String = "";
		
		private var _landlordSyncServerURL1:XMLList;
		private var _landlordSyncServerURL2:XMLList;
		private var _landlordSyncServerURL3:XMLList;
		private var _landlordSyncServerURL4:XMLList;
		private var _landlordSyncServerURL5:XMLList;
		
		private var _hundredHappy:String = "";
		private var _chainGunSyncService:String = "";
		private var _dartsSyncServerURL:String = "";
		
		private var _rouletteSyncServerURL1:String = "";
		private var _rouletteSyncServerURL2:String = "";
		private var _rouletteSyncServerURL3:String = "";
		private var _rouletteSyncServerURL4:String = "";
		
//		private var _sscRefURL:String = "";//pjf 2011-12-2_13:58:44 時時彩參考url
		
		private var _supplementURL:String = "";
		[Bindable]
		public var customerServiceTelephone:String = "";
		[Bindable]
		public var customerServiceEmail:String = "";
		[Bindable]
		public var customerServiceQQ:String = "";
		
		[Bindable]
		public var versionNumber:String = "";//版本号
		
		private var _gameFlagList:XMLList;
		private var _newbieVideoList:XMLList;
		private var _rollImgList:XMLList;
		private var _rightImgList:XMLList;
		private var _alternateNames:XMLList;
		private var _musicList:XMLList;
		
		public function ConfigService()
		{
			versionNumber = "2.5";
		}

		public static function get instance():ConfigService
		{
			if(_instance == null){
				_instance = new ConfigService();
			}
			return _instance;
		}
		
		public function init():void{
			var loader:URLLoader = new URLLoader(new URLRequest("./assets/config.xml"));
			loader.addEventListener(Event.COMPLETE, loadCompleteHandler, false, 0, true);
		}
		
		private function loadCompleteHandler(event:Event):void{
			var loader:URLLoader = URLLoader(event.currentTarget);
			var configXML:XML = XML(loader.data);
			
			_mainDataServerURL = configXML.mainDataServerURL;
			_mainSyncServerURL = configXML.mainSyncServerURL;
			_customerServiceSyncServerURL = configXML.customerServiceSyncServerURL;
			
//			_goURL = configXML.goURL;
			
			_mahjongSyncServerURL1 = configXML.mahjongSyncServerURL1
			_mahjongSyncServerURL5 = configXML.mahjongSyncServerURL5;
			_mahjongSyncServerURL10 = configXML.mahjongSyncServerURL10;
			_mahjongSyncServerURL20 = configXML.mahjongSyncServerURL20;
			_mahjongSyncServerURL50 = configXML.mahjongSyncServerURL50;
			
			_landlordSyncServerURL1 = configXML.landlordSyncServerURL1;
			_landlordSyncServerURL2 = configXML.landlordSyncServerURL2;
			_landlordSyncServerURL3 = configXML.landlordSyncServerURL3;
			_landlordSyncServerURL4 = configXML.landlordSyncServerURL4;
			_landlordSyncServerURL5 = configXML.landlordSyncServerURL5;
			
			_hundredHappy = configXML.hundredHappy;
			_chainGunSyncService = configXML.chainGunSyncService;
			_dartsSyncServerURL = configXML.dartsSyncServerURL;
			
			_rouletteSyncServerURL1 = configXML.rouletteSyncServerURL1;
			_rouletteSyncServerURL2 = configXML.rouletteSyncServerURL2;
			_rouletteSyncServerURL3 = configXML.rouletteSyncServerURL3;
			_rouletteSyncServerURL4 = configXML.rouletteSyncServerURL4;
			
//			_sscRefURL = configXML.sscRefURL;
			
			_supplementURL = configXML.supplementURL;
			
			customerServiceTelephone = configXML.customerServiceTelephone;
			customerServiceEmail = configXML.customerServiceEmail;
			customerServiceQQ = configXML.customerServiceQQ;
			
			_gameFlagList = configXML.gameFlags.gameFlag;
			
			//新手视频列表
			_newbieVideoList = configXML.newbieVideos.newbieVideo;
			
			//滚动图片列表
			_rollImgList = configXML.rollImgs.rollImg;
			RollAreaControl.instance.initImg();
			RollAreaControl.instance.start();
			//右侧图片列表
			_rightImgList = configXML.rightImgs.rightImg;
			RightControl.instance.initImgs();
			
			_alternateNames = configXML.alternateNames.alternateName;
			
			//音乐列表
			/*_musicList = configXML.musics.music;
			MusicService.instance.init();*/
			//------------------------------------------------
			//zj 2011-05-29 14:24 先检测系统是否正在维护，再获取公告
			MainSceneControl.instance.checkWeihu();
			
			//连接客服服务
			CustomerServiceSyncService.instance.connServer();
		}

		//------------------------------------- getter/setter function -------------------------------------
		
		public function get mainDataServerURL():String
		{
			return _mainDataServerURL;
		}
		
		public function get mainSyncServerURL():String
		{
			return _mainSyncServerURL;
		}
		
		public function get customerServiceSyncServerURL():String
		{
			return _customerServiceSyncServerURL;
		}
		
		public function get mahjongSyncServerURL1():String
		{
			return _mahjongSyncServerURL1;
		}
		
		public function get mahjongSyncServerURL5():String
		{
			return _mahjongSyncServerURL5;
		}
		
		public function get mahjongSyncServerURL10():String
		{
			return _mahjongSyncServerURL10;
		}
		
		public function get mahjongSyncServerURL20():String
		{
			return _mahjongSyncServerURL20;
		}
		
		public function get mahjongSyncServerURL50():String
		{
			return _mahjongSyncServerURL50;
		}
		
		public function get landlordSyncServerURL1():XMLList
		{
			return _landlordSyncServerURL1;
		}
		
		public function get landlordSyncServerURL2():XMLList
		{
			return _landlordSyncServerURL2;
		}
		
		public function get landlordSyncServerURL3():XMLList
		{
			return _landlordSyncServerURL3;
		}
		
		public function get landlordSyncServerURL4():XMLList
		{
			return _landlordSyncServerURL4;
		}
		
		public function get landlordSyncServerURL5():XMLList
		{
			return _landlordSyncServerURL5;
		}

		public function get hundredHappy():String
		{
			return _hundredHappy;
		}

		public function get chainGunSyncService():String
		{
			return _chainGunSyncService;
		}

		public function get dartsSyncServerURL():String
		{
			return _dartsSyncServerURL;
		}
		
		public function get rouletteSyncServerURL1():String
		{
			return _rouletteSyncServerURL1;
		}
		
		public function get rouletteSyncServerURL2():String
		{
			return _rouletteSyncServerURL2;
		}
		
		public function get rouletteSyncServerURL3():String
		{
			return _rouletteSyncServerURL3;
		}
		
		public function get rouletteSyncServerURL4():String
		{
			return _rouletteSyncServerURL4;
		}

		public function get supplementURL():String
		{
			return _supplementURL;
		}

		/*public function get customerServiceTelephone():String
		{
			return _customerServiceTelephone;
		}

		public function get customerServiceEmail():String
		{
			return _customerServiceEmail;
		}

		public function get customerServiceQQ():String
		{
			return _customerServiceQQ;
		}*/

		public function get gameFlagList():XMLList
		{
			return _gameFlagList;
		}

		public function get newbieVideoList():XMLList
		{
			return _newbieVideoList;
		}

		public function get rollImgList():XMLList
		{
			return _rollImgList;
		}

		public function get rightImgList():XMLList
		{
			return _rightImgList;
		}

		public function get alternateNames():XMLList
		{
			return _alternateNames;
		}

		public function get musicList():XMLList
		{
			return _musicList;
		}


	}
}