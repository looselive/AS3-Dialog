package looselive.controls.dialog.box 
{
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BevelFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.filters.GradientGlowFilter;
	import flash.filters.ShaderFilter;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	import looselive.controls.Dialog;
	import looselive.controls.dialog.Style;
	import looselive.display.Sprite;
	/**
	 * ...
	 * @author LooseLive
	 */
	public class Button extends Sprite
	{
		private var __callback:Function;
		private var __textfield:TextField;
		private var __style:String;
		private var __colors:Dictionary;
		public function Button(text:String, style:String, callback:Function) 
		{
			__style = style;
			__colors = new Dictionary();
			__colors[Style.None] = __colors[Style.Ask] = [0xCACACA,0xFFFFFF, 0xEFEFEF,0X888888];
			__colors[Style.Success] = [0x9ED89E, 0xffffff,0xDCF1DC, 0x009900];
			__colors[Style.Error] = [0xFFC69F, 0xffffff, 0xFFE5D3, 0xE6574E];
			__colors[Style.Warning] = [0xFFCA7B, 0xffffff, 0xFFE6C1, 0xFF8800];
			__colors[Style.Info] = [0x9ED8FF, 0xffffff, 0xD3EDFF, 0x4E95CD];
			
			__callback = callback;
			__textfield = new TextField();
			__textfield.selectable = false;
			__textfield.autoSize = TextFieldAutoSize.CENTER;
			__textfield.text = text;
			__textfield.textColor = 0x666666;
			__textfield.setTextFormat(new TextFormat(null, 14, 0x666666, false));
			__textfield.filters = [new DropShadowFilter(1, 45, 0xffffff, 1, 1, 1, 1, 2)];
			
			darw([__colors[__style][1], __colors[__style][2]]);
			
			__textfield.x = (width - __textfield.width) / 2;
			__textfield.y = (height - __textfield.height) / 2;
			
			addChild(__textfield);
			
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			addEventListener(MouseEvent.CLICK, callbackHandler);
		}
		private function onMouseOver(e:Event):void
		{
			darw([__colors[__style][2], __colors[__style][1]]);
		}
		private function onMouseDown(e:Event):void
		{
			this.filters = [new GlowFilter(__colors[__style][3], 1, 2, 2, 4, BitmapFilterQuality.HIGH)];
		}
		private function onMouseOut(e:Event):void
		{
			darw([__colors[__style][1], __colors[__style][2]]);
			this.filters = null;
		}
		private function callbackHandler(e:Event):void
		{
			var dialog:Dialog = this.closest(Dialog) as Dialog;
			if (__callback !== null)
			{
				__callback.call(dialog); 
			}
			else
			{
				removeEventListener(MouseEvent.CLICK, callbackHandler);
				dialog.close();
			}
		}
		private function darw(colors:Array):void
		{
			var width:Number = __textfield.width + 32;
			var height:Number = __textfield.height + 8;
			var matrix:Matrix = new Matrix();
				matrix.createGradientBox(width,height, Math.PI * 0.5, 0, 0);
			
			graphics.clear();
			graphics.lineStyle(1, __colors[__style][0]);
			graphics.beginGradientFill(GradientType.LINEAR, colors, [1, 1], [1, 255], matrix);
			graphics.drawRoundRect(0, 0, width, height, 3);
			graphics.endFill();
		}
	}
}