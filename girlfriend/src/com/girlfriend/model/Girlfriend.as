package com.girlfriend.model
{
	import com.girlfriend.view.Num;

	public class Girlfriend
	{
		public var name:String = ""; //名字
		public var smallName:String = "";//小名
		public var age:int = 0;//年龄
		public var birthday:Date; //生日
		public var shengxiao:String = ""// 生肖
		public var xingzuo:String = ""; //星座
		public var xiexing:String = "";//血型
		public var homeTown:String = ""; //家乡
		public var work:String = ""; //职业
		public var introduce:String = "";//个人介绍
		
		public var theMostCakeFlavour:String=""//最喜欢吃的蛋糕味道   隐藏属性，需要玩家游戏过程中自己总结  比如买不同蛋糕 关系指数增长不一样
			还有是否吃辣椒等等，喜欢穿什么样风格的衣服
			
			
		public var yuejingTime:String = "";//月经时间
		public var xinggeNum:Num = 0;//性格指数
		
		public var healthNum:Number = 100;//健康指数
		public var moodNum:Number = 80;//心情指数
		public var loveNum:Number = 20;//爱情指数
		
		public function Girlfriend()
		{
		}
	}
}