package com.hundredHappySyncServer.model
{
	public class Record
	{
		public static final var NoPair:int = 0; //无对
		public static final var XianPair:int = 1;  //闲对
		public static final var ZhuangPair:int = 2;  //庄对
		public static final var ZhuangXianPair:int = 3; //庄闲都有对
		
		public static final var RESULT_ZhuangWin:String = "z";  //庄赢
		public static final var RESULT_XianWin:String = "x";    //闲赢
		public static final var RESULT_ZhuangXianSame:String = "h"; //和牌
		
		public var result:String = "";													//开局结果（庄、 闲、和）
		public var type:int = 0;														//开局的其他类型（庄对、 闲对    1：闲对  2： 庄对  3： 闲对庄对同时有）
		public function Record()
		{
		}
	}
}