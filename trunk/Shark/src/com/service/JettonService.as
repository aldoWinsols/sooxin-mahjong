package com.service
{
	import com.component.jetton.small.*;
	
	import flash.utils.getDefinitionByName;

	/**
	 * 筹码服务类
	 * @author zj
	 * 
	 */
	public class JettonService
	{
		private static var _instance:JettonService;
		
		private static var _jettonValues:Array;//筹码值数组（由大到小排列）
		
		public function JettonService()
		{
			_jettonValues = [];
			
			var jetton:JettonS;
			
			jetton = new JettonS5();
			_jettonValues.push(jetton.value);
			
			jetton = new JettonS10();
			_jettonValues.push(jetton.value);
			
			jetton = new JettonS20();
			_jettonValues.push(jetton.value);
			
			jetton = new JettonS50();
			_jettonValues.push(jetton.value);
			
			jetton = new JettonS100();
			_jettonValues.push(jetton.value);
			
			jetton = new JettonS200();
			_jettonValues.push(jetton.value);
			
			jetton = new JettonS500();
			_jettonValues.push(jetton.value);
			
			jetton = new JettonS1000();
			_jettonValues.push(jetton.value);
			
			jetton = new JettonS5000();
			_jettonValues.push(jetton.value);
			
			jetton = new JettonS10000();
			_jettonValues.push(jetton.value);
			
			_jettonValues.sort(Array.NUMERIC);
			_jettonValues.reverse();
		}
		
		public static function get instance():JettonService
		{
			if(_instance == null){
				_instance = new JettonService();
			}
			return _instance;
		}
		
		/**
		 * 根据筹码值创建筹码 
		 * @param value 筹码值
		 * @return 
		 * 
		 */
		public function getJettonByValue(value:int):JettonS{
			var jettonClass:Class = getDefinitionByName("com.component.jetton.small.JettonS" + value) as Class;
			if(jettonClass){
				return new jettonClass();
			}else{
				return null;
			}
		}
		
		/**
		 * 根据筹码的总值创建筹码数组 
		 * @param totalValue 筹码总值
		 * @return 
		 * 
		 */
		public function getJettonsByTotal(totalValue:int):Array{
			var jettons:Array = [];
			var jetton:JettonS;
			var num:int;
			for each(var jettonValue:int in _jettonValues){
				num = Math.floor(totalValue / jettonValue);
				for(var i:int = 0; i  < num; i ++){
					jetton = getJettonByValue(jettonValue);
					if(jetton){
						jettons.push(jetton);
					}
				}
				
				totalValue = totalValue % jettonValue;
			}
			return jettons;
		}

	}
}