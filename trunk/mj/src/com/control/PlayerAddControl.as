package com.control
{
	import com.model.Alert;
	import com.services.DataService;
	import com.view.PlayerAdd;
	
	import flash.events.MouseEvent;

	public class PlayerAddControl
	{
		private var playerAdd:PlayerAdd;
		public function PlayerAddControl(playerAdd:PlayerAdd)
		{
			this.playerAdd = playerAdd;
			this.playerAdd.commit.addEventListener(MouseEvent.CLICK,commitHandler);
			this.playerAdd.cancel.addEventListener(MouseEvent.CLICK,cancelHandler);
		}
		
		private function commitHandler(e:MouseEvent):void{
			if(playerAdd.playerName.text == ""){
				Alert.show("用户名不能为空！");
				return;
			}
			
//			if(!playerAdd.playerEmail.text.match("^[a-zA-Z0-9_\.]+@[a-zA-Z0-9-]+[\.a-zA-Z]+$")){
//				Alert.show("EMAIL格式不对！");
//				this.playerAdd.playerName.text = "";
//				this.playerAdd.playerEmail.text = "";
//				return;
//			}
			DataService.instance.addPlayer(playerAdd.playerName.text,playerAdd.playerEmail.text);
		}
		private function cancelHandler(e:MouseEvent):void{
			this.playerAdd.visible = false;
			this.playerAdd.playerName.text = "";
			this.playerAdd.playerEmail.text = "";
		}
	}
}