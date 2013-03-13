package traer.physics
{
	
	public class EulerIntegrator implements Integrator
	{
		var s:TraerParticleSystem;
		
		public function EulerIntegrator(s:TraerParticleSystem)
		{
			this.s = s;
		}
		
		public function step(t:Number):void
		{
			s.clearForces();
			s.applyForces();
			
			for (var i:int = 0; i < s.numberOfTraerParticles(); i++)
			{
				var p:TraerParticle = TraerParticle(s.getTraerParticle(i));
				if (p.isFree())
				{
					p.velocity.add(p.force().x() / (p.mass * t), p.force().y() / (p.mass * t), p.force().z() / (p.mass * t));
					p.position.add(p.velocity.x() / t, p.velocity.y() / t, p.velocity.z() / t);
				}
			}
		}
	
	}
}