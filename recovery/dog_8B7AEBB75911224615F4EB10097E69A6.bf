using System.Collections;
namespace bounty_game
{
	class dog : Entity
	{
		Texture myTexture;
		Texture myTexture2;
		Texture myTexture3;
		Texture speedtxt;
		Texture sad;
		vec2 mov;
		vec2 goal;
		
		float timer = 30;
		bool speedac = false;
		bool death = false;
		public shrooms cshrooms;
		public override void Update(float delta)
		{
			timer += delta/1000;
			if(timer > 20)
			{
				timer -= 20 - System.gRand.Next(0,2);
				shrooms next = shrooms();
				next.x = System.gRand.Next(150,1100);
				next.y = System.gRand.Next(150,600);
				next.type = System.gRand.Next(0,3);
				cshrooms = next;
			}

			cshrooms.lifetime = cshrooms.lifetime - delta/1000;
			if(cshrooms.lifetime < 0)
			{
				cshrooms.active = false;
				PlayerBoxes.max = 0.6f;
				speedac = false;
				death = false;
			}
				

			float px = PlayerBoxes.Apos.x - cshrooms.x;
			float py = PlayerBoxes.Apos.y - cshrooms.y;

			if(px*px+py*py < 450 && cshrooms.active)
			{
				switch(cshrooms.type)
				{
				case 0:
					PlayerBoxes.hp += 100;
				break;
				case 1:
					PlayerBoxes.max = 0.7f;
					speedac = true;
				break;
				case 2:
					death = true;
					for(int i < Enemier.slimes.Count)
					{
						float sx = Enemier.slimes[i].pos.x - cshrooms.x;
						float sy = Enemier.slimes[i].pos.y - cshrooms.y;

						if(System.Math.Sqrt(sx*sx + sy * sy) < 150)
						{
							SDL2.SDLMixer.PlayChannel(-1,Enemier.death,0);
							Enemier.slimes.RemoveAt(i);
							KillHud.count++;
						}

						
					}
					
				break;
				default:
				break;
				}
				cshrooms.active = false;
			}

		}

		public override void Draw()
		{
			myTexture.SetAlpha((.)(255*(cshrooms.lifetime/10)));
			myTexture2.SetAlpha((.)(255*(cshrooms.lifetime/10)));
			myTexture3.SetAlpha((.)(255*(cshrooms.lifetime/1)));
			speedtxt.SetAlpha((.)(255*(cshrooms.lifetime/10)));
			sad.SetAlpha((.)(255*(cshrooms.lifetime/10)));

			if(cshrooms.active)
			{
				if(cshrooms.type == 0)
					myTexture.Render((.)cshrooms.x,(.)cshrooms.y);
				else if(cshrooms.type == 1)
					myTexture2.Render((.)cshrooms.x,(.)cshrooms.y);
				else if(cshrooms.type == 2)
					myTexture3.Render((.)cshrooms.x,(.)cshrooms.y);
			}
			if(speedac)
			{
				speedtxt.Render((.)PlayerBoxes.Apos.x-16,(.)PlayerBoxes.Apos.y-16);
			}
			else if(death)
			{
				sad.Render((.)cshrooms.x-150,(.)cshrooms.y-150);
			}
				
		}

		public override void Destroy()
		{
			delete myTexture;
			delete myTexture2;
			delete myTexture3;
			delete speedtxt;
			delete sad;
		}

		public override void Init()
		{
			myTexture = new Texture();
			myTexture.LoadFromFile("Assets/dog.png");
			myTexture2 = new Texture();
			myTexture2.LoadFromFile("Assets/dog2.png");
			myTexture3 = new Texture();
			myTexture3.LoadFromFile("Assets/dog3.png");
			speedtxt = new Texture();
			speedtxt.LoadFromFile("Assets/speed.png");
			sad = new Texture();
			sad.LoadFromFile("Assets/sad.png");
		}
	}
	public struct shrooms
	{
		public bool active = true;
		public float lifetime = 10;
		public int type;
		/*
		0 = hp
		1 = speed
		2 = destruction
		3 = shield
		*/
		public float x;
		public float y;
	}
}
