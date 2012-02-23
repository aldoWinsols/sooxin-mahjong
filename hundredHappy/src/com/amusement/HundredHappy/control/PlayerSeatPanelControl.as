package com.amusement.HundredHappy.control
{
	import com.amusement.HundredHappy.model.HundredHappyPlayer;
	import com.amusement.HundredHappy.model.Seat;
	import com.amusement.HundredHappy.view.PlayerSeatPanel;
	
	import mx.binding.utils.BindingUtils;

	public class PlayerSeatPanelControl
	{
		private static var _instance:PlayerSeatPanelControl;
		
		private var _playerSeatPanel:PlayerSeatPanel;
		
		public function PlayerSeatPanelControl(playerSeatPanel:PlayerSeatPanel)
		{
			_instance = this;
			
			this._playerSeatPanel = playerSeatPanel;
		}
		
		public function bind(authz:int, player:HundredHappyPlayer):void{
			var seat:Seat = this._playerSeatPanel.getChildByName("seat" + authz) as Seat;
			if(seat){
				BindingUtils.bindProperty(seat.playerName, "text", player, "playerName");
				BindingUtils.bindProperty(seat.currentPoint, "text", player, "currentPoint");
			}
			
		}
		
		public function resetSeat():void{
			var seat:Seat;
			for(var i:int = 0; i < this._playerSeatPanel.numElements; i ++){
				seat = this._playerSeatPanel.getElementAt(i) as Seat;
				if(seat){
					seat.reset();
				}
			}
		}
		
		public function setSeatMine(authz:int):void{
			var seat:Seat = this._playerSeatPanel.getChildByName("seat" + authz) as Seat;
			if(seat){
				seat.setMyInfo();
			}
		}

		//---------------------------------------------------------------------
		public static function get instance():PlayerSeatPanelControl
		{
			return _instance;
		}

	}
}