package com.amusement.HundredHappy.control
{
	import com.amusement.HundredHappy.model.poker.Poker;
	import com.amusement.HundredHappy.services.PokerService;
	import com.amusement.HundredHappy.view.ChupaiPanel;

	public class ChupaiPanelControl
	{
		private static var _instance:ChupaiPanelControl;
		
		private var _chupaiPanel:ChupaiPanel;
		
//		private const _centerGap:Number = 110;
//		private const _paiGap:Number = 12;
//		private const _pokerWidth:Number = 66;
//		private const _pokerHeight:Number = 91;
		private const _centerGap:Number = 56;
		private const _paiGap:Number = 8;
		private const _pokerWidth:Number = 87;
		private const _pokerHeight:Number = 120;
		
		private var _xCount:int = 0;
		private var _zCount:int = 0;
		
		public function ChupaiPanelControl(chupaiPanel:ChupaiPanel)
		{
			_instance = this;
			
			this._chupaiPanel = chupaiPanel;
			
			init();
		}
		
		private function init():void{
			hide();
		}
		
		private function reset():void{
			_xCount = 0;
			_zCount = 0;
			
			_chupaiPanel.content.removeAllElements();
			
			this._chupaiPanel.xValueTxt.text = "0";
			this._chupaiPanel.zValueTxt.text = "0";
		}
		
		public function show():void{
			reset();
			this._chupaiPanel.visible = true;
		}
		
		public function hide():void{
			reset();
			_chupaiPanel.visible = false;
			
		}

		public function chupai(pokerName:String, type:String):void
		{
			var poker:Poker = PokerService.instance.getPokerByName(pokerName);
			this._chupaiPanel.content.addElement(poker);
			
			var value:int;
			if (type == "x"){
				if(++_xCount == 3){
					poker.x = (_chupaiPanel.content.width - _centerGap)/2 - (_xCount - 1) * (_pokerWidth + _paiGap);
					poker.y = _pokerHeight - _pokerWidth;
					poker.rotation = 90;
				}else{
					poker.x = (_chupaiPanel.content.width - _centerGap)/2 - (_xCount - 1) * _paiGap - _xCount *_pokerWidth;
				}

				value = int(this._chupaiPanel.xValueTxt.text) + (poker.value > 9 ? 0 : poker.value);
				this._chupaiPanel.xValueTxt.text = (value % 10).toString();
			}else{
				poker.x = (_chupaiPanel.content.width + _centerGap)/2 + _zCount * (_pokerWidth + _paiGap);
				if(++_zCount == 3){
					poker.y = _pokerHeight;
					poker.rotation = -90;
				}
				
				value = int(this._chupaiPanel.zValueTxt.text) + (poker.value > 9 ? 0 : poker.value);
				this._chupaiPanel.zValueTxt.text = (value % 10).toString();
			}
		}

		public static function get instance():ChupaiPanelControl
		{
			return _instance;
		}

	}
}