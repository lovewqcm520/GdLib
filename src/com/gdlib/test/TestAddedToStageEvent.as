package com.gdlib.test
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class TestAddedToStageEvent extends BaseTest
	{
		private var sp:Sprite;
		
		public function TestAddedToStageEvent()
		{
			super();
		}
		
		override protected function init():void
		{
			sp = new Sprite();
			sp.addEventListener(Event.ADDED_TO_STAGE, onSpriteAddedToStage);
			
			sp.graphics.beginFill(0xcccccc, 1);
			sp.graphics.drawRect(0, 0, 158.2, 45.6);
			sp.graphics.endFill();
			
			sp.x= 100;
			sp.y = 100;
			addChild(sp);
			
			stage.addEventListener(MouseEvent.CLICK, onStageClick);
		}
		
		protected function onStageClick(event:MouseEvent):void
		{
			sp.visible = !sp.visible;
		}
		
		private function onSpriteAddedToStage(event:Event):void
		{
			trace("onAddedToStage");
		}
	}
}