package com.gdlib.util
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Matrix;

	/**
	 * 
	 * @author Jack
	 */
	public class SkewUtil
	{
		private static const _DEG2RAD:Number = Math.PI/180;
		
		/**
		 * Skew the display object at vertical direction.
		 * @param target	 the display object that need to skew.
		 * @param skewXDegree the degree needs to skew at horizontal direction. If skewXDegree was negative, skew toward Clockwise(CW), 
		 * otherwise toward Anticlockwises(ACW).
		 * @param skewYDegree the degree needs to skew at vertical direction. If skewYDegree was negative, skew toward Anticlockwise(ACW), 
		 * otherwise toward Clockwise(CW).
		 */
		public static function skew(target:DisplayObject, skewXDegree:Number, skewYDegree:Number):void
		{
			var m:Matrix = target.transform.matrix.clone();
			m.b = Math.tan(skewYDegree*_DEG2RAD);
			m.c = Math.tan(skewXDegree*_DEG2RAD);
			target.transform.matrix = m;
		}	
		
		/**
		 * Skew the display object at vertical direction.
		 * @param target	 the display object that need to skew.
		 * @param skewDegree the degree needs to skew at vertical direction. If skewDegree was negative, skew toward Anticlockwise(ACW), 
		 * otherwise toward Clockwise(CW).
		 */
		public static function skewY(target:DisplayObject, skewDegree:Number):void
		{
			var m:Matrix = target.transform.matrix.clone();
			m.b = Math.tan(skewDegree*_DEG2RAD);
			target.transform.matrix = m;
		}		
		
		/**
		 * Skew the display object at vertical direction.
		 * @param target	 the display object that need to skew.
		 * @param skewDegree the degree needs to skew at horizontal direction. If skewDegree was negative, skew toward Clockwise(CW), 
		 * otherwise toward Anticlockwises(ACW).
		 */
		public static function skewX(target:DisplayObject, skewDegree:Number):void
		{
			var m:Matrix = target.transform.matrix.clone();
			m.c = Math.tan(skewDegree*_DEG2RAD);
			target.transform.matrix = m;
		}		
		
		/**
		 * Add a filling fully in a skewed container.
		 * @param filling		the filling, like a image.
		 * @param container		the container that alreay been skewed.
		 */
		public static function addChildToSkewedContainer(filling:DisplayObject, container:DisplayObjectContainer):void
		{
			if(!filling || !container)
				return;
			
			var oldWidth:Number = container.width;
			var oldHeight:Number = container.height;
			
			container.addChild(filling);
			filling.width = oldWidth;
			filling.height = oldHeight;
			
			while(container.width > oldWidth)
			{
				filling.width--;
			}
			
			while(container.width < oldWidth)
			{
				filling.width++;
			}
			
			while(container.height > oldHeight)
			{
				filling.height--;
			}
			
			while(container.height < oldHeight)
			{
				filling.height++;
			}
		}
		
	}
}