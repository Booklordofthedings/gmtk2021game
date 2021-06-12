using System.Collections;
namespace bounty_game
{
	class Enemier : Entity
	{
		Texture myTexture;
		public static vec2 pos;
		float speed = 60f;
		bool ishurt = false;
		List<Slime> slimes;
		vec2 vel;
		public override void Update(float delta)
		{
			for(Slime i in slimes)
			{
				i.pos.x = 500;


				vec2 move;
				move.x = (PlayerBoxes.Apos.x - i.pos.x);
				move.y = (PlayerBoxes.Apos.y - i.pos.y);
				move.normalize();
				i.pos.x = i.pos.x +  move.x * speed *(delta/1000);
				i.pos.y = i.pos.y +  move.y * speed* (delta/1000);

				float x =  Ball.pos.x - i.pos.x;
				float y = Ball.pos.y - i.pos.y;
				float lenght = System.Math.Sqrt(x*x + y*y);
				if(lenght < 50)
				{
					ishurt = true;
					i.vel.x += -x * Ball.vel.x * 2;
					i.vel.y += -y * Ball.vel.y * 2;
				}

				i.pos.x = i.pos.x + 1 *(delta/1000);

				i.vel.x -= 0.9f*i.vel.x * (delta/1000);
				i.vel.y -= 0.9f*i.vel.y * (delta/1000);

				i.pos.x += i.vel.x * (delta/1000);
				i.pos.y += i.vel.y * (delta/1000);


				if(i.pos.x > game_width -32)
				{
					i.pos.x = game_width - 32;
					i.vel.x = 0;
				}
				else if(i.pos.x < 0)
				{
					i.pos.x = 1;
					i.vel.x = 0;
				}
				if(i.pos.y > game_height - 32)
				{
				   i.pos.y = game_height - 33;
					i.vel.y = 0;
				}
				else if(i.pos.y < 0)
				{
					i.pos.y = 1;
					i.vel.y = 0;

				}

			}
			
			
		}

		public override void Draw()
		{
			for(Slime i in slimes)
			{
				if(i.isHurt)
				{
					myTexture.SetColor(255,0,0);
					i.isHurt = false;
				}
				else
				{
					myTexture.SetColor(255,255,255);
				}
				myTexture.Render((.)i.pos.x,(.)i.pos.y);
			}
		

		}

		public override void Destroy()
		{
			delete myTexture;
			delete slimes;
		}

		public override void Init()
		{
			myTexture = new Texture();
			myTexture.LoadFromFile("Assets/slime.png");

			slimes = new List<Slime>();
			for(int i < 100)
			{
				Slime a = Slime();
				a.pos.x  = System.gRand.Next(0,game_width);
				a.pos.y = System.gRand.Next(0,game_height);
				a.vel.x = 0;
				a.vel.y = 0;
				slimes.Add(a);
			}
			

			
		}
	}
	struct Slime
	{
		public vec2 vel = vec2();
		public bool isActive = true;
		public vec2 pos = vec2();
		public bool isHurt = false;

	}
}
