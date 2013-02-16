package components
{
	import feathers.controls.Label;
	import feathers.controls.Slider;
	
	import flash.utils.setTimeout;
	
	import starling.display.Sprite;
	import starling.events.Event;

	public class SliderWithTitle extends Sprite
	{
		private var valueLabel	: Label;
		private var titleLabel	: Label;
		private var slider		: Slider;
		
		
		public function get value():Number
		{
			return slider.value;			
		}

		public function get minimum():int
		{
			return slider.minimum;			
		}
		
		public function set minimum(value:int):void
		{
			if(value > slider.maximum)
				slider.maximum = value;
			slider.minimum = value;
			slider.value = value;
		}

		public function get maximum():int
		{
			return slider.maximum;			
		}
		
		public function set maximum(value:int):void
		{
			slider.maximum = value;
		}

		public function get step():Number
		{
			return slider.step;			
		}
		
		public function set step(value:Number):void
		{
			slider.step = value;
		}
		
		public function get sliderWidth():Number
		{
			return slider.width;			
		}
		
		public function set sliderWidth(value:Number):void
		{
			slider.width = value;
			valueLabel.x = slider.width + 10;
			updateTitlePosition();
		}
		
		private function updateTitlePosition():void
		{
			setTimeout( function(){
							titleLabel.x = (slider.width - titleLabel.width)/2;
						}, 10);
		}
		
		public function SliderWithTitle(title:String)
		{
			valueLabel = new Label();
			valueLabel.y = 65;
			addChild(valueLabel);
			
			titleLabel = new Label();
			titleLabel.text = title;
			addChild(titleLabel);
			
			slider = new Slider();
			slider.y = 50;
			slider.addEventListener(Event.CHANGE, onSliderChanged);
			addChild(slider);
			
			updateTitlePosition();
		}
		
		private function onSliderChanged(e:Event):void
		{
			valueLabel.text = slider.value.toString();
		}
		
	}
}