package com.control
{
	import com.model.Alert;
	import com.services.DataService;
	import com.view.Home;
	import com.view.PlayerAdd;
	
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;

	public class HomeControl
	{
		public static var instance:HomeControl;
		public var home:Home;
		public function HomeControl(home:Home)
		{
			this.home = home;
			instance = this;
			
			DataService.instance;
			
			this.home.addPlayerB.addEventListener(MouseEvent.CLICK,addPlayerBClickHandler);
		}

		private function addPlayerBClickHandler(e:MouseEvent):void{
			home.playerAdd.visible = true;
		}
	}
}