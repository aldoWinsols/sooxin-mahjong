package com.amusement.HundredHappy.control
{
	import com.amusement.HundredHappy.model.Turntable;
	import com.amusement.HundredHappy.view.TurntablePanel;

	public class TurntablePanelControl
	{
		private static var _instance:TurntablePanelControl;
		
		private var _turntablePanel:TurntablePanel;
		
		public function TurntablePanelControl(turntablePanel:TurntablePanel)
		{
			_instance = this;
			
			this._turntablePanel = turntablePanel;
		}
		
		public function setTurntableSelected(roomName:String):void{
			var turntable:Turntable = this._turntablePanel.getChildByName("tt" + roomName) as Turntable;
			if(turntable){
				turntable.selected = true;
			}
		}
		
		public function clearTurntableSelected():void{
			var turntable:Turntable;
			for(var i:int = 0; i < this._turntablePanel.numElements; i ++){
				turntable = this._turntablePanel.getElementAt(i) as Turntable;
				if(turntable){
					turntable.selected = false;
				}
			}
		}

		public static function get instance():TurntablePanelControl
		{
			return _instance;
		}

	}
}