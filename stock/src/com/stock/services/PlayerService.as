package com.stock.services
{
	import com.stock.control.MainControl;
	import com.stock.model.Alert;
	import com.stock.model.Player;
	import com.stock.util.MD5;
	
	import mx.rpc.events.ResultEvent;
	
	import spark.core.SpriteVisualElement;

	public class PlayerService extends SpriteVisualElement
	{
		public static var instance:PlayerService;
		
		[Bindable]
		public var player:Player;
		public function PlayerService()
		{
			player = new Player();
		}
		
		public static function getInstance():PlayerService{
			if(instance == null){
				instance = new PlayerService();
			}
			return instance;
		}
		
		public function login(playerName:String,playerPwd:String):void{
			RemoteService.instance.playerService.login(playerName,MD5.hash(playerPwd));
			RemoteService.instance.playerService.addEventListener(ResultEvent.RESULT,loginResultHandler);
		}
		
		private function loginResultHandler(e:ResultEvent):void{
			RemoteService.instance.playerService.removeEventListener(ResultEvent.RESULT,loginResultHandler);
			if(e.result is Player){
				this.player = e.result as Player;
				MainControl.instance.main.currentState = "stockList";
			}else{
				Alert.show(e.result.toString());
			}
		}

		public function regist(playerName:String,playerPwd:String):void{
			RemoteService.instance.playerService.regist(playerName,MD5.hash(playerPwd));
			RemoteService.instance.playerService.addEventListener(ResultEvent.RESULT,registResultHandler);
		}
		
		private function registResultHandler(e:ResultEvent):void{
			RemoteService.instance.playerService.removeEventListener(ResultEvent.RESULT,registResultHandler);
			if(e.result is Player){
				this.player = e.result as Player;
				MainControl.instance.main.currentState = "stockList";
			}else{
				Alert.show(e.result.toString());
			}
		}
		
		public function updatePwd(oldPlayerPwd:String,newPlayerPwd:String):void{
			RemoteService.instance.playerService.updatePlayerPwd(this.player.playerName,MD5.hash(oldPlayerPwd),MD5.hash(newPlayerPwd));
			RemoteService.instance.playerService.addEventListener(ResultEvent.RESULT,updatePwdResultHandler);
		}
		
		private function updatePwdResultHandler(e:ResultEvent):void{
			RemoteService.instance.playerService.removeEventListener(ResultEvent.RESULT,updatePwdResultHandler);
			if(e.result is Player){
				this.player = e.result as Player;
				MainControl.instance.main.currentState = "stockList";
				Alert.show("密码修改成功！");
			}else{
				Alert.show(e.result.toString());
			}
		}
	}
}
