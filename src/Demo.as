package 
{
	import flash.display.*;
    import flash.events.*;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import looselive.controls.Dialog;
	import looselive.controls.dialog.Style;
    
    /**
     * ...
     * @author Andreas Rønning
     */
    public class Demo extends Sprite 
    {
        
        public function Demo():void 
        {
            if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
        }
        
        private function init(e:Event = null):void 
        {
            removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.quality = StageQuality.BEST;
            // 初始化对话框的舞台对象。
			Dialog.init(stage);
			var label:TextField = new TextField();
				label.selectable = false;
				label.autoSize = 'left';
				label.htmlText = "我是一个对话框！点击我看演示吧。";
				label.x = label.y = 100;
				label.addEventListener(MouseEvent.CLICK, showDialogs);
			addChild(label);
			showDialogs();
		}
		private function showDialogs(e:Event = null):void
		{
			new Dialog("狄仁杰与元方的对话", "下面我与元方来给大家演示一下这个对话框插件的效果。", [
				{
					text:'开始',
					callback:function():void {
						new Dialog("温馨提示", "对话开始了，请注意！", [
							{
								text:'入正题吧',
								callback:function():void {
									new Dialog("狄仁杰问", "元方，这个东西你怎么看?", [
										{
											text:"很好",
											callback:function():void {
												new Dialog("元方说", "大人，卑职认为极好！", null, Style.Success);
											}
										},
										{
											text:"我喜欢",
											callback:function():void {
												new Dialog("元方说", "大人，再好的东西得有人用啊！", { 
													text:"统统关闭",
													callback:function():void {
														Dialog.closeAll();
													}
												}, Style.Warning);
											}
										}], Style.Ask);
								}
							},
							{
								text:'磨磨唧唧的',
								callback:function():void {
									new Dialog("错误提示", "亲耐心不够啊！！",
										{ 
											text:"统统关闭",
											callback:function():void {
												Dialog.closeAll();
											}
										}, Style.Error);
								}
							}], Style.Info);
					}
				}
			]);
		}
	}
}