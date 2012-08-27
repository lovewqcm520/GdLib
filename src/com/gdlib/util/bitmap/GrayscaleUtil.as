package com.gdlib.util.bitmap
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.ColorMatrixFilter;
	import flash.utils.getTimer;

	public class GrayscaleUtil
	{
		public function GrayscaleUtil()
		{
		}
		
		/**
		 * Modify bitmap to grayscale style.
		 * @param bmp
		 */
		public static function grayscale(bmp:Bitmap):void
		{
			var oldTime:int = getTimer();
			
			var width:int = bmp.width;
			var height:int = bmp.height;			
			var sourceColor:uint;
			var finalColor:uint;
			var a:uint;
			var r:uint;
			var g:uint;
			var b:uint;
			var ret:uint;
			var bmd:BitmapData = bmp.bitmapData;
			var pixels:Vector.<uint> = bmd.getVector(bmd.rect);
			
			for (var y:uint = 0; y < height; y++) 
			{
				for (var x:uint = 0; x < width; x++) 
				{
					sourceColor = pixels[y*width+x];
					a = (sourceColor & 0xff000000) >> 24;
					r = (sourceColor & 0x00ff0000) >> 16;
					g = (sourceColor & 0x0000ff00) >> 8;
					b = (sourceColor & 0x000000ff);
					ret = uint(r * 0.3 + g * 0.59 + b * 0.11);
					finalColor = (a << 24 | ret << 16 | ret << 8 | ret);
					pixels[y*width+x] = finalColor;
				}				
			}
			
			// update the new vector
			bmd.setVector(bmd.rect, pixels);
			// trace the time
			trace("Grayscale image(" + String(bmp.width) + 
				"*" + String(bmp.height) + ")" + " Takes " + String(getTimer()-oldTime) + " ms.");
		}
		
		/**
		 * Modify bitmap to grayscale style.
		 * Use ColorMatrixFilter.
		 * This function was huge faster than function "grayscale".
		 * @param image
		 */
		public static function grayscaleFilter(bmp:Bitmap):void
		{
			var oldTime:int = getTimer();
			
			var matrix:Array=[
				0.3, 0.59, 0.11, 0, 0, 
				0.3, 0.59, 0.11, 0, 0, 
				0.3, 0.59, 0.11, 0, 0, 
				0, 0, 0, 1, 0];
			var grayscaleFilter:ColorMatrixFilter=new ColorMatrixFilter(matrix);
			var filters:Array=bmp.filters;
			filters.push(grayscaleFilter);
			bmp.filters=filters;
			
			// trace the time
			trace("GrayscaleFilter image(" + String(bmp.width) + 
				"*" + String(bmp.height) + ")" + " Takes " + String(getTimer()-oldTime) + " ms.");
		}
		
		
	}
}