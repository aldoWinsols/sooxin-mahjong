package com.sharkSyncServer.model
{
	public class AllTouzhu {
		public var dabaishaAll:int;
		public var shiziAll:int;
		public var laoyingAll:int;
		public var laohuAll:int;
		public var xiongmaoAll:int;
		public var kongqueAll:int;
		public var geziAll:int;
		public var yanziAll:int;
		public var houziAll:int;
		public var feiqinAll:int;
		public var zoushouAll:int;
		
		public function AllTouzhu(){
			dabaishaAll = 0;
			shiziAll = 0;
			laoyingAll = 0;
			laohuAll = 0;
			xiongmaoAll = 0;
			kongqueAll = 0;
			geziAll = 0;
			yanziAll = 0;
			houziAll = 0;
			feiqinAll = 0;
			zoushouAll = 0;
		}
	
		public function allTouzhuNum():int {
			return dabaishaAll + shiziAll + laoyingAll + laohuAll + xiongmaoAll
					+ kongqueAll + geziAll + yanziAll + houziAll + feiqinAll
					+ zoushouAll;
		}
	}
}
