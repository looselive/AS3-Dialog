package looselive.controls.dialog.box 
{
	import flash.display.Sprite;
	import flash.display.GradientType;
	import flash.geom.Matrix;
	import flash.utils.Dictionary;
	import looselive.controls.dialog.Style;
	/**
	 * ...
	 * @author LooseLive
	 */
	public class Footer extends Sprite 
	{
		
		public function Footer(buttons:Sprite, width:Number, style:String) 
		{
			if (buttons.height == 0)
			{
				return;
			}
			var colors:Dictionary = new Dictionary();
				colors[Style.Ask] = colors[Style.Info] = [0xffffff, 0xf4f8ff];
				colors[Style.Error] = [0xffffff, 0xFFFAF6];
				colors[Style.None] = [0xffffff, 0xeeeeee];
				colors[Style.Success] = [0xffffff, 0xfafff8];
				colors[Style.Warning] = [0xffffff,0xfffae7];
			var height:Number = buttons.height + 16;
			var matrix:Matrix = new Matrix();
				matrix.createGradientBox(width, height, Math.PI * 0.5, 0, 0);
			graphics.beginGradientFill(GradientType.LINEAR, colors[style], [1, 1], [1, 255], matrix);
			graphics.drawRoundRect(0, 0, width, height, 3);
			graphics.endFill();
			buttons.x = (width - buttons.width) / 2;
			buttons.y = (height - buttons.height) / 2;
			addChild(buttons);
		}
	}
}