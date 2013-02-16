package
{
	public class CoinsExchanger
	{
		static private var coins		: Array;
		static private var moneyAmount	: int;
		static private var peopleNum	: int;

		private static var order:int;
		
		static public function exchange(_moneyAmount:Number, _coins:Array, _peopleNum:int):Array
		{
			peopleNum = _peopleNum;
			coins = _coins;
			
			var minCoin:Number = coins[0];
			
			for each(var coin:Number in coins)
				minCoin = Math.min(minCoin, coin);
			
			order = 1;
			
			while(minCoin - int(minCoin) != 0)
			{
				minCoin *= 10;
				order *= 10;
			}

			for(var i:int = 0;i < coins.length;i++)
				coins[i] = int(Math.round(coins[i]*order));
			moneyAmount = int(Math.round(_moneyAmount*order));
			
			coins.sort(Array.NUMERIC | Array.DESCENDING);	

			var result:Array = calc(moneyAmount, []);
			if(result != null)
				for(var i:int = 0;i < result.length;i++)
					result[i] /= order;
			return result;
		}
		
		public function CoinsExchanger()
		{
		}
		
		static private function calc(num:int, res:Array):Array
		{
			var loc_res:Array = res.slice();
				
			if(loc_res.length > peopleNum)
				return null; 
			
			loc_res.push(0);
			
			for(var pos:int = 0;pos < coins.length;pos++)
			{
				loc_res.pop();   
				var n1:int = coins[pos];
				loc_res.push(n1);
				trace(loc_res);
				if(loc_res[0] == 1 &&
					loc_res[1] == 1 &&
					loc_res[2] == 0.25 &&
					loc_res[3] == 0.25 &&
					loc_res[4] == 0.01 &&
					loc_res[5] == 0.01)
						trace("S");
				var n2:int = num - n1;
			
				if(n2 == 0 && loc_res.length == peopleNum)
					return loc_res;
			
				if(n2 < 0)
				{
					continue;
				}
				else
				{
					var ret:Array = calc(n2, loc_res);
					if(ret != null)
						return ret;
				}
			}
			return null;
		}
		
	}
}