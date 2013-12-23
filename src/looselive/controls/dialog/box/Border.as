package looselive.controls.dialog.box 
{
	import flash.display.Sprite;
	/**
	 * 表示对话框的边框。
	 * @author LooseLive
	 */
	public class Border extends Sprite 
	{
		public function Border(body:Sprite) 
		{
			var borderWidth:Number = 20;
			graphics.beginFill(0xbbbbbb, 0.6);
			graphics.drawRoundRect(0, 0, body.width + borderWidth, body.height + borderWidth, 16, 16);
		}
	}
}