package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import starling.core.Starling;
	
	[SWF(frameRate="60", height="960", width="640")]
	public class CoinsExchange extends Sprite
	{
	
		public function CoinsExchange()
		{
			var _starling:Starling = new Starling(Main, stage);
			_starling.start();
		}
	}
}