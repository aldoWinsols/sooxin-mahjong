package com.stock.control
{
	import com.stock.services.NowWeituoService;
	import com.stock.view.NowWeituo;
	
	import mx.binding.utils.BindingUtils;

	public class NowWeituoControl
	{
		private var nowWeituo:NowWeituo;
		public function NowWeituoControl(nowWeituo:NowWeituo)
		{
			this.nowWeituo = nowWeituo;
			BindingUtils.bindProperty(this.nowWeituo.dg,"dataProvider",NowWeituoService.getInstance(),"nowWeituos");
		}
	}
}