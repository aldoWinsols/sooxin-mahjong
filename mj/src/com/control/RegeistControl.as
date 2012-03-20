package com.control
{
	import com.model.Alert;
	import com.services.RemoteService;
	import com.util.MD5;
	import com.view.Regeist;
	
	import flash.events.MouseEvent;
	
	import mx.rpc.events.ResultEvent;

	public class RegeistControl
	{
		private var regeist:Regeist;
		public function RegeistControl(regeist:Regeist)
		{
			this.regeist = regeist;
			
			this.regeist.regeistCheckB.addEventListener(MouseEvent.CLICK,regeistCheckHandler);
			this.regeist.regeistCancelB.addEventListener(MouseEvent.CLICK,regeistCancelHandler);
		}
		
		protected function regeistCheckHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			RemoteService.instance.playerService.regeist(regeist.playerNameRe.text, MD5.hash(regeist.playerPwdRe.text));
			RemoteService.instance.playerService.addEventListener(ResultEvent.RESULT, regeistResaultHandler);
		}
		
		private function regeistResaultHandler(e:ResultEvent){
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
	}
}