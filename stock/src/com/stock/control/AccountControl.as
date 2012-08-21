package com.stock.control
{
	import com.stock.model.Alert;
	import com.stock.services.PlayerService;
	import com.stock.view.Account;
	
	import flash.events.MouseEvent;

	public class AccountControl
	{
		private var account:Account;
		public function AccountControl(account:Account)
		{
			this.account = account;
			this.account.updatePwdB.addEventListener(MouseEvent.CLICK,updatePwdBClickHandler);
		}
		
		protected function updatePwdBClickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			if(this.account.oldPwd.text.length<6){
				Alert.show("您输入的旧密码有错误！");
				return;
			}
			if(this.account.newPwd.text.length<6){
				Alert.show("密码长度必须6位以上！");
				return;
			}
			if(this.account.newPwd.text != this.account.cNewPwd.text){
				Alert.show("两次输入的密码不一致！");
				return;
			}
			
			PlayerService.instance.updatePwd(account.oldPwd.text,account.newPwd.text);
		}
	}
}