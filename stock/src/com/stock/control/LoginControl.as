package com.stock.control
{
	import com.stock.model.Alert;
	import com.stock.services.PlayerService;
	import com.stock.view.Login;
	
	import flash.events.MouseEvent;
	import flash.net.SharedObject;

	public class LoginControl
	{
		private var login:Login;
		var userInfoCookie:SharedObject;
		public function LoginControl(login:Login)
		{
			this.login = login;
			userInfoCookie = SharedObject.getLocal("userInfoCookie"); 
			
			if(userInfoCookie.data.hasOwnProperty("playerName") && userInfoCookie.data.isRememberPsw && userInfoCookie.data.playerName != "") 
			{ 					
				this.login.playerName.text = userInfoCookie.data.playerName; 
				this.login.playerPwd.text = userInfoCookie.data.playerPwd; 
				this.login.remberLogin.selected =  true; 
			} 
			
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
			
			if(login.remberLogin.selected) 
			{ 
				userInfoCookie.data.playerName = login.playerName.text; 
				userInfoCookie.data.playerPwd = login.playerPwd.text; 
				userInfoCookie.data.isRememberPsw = true; 
			} 
			else 
			{ 
				userInfoCookie.data.playerName = ""; 
				userInfoCookie.data.playerPwd = ""; 
				userInfoCookie.data.isRememberPsw = false; 
			} 
			userInfoCookie.flush(); 
			PlayerService.instance.login(this.login.playerName.text,this.login.playerPwd.text);
		}
		
	}
}