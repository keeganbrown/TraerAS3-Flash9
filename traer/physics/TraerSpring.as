package traer.physics
{
	
	/**
	 * @author jeffrey traer bernstein
	 *
	 */
	public class TraerSpring implements Force
	{
		protected var _TraerSpringConstant:Number;
		protected var _damping:Number;
		protected var _restLength:Number;
		protected var _a:TraerParticle;
		protected var _b:TraerParticle;
		protected var _on:Boolean;
		
		public function TraerSpring(A:TraerParticle, B:TraerParticle, springConstant:Number, damping:Number, restLength:Number)
		{
			_TraerSpringConstant = springConstant;
			_damping = damping;
			_restLength = restLength;
			_a = A;
			_b = B;
			_on = true;
		}
		
		public function turnOff():void
		{
			_on = false;
		}
		
		public function turnOn():void
		{
			_on = true;
		}
		
		public function isOn():Boolean
		{
			return _on;
		}
		
		public function isOff():Boolean
		{
			return !_on;
		}
		
		public function getOneEnd():TraerParticle
		{
			return _a;
		}
		
		public function getTheOtherEnd():TraerParticle
		{
			return _b;
		}
		
		public function currentLength():Number
		{
			return _a.position.distanceTo(_b.position);
		}
		
		public function restLength():Number
		{
			return _restLength;
		}
		
		public function strength():Number
		{
			return _TraerSpringConstant;
		}
		
		public function setStrength(ks:Number):void
		{
			_TraerSpringConstant = ks;
		}
		
		public function damping():Number
		{
			return _damping;
		}
		
		public function setDamping(d:Number):void
		{
			_damping = d;
		}
		
		public function setRestLength(l:Number):void
		{
			_restLength = l;
		}
		
		public function apply():void
		{
			if (_on && (_a.isFree() || _b.isFree()))
			{
				var a2bX:Number = _a.position.x - _b.position.x;
				var a2bY:Number = _a.position.y - _b.position.y;
				var a2bZ:Number = _a.position.z - _b.position.z;
				
				var a2bDistance:Number = Number(Math.sqrt(a2bX * a2bX + a2bY * a2bY + a2bZ * a2bZ));
				
				if (a2bDistance == 0)
				{
					a2bX = 0;
					a2bY = 0;
					a2bZ = 0;
				}
				else
				{
					a2bX /= a2bDistance;
					a2bY /= a2bDistance;
					a2bZ /= a2bDistance;
				}
				
				// TraerSpring force is proportional to how much it stretched 
				
				var TraerSpringForce:Number = -(a2bDistance - _restLength) * _TraerSpringConstant;
				
				// want velocity along line b/w a & b, damping force is proportional to this
				
				var Va2bX:Number = _a.velocity.x - _b.velocity.x;
				var Va2bY:Number = _a.velocity.y - _b.velocity.y;
				var Va2bZ:Number = _a.velocity.z - _b.velocity.z;
				
				var dampingForce:Number = -_damping * (a2bX * Va2bX + a2bY * Va2bY + a2bZ * Va2bZ);
				
				// forceB is same as forceA in opposite direction
				
				var r:Number = TraerSpringForce + dampingForce;
				
				a2bX *= r;
				a2bY *= r;
				a2bZ *= r;
				
				if (_a.isFree()) {
					_a.force.add( new SimplePoint( a2bX, a2bY, a2bZ ) );
				}
				if (_b.isFree()) {
					_b.force.add( new SimplePoint( -a2bX, -a2bY, -a2bZ ) );
				}
			}
		}
		
		protected function setA(p:TraerParticle):void
		{
			_a = p;
		}
		
		protected function setB(p:TraerParticle):void
		{
			_b = p;
		}
	}
}