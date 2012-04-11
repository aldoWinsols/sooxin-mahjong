package com.control
{
	import com.amusement.Mahjong.control.MahjongApplictionControl;
	import com.amusement.Mahjong.service.MahjongSyncNetworkService;
	import com.model.Alert;
	import com.model.MainPlayer;
	import com.services.ConfigService;
	import com.services.MainPlayerService;
	import com.services.MainSyncService;
	import com.services.RemoteService;
	import com.util.MD5;
	import com.view.Login;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;
	
	import spark.components.Label;

	public class LoginControl
	{
		private var login:Login;
		public static var instance:LoginControl;
		public function LoginControl(login:Login)
		{
			this.login = login;
			instance = this;
			
//			this.login.loginB.addEventListener(MouseEvent.CLICK,loginClickHandler);
			this.login.regeistB.addEventListener(MouseEvent.CLICK,regeistClickHandler);
			this.login.cancelB.addEventListener(MouseEvent.CLICK,cancelBClickHandler);
		}
		
		private function cancelBClickHandler(e:MouseEvent):void{
			LianwangHomeControl.instance.lianwangHome.visible = false;
//			MahjongApplictionControl.instance._mahjongAppliction.danjiB.visible = true;
//			MahjongApplictionControl.instance._mahjongAppliction.lianwangB.visible = true;
		}
		
		public function getNotice():void{
			RemoteService.instance.noticeService.findAllNotice();
			RemoteService.instance.noticeService.addEventListener(ResultEvent.RESULT,findAllNoticeResultHandler);
		}
		
		private function findAllNoticeResultHandler(e:ResultEvent):void{
			RemoteService.instance.noticeService.removeEventListener(ResultEvent.RESULT,findAllNoticeResultHandler);
			var arr:ArrayCollection = e.result as ArrayCollection;
			
			var yv:Number = 0;
			for(var i:int=0; i<arr.length; i++){
				var label:Label = new Label();
				label.text = login.df.format(arr.getItemAt(i).noticeTime)+"  "+arr.getItemAt(i).noticeContent;
				this.login.notice.addElement(label);
				label.y = (yv+=20);
				label.x = 5
				label.alpha = 0.3;
			}
		}
		
		
//		protected function loginClickHandler(event:MouseEvent):void
//		{
//			if(this.login.playerName.text.length < 4){
//				Alert.show("您输入用户有误！");
//				return;
//			}
//			if(this.login.playerPwd.text == ""){
//				Alert.show("您还未输入用户密码！");
//				return;
//			}
//			
//			// TODO Auto-generated method stub
//			RemoteService.instance.playerService.login(login.playerName.text,MD5.hash(login.playerPwd.text));
//			RemoteService.instance.playerService.addEventListener(ResultEvent.RESULT,loginResultHandler);
//		}
		
		public function playerLogin(playerName:String):void{
			RemoteService.instance.playerService.login(playerName);
			RemoteService.instance.playerService.addEventListener(ResultEvent.RESULT,loginResultHandler);
		}
		
		private function loginResultHandler(e:ResultEvent):void{
			RemoteService.instance.playerService.removeEventListener(ResultEvent.RESULT,loginResultHandler);
			if(e.result is MainPlayer){
				MainPlayerService.getInstance().mainPlayer = e.result as MainPlayer;
				
				MainSenceControl.instance.mainSence.currentState = "lianwangHome";
//				LianwangHomeControl.instance.lianwangHome.currentState = "main";
				
				MainSyncService.instance.connServer(MainPlayerService.getInstance().mainPlayer.playerName);
				
				if(MainPlayerService.getInstance().mainPlayer.offlineGameNo != 0){
					MahjongSyncNetworkService.instance.connServer(MainPlayerService.getInstance().mainPlayer.playerName, MainPlayerService.getInstance().mainPlayer.offlineGameNo);
				}
			}else{
				Alert.show(e.result.toString());
			}
		}
		
		private function regeistClickHandler(e:MouseEvent):void{
			LianwangHomeControl.instance.lianwangHome.currentState = "regeist";
		}
	}
}