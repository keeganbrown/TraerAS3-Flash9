package traer.physics
{
	// attract positive repel negative
	public class Attraction implements Force
	{
		private var _a:TraerParticle;
		private var _b:TraerParticle;
		private var _k:Number;
		private var _on:Boolean;
		private var _distanceMin:Number;
		private var _distanceMinSquared:Number;
		
		public function Attraction(a:TraerParticle, b:TraerParticle, k:Number, distanceMin:Number)
		{
			this._a = a;
			this._b = b;
			this._k = k;
			_on = true;
			this._distanceMin = distanceMin;
			this._distanceMinSquared = distanceMin * distanceMin;
		}
		
		protected function setA(p:TraerParticle):void
		{
			_a = p;
		}
		
		protected function setB(p:TraerParticle):void
		{
			_b = p;
		}
		
		public function getMinimumDistance():Number
		{
			return _distanceMin;
		}
		
		public function setMinimumDistance(d:Number):void
		{
			_distanceMin = d;
			_distanceMinSquared = d * d;
		}
		
		public function turnOff():void
		{
			_on = false;
		}
		
		public function turnOn():void
		{
			_on = true;
		}
		
		public function setStrength(k:Number):void
		{
			this._k = k;
		}
		
		public function getOneEnd():TraerParticle
		{
			return _a;
		}
		
		public function getTheOtherEnd():TraerParticle
		{
			return _b;
		}
		
		public function apply():void
		{
			if (_on && (_a.isFree() || _b.isFree()))
			{
				var a2bX:Number = _a.position.x - _b.position.x;
				var a2bY:Number = _a.position.y - _b.position.y;
				var a2bZ:Number = _a.position.z - _b.position.z;
				
				var a2bDistanceSquared:Number = a2bX * a2bX + a2bY * a2bY + a2bZ * a2bZ;
				
				if (a2bDistanceSquared < _distanceMinSquared) {
					a2bDistanceSquared = _distanceMinSquared;
				}
				
				var a_force:Number = _k * _a.mass * _b.mass / a2bDistanceSquared;
				
				var length:Number = Number(Math.sqrt(a2bDistanceSquared));
				
				// make unit vector
				
				a2bX /= length;
				a2bY /= length;
				a2bZ /= length;
				
				// multiply by force 
				
				a2bX *= a_force;
				a2bY *= a_force;
				a2bZ *= a_force;
				
				// apply
				
				if (_a.isFree()) {
					_a.force.add( new SimplePoint( -a2bX, -a2bY, -a2bZ ) );
				}
				if (_b.isFree()) {
					_b.force.add( new SimplePoint( a2bX, a2bY, a2bZ ) );
				}
			}
		}
		
		public function getStrength():Number
		{
			return _k;
		}
		
		public function isOn():Boolean
		{
			return _on;
		}
		
		public function isOff():Boolean
		{
			return !_on;
		}
	}
}