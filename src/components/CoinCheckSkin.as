package components
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class CoinCheckSkin extends Sprite
	{
		public function CoinCheckSkin(color:uint, text:String)
		{
			addChild(new Quad(50, 50, color));
			
			var textField:TextField = new TextField(50, 50, text);
			textField.fontSize = 14;
			textField.color = 0xffffff;
			addChild(textField);
		}
	}
}