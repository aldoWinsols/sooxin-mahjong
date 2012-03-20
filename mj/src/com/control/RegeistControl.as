package com.control
{
	import com.model.Alert;
	import com.services.RemoteService;
	import com.util.MD5;
	import com.view.Regeist;
	
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	
	import mx.rpc.events.ResultEvent;

	public class RegeistControl
	{
		private var regeist:Regeist;
		private var regExp11:RegExp = /[A-Za-z]+/;
		
		public function RegeistControl(regeist:Regeist)
		{
			this.regeist = regeist;
			
			this.regeist.regeistCheckB.addEventListener(MouseEvent.CLICK,regeistCheckHandler);
			this.regeist.regeistCancelB.addEventListener(MouseEvent.CLICK,regeistCancelHandler);
			this.regeist.playerNameRe.addEventListener(FocusEvent.FOCUS_OUT, onPlayerNameReFocus);
			this.regeist.playerPwdRe.addEventListener(FocusEvent.FOCUS_OUT, onPlayerPwdReFocus);
			this.regeist.playerPwdSame.addEventListener(FocusEvent.FOCUS_OUT, onPlayerPwdSameFocus);
			this.regeist.playerNameRe.addEventListener(Event.CHANGE, textInput);
			this.regeist.playerPwdRe.addEventListener(Event.CHANGE, textInput);
			this.regeist.playerPwdSame.addEventListener(Event.CHANGE, textInput);
		}
		
		protected function regeistCheckHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			RemoteService.instance.playerService.regeist(regeist.playerNameRe.text, MD5.hash(regeist.playerPwdRe.text));
			RemoteService.instance.playerService.addEventListener(ResultEvent.RESULT, regeistResaultHandler);
		}
		
		private function regeistResaultHandler(e:ResultEvent):void{
			RemoteService.instance.playerService.removeEventListener(ResultEvent.RESULT, regeistResaultHandler);
			if(e.result){
				Alert.show("注册成功!");
				LianwangHomeControl.instance.lianwangHome.currentState = "login";
			}else{
				Alert.show("注册失败!");
			}
		}
		
		protected function regeistCancelHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			LianwangHomeControl.instance.lianwangHome.currentState = "login";
		}
		
		protected function onPlayerNameReFocus(event:FocusEvent):void
		{
			// TODO Auto-generated method stub
			if(regeist.playerNameRe.text.length < 4){
				this.regeist.lblPointOut.text = "用户名长度不能小于4";
				return;
			}
			
			RemoteService.instance.playerService.checkPlayerNameIsExist(regeist.playerNameRe.text);
			RemoteService.instance.playerService.addEventListener(ResultEvent.RESULT, checkPlayerNameIsExistResaultHandler);
		}
		
		protected function checkPlayerNameIsExistResaultHandler(e:ResultEvent):void
		{
			// TODO Auto-generated method stub
			if(e.result is Boolean){
				if(e.result){
					this.regeist.lblPointOut.text = "此用户名已存在";
				}else{
					this.regeist.lblPointOut.text = "此用户名可以使用";
				}
			}
		}
		
		protected function onPlayerPwdReFocus(event:FocusEvent):void
		{
			// TODO Auto-generated method stub
			if(regeist.playerPwdRe.text.length < 6){
				this.regeist.lblPointOutPwd.text = "密码长度不能小于6";
				return;
			}
		}
		
		protected function onPlayerPwdSameFocus(event:FocusEvent):void
		{
			// TODO Auto-generated method stub
			if(regeist.playerPwdSame.text != regeist.playerPwdRe.text){
				this.regeist.lblPointOutPwdSame.text = "两次密码输入不相同";
				return;
			}
		}
		
		protected function textInput(event:Event):void
		{
			// TODO Auto-generated method stub
			this.regeist.lblPointOut.text = "";
			this.regeist.lblPointOutPwd.text = "";
			this.regeist.lblPointOutPwdSame.text = "";
		}
	}
}