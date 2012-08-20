package com.stock.control
{
	import com.stock.model.Alert;
	import com.stock.services.PlayerService;
	import com.stock.view.Login;
	
	import flash.events.MouseEvent;

	public class LoginControl
	{
		private var login:Login;
		public function LoginControl(login:Login)
		{
			this.login = login;
			login.registB.addEventListener(MouseEvent.CLICK,registBClickHandler);
			login.loginB.addEventListener(MouseEvent.CLICK,loginBClickHandler);
		}
		
		protected function registBClickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			MainControl.instance.main.currentState = "regist";
		}
		
		private function loginBClickHandler(e:MouseEvent):void{
			
			if(this.login.playerName.text.length<4){
				Alert.show("您输入的用户名有错误！");
				return;
			}
			if(this.login.playerPwd.text.length<6){
				Alert.show("您输入的密码有错误！");
				return;
			}
			PlayerService.instance.login(this.login.playerName.text,this.login.playerPwd.text);
		}
		
	}
}