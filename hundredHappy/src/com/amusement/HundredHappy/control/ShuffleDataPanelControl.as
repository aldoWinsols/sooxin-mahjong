package com.amusement.HundredHappy.control
{
	import com.amusement.HundredHappy.services.DeskPanelService;
	import com.amusement.HundredHappy.view.ShuffleDataPanel;
	import com.control.MainSceneControl;
	import com.service.RemoteService;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.core.FlexGlobals;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	import mx.rpc.events.ResultEvent;

	public class ShuffleDataPanelControl
	{
		private static var _instance:ShuffleDataPanelControl;
		
		private var _view:ShuffleDataPanel;
		
		public function ShuffleDataPanelControl()
		{
			_view = new ShuffleDataPanel();
		}

		public static function get instance():ShuffleDataPanelControl
		{
			if(_instance == null){
				_instance = new ShuffleDataPanelControl();
			}
			return _instance;
		}
		
		private function addListeners():void{
			this._view.addEventListener(MouseEvent.MOUSE_UP, dragHandler, false, 0, true);
			this._view.bgImg.addEventListener(MouseEvent.MOUSE_DOWN, dragHandler, false, 0, true);
			
			this._view.closeBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
		}
		
		private function removeLiseners():void{
			this._view.closeBtn.removeEventListener(MouseEvent.CLICK, btnClickHandler);
			
			this._view.bgImg.removeEventListener(MouseEvent.MOUSE_DOWN, dragHandler);
			this._view.removeEventListener(MouseEvent.MOUSE_UP, dragHandler);
		}
		
		private function dragHandler(event:MouseEvent):void{
			switch(event.type){
				case MouseEvent.MOUSE_DOWN:
					this._view.startDrag();
					break;
				case MouseEvent.MOUSE_UP:
					this._view.stopDrag();
					break;
			}
		}
		
		private function btnClickHandler(event:MouseEvent):void{
			switch(event.currentTarget.id){
				case "closeBtn":
					hide();
					break;
			}
		}
		
		private function getDataHandler(event:ResultEvent):void{
			RemoteService.instance.balanceCardArrayService.removeEventListener(ResultEvent.RESULT, getDataHandler);
			
			this._view.dataGrid.dataProvider = event.result as ArrayCollection;
		}
		
		private function getData():void{
			RemoteService.instance.balanceCardArrayService.findLatest(10);
			RemoteService.instance.balanceCardArrayService.addEventListener(ResultEvent.RESULT, getDataHandler);
		}
		
		public function show(parent:DisplayObject = null):void{
			if(_view.isPopUp){
				PopUpManager.bringToFront(_view);
			}else{
				if(parent == null){
					parent = FlexGlobals.topLevelApplication as DisplayObject;
//					parent = MainSceneControl.instance.mainSceneApp;
				}
				PopUpManager.addPopUp(_view, parent);
				
				addListeners();
			}
			PopUpManager.centerPopUp(_view);
			
			getData();
		}
		
		public function hide():void{
			removeLiseners();
			
			PopUpManager.removePopUp(_view);
		}

	}
}