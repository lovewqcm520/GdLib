package com.gdlib.util
{
	import flash.display.DisplayObject;
	import flash.geom.Matrix;

	/**
	 * Display object skew utility class.
	 * @author Jack
	 */
	public class SkewUtil
	{
		private static const _DEG2RAD:Number=Math.PI / 180;

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
			var m:Matrix=target.transform.matrix.clone();
			m.b=Math.tan(skewYDegree * _DEG2RAD);
			m.c=Math.tan(skewXDegree * _DEG2RAD);
			target.transform.matrix=m;
		}

		/**
		 * Skew the display object at vertical direction.
		 * @param target	 the display object that need to skew.
		 * @param skewDegree the degree needs to skew at vertical direction. If skewDegree was negative, skew toward Anticlockwise(ACW),
		 * otherwise toward Clockwise(CW).
		 */
		public static function skewY(target:DisplayObject, skewDegree:Number):void
		{
			var m:Matrix=target.transform.matrix.clone();
			m.b=Math.tan(skewDegree * _DEG2RAD);
			target.transform.matrix=m;
		}

		/**
		 * Skew the display object at vertical direction.
		 * @param target	 the display object that need to skew.
		 * @param skewDegree the degree needs to skew at horizontal direction. If skewDegree was negative, skew toward Clockwise(CW),
		 * otherwise toward Anticlockwises(ACW).
		 */
		public static function skewX(target:DisplayObject, skewDegree:Number):void
		{
			var m:Matrix=target.transform.matrix.clone();
			m.c=Math.tan(skewDegree * _DEG2RAD);
			target.transform.matrix=m;
		}

	}
}
