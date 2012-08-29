package com.gdlib.display.component
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class ParabolaSprite extends Sprite
	{
		private static const _DEG2RAD:Number=Math.PI / 180;
		private static const _RAD2DEG:Number=180 / Math.PI;
		private static const g:Number=0.98;
		
		private var curTime:int;
		private var vx:Number;
		private var vy:Number;		

		private var mx:Number;

		private var my:Number;
		private var startPoint:Point;
		private var endPoint:Point;
		private var vertexPoint:Point;
		private var spinWhenDegreeChange:Boolean;
		
		private var a:Number;
		private var b:Number;
		private var c:Number;
		
		public function ParabolaSprite()
		{
			super();
		}
		
		public function start(startSpeed:Number, startDegree:Number, startPoint:Point, endPoint:Point, spinWhenDegreeChange:Boolean=true):void
		{
			this.startPoint = startPoint;
			this.endPoint = endPoint;
			this.spinWhenDegreeChange = spinWhenDegreeChange;
			vx = Math.cos(startDegree*_DEG2RAD)*startSpeed;
			vy = Math.sin(startDegree*_DEG2RAD)*startSpeed * -1;
			
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			curTime = 0;
			
			var x1:Number, x2:Number, x3:Number, y1:Number, y2:Number, y3:Number;
			
			x1 = startPoint.x;
			y1 = startPoint.y;
			
			x2 = x1 + 1*vx;
			y2 = y1 + 1*vy;	
			
			x3 = x1 + 2*vx;
			y3 = y1 + 2*(vy+g);	
			
			// calculate a, b, c
			b = ((y1 - y3) * (x1 * x1 - x2 * x2) - (y1 - y2) * (x1 * x1 - x3 * x3)) / 
				((x1 - x3) * (x1 * x1 - x2 * x2) - (x1 - x2) * (x1 * x1 - x3 * x3));
			a = ((y1 - y2) - b * (x1 - x2)) / (x1 * x1 - x2 * x2);
			c = y1 - a * x1 * x1 - b * x1;
		}
		
		public function getY(posX:Number):Number
		{
			trace(posX, a*posX*posX + b*posX + c);
			return a*posX*posX + b*posX + c;
		}
		
		public function getX(posY:Number):void
		{
			var delta:Number = Math.sqrt(Math.abs(b*b-4*a*c));
			if(delta < 0)
			{
				trace("No solutions!");
			}
			else if(delta == 0)
			{
				trace(-b/(2*a));
			}
			else 
			{
				trace((-b+delta)/(2*a),(-b-delta)/(2*a), posY);
			}
		}
		
		public function getTangentDegree(posX:Number):Number
		{
			var gradient:Number = 2*a*posX + b;
			var degree:Number = Math.atan(gradient)*_RAD2DEG;
			
			return degree;
		}
		
		public function pause():void
		{
			
		}
		
		public function resume():void
		{
			
		}
		
		public function stop():void
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			curTime = 0;
		}
			
		protected function onEnterFrame(event:Event):void
		{
			mx = startPoint.x + curTime*vx;
			my = startPoint.y + curTime*vy;			
			//my = getY(mx);			
			vy += g;			
			
			this.x = mx;
			this.y = my;
			
			if(spinWhenDegreeChange)
			{
				var d:Number = getTangentDegree(mx);
				this.rotation = d;
			}
			
			curTime++;
			
			
			getY(mx)
			getX(my)
			
			if(my >= endPoint.y && mx >= endPoint.x)
			{
				stop();
			}
		}
		
		
		
	}
}