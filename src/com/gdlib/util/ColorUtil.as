package com.gdlib.util
{
	public class ColorUtil
	{
		public static const ALPHA:uint = 	0xff000000;
		public static const RED:uint = 		0x00ff0000;
		public static const GREEN:uint = 	0x0000ff00;
		public static const BLUE:uint = 	0x000000ff;
		
		public function ColorUtil()
		{
		}

		/**
		 * Get the A(alpha) channel value from a hex color.
		 * @param color
		 * @return 	
		 */
		public static function getA(color:uint):uint
		{
			return  uint((color & ALPHA) >> 24);
		}
		
		/**
		 * Get the R(red) channel value from a hex color.
		 * @param color
		 * @return 
		 */
		public static function getR(color:uint):uint
		{
			return uint((color & RED) >> 16);
		}
		
		/**
		 * Get the G(green) channel value from a hex color.
		 * @param color
		 * @return 
		 */
		public static function getG(color:uint):uint
		{
			return  uint((color & GREEN) >> 8);
		}
		
		/**
		 * Get the B(blue) channel value from a hex color.
		 * @param color
		 * @return 	
		 */
		public static function getB(color:uint):uint
		{
			return  uint(color & BLUE);
		}
		
		/**
		 * Convert individual R,G,B,A values to a hex value.
		 * @param r
		 * @param g
		 * @param b
		 * @param a
		 * @return 
		 */
		public static function rgbToHex(r:uint, g:uint, b:uint, a:uint):uint
		{
			return (a << 24 | r << 16 | g << 8 | b);
		}
		
		
	}
}