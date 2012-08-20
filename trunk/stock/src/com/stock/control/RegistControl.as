package com.stock.control
{
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
			PlayerService.instance.regist(this.regist.rPlayerName.text,this.regist.rPlayerPwd.text);
		}
	}
}