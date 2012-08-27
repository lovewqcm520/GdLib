package com.gdlib.util.bitmap
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.getTimer;

	public class MosaicUtil
	{
		public function MosaicUtil()
		{
		}
		
		/**
		 * Modify the bitmap to mosaic style.
		 * @param bmp		bitmap need to be modified.
		 * @param factor    the factor more bigger, the mosaic looks more fuzzy.
		 */
		public static function mosaic(bmp:Bitmap, factor:Number=5):void
		{
			var oldTime:int = getTimer();
			// ingore the float 
			var width:uint = bmp.width;
			var height:uint = bmp.height;
			var color:uint;
			var bmd:BitmapData = bmp.bitmapData;
			var pixels:Vector.<uint> = bmd.getVector(bmd.rect);
			
			for (var y:uint = 0; y < height; y++) 
			{
				for (var x:uint = 0; x < width; x++) 
				{
					if(y % factor == 0)
					{
						if(x % factor == 0)
						{
							// pick a random seed pixel color as factor*factor rectangle pixels render color
							//get the pixel color 
							color = pixels[x+int(Math.random()*factor)+y*width];
						}
					}
					else
					{
						// copy the pixel color from previous line
						color = pixels[x+(y-1)*width];
					}
					// update the pixel to new color 
					pixels[x+y*width] = color;
				}				
			}		
			// update the new vector
			bmd.setVector(bmd.rect, pixels);
			// trace the time
			trace("Mosaic image(" + String(bmp.width) + 
				"*" + String(bmp.height) + ")" + " Takes " + String(getTimer()-oldTime) + " ms.");
		}
		
		
		
	}
}