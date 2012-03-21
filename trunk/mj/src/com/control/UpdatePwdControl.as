package com.control
{
	import com.model.Alert;
	import com.model.MainPlayer;
	import com.services.MainPlayerService;
	import com.services.RemoteService;
	import com.util.MD5;
	import com.view.UpdatePwd;
	
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	
	import mx.rpc.events.ResultEvent;

	public class UpdatePwdControl
	{
		private var updatePwd:UpdatePwd;
		public function UpdatePwdControl(updatePwd:UpdatePwd)
		{
			this.updatePwd = updatePwd;
			this.updatePwd.commitB.addEventListener(MouseEvent.CLICK,commitBClickHandler);
			this.updatePwd.cancelB.addEventListener(MouseEvent.CLICK,cancelBClickHandler);
			this.updatePwd.newPwd.addEventListener(FocusEvent.FOCUS_OUT,newPwdFocusOutHandler);
			this.updatePwd.newPwdRe.addEventListener(FocusEvent.FOCUS_OUT,newPwdReFocusOutHandler);
		}
		
		private function newPwdFocusOutHandler(e:FocusEvent):Boolean{
			if(this.updatePwd.newPwd.text.length < 6){
				this.updatePwd.newPwdLab.text = "新密码长度必须大于6位！";
				return false;
			}
			this.updatePwd.newPwdLab.text = "";
			return true;
		}
		
		private function newPwdReFocusOutHandler(e:FocusEvent):Boolean{
			if(this.updatePwd.newPwd.text != this.updatePwd.newPwdRe.text){
				this.updatePwd.newPwdReLab.text = "两次输入的密码不一致！";
				return false;
			}
			this.updatePwd.newPwdReLab.text = "";
			return true;
		}
		
		private function commitBClickHandler(e:MouseEvent):void{
			if(this.updatePwd.newPwd.text.length < 6){
				this.updatePwd.newPwdLab
			}
			
			RemoteService.instance.playerService.changePwd(MainPlayerService.getInstance().mainPlayer.playername,MD5.hash(this.updatePwd.oldPwd.text),MD5.hash(this.updatePwd.newPwd.text));
			RemoteService.instance.playerService.addEventListener(ResultEvent.RESULT,updatePwdResultHandler);
		}
		
		private function updatePwdResultHandler(e:ResultEvent):void{
			RemoteService.instance.playerService.removeEventListener(ResultEvent.RESULT,updatePwdResultHandler);
			if(e.result is MainPlayer){
				Alert.show("密码修改成功!");
				this.updatePwd.oldPwd.text = "";
				this.updatePwd.newPwd.text = "";
				this.updatePwd.newPwdRe.text = "";
				this.updatePwd.visible = false;
			}else{
				Alert.show(e.result.toString());
			}
			
		}
		
		private function cancelBClickHandler(e:MouseEvent):void{
			this.updatePwd.oldPwd.text = "";
			this.updatePwd.newPwd.text = "";
			this.updatePwd.newPwdRe.text = "";
			this.updatePwd.visible = false;
		}
	}
}