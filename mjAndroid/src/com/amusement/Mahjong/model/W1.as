package com.amusement.Mahjong.model
{
	import flash.utils.getQualifiedClassName;
	
//	import mx.controls.Alert;


	public class W1 extends Mahjong
	{
		[Embed(source="com/amusement/Mahjong/assets/mj/blue/w1.png")]
		private var SImage180B:Class; //手上的牌
		[Embed(source="com/amusement/Mahjong/assets/mj/blue/pw1.png")]
		private var PImage180B:Class; //碰牌
		[Embed(source="com/amusement/Mahjong/assets/mj/blue/w1_0.png")]
		private var DImage0B:Class; //打出去的牌 0
		[Embed(source="com/amusement/Mahjong/assets/mj/blue/w1_90.png")]
		private var DImage90B:Class; //打出去的牌 90
		[Embed(source="com/amusement/Mahjong/assets/mj/blue/w1_180.png")]
		private var DImage180B:Class; //打出去的牌 180
		[Embed(source="com/amusement/Mahjong/assets/mj/blue/w1_270.png")]
		private var DImage270B:Class; //打出去的牌 270
		
		[Embed(source="com/amusement/Mahjong/assets/mj/blue/Bw1.png")]
		private var SImageBigB:Class; //手上的牌

//		[Embed(source="com/amusement/Mahjong/assets/mj/green/w1.png")]
//		private var SImage180G:Class; //手上的牌
//		[Embed(source="com/amusement/Mahjong/assets/mj/green/pw1.png")]
//		private var PImage180G:Class; //碰牌
//		[Embed(source="com/amusement/Mahjong/assets/mj/green/w1_0.png")]
//		private var DImage0G:Class; //打出去的牌 0
//		[Embed(source="com/amusement/Mahjong/assets/mj/green/w1_90.png")]
//		private var DImage90G:Class; //打出去的牌 90
//		[Embed(source="com/amusement/Mahjong/assets/mj/green/w1_180.png")]
//		private var DImage180G:Class; //打出去的牌 180
//		[Embed(source="com/amusement/Mahjong/assets/mj/green/w1_270.png")]
//		private var DImage270G:Class; //打出去的牌 270
//
//		[Embed(source="com/amusement/Mahjong/assets/mj/yellow/w1.png")]
//		private var SImage180Y:Class; //手上的牌
//		[Embed(source="com/amusement/Mahjong/assets/mj/yellow/pw1.png")]
//		private var PImage180Y:Class; //碰牌
//		[Embed(source="com/amusement/Mahjong/assets/mj/yellow/w1_0.png")]
//		private var DImage0Y:Class; //打出去的牌 0
//		[Embed(source="com/amusement/Mahjong/assets/mj/yellow/w1_90.png")]
//		private var DImage90Y:Class; //打出去的牌 90
//		[Embed(source="com/amusement/Mahjong/assets/mj/yellow/w1_180.png")]
//		private var DImage180Y:Class; //打出去的牌 180
//		[Embed(source="com/amusement/Mahjong/assets/mj/yellow/w1_270.png")]
//		private var DImage270Y:Class; //打出去的牌 270
		
		[Embed(source="com/amusement/Mahjong/assets/mj/small/w1_s.png")]
		private var GImage:Class;

		public function W1()
		{
			this._value=1;
			super();
		}
		
		protected override function init():void
		{
			Simg180B=new SImage180B();
			Pimg180B=new PImage180B();
			Dimg0B=new DImage0B();
			Dimg90B=new DImage90B();
			Dimg180B=new DImage180B();
			Dimg270B=new DImage270B();
			BigS = new SImageBigB();
			
//			Simg180G=new SImage180G();
//			Pimg180G=new PImage180G();
//			Dimg0G=new DImage0G();
//			Dimg90G=new DImage90G();
//			Dimg180G=new DImage180G();
//			Dimg270G=new DImage270G();
//			
//			Simg180Y=new SImage180Y();
//			Pimg180Y=new PImage180Y();
//			Dimg0Y=new DImage0Y();
//			Dimg90Y=new DImage90Y();
//			Dimg180Y=new DImage180Y();
//			Dimg270Y=new DImage270Y();
			
			Gimg = new GImage();
			
			super.init();
			super.initFilter();
		}
		
		public override function clear():void{
			super.clear();
			
			SImage180B = null;
			PImage180B = null;
			DImage0B = null;
			DImage90B = null;
			DImage180B = null;
			DImage270B = null;
			SImageBigB = null;
			
//			SImage180G = null;
//			PImage180G = null;
//			DImage0G = null;
//			DImage90G = null;
//			DImage180G = null;
//			DImage270G = null;
//
//			SImage180Y = null;
//			PImage180Y = null;
//			DImage0Y = null;
//			DImage90Y = null;
//			DImage180Y = null;
//			DImage270Y = null;
			
			GImage = null;
			
		}
	}
}