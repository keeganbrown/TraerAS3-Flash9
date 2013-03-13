package traer.physics
{
	
	public class TraerParticle
	{
		protected var _position:TraerVector3D;
		protected var _velocity:TraerVector3D;
		protected var _force:TraerVector3D;
		protected var _mass:Number;
		protected var _age:Number;
		protected var _dead:Boolean;
		
		protected var _fixed:Boolean;
		
		public function TraerParticle(m:Number)
		{
			_position = new TraerVector3D();
			_velocity = new TraerVector3D();
			_force = new TraerVector3D();
			_mass = m;
			_fixed = false;
			_age = 0;
			_dead = false;
		}

		public function distanceTo(p:TraerParticle):Number
		{
			return this.position.distanceTo(p.position);
		}

		public function makeFixed():void
		{
			_fixed = true;
			_velocity.clear();
		}

		public function isFixed():Boolean
		{
			return _fixed;
		}

		public function isFree():Boolean
		{
			return !_fixed;
		}

		public function makeFree():void
		{
			_fixed = false;
		}

		public function set position( pos:TraerVector3D ):void
		{
			_position = pos;
		}
		
		public function get position():TraerVector3D
		{
			return _position;
		}
		
		public function set velocity( vel:TraerVector3D ):void
		{
			_velocity = vel;
		}

		public function get velocity():TraerVector3D
		{
			return _velocity;
		}

		public function set mass( m:Number ):void
		{
			_mass = m;
		}		
		
		public function get mass():Number
		{
			return _mass;
		}

		public function setMass(m:Number):void
		{
			_mass = m;
		}

		public function get force():TraerVector3D
		{
			return _force;
		}
		
		public function set force(force:TraerVector3D):void
		{
			_force = force;
		}		

		public function get age():Number
		{
			return _age;
		}
		
		public function set age(a:Number):void
		{
			_age = a;
		}
		
		protected function reset():void
		{
			_age = 0;
			_dead = false;
			_position.clear();
			_velocity.clear();
			_force.clear();
			_mass = 1;
		}
	}
}