package
{
	import components.CoinView;
	
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.themes.AzureMobileTheme;
	
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
			var theme:AzureMobileTheme = new AzureMobileTheme(stage);
			
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