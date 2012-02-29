/**
 * DragPoint.as by Lee Burrows
 * Apr 06, 2011
 * Visit blog.leeburrows.com for more stuff
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 **/
package com.missile.util
{
	import com.missile.model.Missile;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import spark.core.SpriteVisualElement;

	public class DragPoint extends SpriteVisualElement
	{
		private var dd:Missile;
		public function DragPoint(dd:Missile)
		{
			this.dd = dd;
			init();
		}
		
		private function init():void
		{
			graphics.beginFill(0x990000);
			graphics.drawCircle(0, 0, 20);
			addEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
			addEventListener(MouseEvent.DOUBLE_CLICK,doubleClickHandler);
		}
		
		private function doubleClickHandler(e:MouseEvent):void{
			(parent as Missile).removePoint(this);
		}
		
		private function mouseHandler(event:MouseEvent):void
		{
			switch (event.type)
			{
				case MouseEvent.MOUSE_DOWN:
					removeEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
					this.dd.addElement(this);
					startDrag(false, new Rectangle(5, 5, stage.stageWidth, stage.stageHeight));
					addEventListener(MouseEvent.MOUSE_UP, mouseHandler);
					break;
				case MouseEvent.MOUSE_UP:
					removeEventListener(MouseEvent.MOUSE_UP, mouseHandler);
					stopDrag();
					if (event.stageY>stage.stageHeight-40 && parent.numChildren>2)
						(parent as Missile).removePoint(this);
					else
						addEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
					break;
			}
		}

	}
}