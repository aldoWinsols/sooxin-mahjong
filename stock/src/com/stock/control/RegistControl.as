package com.stock.control
{
	import com.stock.model.Alert;
	import com.stock.services.PlayerService;
	import com.stock.view.Regist;
	
	import flash.events.MouseEvent;

	public class RegistControl
	{
		private var regist:Regist;
		public function RegistControl(regist:Regist)
		{
			this.regist = regist;
			this.regist.registB.addEventListener(MouseEvent.CLICK,registBClickHandler);
		}
		
		private function registBClickHandler(e:MouseEvent):void{
			if(this.regist.rPlayerName.text.length<4){
				Alert.show("用户名长度必须4位以上！");
				return;
			}
			if(this.regist.rPlayerPwd.text.length<6){
				Alert.show("密码长度必须6位以上！");
				return;
			}
			if(this.regist.rPlayerPwd.text != this.regist.rCPlayerPwd.text){
				Alert.show("两次输入的密码不一致！");
				return;
			}
			PlayerService.instance.regist(this.regist.rPlayerName.text,this.regist.rPlayerPwd.text);
		}
	}
}