package traer.physics
{
	
	public class ModifiedEulerIntegrator implements Integrator
	{
		private var s:TraerParticleSystem;
		
		public function ModifiedEulerIntegrator(s:TraerParticleSystem)
		{
			this.s = s;
		}
		
		public function step(t:Number):void
		{
			s.clearForces();
			s.applyForces();
			
			var halftt:Number = 0.5 * t * t;
			
			for (var i:int = 0; i < s.numberOfTraerParticles(); i++)
			{
				var p:TraerParticle = s.getTraerParticle(i);
				if (p.isFree())
				{
					var ax:Number = p.force.x / p.mass;
					var ay:Number = p.force.y / p.mass;
					var az:Number = p.force.z / p.mass;
					
					p.position.add( new SimplePoint( p.velocity.x / t, p.velocity.y / t, p.velocity.z / t ) );
					p.position.add( new SimplePoint( ax * halftt, ay * halftt, az * halftt ) );
					p.velocity.add( new SimplePoint( ax / t, ay / t, az / t) );
				}
			}
		}
	
	}
}