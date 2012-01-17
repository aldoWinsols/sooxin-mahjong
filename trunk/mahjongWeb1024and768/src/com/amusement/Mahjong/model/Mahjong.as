package com.amusement.Mahjong.model
{
	import com.amusement.Mahjong.control.MahjongDingzhangControl;
	import com.amusement.Mahjong.control.MahjongPlayerControlD;
	import com.amusement.Mahjong.control.MahjongQuemenControl;
	import com.amusement.Mahjong.control.MahjongRoomControl;
	import com.amusement.Mahjong.control.MahjongTimerControl;
	import com.amusement.Mahjong.service.MahjongSyncService;
	import com.model.Alert;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import mx.events.DragEvent;
	
	import spark.components.Image;
	import spark.core.SpriteVisualElement;
	
	public class Mahjong extends SpriteVisualElement
	{
		protected var _value:int = 0; // 牌值
		
		public var isGangBack:Boolean = false;
		
		[Embed(source="com/amusement/Mahjong/assets/mj/blue/b_90.png")]
		private var HImageB:Class; // 横 扣 牌
		[Embed(source="com/amusement/Mahjong/assets/mj/blue/b_180.png")]
		private var VImageB:Class; //竖 扣 牌
		
//		[Embed(source="com/amusement/Mahjong/assets/mj/green/b_90.png")]
//		private var HImageG:Class; // 横 扣 牌
//		[Embed(source="com/amusement/Mahjong/assets/mj/green/b_180.png")]
//		private var VImageG:Class; //竖 扣 牌
//		
//		[Embed(source="com/amusement/Mahjong/assets/mj/yellow/b_90.png")]
//		private var HImageY:Class; // 横 扣 牌
//		[Embed(source="com/amusement/Mahjong/assets/mj/yellow/b_180.png")]
//		private var VImageY:Class; //竖 扣 牌
		
		///////////////////////////////////////////////
		//这里不需要本方手上的牌
		[Embed(source="com/amusement/Mahjong/assets/mj/blue/s_0.png")]
		private var SImage0B:Class; //手牌 0 对方
		[Embed(source="com/amusement/Mahjong/assets/mj/blue/s_90.png")]
		private var SImage90B:Class; //手牌 180 对方
		[Embed(source="com/amusement/Mahjong/assets/mj/blue/s_270.png")]
		private var SImage270B:Class; //手牌 270 对方	
		
//		[Embed(source="com/amusement/Mahjong/assets/mj/green/s_0.png")]
//		private var SImage0G:Class; //手牌 0 对方
//		[Embed(source="com/amusement/Mahjong/assets/mj/green/s_90.png")]
//		private var SImage90G:Class; //手牌 180 对方
//		[Embed(source="com/amusement/Mahjong/assets/mj/green/s_270.png")]
//		private var SImage270G:Class; //手牌 270 对方	
//		
//		[Embed(source="com/amusement/Mahjong/assets/mj/yellow/s_0.png")]
//		private var SImage0Y:Class; //手牌 0 对方
//		[Embed(source="com/amusement/Mahjong/assets/mj/yellow/s_90.png")]
//		private var SImage90Y:Class; //手牌 180 对方
//		[Embed(source="com/amusement/Mahjong/assets/mj/yellow/s_270.png")]
//		private var SImage270Y:Class; //手牌 270 对方	
		
		///////////////////////////////////////////////////////////////////////////
		[Embed(source="com/amusement/Mahjong/assets/mj/blue/pback.png")]
		private var PBackImageB:Class; //碰牌背面 180 对方
		
//		[Embed(source="com/amusement/Mahjong/assets/mj/green/pback.png")]
//		private var PBackImageG:Class; //碰牌背面 180 对方
//		
//		[Embed(source="com/amusement/Mahjong/assets/mj/yellow/pback.png")]
//		private var PBackImageY:Class; //碰牌背面 180 对方
		
		///////////////////////////////////////////////////////////////////
		protected var HimgB:Bitmap;
		protected var HimgG:Bitmap;
		protected var HimgY:Bitmap;
		
		protected var VimgB:Bitmap;
		protected var VimgG:Bitmap;
		protected var VimgY:Bitmap;
		
		protected var Simg0B:Bitmap;
		protected var Simg90B:Bitmap;
		protected var Simg180B:Bitmap;
		protected var Simg270B:Bitmap;
		
		protected var Simg0G:Bitmap;
		protected var Simg90G:Bitmap;
		protected var Simg180G:Bitmap;
		protected var S180G:Sprite; 
		
		protected var Simg270G:Bitmap;
		
		protected var Simg0Y:Bitmap;
		protected var Simg90Y:Bitmap;
		protected var Simg180Y:Bitmap;
		protected var Simg270Y:Bitmap;
		
		protected var PBackImgB:Bitmap;
		protected var PBackImgG:Bitmap;
		protected var PBackImgY:Bitmap;
		
		protected var Pimg180B:Bitmap;
		protected var Pimg180G:Bitmap;
		protected var Pimg180Y:Bitmap;
		
		protected var Dimg0B:Bitmap;
		protected var Dimg90B:Bitmap;
		protected var Dimg180B:Bitmap;
		protected var Dimg270B:Bitmap;
		
		protected var Dimg0G:Bitmap;
		protected var Dimg90G:Bitmap;
		protected var Dimg180G:Bitmap;
		protected var Dimg270G:Bitmap;
		
		protected var Dimg0Y:Bitmap;
		protected var Dimg90Y:Bitmap;
		protected var Dimg180Y:Bitmap;
		protected var Dimg270Y:Bitmap;
		
		/////////////////////////////////////////////////
		protected var Himg:Bitmap;
		protected var Vimg:Bitmap;
		
		///////////////////////////////////////////////
		protected var Simg0:Bitmap; // 自己的手牌
		protected var Simg90:Bitmap; // 自己的手牌
		protected var Simg180:Bitmap; // 自己的手牌
		protected var Simg270:Bitmap; // 自己的手牌
		
		////////////////////////////////////////////////
		public var BigSP:Sprite;
		protected var BigS:Bitmap; // 鼠标移动上去放大的牌
		
		///////////////////////////////////////////////
		protected var Dimg0:Bitmap; // 打出去的桌牌  0
		protected var Dimg90:Bitmap; // 打出去的桌牌  90
		protected var Dimg180:Bitmap; // 打出去的桌牌  180
		protected var Dimg270:Bitmap; // 打出去的桌牌  270
		
		///////////////////////////////////////////////
		protected var PBackImg:Bitmap;//碰/杠背面 180
		
		//////////////////////////////////////////////
		protected var Pimg180:Bitmap;//碰/杠/胡牌 180
		///////////////////////////////////////////////
		
		///////////////////////////////////////////////
		protected var Gimg:Bitmap; //杠选择
		///////////////////////////////////////////////
		
		protected var shade:Sprite=null;
		
		//////////////////////////////////////////////
		//-----------------------坐标属性-----------------------------------
		
		public function Mahjong():void{
			init();
		}
		
		private function getBitmapFilter():BitmapFilter {
			var color:Number = 0x000000;
			var angle:Number = 45;
			var alpha:Number = 0.5;
			var blurX:Number = 5;
			var blurY:Number = 5;
			var distance:Number = 0;
			var strength:Number = 0.65;
			var inner:Boolean = false;
			var knockout:Boolean = false;
			var quality:Number = BitmapFilterQuality.HIGH;
			return new DropShadowFilter(distance,
				angle,
				color,
				alpha,
				blurX,
				blurY,
				strength,
				quality,
				inner,
				knockout);
		}
		
		public function setFilter(sort:String):void{
			switch(sort){
				case "HimgB":
					HimgB.filters = new Array(getBitmapFilter());
					break;
				
				case "VimgB":
					VimgB.filters = new Array(getBitmapFilter());
					break;
			}
		}
		
		public function initFilter():void{
			Dimg0B.filters = new Array(getBitmapFilter());
			Dimg90B.filters = new Array(getBitmapFilter());
			Dimg180B.filters = new Array(getBitmapFilter());
			Dimg270B.filters = new Array(getBitmapFilter());
			
			PBackImgB.filters = new Array(getBitmapFilter());
			
			Pimg180B.filters = new Array(getBitmapFilter());
		}
		
		/**
		 *
		 * @param color
		 */
		protected function init():void
		{
			/////////////////////////////
			HimgB=new HImageB();
			
//			HimgG=new HImageG();
//			HimgY=new HImageY();
			
			VimgB=new VImageB();
//			VimgG=new VImageG();
//			VimgY=new VImageY();
			
			Simg0B=new SImage0B();
			Simg0B.filters = new Array(getBitmapFilter());
//			Simg0G=new SImage0G();
//			Simg0Y=new SImage0Y();
			
			Simg90B=new SImage90B()
			Simg90B.filters = new Array(getBitmapFilter());
//			Simg90G=new SImage90G()
//			Simg90Y=new SImage90Y()
			
			Simg270B=new SImage270B()
			Simg270B.filters = new Array(getBitmapFilter());
//			Simg270G=new SImage270G()
//			Simg270Y=new SImage270Y()
			
			PBackImgB = new PBackImageB();
			PBackImgB.filters = new Array(getBitmapFilter());
//			PBackImgG = new PBackImageG();
//			PBackImgY = new PBackImageY();
			
			
		}
		
		public function setColor(color:String):void{
			removeChidren();
			
			switch(color){
				case "blue":
					Himg = HimgB;
					Vimg = VimgB;
					
					Simg0 = Simg0B;
					Simg90 = Simg90B;
					Simg180 = Simg180B;
					Simg270 = Simg270B;
					
					Dimg0 = Dimg0B;
					Dimg90 = Dimg90B;
					Dimg180 = Dimg180B;
					Dimg270 = Dimg270B;
					
					PBackImg = PBackImgB;
					
					Pimg180 = Pimg180B;
					break;
				case "green":
					Himg = HimgG;
					Vimg = VimgG;
					
					Simg0 = Simg0G;
					Simg90 = Simg90G;
					Simg180 = Simg180G;
					Simg270 = Simg270G;
					
					Dimg0 = Dimg0G;
					Dimg90 = Dimg90G;
					Dimg180 = Dimg180G;
					Dimg270 = Dimg270G;
					
					PBackImg = PBackImgG;
					
					Pimg180 = Pimg180G;
					break;
				case "yellow":
					Himg = HimgY;
					Vimg = VimgY;
					
					Simg0 = Simg0Y;
					Simg90 = Simg90Y;
					Simg180 = Simg180Y;
					Simg270 = Simg270Y;
					
					Dimg0 = Dimg0Y;
					Dimg90 = Dimg90Y;
					Dimg180 = Dimg180Y;
					Dimg270 = Dimg270Y;
					
					PBackImg = PBackImgY;
					
					Pimg180 = Pimg180Y;
					break;
			}
			
			if(Himg){
				this.addChild(Himg);
			}
			if(Vimg){
				this.addChild(Vimg);
			}
			if(PBackImg){
				this.addChild(PBackImg);
			}
			
			if(Simg0){
				this.addChild(Simg0);
			}
			if(Simg90){
				this.addChild(Simg90);
			}
			if(Simg180){
				S180G = new Sprite();
				this.S180G.addChild(Simg180);
				this.addChild(S180G);
				
				BigSP = new Sprite();
				this.BigSP.addChild(BigS);
				this.addChild(BigSP);
				
				BigSP.visible = false;
				BigSP.x = -8;
				BigSP.y -= 80;
			}
			if(Simg270){
				this.addChild(Simg270);
			}
			
			if(Dimg0){
				this.addChild(Dimg0);
			}
			if(Dimg90){
				this.addChild(Dimg90);
			}
			if(Dimg180){
				this.addChild(Dimg180);
			}
			if(Dimg270){
				this.addChild(Dimg270);
			}
			
			if(Pimg180){
				this.addChild(Pimg180);
			}
			
			if(Gimg){
				this.addChild(Gimg);
			}
			
			show("");
		}
		
		public function show(str:String):void
		{
			removeMouseEvent();
			
			Himg.visible=false;
			Vimg.visible=false;
			
			PBackImg.visible = false;
			
			Simg0.visible=false;
			Simg90.visible=false;
			if (Simg180){
				Simg180.visible=false;
			}
			Simg270.visible=false;
			
			if (Dimg0){
				Dimg0.visible=false;
			}
			
			if (Dimg90){
				Dimg90.visible=false;
			}
			
			if (Dimg180){
				Dimg180.visible=false;
			}
			
			if (Dimg270){
				Dimg270.visible=false;
			}
			
			if(Pimg180){
				Pimg180.visible = false;
			}
			
			if(Gimg){
				Gimg.visible = false;
			}
			
			switch (str){
				case "Himg":
					Himg.visible=true;
					break;
				case "Vimg":
					Vimg.visible=true;
					break;
				case "Simg0":
					Simg0.visible=true;
					break;
				
				case "Simg90":
					Simg90.visible=true;
					break;
				
				case "Simg180":
					if (Simg180){
						Simg180.visible=true;
						initMouseEvent();
					}
					break;
				
				case "Simg270":
					Simg270.visible=true;
					break;
				
				case "Dimg0":
					if (Dimg0){
						Dimg0.visible=true;
					}
					break;
				
				case "Dimg90":
					if (Dimg90){
						Dimg90.visible=true;
					}
					break;
				
				case "Dimg180":
					if (Dimg180){
						Dimg180.visible=true;
					}
					break;
				
				case "Dimg270":
					if (Dimg270){
						Dimg270.visible=true;
					}
					break;
				case "Pimg180":
					if(Pimg180){
						Pimg180.visible = true;
					}
				case "PBackImg":
					PBackImg.visible = true;
					break;
				case "Himg":
					Himg.visible=true;
					break;
				case "Vimg":
					Vimg.visible=true;
					break;
				case "Gimg":
					Gimg.visible = true;
					break;
			}
		}
		
		////////////////////////////////////////////////////////////////
		public function initMouseEvent():void
		{
//			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			this.S180G.addEventListener(MouseEvent.CLICK, clickHandler, false, 0, true);
//			this.addEventListener(TouchEvent.TOUCH_OUT, outHandler, false, 0, true);
			
//			this.addEventListener(MouseEvent.CLICK,clickHandler);
			this.BigSP.addEventListener(MouseEvent.CLICK,bigSPclickHandler);
			
//			this.BigSP.addEventListener(TouchEvent.TOUCH_OVER,beginHandler);
//			this.BigSP.addEventListener(TouchEvent.TOUCH_OUT,endHandler);
		}
		
		private function bigSPclickHandler(e:MouseEvent):void{
			onClickMahjong();
		}
		
		private function beginHandler(e:TouchEvent):void{
			e.target.startTouchDrag(e.touchPointID, false);
		}
		
		private function endHandler(e:TouchEvent):void{
			e.target.stopTouchDrag(e.touchPointID);
			BigSP.x = -5;
			BigSP.y = -100;
			BigSP.visible = false;
			onClickMahjong();
		}
		
		public function clickHandler(e:MouseEvent):void
		{
			if(MahjongRoomControl.instance.selectMahjong){
				MahjongRoomControl.instance.selectMahjong.BigSP.visible = false;
				MahjongRoomControl.instance.selectMahjong.y += 10;
				
				if(MahjongRoomControl.instance.selectMahjong === this){
					MahjongRoomControl.instance.selectMahjong = null;
					
					
//					onClickMahjong();
				}else{
					MahjongRoomControl.instance.selectMahjong = this;
					this.y -= 10;
					BigSP.visible = true;
				}
			}else{
				MahjongRoomControl.instance.selectMahjong = this;
				this.y -= 10;
				BigSP.visible = true;
			}
		}
		
		public function outHandler(e:TouchEvent):void
		{
			BigSP.visible = false;
		}
		
		public function removeMouseEvent():void
		{
//			this.removeEventListener(MouseEvent.MOUSE_OVER, overHandler);
			this.removeEventListener(MouseEvent.MOUSE_OUT, outHandler);
//			this.removeEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		public function onClickMahjong():void{
			switch(MahjongRoomControl.instance.putState){
				case 1://定章
					MahjongRoomControl.instance.putState = 0;
					//停止倒计时
					MahjongTimerControl.instance.hide();
					
					MahjongQuemenControl.instance.hide();
					MahjongDingzhangControl.instance.hide();
					
					//发送向服务器发送请求
					MahjongSyncService.instance.dingzhang(this._value);
					
					BigSP.visible = false;
					break;
				case 2://打牌
					//判断所出牌是否是定章类, 是否还有定章类
					if (MahjongPlayerControlD.instance.checkPutMahjongLegally(this._value)){
						MahjongRoomControl.instance.putState = 0;
						//停止倒计时
						MahjongTimerControl.instance.hide();
						//发送向服务器发送请求
						MahjongSyncService.instance.putOneMahjong(this._value);
					}else{
						Alert.show("根據遊戲規則您需要先打完定章類牌");
					}
					
					BigSP.visible = false;
					break;
				default:
					this.BigSP.x = -5;
					this.BigSP.y = -90;
					break;
			}
		}
		
		/**
		 * 绘制红色遮罩
		 * @param azimuth 胡牌方位
		 *
		 */
		public function drawShade(azimuth:int):void
		{
			this.shade=new Sprite();
			shade.graphics.beginFill(0xFF0000, 0.3);
			switch (azimuth)
			{
				case 1:
					shade.graphics.drawRect(0, 0, Dimg0.width, Dimg0.height);
					break;
				case 2:
					shade.graphics.drawRect(0, 0, Dimg270.width, Dimg270.height);
					break;
				case 3:
					shade.graphics.drawRect(0, 0, Pimg180.width, Pimg180.height);
					break;
				case 4:
					shade.graphics.drawRect(0, 0, Dimg90.width, Dimg90.height);
					break;
			}
			
			shade.graphics.endFill();
			this.addChild(shade);
		}
		
		public function removeChidren():void{
			if (Himg && Himg.parent){
				this.removeChild(Himg);
			}
			
			if (Vimg && Vimg.parent){
				this.removeChild(Vimg);
			}
			
			if(PBackImg && PBackImg.parent){
				this.removeChild(PBackImg);
			}
			
			if (Simg0 && Simg0.parent){
				this.removeChild(Simg0);
			}
			
			if (Simg90 && Simg90.parent){
				this.removeChild(Simg90);
			}
			
			if (Simg180 && Simg180.parent){
				this.removeChild(S180G);
			}
			
			if (Simg270 && Simg270.parent){
				this.removeChild(Simg270);
			}
			
			if (Dimg0 && Dimg0.parent){
				this.removeChild(Dimg0);
			}
			
			if (Dimg90 && Dimg90.parent){
				this.removeChild(Dimg90);
			}
			
			if (Dimg180 && Dimg180.parent){
				this.removeChild(Dimg180);
			}
			
			if (Dimg270 && Dimg270.parent){
				this.removeChild(Dimg270);
			}
			
			if(Pimg180 && Pimg180.parent){
				this.removeChild(Pimg180);
			}
			
			if(BigSP && BigSP.parent){
				this.removeChild(BigSP);
			}
		}
		
		public function clear():void
		{
			removeMouseEvent();
			
			if (shade){
				this.removeChild(shade);
				shade.graphics.clear();
				shade=null;
			}
			
			//////////////////////////////////////////////////////
			removeChidren();
			
			Himg=null;
			Vimg=null;
			PBackImg = null;
			
			Simg0=null;
			Simg90=null;
			Simg180=null;
			Simg270=null;
			
			Dimg0=null;
			Dimg90=null;
			Dimg180=null;
			Dimg270=null;
			
			Pimg180 = null;
			
			if(Gimg){
				Gimg.bitmapData.dispose();
				Gimg = null;
			}
			
			///////////////////////////////////////////////////
			if(HimgB){
				HimgB.bitmapData.dispose();
				HimgB = null;
			}
			if(HimgG){
				HimgG.bitmapData.dispose();
				HimgG = null;
			}
			if(HimgY){
				HimgY.bitmapData.dispose();
				HimgY = null;
			}
			
			if(VimgB){
				VimgB.bitmapData.dispose();
				VimgB = null;
			}
			if(VimgG){
				VimgG.bitmapData.dispose();
				VimgG = null;
			}
			if(VimgY){
				VimgY.bitmapData.dispose();
				VimgY = null;
			}
			
			if(PBackImgB){
				PBackImgB.bitmapData.dispose();
				PBackImgB = null;
			}
			if(PBackImgG){
				PBackImgG.bitmapData.dispose();
				PBackImgG = null;
			}
			if(PBackImgY){
				PBackImgY.bitmapData.dispose();
				PBackImgY = null;
			}
			
			if(Pimg180B){
				Pimg180B.bitmapData.dispose();
				Pimg180B = null;
			}
			if(Pimg180G){
				Pimg180G.bitmapData.dispose();
				Pimg180G = null;
			}
			if(Pimg180Y){
				Pimg180Y.bitmapData.dispose();
				Pimg180Y = null;
			}
			
			if(Simg0B){
				Simg0B.bitmapData.dispose();
				Simg0B = null;
			}
			if(Simg90B){
				Simg90B.bitmapData.dispose();
				Simg90B = null;
			}
			if(Simg180B){
				Simg180B.bitmapData.dispose();
				Simg180B = null;
			}
			if(Simg270B){
				Simg270B.bitmapData.dispose();
				Simg270B = null;
			}
			
			if(Simg0G){
				Simg0G.bitmapData.dispose();
				Simg0G = null;
			}
			if(Simg90G){
				Simg90G.bitmapData.dispose();
				Simg90G = null;
			}
			if(Simg180G){
				Simg180G.bitmapData.dispose();
				Simg180G = null;
			}
			if(Simg270G){
				Simg270G.bitmapData.dispose();
				Simg270G = null;
			}
			
			if(Simg0Y){
				Simg0Y.bitmapData.dispose();
				Simg0Y = null;
			}
			if(Simg90Y){
				Simg90Y.bitmapData.dispose();
				Simg90Y = null;
			}
			if(Simg180Y){
				Simg180Y.bitmapData.dispose();
				Simg180Y = null;
			}
			if(Simg270Y){
				Simg270Y.bitmapData.dispose();
				Simg270Y = null;
			}
			
			if(Dimg0B){
				Dimg0B.bitmapData.dispose();
				Dimg0B = null;
			}
			if(Dimg90B){
				Dimg90B.bitmapData.dispose();
				Dimg90B = null;
			}
			if(Dimg180B){
				Dimg180B.bitmapData.dispose();
				Dimg180B = null;
			}
			if(Dimg270B){
				Dimg270B.bitmapData.dispose();
				Dimg270B = null;
			}
			
			if(Dimg0G){
				Dimg0G.bitmapData.dispose();
				Dimg0G = null;
			}
			if(Dimg90G){
				Dimg90G.bitmapData.dispose();
				Dimg90G = null;
			}
			if(Dimg180G){
				Dimg180G.bitmapData.dispose();
				Dimg180G = null;
			}
			if(Dimg270G){
				Dimg270G.bitmapData.dispose();
				Dimg270G = null;
			}
			
			if(Dimg0Y){
				Dimg0Y.bitmapData.dispose();
				Dimg0Y = null;
			}
			if(Dimg90Y){
				Dimg90Y.bitmapData.dispose();
				Dimg90Y = null;
			}
			if(Dimg180Y){
				Dimg180Y.bitmapData.dispose();
				Dimg180Y = null;
			}
			if(Dimg270Y){
				Dimg270Y.bitmapData.dispose();
				Dimg270Y = null;
			}
			///////////////////////////////////////////////////
			HImageB=null;
			VImageB=null;
			PBackImageB=null;
			SImage0B=null;
			SImage90B=null;
			SImage270B=null;
			
			BigS = null;
			
//			HImageG=null;
//			VImageG=null;
//			PBackImageG=null;
//			SImage0G=null;
//			SImage90G=null;
//			SImage270G=null;
			
//			HImageY=null;
//			VImageY=null;
//			PBackImageY=null;
//			SImage0Y=null;
//			SImage90Y=null;
//			SImage270Y=null;
			///////////////////////////////////////////////////////////
			_value = 0;
		}
		
		public function get value():int
		{
			return this._value;
		}
		
	}
}