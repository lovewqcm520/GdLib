package com.gdlib.util.bitmap
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;

	public class BitmapDataUtil
	{
		/**
		 * Scale a bitmapData object to a smaller or bigger bitmapData.
		 * Usually scale down it.
		 * @param sourceBmd		the source bitmapData object
		 * @param thumbWidth	the destination	bitmapData width that "sourceBmd" will scaled to
		 * @param thumbHeight	the destination	bitmapData height that "sourceBmd" will scaled to
		 * @param smoothing		A Boolean value that determines whether the destination BitmapData object is smoothed when scaled or rotated, 
		 * due to a scaling or rotation in the matrix parameter.
		 * @return 
		 */
		public static function getBitmapDataScaled(sourceBmd:BitmapData, thumbWidth:Number, thumbHeight:Number, smoothing:Boolean=false):BitmapData
		{
			var mat:Matrix = new Matrix();
			mat.scale(thumbWidth/sourceBmd.width, thumbHeight/sourceBmd.height);
			
			var desBmd:BitmapData = new BitmapData(thumbWidth, thumbHeight, false);
			desBmd.draw(sourceBmd, mat, null, null, null, smoothing);
			
			return desBmd;
		}
		
		/**
		 * Get a display object's bitmapData, and Scale the bitmapData to a smaller or bigger bitmapData.
		 * Usually scale down it.
		 * @param sourceObject	the source display object
		 * @param thumbWidth	the destination	bitmapData width that "sourceObject" will scaled to
		 * @param thumbHeight	the destination	bitmapData height that "sourceObject" will scaled to
		 * @param smoothing		A Boolean value that determines whether the destination BitmapData object is smoothed when scaled or rotated, 
		 * due to a scaling or rotation in the matrix parameter.
		 * @return 
		 */
		public static function getObjectBitmapDataScaled(sourceObject:DisplayObject, thumbWidth:Number, thumbHeight:Number, smoothing:Boolean=false):BitmapData
		{
			var mat:Matrix = new Matrix();
			mat.scale(thumbWidth/sourceObject.width, thumbHeight/sourceObject.height);
			
			var bmd:BitmapData = new BitmapData(thumbWidth, thumbHeight, false);
			bmd.draw(sourceObject, mat, null, null, null, smoothing);
			
			return bmd;
		}
		
		
	}
}