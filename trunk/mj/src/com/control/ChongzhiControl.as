package com.control
{
	import com.view.Chongzhi;

	public class ChongzhiControl
	{
		public static var instance:ChongzhiControl;
		public var chongzhi:Chongzhi;
		public function ChongzhiControl(chongzhi:Chongzhi)
		{
			this.chongzhi = chongzhi;
			instance = this;
		}
	}
}