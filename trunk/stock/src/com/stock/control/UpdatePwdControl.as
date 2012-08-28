package com.stock.control
{
	import com.stock.model.Alert;
	import com.stock.services.PlayerService;
	import com.stock.view.UpdatePwd;
	
	import flash.events.MouseEvent;

	public class UpdatePwdControl
	{
		private var updatePwd:UpdatePwd;
		public function UpdatePwdControl(updatePwd:UpdatePwd)
		{
			this.updatePwd = updatePwd;
			this.updatePwd.updatePwdB.addEventListener(MouseEvent.CLICK,updatePwdBClickHandler);
		}
		
		protected function updatePwdBClickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			if(this.updatePwd.oldPwd.text.length<6){
				Alert.show("您输入的旧密码有错误！");
				return;
			}
			if(this.updatePwd.newPwd.text.length<6){
				Alert.show("密码长度必须6位以上！");
				return;
			}
			if(this.updatePwd.newPwd.text != this.updatePwd.cNewPwd.text){
				Alert.show("两次输入的密码不一致！");
				return;
			}
			
			PlayerService.instance.updatePwd(updatePwd.oldPwd.text,updatePwd.newPwd.text);
		}
	}
}