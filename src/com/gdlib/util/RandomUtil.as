package com.gdlib.util
{
	import flash.utils.Dictionary;

	/**
	 * 随机类
	 *
	 * @author
	 *
	 */
	public final class RandomUtil
	{
		private static var randomHistory:Dictionary=new Dictionary(); //随机数历史记录

		/**
		 * 获得一个范围内的双精度小数
		 *
		 * @param min	最小值
		 * @param max	最大值
		 * @param duplicate	是否可重复
		 * @return
		 *
		 */
		public static function dec(min:Number, max:Number, duplicate:Boolean=true):Number
		{
			var r:Number;
			r=min + Math.random() * (max - min);
			if (!duplicate)
			{
				while (randomHistory[r])
					r=min + Math.random() * (max - min);

				randomHistory[r]=true;
			}


			return r;
		}

		/**
		 * 获得一个范围内的有符号整数(不包括最大值)
		 *
		 * @param min	最小值
		 * @param max	最大值
		 * @param duplicate	是否可重复
		 * @return
		 *
		 */
		public static function integer(min:int, max:int, duplicate:Boolean=true):int
		{
			var r:int;
			r=min + Math.random() * (max - min);
			if (!duplicate)
			{
				while (randomHistory[r])
					r=min + Math.random() * (max - min);

				randomHistory[r]=true;
			}

			return r;
		}

		/**
		 * 获得一个范围内的无符号整数(包括最大值)
		 * ex:  unsignedInteger(-1024, 1024) = 398 or -549 or -1024 or 1024.
		 * @param min	最小值
		 * @param max	最大值
		 * @param duplicate	是否可重复
		 * @return
		 *
		 */
		public static function unsignedInteger(min:int, max:int, duplicate:Boolean=true):int
		{
			if (min > max)
				throw new Error("In function unsignedInteger, parameter max must bigger than min.");

			var r:int;
			if (min <= 0 && max <= 0)
			{
				r=-integer(-max, -min);
			}
			else if (min <= 0 && max >= 0)
			{
				var rate:Number=-min / (max - min);
				if (Math.random() > rate)
				{
					r=integer(0, max + 1);
				}
				else
				{
					r=-integer(0, -min + 1);
				}
			}
			else
			{
				r=integer(min, max + 1);
			}

			return r;
		}

		/**
		 * 清除随机数历史记录。重新开始取数。
		 *
		 */
		public static function clearHistory():void
		{
			for (var key:* in randomHistory)
			{
				delete randomHistory[key];
			}
		}

		/**
		 * 生成固定长度的随机字符串
		 *
		 * @param len	长度
		 * @return
		 *
		 */
		public static function string(len:int):String
		{
			var result:String="";
			for (var i:int=0; i < len; i++)
			{
				// 28个小写英文字母和28个大写英文字母
				result+=String.fromCharCode(integer(65, 122));
			}
			return result;
		}

		/**
		 * 随机排序
		 *
		 * @param arr	数组
		 *
		 */
		public static function randomArray(arr:Array):Array
		{
			return arr.sort(randomFunction);
		}

		private static function randomFunction(n1:*, n2:*):int
		{
			return (Math.random() < 0.5) ? -1 : 1;
		}

		/**
		 * 随机选择多个数
		 * @param arr
		 * @param num
		 * @return
		 *
		 */
		public static function chooseMuti(arr:Array, num:int):Array
		{
			var a:Array=randomArray(arr.concat());
			return a.slice(0, num);
		}

		/**
		 * 以均等的几率从多个参数中选择一个
		 *
		 * @param reg	数组
		 * @return
		 *
		 */
		public static function choose(... reg):*
		{
			return reg[int(Math.random() * reg.length)];
		}


	}
}

