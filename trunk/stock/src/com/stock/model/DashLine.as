package com.stock.model
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import mx.core.UIComponent;
	
	public class DashLine extends UIComponent{
		private var lines:Sprite = new Sprite();
		private var component:UIComponent = new UIComponent();
		
		public function DashLine(){
			lines = new Sprite();
			component = new UIComponent();
		}
		
		/**myInit()函数参数注解：
			* 1、shuliang    虚线的条数
			* 2、lineColor   虚线的颜色
			* 3、lineAlpha   虚线的alpha值
			* 4、fromX       虚线起始点的x轴的值
			* 5、fromY       虚线起始点的y轴的值
			* 6、toX         虚线末点的x轴的值
			* 7、toY         虚线末点的y轴的值
			* 8、pointWidth 单个点的厚度
			* 9、pointLength 单个点的长度
			* 10、twoPointDistance 两个点之间的间隔
			* 
			*/
		public function myInit(shuliang:Number, lineColor:uint, lineAlpha:Number, fromX:Number, fromY:Number, toX:Number, toY:Number, pointWidth:Number, pointLength:Number, twoPointDistance:Number):UIComponent{
			drawDashed(lines.graphics, lineColor, lineAlpha, new Point(fromX, fromY), new Point(toX, toY), pointWidth, pointLength, twoPointDistance);
			return component;
		}
		
		private function drawDashed(graphics:Graphics, lineColor:uint, lineAlpha:Number, p1:Point, p2:Point, pointWidth:Number, pointLength:Number, twoPointDistance:Number):void{
			graphics.lineStyle(pointWidth, lineColor, lineAlpha);
			var max:Number = Point.distance(p1, p2);
			var dis:Number = 0;
			var p3:Point;
			var p4:Point;
			while(dis < max){
				p3 = Point.interpolate(p2, p1, dis / max);
				dis += pointLength;
				if(dis > max){
					dis = max;
				}
				p4 = Point.interpolate(p2, p1, dis / max);
				lines.graphics.moveTo(p3.x, p3.y);
				lines.graphics.lineTo(p4.x, p4.y);
				dis += twoPointDistance;
			}
			component.addChild(lines);
		}
		
	}
}