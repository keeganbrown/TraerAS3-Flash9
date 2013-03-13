package traer.physics
{
	
	public class RungeKuttaIntegrator implements Integrator
	{
		var originalPositions:ArrayList;
		var originalVelocities:ArrayList;
		var k1Forces:ArrayList;
		var k1Velocities:ArrayList;
		var k2Forces:ArrayList;
		var k2Velocities:ArrayList;
		var k3Forces:ArrayList;
		var k3Velocities:ArrayList;
		var k4Forces:ArrayList;
		var k4Velocities:ArrayList;
		
		var s:TraerParticleSystem;
		
		public function RungeKuttaIntegrator(s:TraerParticleSystem)
		{
			this.s = s;
			
			originalPositions = new ArrayList();
			originalVelocities = new ArrayList();
			k1Forces = new ArrayList();
			k1Velocities = new ArrayList();
			k2Forces = new ArrayList();
			k2Velocities = new ArrayList();
			k3Forces = new ArrayList();
			k3Velocities = new ArrayList();
			k4Forces = new ArrayList();
			k4Velocities = new ArrayList();
		}
		
		function allocateTraerParticles():void
		{
			while (s.TraerParticles.size() > originalPositions.size())
			{
				originalPositions.add(new TraerVector3D());
				originalVelocities.add(new TraerVector3D());
				k1Forces.add(new TraerVector3D());
				k1Velocities.add(new TraerVector3D());
				k2Forces.add(new TraerVector3D());
				k2Velocities.add(new TraerVector3D());
				k3Forces.add(new TraerVector3D());
				k3Velocities.add(new TraerVector3D());
				k4Forces.add(new TraerVector3D());
				k4Velocities.add(new TraerVector3D());
			}
		}
		
		public function step(deltaT:Number):void
		{
			allocateTraerParticles();
			/////////////////////////////////////////////////////////
			// save original position and velocities
			
			var p:TraerParticle;
			var i:int = 0;
			var originalPosition:TraerVector3D;
			var k1Velocity:TraerVector3D;
			var k2Velocity:TraerVector3D;
			var k3Velocity:TraerVector3D;
			var k4Velocity:TraerVector3D;
			
			var originalVelocity:TraerVector3D;
			var k1Force:TraerVector3D;
			var k2Force:TraerVector3D;
			var k3Force:TraerVector3D;
			var k4Force:TraerVector3D;
					
			for (i = 0; i < s.TraerParticles.size(); ++i)
			{
				p = TraerParticle(s.TraerParticles.eq_TP(i))
				if (p.isFree())
				{
					(TraerVector3D(originalPositions.eq(i))).setV3D(p.position);
					(TraerVector3D(originalVelocities.eq(i))).setV3D(p.velocity);
				}
				
				p.force.clear(); // and clear the forces
			}
			
			////////////////////////////////////////////////////////
			// get all the k1 values
			
			s.applyForces();
			
			p = null;
			
			// save the intermediate forces
			for (i = 0; i < s.TraerParticles.size(); ++i)
			{
				p = TraerParticle(s.TraerParticles.eq_TP(i));
				if (p.isFree())
				{
					(TraerVector3D(k1Forces.eq(i))).setV3D(p.force);
					(TraerVector3D(k1Velocities.eq(i))).setV3D(p.velocity);
				}
				
				p.force.clear();
			}
			p = null;
			
			////////////////////////////////////////////////////////////////
			// get k2 values
			
			for (i = 0; i < s.TraerParticles.size(); ++i)
			{
				p = TraerParticle(s.TraerParticles.eq_TP(i));
				if (p.isFree())
				{
					originalPosition = TraerVector3D(originalPositions.eq(i));
					k1Velocity = TraerVector3D(k1Velocities.eq(i));
					
					p.position.x = originalPosition.x + k1Velocity.x * 0.5 * deltaT;
					p.position.y = originalPosition.y + k1Velocity.y * 0.5 * deltaT;
					p.position.z = originalPosition.z + k1Velocity.z * 0.5 * deltaT;
					
					originalVelocity = TraerVector3D(originalVelocities.eq(i));
					k1Force = TraerVector3D(k1Forces.eq(i));
					
					p.velocity.x = originalVelocity.x + k1Force.x * 0.5 * deltaT / p.mass;
					p.velocity.y = originalVelocity.y + k1Force.y * 0.5 * deltaT / p.mass;
					p.velocity.z = originalVelocity.z + k1Force.z * 0.5 * deltaT / p.mass;
				}
			}
			s.applyForces();
			p = null;
			
			// save the intermediate forces
			for (i = 0; i < s.TraerParticles.size(); ++i)
			{
				p = TraerParticle(s.TraerParticles.eq_TP(i));
				if (p.isFree())
				{
					(TraerVector3D(k2Forces.eq(i))).setV3D(p.force);
					(TraerVector3D(k2Velocities.eq(i))).setV3D(p.velocity);
				}
				
				p.force.clear(); // and clear the forces now that we are done with them
			}
			p = null;
			/////////////////////////////////////////////////////
			// get k3 values
			
			for (i = 0; i < s.TraerParticles.size(); ++i)
			{
				p = TraerParticle(s.TraerParticles.eq_TP(i));
				if (p.isFree())
				{
					originalPosition = TraerVector3D(originalPositions.eq(i));
					k2Velocity = TraerVector3D(k2Velocities.eq(i));
					
					p.position.x = originalPosition.x + k2Velocity.x * 0.5 * deltaT;
					p.position.y = originalPosition.y + k2Velocity.y * 0.5 * deltaT;
					p.position.z = originalPosition.z + k2Velocity.z * 0.5 * deltaT;
					
					originalVelocity = TraerVector3D(originalVelocities.eq(i));
					k2Force = TraerVector3D(k2Forces.eq(i));
					
					p.velocity.x = originalVelocity.x + k2Force.x * 0.5 * deltaT / p.mass;
					p.velocity.y = originalVelocity.y + k2Force.y * 0.5 * deltaT / p.mass;
					p.velocity.z = originalVelocity.z + k2Force.z * 0.5 * deltaT / p.mass;
				}
			}
			
			s.applyForces();
			
			p = null;
			
			// save the intermediate forces
			for (i = 0; i < s.TraerParticles.size(); ++i)
			{
				p = TraerParticle(s.TraerParticles.eq_TP(i));
				if (p.isFree())
				{
					(TraerVector3D(k3Forces.eq(i))).setV3D(p.force);
					(TraerVector3D(k3Velocities.eq(i))).setV3D(p.velocity);
				}
				
				p.force.clear(); // and clear the forces now that we are done with them
			}
			p = null;
			//////////////////////////////////////////////////
			// get k4 values
			
			for (i = 0; i < s.TraerParticles.size(); ++i)
			{
				p = TraerParticle(s.TraerParticles.eq_TP(i));
				if (p.isFree())
				{
					originalPosition = TraerVector3D(originalPositions.eq(i));
					k3Velocity = TraerVector3D(k3Velocities.eq(i));
					
					p.position.x = originalPosition.x + k3Velocity.x * deltaT;
					p.position.y = originalPosition.y + k3Velocity.y * deltaT;
					p.position.z = originalPosition.z + k3Velocity.z * deltaT;
					
					originalVelocity = TraerVector3D(originalVelocities.eq(i));
					k3Force = TraerVector3D(k3Forces.eq(i));
					
					p.velocity.x = originalVelocity.x + k3Force.x * deltaT / p.mass;
					p.velocity.y = originalVelocity.y + k3Force.y * deltaT / p.mass;
					p.velocity.z = originalVelocity.z + k3Force.z * deltaT / p.mass;
					
				}
			}
			
			s.applyForces();
			p = null;
			
			// save the intermediate forces
			for (i = 0; i < s.TraerParticles.size(); ++i)
			{
				p = TraerParticle(s.TraerParticles.eq_TP(i));
				if (p.isFree())
				{
					(TraerVector3D(k4Forces.eq(i))).setV3D(p.force);
					(TraerVector3D(k4Velocities.eq(i))).setV3D(p.velocity);
				}
			}
			p = null;
			/////////////////////////////////////////////////////////////
			// put them all together and what do you get?
			
			for (i = 0; i < s.TraerParticles.size(); ++i)
			{
				p = TraerParticle(s.TraerParticles.eq_TP(i));
				p.age += deltaT;
				if (p.isFree())
				{
					// update position
					
					originalPosition = TraerVector3D(originalPositions.eq(i));
					k1Velocity = TraerVector3D(k1Velocities.eq(i));
					k2Velocity = TraerVector3D(k2Velocities.eq(i));
					k3Velocity = TraerVector3D(k3Velocities.eq(i));
					k4Velocity = TraerVector3D(k4Velocities.eq(i));
					
					p.position.x = originalPosition.x + deltaT / 6.0 * (k1Velocity.x + 2.0 * k2Velocity.x + 2.0 * k3Velocity.x + k4Velocity.x);
					p.position.y = originalPosition.y + deltaT / 6.0 * (k1Velocity.y + 2.0 * k2Velocity.y + 2.0 * k3Velocity.y + k4Velocity.y);
					p.position.z = originalPosition.z + deltaT / 6.0 * (k1Velocity.z + 2.0 * k2Velocity.z + 2.0 * k3Velocity.z + k4Velocity.z);
					
					// update velocity
					
					originalVelocity = TraerVector3D(originalVelocities.eq(i));
					k1Force = TraerVector3D(k1Forces.eq(i));
					k2Force = TraerVector3D(k2Forces.eq(i));
					k3Force = TraerVector3D(k3Forces.eq(i));
					k4Force = TraerVector3D(k4Forces.eq(i));
					
					p.velocity.x = originalVelocity.x + deltaT / (6.0 * p.mass) * (k1Force.x + 2.0 * k2Force.x + 2.0 * k3Force.x + k4Force.x);
					p.velocity.y = originalVelocity.y + deltaT / (6.0 * p.mass) * (k1Force.y + 2.0 * k2Force.y + 2.0 * k3Force.y + k4Force.y);
					p.velocity.z = originalVelocity.z + deltaT / (6.0 * p.mass) * (k1Force.z + 2.0 * k2Force.z + 2.0 * k3Force.z + k4Force.z);
				}
			}
		}
	}
}