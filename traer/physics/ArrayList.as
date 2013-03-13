package traer.physics 
{
	/**
	 * ...
	 * @author Keegan
	 */
	dynamic public class ArrayList extends Array 
	{
		
		public function ArrayList(...rest) 
		{
			super();
		}
		
		public function add(item):ArrayList 
		{
			this.push(item);
			return this;
		}
		
		public function remove(index:int):ArrayList
		{
			this.slice( index, 1 );
			return this;
		}
		
		public function eq(index:int):TraerVector3D
		{
			var arr:Array = this as Array;
			if ( arr[index] != undefined ) {
				return arr[index];
			}
			return null;
		}
		
		public function eq_TP(index:int):TraerParticle
		{
			var arr:Array = this as Array;
			if ( arr[index] != undefined ) {
				return arr[index];
			}
			return null;
		}
		
		public function eq_SP(index:int):TraerSpring
		{
			var arr:Array = this as Array;
			if ( arr[index] != undefined ) {
				return arr[index];
			}
			return null;
		}
		
		public function eq_AT(index:int):Attraction
		{
			var arr:Array = this as Array;
			if ( arr[index] != undefined ) {
				return arr[index];
			}
			return null;
		}
		
		public function eq_FC(index:int):Force
		{
			var arr:Array = this as Array;
			if ( arr[index] != undefined ) {
				return arr[index];
			}
			return null;
		}
		
		public function clear():void
		{
			this.clear();
		}
		
		public function size():int
		{
			return this.length;
		}
	}

}