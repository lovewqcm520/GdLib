package com.gdlib.util.bitmap
{
	import com.gdlib.util.RandomUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.getTimer;

	public class BitmapUtil
	{
		public function BitmapUtil()
		{
		}
		
		/**
		 * Clone a bitmap object.
		 * @param source	the source bitmap to be cloned.
		 * @return 			return the clone of the source bitmap.
		 */
		public static function clone(source:Bitmap):Bitmap
		{
			if(!source)
				return null;
			
			var bmd:BitmapData = source.bitmapData.clone();
			return new Bitmap(bmd, source.pixelSnapping, source.smoothing);
		}
		
		/**
		 * Rebellious a bitmap object.
		 * @param bmp
		 */
		public static function rebelliousImage(bmp:Bitmap):void
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
			var bmd:BitmapData = bmp.bitmapData;
			var pixels:Vector.<uint> = bmd.getVector(bmd.rect);
			
			for (var y:uint = 0; y < height; y++) 
			{
				for (var x:uint = 0; x < width; x++) 
				{
					sourceColor = pixels[y*width+x];
					a = uint((sourceColor & 0xff000000) >> 24);
					r = 255 - uint((sourceColor & 0x00ff0000) >> 16);
					g = 255 - uint((sourceColor & 0x0000ff00) >> 8);
					b = 255 - uint(sourceColor & 0x000000ff);
					finalColor = uint(a << 24 | r << 16 | g << 8 | b);
					pixels[y*width+x] = finalColor;
				}				
			}
			
			// update the new vector
			bmd.setVector(bmd.rect, pixels);
			// trace the time
			trace("Rebellious image(" + String(bmp.width) + 
				"*" + String(bmp.height) + ")" + " Takes " + String(getTimer()-oldTime) + " ms.");
		}

		/**
		 * Binarize a bitmap object.
		 * @param bmp
		 */
		public static function binarizeImage(bmp:Bitmap):void
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
					a = uint((sourceColor & 0xff000000) >> 24);
					r = uint((sourceColor & 0x00ff0000) >> 16);
					g = uint((sourceColor & 0x0000ff00) >> 8);
					b = uint(sourceColor & 0x000000ff);
					ret = (r+g+b)/3;
					ret = ret >= 128 ? 255 : 0;
					finalColor = uint(a << 24 | ret << 16 | ret << 8 | ret);
					pixels[y*width+x] = finalColor;
				}				
			}
			
			// update the new vector
			bmd.setVector(bmd.rect, pixels);
			// trace the time
			trace("Binarize image(" + String(bmp.width) + 
				"*" + String(bmp.height) + ")" + " Takes " + String(getTimer()-oldTime) + " ms.");
		}
		
		/**
		 * Fog a bitmap object.
		 * @param bmp
		 */
		public static function fogImage(bmp:Bitmap):void
		{
			var oldTime:int = getTimer();
			
			var width:int = bmp.width;
			var height:int = bmp.height;			
			var sourceColor:uint;
			var finalColor:uint;
			var bmd:BitmapData = bmp.bitmapData;
			var pixels:Vector.<uint> = bmd.getVector(bmd.rect);
			
			for (var y:uint = 0; y < height; y++) 
			{
				for (var x:uint = 0; x < width; x++) 
				{
					var k:int = RandomUtil.unsignedInteger(
					sourceColor = pixels[y*width+x];
					pixels[y*width+x] = finalColor;
				}				
			}
			
			// update the new vector
			bmd.setVector(bmd.rect, pixels);
			// trace the time
			trace("Binarize image(" + String(bmp.width) + 
				"*" + String(bmp.height) + ")" + " Takes " + String(getTimer()-oldTime) + " ms.");
		}
		
	}
}