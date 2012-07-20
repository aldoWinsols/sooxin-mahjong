package com.control
{
	import com.model.Alert;
	import com.model.MainPlayer;
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
		
		private var isPlayerNameHave:Boolean = false;
		
		public function RegeistControl(regeist:Regeist)
		{
			this.regeist = regeist;
			
			this.regeist.regeistCheckB.addEventListener(MouseEvent.CLICK,regeistCheckHandler);
			this.regeist.regeistCancelB.addEventListener(MouseEvent.CLICK,regeistCancelHandler);
			this.regeist.playerNameRe.addEventListener(FocusEvent.FOCUS_OUT, onPlayerNameReFocus);
			this.regeist.playerPwdRe.addEventListener(FocusEvent.FOCUS_OUT, onPlayerPwdReFocus);
			this.regeist.playerPwdSame.addEventListener(FocusEvent.FOCUS_OUT, onPlayerPwdSameFocus);
//			this.regeist.playerNameRe.addEventListener(Event.CHANGE, textInput);
//			this.regeist.playerPwdRe.addEventListener(Event.CHANGE, textInput);
//			this.regeist.playerPwdSame.addEventListener(Event.CHANGE, textInput);
		}
		
		protected function regeistCheckHandler(event:MouseEvent):void
		{
			if(checkPlayerNameLenth() && onPlayerPwdReFocus(null) && onPlayerPwdSameFocus(null) && isPlayerNameHave){
				// TODO Auto-generated method stub
				var player:MainPlayer = new MainPlayer();
				player.playerName = regeist.playerNameRe.text;
				player.playerPwd = MD5.hash(regeist.playerPwdRe.text);
				RemoteService.instance.playerService.regeist(player);
				RemoteService.instance.playerService.addEventListener(ResultEvent.RESULT, regeistResaultHandler);
			}
		}
		
		private function regeistResaultHandler(e:ResultEvent):void{
			RemoteService.instance.playerService.removeEventListener(ResultEvent.RESULT, regeistResaultHandler);
			if(e.result is MainPlayer){
				Alert.show("注册成功!");
				textInput(null);
				LianwangHomeControl.instance.lianwangHome.currentState = "login";
				LianwangHomeControl.instance.lianwangHome.login.playerName.text = regeist.playerNameRe.text;
			}else{
				Alert.show(e.result.toString());
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
			if(checkPlayerNameLenth()){
				RemoteService.instance.playerService.checkPlayerNameIsExist(regeist.playerNameRe.text);
				RemoteService.instance.playerService.addEventListener(ResultEvent.RESULT, checkPlayerNameIsExistResaultHandler);
			}
		}
		
		protected function checkPlayerNameIsExistResaultHandler(e:ResultEvent):void
		{
			// TODO Auto-generated method stub
			RemoteService.instance.playerService.removeEventListener(ResultEvent.RESULT, checkPlayerNameIsExistResaultHandler);
			if(e.result is Boolean){
				if(e.result){
					this.regeist.lblPointOut.text = "此用户名已存在";
					isPlayerNameHave = false;
				}else{
					this.regeist.lblPointOut.text = "此用户名可以使用";
					isPlayerNameHave = true;
				}
			}
		}
		
		private function checkPlayerNameLenth():Boolean{
			if(regeist.playerNameRe.text.length < 4){
				this.regeist.lblPointOut.text = "用户名长度不能小于4";
				return false;
			}
			return true;
		}
		
		protected function onPlayerPwdReFocus(event:FocusEvent):Boolean
		{
			// TODO Auto-generated method stub
			if(regeist.playerPwdRe.text.length < 6){
				this.regeist.lblPointOutPwd.text = "密码长度不能小于6";
				return false;
			}
			this.regeist.lblPointOutPwd.text = "";
			return true;
		}
		
		protected function onPlayerPwdSameFocus(event:FocusEvent):Boolean
		{
			// TODO Auto-generated method stub
			if(regeist.playerPwdSame.text != regeist.playerPwdRe.text){
				this.regeist.lblPointOutPwdSame.text = "两次密码输入不相同";
				return false;
			}
			this.regeist.lblPointOutPwdSame.text = "";
			return true;
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