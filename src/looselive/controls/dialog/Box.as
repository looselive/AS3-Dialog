package looselive.controls.dialog 
{
	import flash.display.Sprite;
	import looselive.controls.dialog.box.Body;
	import looselive.controls.dialog.box.Border;
	/**
	 * ...
	 * @author LooseLive
	 */
	public class Box extends Sprite
	{
		public function Box(title:String, content:String, buttons:*, style:String)
		{
			var body:Body = new Body(title, content, buttons, style);
				body.x = body.y = 10;
			var border:Border = new Border(body);
			addChild(border);
			addChild(body);
		}

	}
}