package com.control
{
	import com.model.Alert;
	import com.services.ChatService;
	import com.services.ConfigService;
	import com.services.GameCenterService;
	import com.services.MainSyncService;
	import com.tencent.weibo.api.Authorize;
	import com.tencent.weibo.core.WeiboConfig;
	import com.tencent.weibo.operation.IRequestOperation;
	import com.view.MainSence;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;

	public class MainSenceControl
	{
		public static var instance:MainSenceControl;
		public var mainSence:MainSence;
		public static var hasAccessToken:Boolean = false;
		private var appKey:String = "801121817";
		private var appSecret:String = "44e1659a923015c2f4d912a935eacdb2";
		private var authorizeAPI:Authorize;
		
		public function MainSenceControl(mainSence:MainSence)
		{
			this.mainSence = mainSence;
			instance = this;
			
			ChatService.getInstance();
			ConfigService.instance;
			
			this.mainSence.currentState = "login";
			this.mainSence.currentState = "lianwangHome";
			this.mainSence.currentState = "verifier";
			this.mainSence.currentState = "danjiHome";
			this.mainSence.currentState = "login";
			
			mobileConfig();
			
			this.mainSence.mainButDJ.addEventListener(MouseEvent.CLICK,mainButDJClickHandler);
			this.mainSence.mainButQQ.addEventListener(MouseEvent.CLICK,mainButQQClickHandler);
			this.mainSence.mainButYK.addEventListener(MouseEvent.CLICK,mainButYKClickHandler);
			this.mainSence.verifierCommitB.addEventListener(MouseEvent.CLICK,verifierCommitBClickHandler);
			this.mainSence.verifierCancelB.addEventListener(MouseEvent.CLICK,verifierCancelBClickHandler);
		}
		
		var request:IRequestOperation;
		public function mobileConfig():void
		{
			//配置微博核心参数
			var configObj:WeiboConfig = WeiboConfig.getInstance();
			configObj.initialize(appKey,appSecret);
			if(configObj.oauthToken != null && configObj.oauthSecret != null){
				hasAccessToken = true;
			}
				
//			if(hasAccessToken)
//			{
//				this.mainSence.currentState = "lianwangHome";
//			}
//			else
//			{
//				//获取未授权的Token
//				authorizeAPI = new Authorize();
//				var request:IRequestOperation = authorizeAPI.requestToken();
//				request.addEventListener(Event.COMPLETE,requestTokenHandler);
//				request.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);
//			}
		}
		
		private function requestTokenHandler(event:Event):void
		{
			this.mainSence.enabled = true;
		}
		
		/**
		 * 已获取AccessToken,进入下一个页面
		 * @param event
		 */		
		private function accessTokenHandler(event:Event):void
		{
			this.mainSence.currentState = "lianwangHome";
			this.mainSence.enabled = true;
		}
		
		private function errorHandler(e:IOErrorEvent):void
		{
			Alert.show("登录失败，请尝试重新输入或重新授权操作！"+e.toString());
			this.mainSence.verInput.text = "";
			this.mainSence.enabled = true;
		}
		
		protected function verifierCommitBClickHandler(event:MouseEvent):void
		{
			if(this.mainSence.verInput.text == "" || this.mainSence.verInput.text == null)
				return;
			var request:IRequestOperation;
			var oauthVerifier:String = this.mainSence.verInput.text;
			request = authorizeAPI.accessToken(oauthVerifier);
			request.addEventListener(Event.COMPLETE,accessTokenHandler);
			request.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);
			this.mainSence.enabled = false;
		}
		
		private function verifierCancelBClickHandler(e:MouseEvent):void{
			this.mainSence.currentState = "login";
		}
		
		private function mainButDJClickHandler(e:MouseEvent):void{
			this.mainSence.currentState = "danjiHome";
		}
		private function mainButQQClickHandler(e:MouseEvent):void{
			if(hasAccessToken)
			{
				this.mainSence.currentState = "lianwangHome";
			}
			else
			{
				//获取未授权的Token
				authorizeAPI.openUserAuthPage();
				this.mainSence.currentState = "verifier";
			}
			
		}
		private function mainButYKClickHandler(e:MouseEvent):void{
			
		}
	}
}