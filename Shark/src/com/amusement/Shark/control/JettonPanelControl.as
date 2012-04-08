package com.amusement.Shark.control
{
	import com.amusement.Shark.main.JettonPanel;
	import com.amusement.Shark.model.jetton.SharkJetton;

	public class JettonPanelControl
	{
		private static var _instance:JettonPanelControl;
		
		private var _view:JettonPanel;
		
		private var _selectJetton:SharkJetton;
		
		public function JettonPanelControl(view:JettonPanel)
		{
			_instance = this;
			
			this._view = view;
		}

		//---------------------------------- getter/setter function ------------------------------
		public static function get instance():JettonPanelControl
		{
			return _instance;
		}

		public function get selectJetton():SharkJetton
		{
			return _selectJetton;
		}

		public function set selectJetton(value:SharkJetton):void
		{
			_selectJetton = value;
		}


	}
}