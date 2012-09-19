package com.gdlib.test
{
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	public class RegisterClassAliasTest2
	{
		public var matrix:Matrix;
		public var point:Point;
		public var rect:Rectangle;
		public var filter:GlowFilter;
		public var vecter:Vector.<int>;
		public var arr:Array = [1,2,3,4,5,6];
		public var sp:Sprite = new Sprite();
		public var xml:XML = 
			<employees>
								<employee ssn="123-123-1234">
									<name first="John" last="Doe"/>
									<address>
										<street>11 Main St.</street>
										<city>San Francisco</city>
										<state>CA</state>
										<zip>98765</zip>
									</address>
								</employee>
								<employee ssn="789-789-7890">
									<name first="Mary" last="Roe"/>
									<address>
										<street>99 Broad St.</street>
										<city>Newton</city>
										<state>MA</state>
										<zip>01234</zip>
									</address>
								</employee>
							</employees>;

		
		public static var test_static2:Number = 0.98;
		public static var test_dic:Dictionary = new Dictionary();
		
		
		public function RegisterClassAliasTest2()
		{
			test_dic["jack"] = "smart";
		}
	}
}