package screens
{
	import com.greensock.TweenMax;
	
	import components.CoinCheck;
	import components.CoinView;
	import components.SliderWithTitle;
	
	import feathers.controls.Button;
	import feathers.controls.Check;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.controls.Slider;
	import feathers.data.ListCollection;
	import feathers.layout.HorizontalLayout;
	
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.setTimeout;
	
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Polygon;
	import nape.space.Space;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class MainScreen extends Screen
	{
		private var header					: Header;
		private var moneySlider				: SliderWithTitle;
		private var peopleNumSlider			: SliderWithTitle;
		private var initialized				: Boolean;
		private var exchangeButton			: Button;
		private var coinsChecks				: Array = new Array();
		private var coinsValuesTitleLabel	: Label;

		private var resultList:List;

		private var physicsSpace:Space;
		
		public function MainScreen()
		{
			super();
		}
		
		override protected function draw():void
		{
			if(!initialized) return;
			header.width = actualWidth;

			moneySlider.x = 40;
			moneySlider.y = 100;
			
			peopleNumSlider.x = 40;
			peopleNumSlider.y = 230;
			
			exchangeButton.x = 250;
			exchangeButton.y = 730;

			coinsValuesTitleLabel.x = 160;
			coinsValuesTitleLabel.y = 370;
			
			var x_pos:int = 140;
			
			for each(var coinCheck:CoinCheck in coinsChecks)
			{
				coinCheck.x = x_pos;
				x_pos += (coinCheck.width + 10);
				coinCheck.y = 420;
			}		
		}
		
		override protected function initialize():void
		{
			var settingsLoader:URLLoader = new URLLoader();
			settingsLoader.load(new URLRequest("settings.json"));
			settingsLoader.addEventListener(flash.events.Event.COMPLETE, onSettingsLoadComplete);
			settingsLoader.addEventListener(IOErrorEvent.IO_ERROR, onSettingsLoadError);
		}
		
		protected function onSettingsLoadError(e:IOErrorEvent):void
		{
			trace("Settings loading error");
		}
		
		protected function onSettingsLoadComplete(e:flash.events.Event):void
		{
			var settings : Object;
			settings = JSON.parse(String (e.target.data));
			
			CoinsExchanger.maxLoopNumber = settings.maxAlgLoops;

			header = new Header();
			header.title = settings.title;
			addChild(header);
			
			moneySlider = new SliderWithTitle("Select amount of money");
			moneySlider.minimum = settings.minMoneyAmount;
			moneySlider.maximum = settings.maxMoneyAmount;
			moneySlider.step = settings.moneyStep;
			moneySlider.sliderWidth = 500;
			addChild(moneySlider);
			
			peopleNumSlider = new SliderWithTitle("Select number of people");
			peopleNumSlider.minimum = settings.minPeopleNum;
			peopleNumSlider.maximum = settings.maxPeopleNum;
			peopleNumSlider.step = 1;
			peopleNumSlider.sliderWidth = 500;
			addChild(peopleNumSlider);
			
			exchangeButton = new Button();
			exchangeButton.label = "Exchange";
			exchangeButton.addEventListener(Event.TRIGGERED, onExchangeButtonTriggered);
			addChild(exchangeButton);
			
			coinsValuesTitleLabel = new Label();
			coinsValuesTitleLabel.text = "Choose coins values";
			addChild(coinsValuesTitleLabel);
			
			for each(var coinValue:Number in settings.coinsValues)
			{
				var coinCheck:CoinCheck = new CoinCheck(coinValue);
				coinsChecks.push(coinCheck);
				addChild(coinCheck);
			}
			
			resultList = new List();
			resultList.width = stage.stageWidth;
			resultList.y = stage.stageHeight-300;
			resultList.height = 50;
			
			var layout:HorizontalLayout = new HorizontalLayout();
			layout.gap = 2;
			layout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_JUSTIFY;
			resultList.layout = layout;
			resultList.itemRendererProperties.labelField = "text";
			resultList.itemRendererProperties.accessoryLabelField = "description";
			addChild(resultList);

			// Creating physical space
			physicsSpace = new Space(new Vec2(0, 6000));
			createFloor();	
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
	
			initialized = true;
			this.draw();
		}
		
		private function onEnterFrame(e:Event):void
		{
			physicsSpace.step(1/60);
		}
		
		private function createFloor():void
		{
			var wallBody:Body = new Body(BodyType.STATIC);
			wallBody.shapes.add(new Polygon(Polygon.rect(0, stage.stageHeight-300, stage.stageWidth, 10)));
			wallBody.space = physicsSpace;
		}
		
		private function createCoin():void
		{
			// creating coin view
			var coinView:CoinView = new CoinView();
			addChild(coinView);
			
			// creating coin phisician body
			var coinBody:Body = new Body(BodyType.DYNAMIC);
			coinBody.shapes.add(new Polygon(Polygon.rect(12, 12, coinView.width - 12, coinView.height - 12), new Material(0.65)));
			
			coinBody.space = physicsSpace;
			coinBody.graphic = coinView; // binding view to body
			//coinBody.angularVel = 10;
			//coinBody.mass = 10;
			coinBody.position = new Vec2(300, 300); // set coin to start position
		}
		
		private function onExchangeButtonTriggered(e:Event):void
		{	
			var coinsValues:Array = new Array();
			
			for each(var coinsCheck:CoinCheck in coinsChecks)
			{
				if(coinsCheck.isSelected)
					coinsValues.push(coinsCheck.value);	
			}
			
			if(coinsValues.length == 0)
			{
				createFloatingText("Please select coins");
				return;
			}
			
			var result:Array = CoinsExchanger.exchange(moneySlider.value, coinsValues, peopleNumSlider.value);

			if(result == null)
			{
				createFloatingText("No solution");
				return;
			}

			if(result.length == 0)
			{
				createFloatingText("Need too much time...");
				return;
			}

			var labels:ListCollection = new ListCollection();
			
			for(var i:int = 0; i < 20; i++)
				createCoin();
			
			//result = ["0.2","aa ","aa ","aa","bb"];
			for each(var num:Object in result)
			{
				labels.push({ text:"", description:num.toString()});
			}
			resultList.dataProvider = labels;
		}
		
		public function createFloatingText(text:String):void
		{
			function onFloatComplete():void
			{
				setTimeout(function(){
					TweenMax.to(label, 0.5, {alpha: 0});
				}, 1000);
			}
			
			var label:Label = new Label();
			label.touchable = false;
			label.text = text;
			label.x = 170;
			label.y = 500;
			this.addChild(label);
			label.alpha = 0;
			TweenMax.to(label, 0.9, {y: label.y - 30, alpha:1, onComplete: onFloatComplete});
		}
		
	}
}