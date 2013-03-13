package traer.physics 
{
	/**
	 * ...
	 * @author Peter Mayer Advertising for CenturyLink
	 */
	public class SimplePoint extends Object 
	{
		protected var _x:Number;
		protected var _y:Number;
		protected var _z:Number;
		
		public function SimplePoint(X:Number = 0, Y:Number = 0, Z:Number = 0) 
		{
			_x = X;
			_y = Y;
			_z = Z;
		}
		
		public function get z():Number
		{
			return _z;
		}
		
		public function get y():Number
		{
			return _y;
		}
		
		public function get x():Number
		{
			return _x;
		}
		
		public function set x(X:Number):void
		{
			_x = X;
		}
		
		public function set y(Y:Number):void
		{
			_y = Y;
		}
		
		public function set z(Z:Number):void
		{
			_z = Z;
		}
	}
}