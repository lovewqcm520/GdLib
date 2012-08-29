package com.gdlib.test
{
	import com.gdlib.display.component.ParabolaSprite;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.events.Event;
	
	public class ParabolaTest2 extends BaseTest
	{
		[Embed(source="assets/swf/sources.swf", symbol="bullet")]
		private var bullet:Class;
		
		private var sp:ParabolaSprite;
		
		private var vx:Number;
		
		private var vy:Number;
		private var g:Number = 0.98;
		private var initY:Number;
		private var initX:Number;
		private var curTime:Number=0;
		
		public function ParabolaTest2()
		{
			super();
		}
		
		override protected function init():void
		{
			super.init();
			
			sp = new ParabolaSprite();
			var bu:Sprite = new bullet() as Sprite;
			bu.scaleX = bu.scaleY = 0.2;
			sp.addChild(bu);
			
			initX = sp.x = 50;
			initY = sp.y = 400;
			addChild(sp);
			
			stage.addEventListener(MouseEvent.CLICK, onStageClick);
		}
		
		protected function onStageClick(event:MouseEvent):void
		{			
			sp.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			this.graphics.endFill();
			this.graphics.clear();
			
			sp.start(30, 20, new Point(initX, initY), new Point(1000, 500));
			sp.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			this.graphics.lineStyle(2, 0x0000ff);
			this.graphics.moveTo(initX, initY)
		}
		
		protected function onEnterFrame(event:Event):void
		{
			this.graphics.lineTo(sp.x, sp.y);
		}
	}
}