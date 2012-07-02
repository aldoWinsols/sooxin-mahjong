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
			
			if(MainControl.instance.main.applicationDPI == 320){
				chongzhi.dg.alpha = 1;
				chongzhi.chongzhiViewNavigator.title="";
			}
		}
	}
}