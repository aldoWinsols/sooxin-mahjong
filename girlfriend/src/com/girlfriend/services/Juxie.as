package com.girlfriend.services
{
	import com.girlfriend.inter.GirlfriendServiceI;
	import com.girlfriend.model.Girlfriend;
	
	public class Juxie implements GirlfriendServiceI
	{
		public var girlfriend:Girlfriend;
		public function Juxie()
		{
			girlfriend = new Girlfriend();
			
		}
	}
}