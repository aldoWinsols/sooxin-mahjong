package config
{
//	import com.tencent.weibo.core.WeiboConfig;
	/**
	 * 设置App Key和App Secret
	 * @author NeoGuo
	 * 
	 */
	public class MobileConfig
	{
		public static var hasAccessToken:Boolean = false;
		
		private var appKey:String = "801121817";
		private var appSecret:String = "44e1659a923015c2f4d912a935eacdb2";
		
		public function MobileConfig()
		{
			//配置微博核心参数
//			var configObj:WeiboConfig = WeiboConfig.getInstance();
//			configObj.initialize(appKey,appSecret);
//			if(configObj.oauthToken != null && configObj.oauthSecret != null)
//				hasAccessToken = true;
		}
	}
}