package traer.physics
{
	
	public class TraerVector3D extends SimplePoint
	{
		public function TraerVector3D( p:SimplePoint = null )
		{
			if ( p == null ) p = new SimplePoint(); 
			_x = p.x;
			_y = p.y;
			_z = p.z;
		}
		
		public function setV3D( p:SimplePoint )
		{
			_x = p.x;
			_y = p.y;
			_z = p.z;
		}
		
		public function setXYZ(X:Number = 0, Y:Number = 0, Z:Number = 0)
		{
			_x = X;
			_y = Y;
			_z = Z;
		}
		
		public function add(p:SimplePoint):void
		{
			_x += p.x;
			_y += p.y;
			_z += p.z;
		}
		
		public function addXYZ(X:Number = 0, Y:Number = 0, Z:Number = 0):void
		{
			_x += X;
			_y += Y;
			_z += Z;
		}
		
		public function subtract(p:SimplePoint):void
		{
			_x -= p.x;
			_y -= p.y;
			_z -= p.z;
		}
		
		public function subtractXYZ(X:Number = 0, Y:Number = 0, Z:Number = 0):void
		{
			_x -= X;
			_y -= Y;
			_z -= Z;
		}
		
		public function multiplyBy(force:Number):TraerVector3D
		{
			_x *= force;
			_y *= force;
			_z *= force;
			return this;
		}
		
		public function distanceTo(p:SimplePoint):Number
		{
			return Number(Math.sqrt(distanceSquaredTo(p)));
		}
		
		public function distanceToXYZ(X:Number = 0, Y:Number = 0, Z:Number = 0):Number
		{
			var dx:Number = _x - X;
			var dy:Number = _y - Y;
			var dz:Number = _z - Z;
			return Number(Math.sqrt(dx * dx + dy * dy + dz * dz));
		}

		public function distanceSquaredTo(p:SimplePoint):Number
		{
			var dx:Number = _x - p.x;
			var dy:Number = _y - p.y;
			var dz:Number = _z - p.z;
			return dx * dx + dy * dy + dz * dz;
		}
		
		public function dot(p:TraerVector3D):Number
		{
			return _x * p.x + _y * p.y + _z * p.z;
		}
		
		public function length():Number
		{
			return Number(Math.sqrt(_x * _x + _y * _y + _z * _z));
		}
		
		public function lengthSquared():Number
		{
			return _x * _x + _y * _y + _z * _z;
		}
		
		public function clear():void
		{
			_x = 0;
			_y = 0;
			_z = 0;
		}
		
		public function toString():String
		{
			return new String("(" + _x + ", " + _y + ", " + _z + ")");
		}
		
		public function cross(p:TraerVector3D):TraerVector3D
		{
			return new TraerVector3D( new SimplePoint( this.y * p.z - this.z * p.y, this.x * p.z - this.z * p.x, this.x * p.y - this.y * p.x ) );
		}
		
		public function isZero():Boolean
		{
			return Boolean(_x == 0 && _y == 0 && _z == 0);
		}
	}
}