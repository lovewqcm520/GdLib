package com.gdlib.test
{
	import com.gdlib.util.bitmap.BitmapUtil;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;

	public class BitmapProcessTest extends BaseTest
	{
		//[Embed(source="assets/images/rebellious.png")]
		[Embed(source="assets/images/jack.jpg")]
		private var TestImage:Class;

		private var sourceBmp:Bitmap;
		
		public function BitmapProcessTest()
		{
			super();
		}
		
		override protected function init():void
		{
			super.init();
			
			sourceBmp = new TestImage();
			sourceBmp.x = 0;
			sourceBmp.y = 0;
			addChild(sourceBmp);
			
			stage.addEventListener(MouseEvent.CLICK, onStageClick);
		}
		
		protected function onStageClick(event:MouseEvent):void
		{
			BitmapUtil.binarizeImage(sourceBmp);
		}		
		
	}
}