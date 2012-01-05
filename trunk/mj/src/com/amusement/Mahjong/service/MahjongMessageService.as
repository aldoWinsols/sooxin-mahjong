package com.amusement.Mahjong.service
{
	import com.amusement.Mahjong.model.MahjongMessage;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class MahjongMessageService
	{
		private var _msgTimer:Timer;
		private var _messages:Array;
		
		public function MahjongMessageService()
		{
			_msgTimer = new Timer(1000);
			_msgTimer.addEventListener(TimerEvent.TIMER, msgTimerHandler, false, 0, true);
			
			_messages = [];
		}
		
		private function msgTimerHandler(event:TimerEvent):void{
			if (_messages.length > 0){
				var message:MahjongMessage = _messages.shift();
				message.method.call(null, message.arg);
			}else{
				stopTimer();
			}
		}
		
		/**
		 * 添加消息 
		 * @param message
		 * @return 
		 * 
		 */
		public function addMessage(message:MahjongMessage):void{
			_messages.push(message);
		}
		
		/**
		 * 清空消息队列 
		 * 
		 */
		public function clearMesseges():void{
			_messages.splice(0, _messages.length);
		}
		
		/**
		 * 执行消息队列中第一条消息 
		 * 
		 */
		public function executeMessage():void{
			if (_messages.length > 0){
				var message:MahjongMessage = _messages.shift();
				message.method.call(null, message.arg);
			}
		}
		
		/**
		 * 开始
		 * 
		 */
		public function startTimer():void{
			_msgTimer.delay = 1000;
			_msgTimer.start();
		}
		
		/**
		 * 停止 
		 * 
		 */
		public function stopTimer():void{
			_msgTimer.reset();
			_msgTimer.delay = 1000;
		}
		
		/**
		 * 播放/暂停 
		 * 
		 */
		public function playOrpauseTimer():void{
			if(_msgTimer.running){
				_msgTimer.stop();
			}else if(_messages.length > 0){
				_msgTimer.start();
			}
		} 
		
		/**
		 * 慢速
		 * 
		 */
		public function slowTimer():void
		{
			if(_messages.length > 0){
				if (_msgTimer.delay < 2000){
					_msgTimer.delay += 100;
				}
				if(!_msgTimer.running){
					_msgTimer.start();
				}
			}
		}
		
		/**
		 * 快速 
		 * 
		 */
		public function fastTimer():void
		{
			if(_messages.length > 0){
				if (_msgTimer.delay > 0){
					_msgTimer.delay -= 100;
				}
				if(!_msgTimer.running){
					_msgTimer.start();
				}
			}
		}
		
		/**
		 * 速度 
		 * @return 
		 * 
		 */
		public function getSpeed():Number{
			if(_msgTimer.running){
				return (1000 - _msgTimer.delay) / 100;
			}else if(_messages.length > 0){
				return NaN;
			}else{
				return Number.NEGATIVE_INFINITY;
			}
		}

	}
}