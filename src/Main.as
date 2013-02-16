package
{
	import components.CoinView;
	
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.system.DeviceCapabilities;
	import feathers.themes.AzureMobileTheme;
	import feathers.themes.MetalWorksMobileTheme;
	
	import flash.system.Capabilities;
	
	import screens.MainScreen;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Main extends Sprite
	{
		public function Main()
		{ 
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(e:Event):void
		{
			DeviceCapabilities.dpi = 326;
			DeviceCapabilities.screenPixelWidth = 960;
			DeviceCapabilities.screenPixelHeight = 640;

			var theme:MetalWorksMobileTheme = new MetalWorksMobileTheme(stage);
			
			var navigator:ScreenNavigator = new ScreenNavigator();
			addChild(navigator);
			
			var mainScreen:ScreenNavigatorItem = new ScreenNavigatorItem(new MainScreen, {listSelected: onMainScreenSelected}, null);
			navigator.addScreen("mainScreen", mainScreen);
			navigator.showScreen("mainScreen");			
		}
		
		private function onMainScreenSelected(e:Event, selectedItem:Object):void
		{
			
		}
		
		
	}
}