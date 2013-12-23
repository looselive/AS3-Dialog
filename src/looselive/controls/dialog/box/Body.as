package looselive.controls.dialog.box 
{
	import looselive.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import looselive.controls.Dialog;
	
	/**
	 * ...
	 * @author LooseLive
	 */
	public class Body extends Sprite 
	{
		private var __buttons:*;
		public function Body(title:String, content:String, buttons:*, style:String)
		{
			__buttons = buttons;
			var __title:TextField;
			var headWidth:Number = 0;
			if (title)
			{
				__title = new TextField()
				__title.selectable = false;
				__title.autoSize = TextFieldAutoSize.LEFT;
				__title.text = title;
				__title.setTextFormat(new TextFormat(null, 14, 0x666666, true, null, null, null, null, null, 8, 8));
				headWidth = __title.width;
			}
			var __content:TextField = new TextField();
				__content.autoSize = TextFieldAutoSize.LEFT;
				__content.mouseEnabled = false; 
				__content.text = content;
				__content.setTextFormat(new TextFormat(null, 14, 0x666666, false, null, null, null, null, null, 8, 8, null, 7));

			var buttonBar:Sprite = createButtons(style);
			var width:Number = Math.max(headWidth, __content.width, buttonBar.width);
			var head:Head = new Head(__title, style, width);
			
			__content.y = head.height == 0 ? 8 : head.height;

			var close:Button_Close = new Button_Close();
				close.x = width - close.width - 4;
				close.y = (head.height - close.height) / 2 - 4;
				close.stop();
				close.addEventListener(MouseEvent.MOUSE_OVER, function(e:Event):void { 
					close.gotoAndStop(2);
				} ); 
				close.addEventListener(MouseEvent.MOUSE_OUT, function(e:Event):void { 
					close.gotoAndStop(1);
				} ); 
				close.addEventListener(MouseEvent.CLICK,  closeHandler); 
			addChild(head);
			addChild(close);
			addChild(__content);
			if (__buttons != null)
			{
				var footer:Footer = new Footer(buttonBar, width, style);
					footer.y = __content.y + __content.height;
				addChild(footer);
			}
			graphics.beginFill(0xffffff, 1);
			graphics.drawRoundRect(0, 0, width, height, 8, 8);
		}
		
		private function createButtons(style:String):Sprite
		{
			var number:int = 0;
			var buttonsGroup:Sprite = new Sprite();
			if (__buttons === null)
			{
				return buttonsGroup;
			}
			
			if (!(__buttons is Array))
			{
				trace(666);
				__buttons = [__buttons] as Array;
			}
			for (var i:int = 0; i < __buttons.length; i++ )
			{
				var object:Object = __buttons[i];
					var button:Button = new Button(object.text, style, object.callback);
					buttonsGroup.addChild(button);
					button.x = number == 0 ? 0 : buttonsGroup.width + 8;
				number++;
			}
			
			var buttonBar:Sprite = new Sprite();
				buttonBar.addChild(buttonsGroup);
				buttonBar.graphics.lineStyle(1, 0, 0);
				buttonBar.graphics.drawRect(0, 0, buttonsGroup.width + 16, 1);
				buttonsGroup.x = (buttonBar.width - buttonsGroup.width) / 2;
			return buttonBar;
		}
		private	function closeHandler(e:Event):void 
		{ 
			var dialog:Dialog = this.closest(Dialog) as Dialog;
			dialog.close();
		}
	}

}