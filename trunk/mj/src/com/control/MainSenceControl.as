package com.control
{
	import com.tencent.weibo.api.Authorize;
	import com.tencent.weibo.core.WeiboConfig;
	import com.tencent.weibo.operation.IRequestOperation;
	import com.view.MainSence;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;

	public class MainSenceControl
	{
		private var mainSence:MainSence;
		public static var hasAccessToken:Boolean = false;
		private var appKey:String = "801121817";
		private var appSecret:String = "44e1659a923015c2f4d912a935eacdb2";
		private var authorizeAPI:Authorize;
		
		public function MainSenceControl(mainSence:MainSence)
		{
			this.mainSence = mainSence;
			this.mainSence.currentState = "verifier";
			this.mainSence.currentState = "login";
			
			mobileConfig();
			
			this.mainSence.mainButDJ.addEventListener(MouseEvent.CLICK,mainButDJClickHandler);
			this.mainSence.mainButQQ.addEventListener(MouseEvent.CLICK,mainButQQClickHandler);
			this.mainSence.mainButYK.addEventListener(MouseEvent.CLICK,mainButYKClickHandler);
			this.mainSence.verifierCommitB.addEventListener(MouseEvent.CLICK,verifierCommitBClickHandler);
		}
		
		public function mobileConfig():void
		{
			//配置微博核心参数
			var configObj:WeiboConfig = WeiboConfig.getInstance();
			configObj.initialize(appKey,appSecret);
			if(configObj.oauthToken != null && configObj.oauthSecret != null){
				hasAccessToken = true;
			}
				
			if(hasAccessToken)
			{
				this.mainSence.currentState = "lianwangHome";
			}
			else
			{
				//获取未授权的Token
				var request:IRequestOperation;
				authorizeAPI = new Authorize();
				request = authorizeAPI.requestToken();
				request.addEventListener(Event.COMPLETE,requestTokenHandler);
				request.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);
			}
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
		}
		
		private function errorHandler(event:IOErrorEvent):void
		{
			trace("获取数据失败或参数错误:"+event.text);
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
		
		private function mainButDJClickHandler(e:MouseEvent):void{
			
		}
		private function mainButQQClickHandler(e:MouseEvent):void{
			authorizeAPI.openUserAuthPage();
			this.mainSence.currentState = "verifier";
		}
		private function mainButYKClickHandler(e:MouseEvent):void{
			
		}
	}
}