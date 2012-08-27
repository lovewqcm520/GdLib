package com.gdlib.test
{
	import com.gdlib.util.SkewUtil;
	
	import flash.display.Sprite;

	public class DisplayUtilTest extends BaseTest
	{
		[Embed(source="assets/images/EuropeanStarling.jpg")]
		private var TestImage:Class;
		
		public function DisplayUtilTest()
		{
			super();
			
			var sp:Sprite = createTestRectBox();
			addChild(sp);
			
			var sp1:Sprite = createTestRectBox();
			SkewUtil.skewY(sp1, 45);
			sp1.x = 300;			
			addChild(sp1);
			
			var sp2:Sprite = createTestRectBox();
			SkewUtil.skewY(sp2, -45);
			sp2.y = 300;			
			addChild(sp2);
			
			var sp3:Sprite = createTestRectBox();
			SkewUtil.skewX(sp3, -45);
			sp3.x = 600;			
			addChild(sp3);
			
			var sp4:Sprite = createTestRectBox();
			SkewUtil.skewX(sp4, -45);
			sp4.y = 300;	
			sp4.x = 600;			
			addChild(sp4);
		}
		
		private function createTestRectBox():Sprite
		{
			var sp:Sprite = new Sprite();
			sp.graphics.beginFill(0xcccccc, 1);
			sp.graphics.drawRect(0, 0, 158.2, 45.6);
			sp.graphics.endFill();
			
			return sp;
		}
	}
}