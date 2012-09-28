package com.stock.model
{
	[Bindable]
	[RemoteClass(alias="com.stock.dao.Config")]
	public class Config
	{
		public var dayLoanLv:Number = 0;
		public var dayDepositLv:Number = 0;
		public function Config()
		{
		}
	}
}