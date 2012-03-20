package com.control
{
	import com.model.Alert;
	import com.model.MainPlayer;
	import com.services.MainPlayerService;
	import com.services.MainSyncService;
	import com.services.RemoteService;
	import com.util.MD5;
	import com.view.Login;
	
	import flash.events.MouseEvent;
	
	import mx.rpc.events.ResultEvent;

	public class LoginControl
	{
		private var login:Login;
		public function LoginControl(login:Login)
		{
			this.login = login;
			
			this.login.loginB.addEventListener(MouseEvent.CLICK,loginClickHandler);
			this.login.regeistB.addEventListener(MouseEvent.CLICK,regeistClickHandler);
		}
		
		protected function loginClickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			RemoteService.instance.playerService.login(login.playerName.text,MD5.hash(login.playerPwd.text));
			RemoteService.instance.playerService.addEventListener(ResultEvent.RESULT,loginResultHandler);
		}
		
		private function loginResultHandler(e:ResultEvent):void{
			RemoteService.instance.playerService.removeEventListener(ResultEvent.RESULT,loginResultHandler);
			if(e.result is MainPlayer){
				MainPlayerService.getInstance().mainPlayer = e.result as MainPlayer;
				LianwangHomeControl.instance.lianwangHome.currentState = "main";
				MainSyncService.instance.connServer(MainPlayerService.getInstance().mainPlayer.playername);
			}else{
				Alert.show(e.result.toString());
			}
		}
		
		private function regeistClickHandler(e:MouseEvent):void{
			LianwangHomeControl.instance.lianwangHome.currentState = "regeist";
		}
	}
}