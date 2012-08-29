package com.gdlib.util.bitmap
{
	import com.gdlib.util.RandomUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.ColorMatrixFilter;
	import flash.utils.getTimer;

	/**
	 * Bitmap object utility class.
	 * @author Jack
	 */
	public class BitmapUtil
	{
		/**
		 * Clone a bitmap object.
		 * @param source	the source bitmap to be cloned.
		 * @return 			return the clone of the source bitmap.
		 */
		public static function clone(source:Bitmap):Bitmap
		{
			if (!source)
				return null;

			var bmd:BitmapData=source.bitmapData.clone();
			return new Bitmap(bmd, source.pixelSnapping, source.smoothing);
		}

//		逆反处理的原理很简单，用255减去该像素的RGB作为新的RGB值即可。
//		g(i,j)=255-f(i,j)
//		更多的信息在:	http://www.cnblogs.com/sndnnlfhvk/archive/2012/03/04/2379344.html
		/**
		 * Rebellious a bitmap object.
		 * @param bmp
		 */
		public static function rebelliousImage(bmp:Bitmap):void
		{
			var oldTime:int=getTimer();

			var width:int=bmp.width;
			var height:int=bmp.height;
			var sourceColor:uint;
			var finalColor:uint;
			var a:uint;
			var r:uint;
			var g:uint;
			var b:uint;
			var bmd:BitmapData=bmp.bitmapData;
			var pixels:Vector.<uint>=bmd.getVector(bmd.rect);

			for (var y:uint=0; y < height; y++)
			{
				for (var x:uint=0; x < width; x++)
				{
					sourceColor=pixels[y * width + x];
					a=uint((sourceColor & 0xff000000) >> 24);
					r=255 - uint((sourceColor & 0x00ff0000) >> 16);
					g=255 - uint((sourceColor & 0x0000ff00) >> 8);
					b=255 - uint(sourceColor & 0x000000ff);
					finalColor=uint(a << 24 | r << 16 | g << 8 | b);
					pixels[y * width + x]=finalColor;
				}
			}

			// update the new vector
			bmd.setVector(bmd.rect, pixels);
			// trace the time
			trace("Rebellious image(" + String(bmp.width) + "*" + String(bmp.height) + ")" + " Takes " + String(getTimer() - oldTime) + " ms.");
		}

//		二值处理，顾名思义，将图片处理后就剩下二值了，0、255就是RGB取值的极限值，图片只剩下黑白二色，从上一篇C#图片处理常见方法性能比较 可知，
//		二值处理为图像灰度彩色变黑白灰度处理的一个子集，只不过值就剩下0和255了，因此处理方法有些类似。进行加权或取平均值后进行极端化，
//		若平均值大于等于128则255，否则0.
//		更多的信息在:	http://www.cnblogs.com/sndnnlfhvk/archive/2012/03/04/2379344.html
		/**
		 * Binarize a bitmap object.
		 * @param bmp
		 */
		public static function binarizeImage(bmp:Bitmap):void
		{
			var oldTime:int=getTimer();

			var width:int=bmp.width;
			var height:int=bmp.height;
			var sourceColor:uint;
			var finalColor:uint;
			var a:uint;
			var r:uint;
			var g:uint;
			var b:uint;
			var ret:uint;
			var bmd:BitmapData=bmp.bitmapData;
			var pixels:Vector.<uint>=bmd.getVector(bmd.rect);

			for (var y:uint=0; y < height; y++)
			{
				for (var x:uint=0; x < width; x++)
				{
					sourceColor=pixels[y * width + x];
					a=uint((sourceColor & 0xff000000) >> 24);
					r=uint((sourceColor & 0x00ff0000) >> 16);
					g=uint((sourceColor & 0x0000ff00) >> 8);
					b=uint(sourceColor & 0x000000ff);
					ret=(r + g + b) / 3;
					ret=ret >= 128 ? 255 : 0;
					finalColor=uint(a << 24 | ret << 16 | ret << 8 | ret);
					pixels[y * width + x]=finalColor;
				}
			}

			// update the new vector
			bmd.setVector(bmd.rect, pixels);
			// trace the time
			trace("Binarize image(" + String(bmp.width) + "*" + String(bmp.height) + ")" + " Takes " + String(getTimer() - oldTime) + " ms.");
		}

//		雾化处理效果算法原理：
//		对每个像素A(i,j)进行处理，用其周围一定范围内随机点A(i+d,j+d),(-k<d<k)的像素替代。显然，以该点为圆心的圆半径越大，则雾化效果越明显。
//		图像的雾化处理不是基于图像中像素点之间的计算,而是给图像像素的颜色值引入一定的随机值
//		使图像具有毛玻璃带水雾般的效果
//		更多的信息在:	http://www.cnblogs.com/sndnnlfhvk/archive/2012/03/08/2385831.html		
		/**
		 * Modify the bitmap to fog style.
		 * @param bmp		bitmap need to be modified.
		 * @param factor    the factor more bigger, the fog looks more fuzzy.
		 */
		public static function fogImage(bmp:Bitmap, factor:Number=7):void
		{
			var oldTime:int=getTimer();

			var width:int=bmp.width;
			var height:int=bmp.height;
			var finalColor:uint;
			var bmd:BitmapData=bmp.bitmapData;
			var pixels:Vector.<uint>=bmd.getVector(bmd.rect);

			var randomRange:Number=Math.max(width, height);
			var k:int, dx:int, dy:int;
			// ignore the last pixel
			for (var y:uint=0; y < height - 1; y++)
			{
				for (var x:uint=0; x < width - 1; x++)
				{
					k=RandomUtil.unsignedInteger(-randomRange, randomRange);
					// get pixel block size
					dx=x + k % factor;
					dy=y + k % factor;
					// handle overflow
					if (dx >= width)
						dx=width - 1;
					if (dy >= height)
						dy=height - 1;
					if (dx < 0)
						dx=0;
					if (dy < 0)
						dy=0;
					finalColor=pixels[dy * width + dx];
					pixels[y * width + x]=finalColor;
				}
			}

			// update the new vector
			bmd.setVector(bmd.rect, pixels);
			// trace the time
			trace("Fog image(" + String(bmp.width) + "*" + String(bmp.height) + ")" + " Takes " + String(getTimer() - oldTime) + " ms.");
		}

		/********************************************************************
		 霓虹处理算法：同样以3*3的点阵为例，目标像素g(i,j)应当以f(i,j)与f(i,j+1)，f(i,j)与f(i+1,j)的梯度作为R,G,B分量，
		 我们不妨设f(i,j)的RGB分量为(r1, g1, b1), f(i,j+1)为(r2, g2, b2), f(i+1,j)为(r3, g3, b3), g(i, j)为(r, g, b),
		 那么结果应该为
			r = 2 * sqrt( (r1 - r2)^2 + (r1 - r3)^2 )
			g = 2 * sqrt( (g1 - g2)^2 + (g1 - g3)^2 )
			b = 2 * sqrt( (b1 - b2)^2 + (b1 - b3)^2 )
			f(i,j)=2*sqrt[(f(i,j)-f(i+1,j))^2+(f(i,j)-f(,j+1))^2]
		 * 更多的信息在:	http://www.cnblogs.com/sndnnlfhvk/archive/2012/03/11/2390704.html
		 * ******************************************************************/
		/**
		 * Modify the bitmap to neon style.
		 * @param bmp		bitmap need to be modified.
		 */
		public static function neonImage(bmp:Bitmap):void
		{
			var oldTime:int=getTimer();

			var width:int=bmp.width;
			var height:int=bmp.height;
			var finalColor:uint;
			var bmd:BitmapData=bmp.bitmapData;
			var pixels:Vector.<uint>=bmd.getVector(bmd.rect);

			var c1:uint, c2:uint, c3:uint;
			var a1:uint, r1:uint, g1:uint, b1:uint;
			var a2:uint, r2:uint, g2:uint, b2:uint;
			var a3:uint, r3:uint, g3:uint, b3:uint;
			var a:uint, r:uint, g:uint, b:uint;

			for (var y:uint=0; y < height - 1; y++)
			{
				for (var x:uint=0; x < width - 1; x++)
				{
					// get first pixel color
					c1=pixels[y * width + x];
					a1=uint((c1 & 0xff000000) >> 24);
					r1=uint((c1 & 0x00ff0000) >> 16);
					g1=uint((c1 & 0x0000ff00) >> 8);
					b1=uint(c1 & 0x000000ff);

					// get second pixel color
					c2=pixels[(y + 1) * width + x];
					a2=uint((c2 & 0xff000000) >> 24);
					r2=uint((c2 & 0x00ff0000) >> 16);
					g2=uint((c2 & 0x0000ff00) >> 8);
					b2=uint(c2 & 0x000000ff);

					// get third pixel color
					c3=pixels[y * width + (x + 1)];
					a3=uint((c3 & 0xff000000) >> 24);
					r3=uint((c3 & 0x00ff0000) >> 16);
					g3=uint((c3 & 0x0000ff00) >> 8);
					b3=uint(c3 & 0x000000ff);

					a=uint((a1 + a2 + a3) / 3);
					r=2 * uint(Math.sqrt((r3 - r1) * (r3 - r1) + (r2 - r1) * (r2 - r1)));
					g=2 * uint(Math.sqrt((g3 - g1) * (g3 - g1) + (g2 - g1) * (g2 - g1)));
					b=2 * uint(Math.sqrt((b3 - b1) * (b3 - b1) + (b2 - g1) * (b2 - b1)));

					if (a > 255)
						a=255;
					if (r > 255)
						r=255;
					if (g > 255)
						g=255;
					if (b > 255)
						b=255;

					finalColor=uint(a << 24 | r << 16 | g << 8 | b);
					pixels[y * width + x]=finalColor;
				}
			}

			// update the new vector
			bmd.setVector(bmd.rect, pixels);
			// trace the time
			trace("Neon image(" + String(bmp.width) + "*" + String(bmp.height) + ")" + " Takes " + String(getTimer() - oldTime) + " ms.");
		}

		/********************************************************************
		 *
		 * 浮雕处理原理：通过对图像像素点的像素值与相邻像素点的像素值相减后加上128, 然后作为新的像素点的值...

		 * g(i,j)=f(i,i)-f(i+1,j)+128
		 *
		 * 更多的信息在:	http://www.cnblogs.com/sndnnlfhvk/archive/2012/03/11/2390704.html
		 * ******************************************************************/
		/**
		 * Modify the bitmap to relief style.
		 * @param bmp		bitmap need to be modified.
		 */
		public static function reliefImage(bmp:Bitmap):void
		{
			var oldTime:int=getTimer();

			var width:int=bmp.width;
			var height:int=bmp.height;
			var finalColor:uint;
			var bmd:BitmapData=bmp.bitmapData;
			var pixels:Vector.<uint>=bmd.getVector(bmd.rect);

			var c1:uint, c2:uint;
			var a1:uint, r1:uint, g1:uint, b1:uint;
			var a2:uint, r2:uint, g2:uint, b2:uint;
			var a:uint, r:uint, g:uint, b:uint;

			// 如果过小，则图片偏黑色，如果过大，则图片偏白色，128刚好。
			var factor:Number=128;

			for (var y:uint=0; y < height; y++)
			{
				for (var x:uint=0; x < width - 1; x++)
				{
					// get first pixel color
					c1=pixels[y * width + x];
					a1=uint((c1 & 0xff000000) >> 24);
					r1=uint((c1 & 0x00ff0000) >> 16);
					g1=uint((c1 & 0x0000ff00) >> 8);
					b1=uint(c1 & 0x000000ff);

					// get second pixel color
					c2=pixels[y * width + (x + 1)];
					a2=uint((c2 & 0xff000000) >> 24);
					r2=uint((c2 & 0x00ff0000) >> 16);
					g2=uint((c2 & 0x0000ff00) >> 8);
					b2=uint(c2 & 0x000000ff);

					//a = a1 - a2 + factor;
					a=(a1 + a2) / 2;
					r=r1 - r2 + factor;
					g=g1 - g2 + factor;
					b=b1 - b2 + factor;

					if (a > 255)
						a=255;
					if (r > 255)
						r=255;
					if (g > 255)
						g=255;
					if (b > 255)
						b=255;
					if (a < 0)
						a=0;
					if (r < 0)
						r=0;
					if (g < 0)
						g=0;
					if (b < 0)
						b=0;

					finalColor=uint(a << 24 | r << 16 | g << 8 | b);
					pixels[y * width + x]=finalColor;
				}
			}

			// update the new vector
			bmd.setVector(bmd.rect, pixels);
			// trace the time
			trace("Neon image(" + String(bmp.width) + "*" + String(bmp.height) + ")" + " Takes " + String(getTimer() - oldTime) + " ms.");
		}

		//		马赛克算法很简单，说白了就是把一张图片分割成若干个val * val像素的小区块（可能在边缘有零星的小块，但不影响整体算法,val越大，
		//		马赛克效果越明显），每个小区块的颜色都是相同的。为了方便起见，我们不妨让这个颜色就用该区域最左上角的那个点的颜色。当然还可以有其他方法，
		//		比如取区块中间点的颜色，或区块中随机点的颜色作代表等等。
		//		下面的示意图就是取val=2的结果。
		//		原图像素
		//		ABCDEFG
		//		HIJKLMN    
		//		OPQRSTU    
		//		VWXYZ01    
		//		2345678    
		//		
		//		马赛克处理后
		//		AACCEEG
		//		AACCEEG
		//		OOQQSSU
		//		OOQQSSU
		//		2244668
		//		原理就是那么简单。具体实现就看各人的思维习惯了。我的想法是：
		//		当y（当前高度）是val的整数倍时：
		//		扫描当前行中的每一点x，如果x也是val的整数倍，记录下当前x,y的颜色值；如果x不是val的整数倍，则沿用最近一次被记录的颜色值。
		//		当y不是val的整数倍：
		//		很简单，直接复制上一行。
		//		因此，区块越大，处理效果越明显；也可得出，源图片(R)对处理后的图片(S)是多对一映射，也就是说：马赛克处理后的图片是不可逆的，不要试图用可逆算法复原。
		//		更多的信息在:	http://www.cnblogs.com/sndnnlfhvk/archive/2012/03/27/2419801.html
		/**
		 * Modify the bitmap to mosaic style.
		 * @param bmp		bitmap need to be modified.
		 * @param factor    the factor more bigger, the mosaic looks more fuzzy.
		 */
		public static function mosaic(bmp:Bitmap, factor:Number=5):void
		{
			var oldTime:int=getTimer();
			// ingore the float 
			var width:uint=bmp.width;
			var height:uint=bmp.height;
			var color:uint;
			var bmd:BitmapData=bmp.bitmapData;
			var pixels:Vector.<uint>=bmd.getVector(bmd.rect);

			for (var y:uint=0; y < height; y++)
			{
				for (var x:uint=0; x < width; x++)
				{
					if (y % factor == 0)
					{
						if (x % factor == 0)
						{
							// pick a random seed pixel color as factor*factor rectangle pixels render color
							//get the pixel color 
							color=pixels[x + int(Math.random() * factor) + y * width];
						}
					}
					else
					{
						// copy the pixel color from previous line
						color=pixels[x + (y - 1) * width];
					}
					// update the pixel to new color 
					pixels[x + y * width]=color;
				}
			}
			// update the new vector
			bmd.setVector(bmd.rect, pixels);
			// trace the time
			trace("Mosaic image(" + String(bmp.width) + "*" + String(bmp.height) + ")" + " Takes " + String(getTimer() - oldTime) + " ms.");
		}

		//		黑白处理原理：彩色图像处理成黑白效果通常有3种算法；
		//		(1).最大值法: 使每个像素点的 R, G, B 值等于原像素点的 RGB (颜色值) 中最大的一个；
		//		(2).平均值法: 使用每个像素点的 R,G,B值等于原像素点的RGB值的平均值；
		//		(3).加权平均值法: 对每个像素点的 R, G, B值进行加权
		//		自认为第三种方法做出来的黑白效果图像最 "真实".
		//		更多的信息在:	http://www.cnblogs.com/sndnnlfhvk/archive/2012/02/27/2370643.html
		/**
		 * Modify bitmap to grayscale style.
		 * @param bmp
		 */
		public static function grayscale(bmp:Bitmap):void
		{
			var oldTime:int=getTimer();

			var width:int=bmp.width;
			var height:int=bmp.height;
			var sourceColor:uint;
			var finalColor:uint;
			var a:uint;
			var r:uint;
			var g:uint;
			var b:uint;
			var ret:uint;
			var bmd:BitmapData=bmp.bitmapData;
			var pixels:Vector.<uint>=bmd.getVector(bmd.rect);

			for (var y:uint=0; y < height; y++)
			{
				for (var x:uint=0; x < width; x++)
				{
					sourceColor=pixels[y * width + x];
					a=(sourceColor & 0xff000000) >> 24;
					r=(sourceColor & 0x00ff0000) >> 16;
					g=(sourceColor & 0x0000ff00) >> 8;
					b=(sourceColor & 0x000000ff);
					ret=uint(r * 0.3 + g * 0.59 + b * 0.11);
					finalColor=(a << 24 | ret << 16 | ret << 8 | ret);
					pixels[y * width + x]=finalColor;
				}
			}

			// update the new vector
			bmd.setVector(bmd.rect, pixels);
			// trace the time
			trace("Grayscale image(" + String(bmp.width) + "*" + String(bmp.height) + ")" + " Takes " + String(getTimer() - oldTime) + " ms.");
		}

		/**
		 * Modify bitmap to grayscale style.
		 * Use ColorMatrixFilter.
		 * This function was huge faster than function "grayscale".
		 * @param image
		 */
		public static function grayscaleFilter(bmp:Bitmap):void
		{
			var oldTime:int=getTimer();

			var matrix:Array=[0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0, 0, 0, 1, 0];
			var grayscaleFilter:ColorMatrixFilter=new ColorMatrixFilter(matrix);
			var filters:Array=bmp.filters;
			filters.push(grayscaleFilter);
			bmp.filters=filters;

			// trace the time
			trace("GrayscaleFilter image(" + String(bmp.width) + "*" + String(bmp.height) + ")" + " Takes " + String(getTimer() - oldTime) + " ms.");
		}

	}
}


