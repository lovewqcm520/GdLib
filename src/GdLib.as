package
{
	import com.gdlib.test.RegisterClassAliasTest;
	import com.gdlib.test.RegisterClassAliasTest2;
	import com.gdlib.util.ObjectUtil;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;

	[SWF (width="800", height="600", backgroundColor="#cccccc")]
	public class GdLib extends Sprite
	{

		private var square:Sprite;
		public function GdLib()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			
			var source:RegisterClassAliasTest = new RegisterClassAliasTest();
			source.point = new Point();
			source.rect = new Rectangle();
			//obj.point.x = obj.point.y = 230;
			source.point.x = source.point.y = 230;
			source.rect.x = source.rect.y = 82;
			source.name = "modify";
			
			source.test2 = new RegisterClassAliasTest2();
			source.test2.filter = new GlowFilter(0xff0000, 0.5, 10, 10, 2, 5, true, true);
			source.test2.matrix = new Matrix(1,2,3,4,5,6);
			source.test2.point = new Point(123,452);
			source.test2.rect = new Rectangle(-213,342,123123,345);
			source.test2.vecter = new Vector.<int>();
			source.test2.vecter.push(56);
			source.test2.vecter.push(12);
			
			var result:RegisterClassAliasTest = ObjectUtil.clone(source);			
			trace(result is RegisterClassAliasTest);
			
			//trace(describeType(source));
		}
		
		public function clone(sourceObj:*):*
		{
			var b:ByteArray = new ByteArray();
			b.writeObject(sourceObj);
			b.position = 0;
			return b.readObject();
		}

	}
}
