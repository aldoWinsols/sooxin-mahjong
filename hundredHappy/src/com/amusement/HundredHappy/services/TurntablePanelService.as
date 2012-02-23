package com.amusement.HundredHappy.services
{
	import com.amusement.HundredHappy.control.TurntablePanelControl;

	public class TurntablePanelService
	{
		private static var _instance:TurntablePanelService;
		
		public function TurntablePanelService()
		{
		}

		public static function get instance():TurntablePanelService
		{
			if(_instance == null){
				_instance = new TurntablePanelService();
			}
			return _instance;
		}
		
		public function setSelectedRoom(roomNo:String):void{
			TurntablePanelControl.instance.setTurntableSelected(roomNo);
		}
		
		public function clearSelected():void{
			TurntablePanelControl.instance.clearTurntableSelected();
		}

	}
}