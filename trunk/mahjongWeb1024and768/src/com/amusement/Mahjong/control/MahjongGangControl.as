package com.amusement.Mahjong.control
{
	import com.amusement.Mahjong.model.Mahjong;
	import com.amusement.Mahjong.service.MahjongGangService;
	import com.amusement.Mahjong.service.MahjongPoolService;
	import com.amusement.Mahjong.view.MahjongGang;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;
	import mx.managers.PopUpManager;
	
	import spark.core.SpriteVisualElement;

	public class MahjongGangControl
	{
		private static var _instance:MahjongGangControl;
		
		private var _mahjongGang:MahjongGang;
		private var _mahjongGangService:MahjongGangService;
		
		private var _ui:UIComponent;
		
		private var _selectBorder:SpriteVisualElement;
		
//		private var _mask:SpriteVisualElement;
		private var _selectGangMahjong:Mahjong;
		
		public function MahjongGangControl()
		{
			_mahjongGang = new MahjongGang();
			_mahjongGangService = new MahjongGangService();
			
			init();
		}
		
		private function init():void{
			_ui = new UIComponent();
			this._mahjongGang.addElement(_ui);
			
			_selectBorder = new SpriteVisualElement();
			_selectBorder.graphics.lineStyle(1, 0xff0000, 1);
			_selectBorder.graphics.drawRect(0, 0, 32, 39);
			_ui.addChild(_selectBorder);
//			this._mahjongGang.addElement(_selectBorder);
			
			/*_mask = new SpriteVisualElement();
			_mask.graphics.beginFill(0xff0000, 1);
			_mask.graphics.drawRect(0, 0, this._mahjongGang.width + 2, this._mahjongGang.height);
			_mask.graphics.endFill();
			_mask.x = -1;
			_mask.y = -33;
			this._mahjongGang.addElement(_mask);
			this._mahjongGang.mask = _mask;*/
		}
		
		private function setMahjongImg(gangValues:Array):void{
			var gangMahjongs:Array = MahjongPoolService.instance.getMahjongs(gangValues, MahjongRoomControl.instance.mahjongColor);
			for(var i:int = 0; i < gangMahjongs.length; i ++){
				gangMahjongs[i].show("Gimg");
				gangMahjongs[i].x = i * 33;
				gangMahjongs[i].y = 0;
				
				gangMahjongs[i].addEventListener(MouseEvent.CLICK, mahjongClickHandler, false, 0, true);
				
//				this._mahjongGang.addElementAt(gangMahjongs[i], i);
				_ui.addChildAt(gangMahjongs[i], i);
			}
			
			_selectGangMahjong = gangMahjongs[0];
		}
		
		private function mahjongClickHandler(event:MouseEvent):void{
			var mahjong:Mahjong = event.currentTarget as Mahjong;
			if(mahjong && MahjongRoomControl.instance.putState == 3){
				_selectBorder.x = mahjong.x;
				_selectBorder.y = mahjong.y;
				
				this._mahjongGangService.mahjongClickHandler(mahjong);
			}
		}
		
		public function show(gangValues:Array, parent:DisplayObject, px:int, py:int):void{
			_selectBorder.x = 0;
			_selectBorder.y = 0;
			
			if(!this._mahjongGang.isPopUp){
				this._mahjongGang.x = px;
				this._mahjongGang.y = py;
				PopUpManager.addPopUp(this._mahjongGang, parent);
			}
			
			setMahjongImg(gangValues);
		}
		
		public function hide():void{
			_selectGangMahjong = null;
			
			var mahjong:Mahjong;
			for(var i:int = 0; i < _ui.numChildren; i ++){
				if(_ui.getChildAt(i) is Mahjong){
					mahjong = _ui.removeChildAt(i) as Mahjong;
					mahjong.removeEventListener(MouseEvent.CLICK, mahjongClickHandler);
					mahjong.clear();
					i --;
				}
			}
			/*for(var i:int = 0; i < this._mahjongGang.numElements; i ++){
				if(this._mahjongGang.getElementAt(i) is Mahjong){
					mahjong = this._mahjongGang.removeElementAt(i) as Mahjong;
					mahjong.removeEventListener(MouseEvent.CLICK, mahjongClickHandler);
					mahjong.clear();
					i --;
				}
			}*/
			mahjong = null;
			
			PopUpManager.removePopUp(this._mahjongGang);
			
			_selectBorder.x = 0;
			_selectBorder.y = 0;
		}

		public static function get instance():MahjongGangControl
		{
			if(_instance == null){
				_instance = new MahjongGangControl();
			}
			return _instance;
		}

		public function get selectGangMahjong():Mahjong
		{
			return _selectGangMahjong;
		}

		public function set selectGangMahjong(value:Mahjong):void
		{
			_selectGangMahjong = value;
		}

		
	}
}