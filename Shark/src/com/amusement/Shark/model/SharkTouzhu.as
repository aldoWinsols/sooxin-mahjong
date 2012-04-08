package com.amusement.Shark.model
{

	public class SharkTouzhu
	{
		public var playername:String="";
		public var dabaishaT:int=0;
		public var shiziT:int=0;
		public var yanziT:int=0;
		public var geziT:int=0;
		public var laoyingT:int=0;
		public var kongqueT:int=0;
		public var feiqinT:int=0;
		public var zoushouT:int=0;
		public var laohuT:int=0;
		public var xiongmaoT:int=0;
		public var houziT:int=0;

		public function SharkTouzhu()
		{
		}

		public function clear():void
		{
			dabaishaT=0;
			shiziT=0;
			yanziT=0;
			geziT=0;
			laoyingT=0;
			kongqueT=0;
			feiqinT=0;
			zoushouT=0;
			laohuT=0;
			xiongmaoT=0;
			houziT=0;
		}


		public static var instance:SharkTouzhu;
		public static function getInstance():SharkTouzhu
		{
			if (instance == null)
			{
				instance=new SharkTouzhu();
			}

			return instance;
		}

	}
}