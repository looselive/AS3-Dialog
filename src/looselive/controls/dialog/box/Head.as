package looselive.controls.dialog.box 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	import looselive.controls.dialog.Style;
	
	/**
	 * 表示对话框的头部（标题栏）。
	 * @author LooseLive
	 */
	public class Head extends Sprite 
	{
		public function Head(textField:TextField, style:String, width:Number)
		{
			var icons:Dictionary = new Dictionary();
				icons[Style.Ask] = new Icon_Ask();
				icons[Style.Error] = new Icon_Error();
				icons[Style.Info] = new Icon_Info();
				icons[Style.Success] = new Icon_Success();
				icons[Style.Warning] = new Icon_Warning();
			if (textField)
			{
				var textColors:Dictionary = new Dictionary();
					textColors[Style.Ask] = textColors[Style.Info] = textColors[Style.None] = 0x666666;
					textColors[Style.Error] = 0xE6574E;
					textColors[Style.Success] = 0x009900;
					textColors[Style.Warning] = 0xff8800;
				var bgColors:Dictionary = new Dictionary();
					bgColors[Style.Ask] = bgColors[Style.None] = [0xffffff,0xf0f0f0,0xffffff];
					bgColors[Style.Error] = [0xffffff,0xFFF4ED,0xffffff];
					bgColors[Style.Success] = [0xffffff,0xf3ffee,0xffffff];
					bgColors[Style.Warning] = [0xffffff,0xfff4ca,0xffffff];
					bgColors[Style.Info] = [0xffffff,0xe7f1ff,0xffffff];
				var height:Number = textField.height + 16;
				var matrix:Matrix = new Matrix();
					matrix.createGradientBox(width, height, Math.PI * 0.5, 0, 0);
				graphics.beginGradientFill(GradientType.LINEAR, bgColors[style], [1, 1,1], [1, 123,255], matrix);
				graphics.drawRoundRect(0, 0, width, height, 3);
				graphics.endFill();
				textField.y = (height - textField.height) / 2 - 4;
				textField.textColor = textColors[style];
				addChild(textField);
				//如果定义了样式且该样式有图标
				if (icons[style])
				{
					var icon:Bitmap = new Bitmap(icons[style]);
						icon.x = 8;
						icon.y = (height - icon.height) / 2 - 4;
					addChild(icon);
					textField.x = icon.width + 4;
				}
				addEventListener(MouseEvent.MOUSE_DOWN, preDragWindow);
			}
		}
		
		private function preDragWindow(e:Event):void
		{
			addEventListener(MouseEvent.MOUSE_MOVE, startDragWindow);
			stage.addEventListener(MouseEvent.MOUSE_UP, stopDragWindow);
		}
		
		private function startDragWindow(e:Event):void
		{
			
			var box:Sprite = parent.parent as Sprite;
			var rect:Rectangle = new Rectangle(0, 0, stage.stageWidth -box.width, stage.stageHeight - box.height);
			
			box.startDrag(false, rect);
			
		}
		private function stopDragWindow(e:Event):void
		{
			removeEventListener(MouseEvent.MOUSE_MOVE, startDragWindow);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stopDragWindow);
			
			var box:Sprite = parent.parent as Sprite;
			box.stopDrag();
		}
		
	}
}