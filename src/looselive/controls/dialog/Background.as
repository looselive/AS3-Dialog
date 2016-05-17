package looselive.controls.dialog 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * 遮罩背景层。
	 * @author LooseLive
	 */
	public class Background extends Sprite
	{
		public function Background(stage:Stage)
		{
			var background:BitmapData = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0xFF000000);
			// var stageBackground:BitmapData = new BitmapData(stage.stageWidth, stage.stageHeight);
			// stageBackground.draw(stage);
			var rectangle:Rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			var point:Point = new Point(0, 0);
			var multiplier:uint = 120;
			// background.merge(stageBackground, rectangle, point, multiplier, multiplier, multiplier, multiplier);
			background.applyFilter(background, rectangle, point, new BlurFilter(3, 3, 2));
			var bitmap:Bitmap = new Bitmap(background);
			bitmap.alpha = 0.5;
			addChild(bitmap);
		}
	}
}
