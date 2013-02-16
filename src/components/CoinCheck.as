package components
{
	import feathers.controls.Check;
	import feathers.themes.AzureMobileTheme;
	
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class CoinCheck extends Sprite
	{
		private var _value:Number;
		private var check:Check;
		
		public function get value():Number 
		{
			return _value;
		}
		
		public function get isSelected():Boolean 
		{
			return check.isSelected;
		}

		public function CoinCheck(value:Number)
		{
			this._value = value;
			
			check = new Check();
			check.y = 40;
			//check.selectedUpSkin = check.defaultSkin;
			//check.selectedd = check.disabledSkin;
			check.defaultIcon = check.disabledIcon;
			addChild(check);
			
			var textField:TextField = new TextField(50, 50, value.toString());
			textField.touchable = false;
			textField.fontSize = 14;
			textField.color = 0xffffff;
			addChild(textField);
		}
	}
}