package com.amusement.Shark.util
{

	public class SharkUtil
	{
		public function SharkUtil()
		{
		}

		public static function getResaultAnimal(str:String):String
		{
			var resaultAnimal:String="";
			switch (str)
			{
				case "gezi":
					resaultAnimal="鴿子";
					break;

				case "yanzi":
					resaultAnimal="燕子";
					break;

				case "kongque":
					resaultAnimal="孔雀";
					break;

				case "laoying":
					resaultAnimal="老鷹";
					break;

				case "feiqin":
					resaultAnimal="飛禽";
					break;

				case "dabaisha":
					resaultAnimal="大白鯊";
					break;

				case "zoushou":
					resaultAnimal="走獸";
					break;

				case "shizi":
					resaultAnimal="獅子";
					break;

				case "laohu":
					resaultAnimal="老虎";
					break;

				case "xiongmao":
					resaultAnimal="熊貓";
					break;

				case "houzi":
					resaultAnimal="猴子";
					break;
				case "lieqiang":
					resaultAnimal="獵槍";
					break;
			}

			return resaultAnimal;
		}
	}
}