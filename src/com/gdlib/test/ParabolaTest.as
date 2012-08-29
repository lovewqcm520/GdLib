package com.gdlib.test
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	public class ParabolaTest extends BaseTest
	{
		
		private var sp:Sprite;
		
		private var vx:Number;
		
		private var vy:Number;
		private var g:Number = 0.98;
		private var initY:Number;
		private var initX:Number;
		private var curTime:Number=0;
		
		public function ParabolaTest()
		{
			super();
		}
		
		override protected function init():void
		{
			super.init();
			
			sp = new Sprite();
			sp.graphics.beginFill(0xff0000, 1);
			sp.graphics.drawCircle(0, 0, 5);
			sp.graphics.endFill();
			
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
			draw(30, 80, new Point(initX, initY));
		}
		
		public function draw(startSpeed:Number, startDegree:Number, startPoint:Point):void
		{
			vx = Math.cos(startDegree*Math.PI/180)*startSpeed;
			vy = Math.sin(startDegree*Math.PI/180)*startSpeed * -1;
			
			sp.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			curTime = 0;
			this.graphics.lineStyle(2, 0x0000ff);
			this.graphics.moveTo(startPoint.x, startPoint.y)
		}
		
		protected function onEnterFrame(event:Event):void
		{
			var mx:Number = initX + curTime*vx;
			var my:Number = initY + curTime*vy;
			
			vy += g;
			
			
			sp.x = mx;
			sp.y = my;
			
			
			//this.graphics.moveTo(mx, my);
			this.graphics.lineTo(mx, my);
			
			curTime++;
		}
	}
}