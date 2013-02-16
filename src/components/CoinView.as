package components
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class CoinView extends Sprite
	{
		[Embed(source="../assets/Coin.png")]
		private static var Coin:Class;
		
		public function CoinView()
		{
			touchable = false;
			addChild(new Image(Texture.fromBitmap(new Coin)));
		}
	}
}