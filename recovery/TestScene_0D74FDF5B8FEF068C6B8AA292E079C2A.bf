namespace bounty_game
{
	class TestScene : Scene
	{
		public override void Load()
		{
			base.Load();
			this.SceneHuds.Add(new Minimap());
			this.SceneHuds.Add(new Lifebar());
			this.SceneHuds.Add(new Title());
			this.AddEntity(new Background());
			this.AddEntity(new PlayerBoxes());
			this.AddEntity(new Ball());
			this.AddEntity(new Enemier());
			this.AddEntity(new HeavySlime());
			this.AddEntity(new FastSlime());
			this.AddEntity(new MagiSlime());
			this.AddEntity(new dog());
			this.AddEntity(new foreground());
			this.AddEntity(new KillHud());
			Lifebar.hight = 30;
		}
		
	}
	class PlayerBoxes : Entity
	{
		public static int32 hitoffsetx;
		public static int32 hitoffsety;

		public bool* gCurrentKeyStates;
		public bool[] gLastKeyStates;
		
		bool ishit;
		public Texture myTexture;

		public static vec2 Apos;

		vec2 movTest2;
		public static float max = 0.6f;
		float accel = 0.06f;
		float deveö = 0.01f;
		public static vec2 movTest = vec2();
		public static vec2 vel;
		public SDL2.SDLMixer.Music *music;

		float timer = 0;

		public static float hp;
		public const float maxhp = 10000;

		public override void Update(float delta)
		{
			
			if(hitoffsetx < 0)
				hitoffsetx++;
			else if(hitoffsetx > 0)
				hitoffsetx--;

			if(hitoffsety < 0)
				hitoffsety++;
			else if(hitoffsety > 0)
				hitoffsety--;

			gCurrentKeyStates = Game.gCurrentScene.gCurrentKeyStates;
			gLastKeyStates = Game.gCurrentScene.gLastKeyStates;

			movTest = vec2();
			if(gCurrentKeyStates[(int)SDL2.SDL.Scancode.W])
				movTest.y = -1;
			else if(gCurrentKeyStates[(int)SDL2.SDL.Scancode.S])
				movTest.y = 1;

			if(gCurrentKeyStates[(int)SDL2.SDL.Scancode.A])
				movTest.x = -1;
			else if(gCurrentKeyStates[(int)SDL2.SDL.Scancode.D])
				movTest.x = 1;
			movTest.normalize();
			
		


			if(movTest.x != 0)
			{
				vel.x = vel.x + accel * delta * movTest.x;
			}
			else
			{
				if(vel.x < 0)
				{
					vel.x = vel.x + deveö * delta;
					if(vel.x > 0)
						vel.x = 0;
				}
				else
				{
					vel.x = vel.x - deveö * delta;
					if(vel.x < 0)
						vel.x = 0;
				}
			}
			if(movTest.y != 0)
			{
				vel.y = vel.y + accel * delta * movTest.y;

			}
			else
			{
				if(vel.y < 0)
				{
					vel.y = vel.y + deveö * delta;
					if(vel.y > 0)
						vel.y = 0;
				}
				else
				{
					vel.y = vel.y - deveö * delta;
					if(vel.y < 0)
						vel.y = 0;
				}
			}
			if(vel.x !=0 && vel.y != 0)
			{
				if(System.Math.Sqrt(vel.x*vel.x + vel.y * vel.y) > max)
				{
					vel.normalize();
					vel.x = vel.x * max;
					vel.y = vel.y * max;
				}
				if(System.Math.Sqrt(vel.x*vel.x + vel.y * vel.y) < -max)
				{
					vel.normalize();
					vel.x = vel.x * -max;
					vel.y = vel.y * -max;

				}
			}
			else
			{
				if(vel.x > max)
					vel.x = max;
				else if(vel.x < -max)
					vel.x = -max;
				if(vel.y > max)
					vel.y = max;
				else if(vel.y < -max)
					vel.y = -max;
			}
			


			
			

				Apos.y = System.Math.Clamp(Apos.y + (vel.y * delta),55,680 - 32);
				Apos.x = System.Math.Clamp(Apos.x + (vel.x * delta),60,1230 - 32);
				
			for(int i = 0; i < Enemier.slimes.Count; i++)
			{
				
					float x =  Apos.x - Enemier.slimes[i].pos.x;
					float y = Apos.y - Enemier.slimes[i].pos.y;
					float lenght = System.Math.Sqrt(x*x + y*y);
					if(lenght < 20)
					{
						hp -= 3 * delta;
						ishit = true;
						hitoffsety += System.gRand.Next(-3,3);
						hitoffsetx += System.gRand.Next(-3,3);
					}
			}
			if(hp > maxhp)
				hp -= delta * 1f;
			else
				hp -= delta * 0.1f;
			if(hp < 0)
			{
				
				EndHud.timer = KillHud.timeLived;
				EndHud.wave = Enemier.wave;
				EndHud.killcount = KillHud.count;
				Game.gCurrentScene = new EndScene();
				Game.changedScene = true;
			}
			for(int i = 0; i < HeavySlime.slimes.Count; i++)
			{
				
					float x =  Apos.x - HeavySlime.slimes[i].pos.x;
					float y = Apos.y - HeavySlime.slimes[i].pos.y;
					float lenght = System.Math.Sqrt(x*x + y*y);
					if(lenght < 20)
					{
						hp -= 5 * delta;
						ishit = true;
						hitoffsety += System.gRand.Next(-3,3);
						hitoffsetx += System.gRand.Next(-3,3);
					}
			}
			
			if(hp < 0)
			{
				
				EndHud.timer = KillHud.timeLived;
				EndHud.wave = Enemier.wave;
				EndHud.killcount = KillHud.count;
				Game.gCurrentScene = new EndScene();
				Game.changedScene = true;
			}
			for(int i = 0; i < FastSlime.slimes.Count; i++)
			{
				
					float x =  Apos.x - FastSlime.slimes[i].pos.x;
					float y = Apos.y - FastSlime.slimes[i].pos.y;
					float lenght = System.Math.Sqrt(x*x + y*y);
					if(lenght < 20)
					{
						hp -= 5 * delta;
						ishit = true;
						hitoffsety += System.gRand.Next(-3,3);
						hitoffsetx += System.gRand.Next(-3,3);
					}
			}
			
			if(hp < 0)
			{
				
				EndHud.timer = KillHud.timeLived;
				EndHud.wave = Enemier.wave;
				EndHud.killcount = KillHud.count;
				Game.gCurrentScene = new EndScene();
				Game.changedScene = true;
			}
			for(int i = 0; i < MagiSlime.slimes.Count; i++)
			{
				
					float x =  Apos.x - MagiSlime.slimes[i].pos.x;
					float y = Apos.y - MagiSlime.slimes[i].pos.y;
					float lenght = System.Math.Sqrt(x*x + y*y);
					if(lenght < 20)
					{
						hp -= 10 * delta;
						ishit = true;
						hitoffsety += System.gRand.Next(-3,3);
						hitoffsetx += System.gRand.Next(-3,3);
					}
			}
			
			if(hp < 0)
			{
				
				EndHud.timer = KillHud.timeLived;
				EndHud.wave = Enemier.wave;
				EndHud.killcount = KillHud.count;
				Game.gCurrentScene = new EndScene();
				Game.changedScene = true;
			}

				

			
				

		}

		public override void Draw()
		{
			myTexture.SetColor(0xFF,0xFF,0xFF);
			if(ishit)
			{
				myTexture.SetColor(0x90,0x3f,0x39);
				ishit = false;
			}
		   myTexture.Render((.)Apos.x,(.)Apos.y);
			
			SDL2.SDL.SetRenderDrawColor(SDLManager.gGameRender,255,255,255,255);
			SDL2.SDL.RenderDrawLine(SDLManager.gGameRender,(.)Apos.x +16,(.)Apos.y+16,(.)Ball.pos.x+32,(.)Ball.pos.y+32);
			SDL2.SDL.SetRenderDrawColor(SDLManager.gGameRender,0x55,0x45,0x65,0xFF);

		}

		public override void Destroy()
		{
			delete myTexture;
			delete Title.title;
			SDL2.SDLMixer.FreeMusic(music);
			
		}

		public override void Init()
		{
			music = SDL2.SDLMixer.LoadMUS("Assets/brawl.wav");
			SDL2.SDLMixer.PlayMusic(music,-1);

			ishit = false;
			hp = maxhp;
			Apos.y = 500;
			Apos.x = 500;
			
			movTest.x = 0;
			movTest.y = 0;

			vel.x = 0;
			vel.y = 0;
			hitoffsetx = 0;
			hitoffsety = 0;
			myTexture = new Texture();
			myTexture.LoadFromFile("Assets/box.png");

			
		}
		public void SetKeyCode(bool* cState)
		{
			gCurrentKeyStates = cState;
		}
	}

	
		struct vec2
		{
			public float x = 0,y = 0;
			[System.InlineAttribute]
			public void normalize() mut
			{
				float lenght = System.Math.Sqrt(x*x + y*y);
				if(lenght == 0)
				{
					return;
				}
				this.x = x / lenght;
				this.y = y / lenght;
			}
			
			public bool isNull()
			{
				if(x == 0 && y == 0)
					return false;
				return true;
			}
		}
}
