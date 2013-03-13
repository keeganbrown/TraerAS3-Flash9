package traer.physics
{
	
	public class TraerParticleSystem
	{
		public static const RUNGE_KUTTA:int = 0;
		public static const MODIFIED_EULER:int = 1;
		
		protected static const DEFAULT_GRAVITY:Number = 0;
		protected static const DEFAULT_DRAG:Number = 0.001;
		
		public var TraerParticles:ArrayList;
		public var TraerSprings:ArrayList;
		public var attractions:ArrayList;
		public var customForces:ArrayList = new ArrayList();
		
		var integrator:Integrator;
		
		var gravity:TraerVector3D;
		var drag:Number;
		
		var hasDeadTraerParticles:Boolean = false;
		
		public function TraerParticleSystem(gx:Number = 0, gy:Number = TraerParticleSystem.DEFAULT_GRAVITY, gz:Number = 0, somedrag:Number = TraerParticleSystem.DEFAULT_DRAG)
		{
			integrator = new RungeKuttaIntegrator(this);
			TraerParticles = new ArrayList();
			TraerSprings = new ArrayList();
			attractions = new ArrayList();
			gravity = new TraerVector3D( new SimplePoint( gx, gy, gz ) );
			drag = somedrag;
		}
		
		public function setIntegrator(integrator:int):void
		{
			switch (integrator)
			{
				case RUNGE_KUTTA: 
					this.integrator = new RungeKuttaIntegrator(this);
					break;
				case MODIFIED_EULER: 
					this.integrator = new ModifiedEulerIntegrator(this);
					break;
			}
		}
		
		public function setGravity(x:Number = 0, y:Number = TraerParticleSystem.DEFAULT_GRAVITY, z:Number = 0):void
		{
			gravity.setXYZ(x, y, z);
		}
		
		public function setDrag(d:Number):void
		{
			drag = d;
		}

		public function tick(t:Number = 1):void
		{
			integrator.step(t);
		}
		
		public function makeTraerParticle(mass:Number = 1.0, x:Number = 0, y:Number = 0, z:Number = 0):TraerParticle
		{
			var p:TraerParticle = new TraerParticle(mass);
			p.position.setXYZ(x, y, z);
			TraerParticles.add(p);
			return p;
		}
		
		public function makeTraerSpring(a:TraerParticle, b:TraerParticle, ks:Number, d:Number, r:Number):TraerSpring
		{
			var s:TraerSpring = new TraerSpring(a, b, ks, d, r);
			TraerSprings.add(s);
			return s;
		}
		
		public function makeAttraction(a:TraerParticle, b:TraerParticle, k:Number, minDistance:Number):Attraction
		{
			var m:Attraction = new Attraction(a, b, k, minDistance);
			attractions.add(m);
			return m;
		}
		
		public function clear():void
		{
			TraerParticles.clear();
			TraerSprings.clear();
			attractions.clear();
		}
		
		public function applyForces():void
		{
			var i:int = 0;
			var p:TraerParticle;
			if (!gravity.isZero())
			{
				for (i = 0; i < TraerParticles.size(); ++i)
				{
					p = TraerParticle(TraerParticles.eq_TP(i));
					p.force.add(gravity);
				}
			}
			
			for (i = 0; i < TraerParticles.size(); ++i)
			{
				p = TraerParticle(TraerParticles.eq_TP(i));
				p.force.add( new SimplePoint( p.velocity.x * -drag, p.velocity.y * -drag, p.velocity.z * -drag ) );
			}
			
			for (i = 0; i < TraerSprings.size(); i++)
			{
				var s_force:TraerSpring = TraerSpring(TraerSprings.eq_SP(i));
				s_force.apply();
			}
			
			for (i = 0; i < attractions.size(); i++)
			{
				var a_force:Attraction = Attraction(attractions.eq_AT(i));
				a_force.apply();
			}
			
			for (i = 0; i < customForces.size(); i++)
			{
				var f_force:Force = Force(customForces.eq_FC(i));
				f_force.apply();
			}
		}
		
		public function clearForces():void
		{
			var i:int = TraerParticles.size();
			while (i--)
			{
				var p:TraerParticle = TraerParticles[i];
				p.force.clear();
			}
		}
		
		public function numberOfTraerParticles():int
		{
			return TraerParticles.size();
		}
		
		public function numberOfTraerSprings():int
		{
			return TraerSprings.size();
		}
		
		public function numberOfAttractions():int
		{
			return attractions.size();
		}
		
		public function getTraerParticle(i:int):TraerParticle
		{
			return TraerParticle(TraerParticles.eq_TP(i));
		}
		
		public function getTraerSpring(i:int):TraerSpring
		{
			return TraerSpring(TraerSprings.eq_TP(i));
		}
		
		public function getAttraction(i:int):Attraction
		{
			return Attraction(attractions.eq_TP(i));
		}
		
		public function addCustomForce(force:Force):void
		{
			customForces.add(force);
		}
		
		public function numberOfCustomForces():int
		{
			return customForces.size();
		}
		
		public function getCustomForce(i:int):Force
		{
			return Force(customForces.eq(i));
		}
		
		public function removeCustomForce(i:int):Force
		{
			return Force(customForces.remove(i));
		}
		
		public function removeTraerSpring(i:int):TraerSpring
		{
			return TraerSpring(TraerSprings.remove(i));
		}
		
		public function removeAttraction(i:int):Attraction
		{
			return Attraction(attractions.remove(i));
		}
	
	}
}