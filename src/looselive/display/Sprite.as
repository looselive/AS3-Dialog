package looselive.display 
{
	import flash.display.InteractiveObject;
	/**
	 * 表示一个自定义的Sprite，继承自flash.display.Sprite.
	 * @author LooseLive
	 */
	public class Sprite extends flash.display.Sprite
	{
		/**
		 * 创建一个新的 Sprite 实例。创建 Sprite 实例后，调用 DisplayObjectContainer.addChild() 或 DisplayObjectContainer.addChildAt() 方法，以便将 Sprite 添加到父级 DisplayObjectContainer。
		 */
		public function Sprite() 
		{
			super();
		}
		/**
		 * 从本身开始，逐级向上级匹配指定的父容器对象并返回最先匹配到的父容器对象。
		 * @param	targetClass 要查找的父容器的类。
		 * @return 父容器对象。
		 */
		protected function closest(targetClass:Class):InteractiveObject
		{
			return findParents(this, targetClass);
		}
		private function findParents(e:InteractiveObject, targetClass:Class):InteractiveObject
		{
			if (e is targetClass)
			{
				return e;
			}
			return findParents(e.parent, targetClass);
		}
	}
}