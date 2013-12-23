package looselive.controls 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.filters.DropShadowFilter;
	import flash.utils.clearInterval;
	import flash.utils.clearTimeout;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	import looselive.controls.dialog.Background;
	import looselive.controls.dialog.Box;
	import looselive.controls.dialog.Style;
	/**
	 * 对话框组件。
	 * @author LooseLive
	 */
	public class Dialog extends Sprite
	{
		private static var __stage:Stage;
		private static var __dialogs:Array = [];
		private var __autoCloseTimer:uint;
		private var __animationTimer:uint;
		/**
		 * 设置对话框的舞台对象。
		 * @param	stage
		 */
		public static function init(stage:Stage):void 
		{
			__stage = stage;
		}
		/**
		 * 
		 * @param	title				对话框的标题。
		 * @param	content				对话框的内容。
		 * @param	buttons				表示一个按钮对象或多个按钮对象的数组。
		 * @param	style				对话框的样式。可接受值为 looselive.controls.alert.Style 的枚举值。
		 * @param	autoCloseSeconds	自动关闭对话框的时间（单位：秒），0 表示不关闭。
		 */
		public function Dialog(title:String = "提示", content:String = "", buttons:* = null, style:String = Style.None, autoCloseSeconds:int = 0)
		{
			var background:Background = new Background(__stage);
			var box:Box = new Box(title, content, buttons, style);
				box.x = (__stage.stageWidth - box.width) / 2;
				box.y = (__stage.stageHeight - box.height) / 2;
			addChild(background);
			addChild(box);
			__stage.addChild(this);
			if (autoCloseSeconds > 0)
			{
				__autoCloseTimer = setTimeout(close, autoCloseSeconds * 1000);
			}
			__dialogs.push(this);
		}
		/**
		 * 关闭所有的对话框。
		 */
		public static function closeAll():void
		{
			var length:int = __dialogs.length;
			for each (var dialog:Dialog in __dialogs) 
			{
				dialog.close();
			}
		}
		/**
		 * 关闭对话框。
		 */
		public function close():void
		{
			__animationTimer = setInterval(closeAnimation, 30);
		}
		private function closeAnimation():void
		{
			if (alpha > 0)
			{
				alpha -= 0.2;
			}
			if (alpha <= 0)
			{
				clearInterval(__animationTimer);
				if (__autoCloseTimer > 0)
				{
					clearTimeout(__autoCloseTimer);
				}
				try
				{
					__stage.removeChild(this);
				}
				catch(e:Error){}
			}
		}
	}
}