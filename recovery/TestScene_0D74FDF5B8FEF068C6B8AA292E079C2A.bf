namespace bounty_game
{
	class TestScene : Scene
	{
		public override void Load()
		{
			base.Load();
			this.AddEntity(new Background());
			this.AddEntity(new PlayerBoxes());
			this.AddEntity(new Ball());
			this.AddEntity(new Enemier());
			
		}
		
	}
	class PlayerBoxes : Entity
	{
		public bool* gCurrentKeyStates;
		public bool[] gLastKeyStates;


		public Texture myTexture;

		public static vec2 Apos;

		vec2 movTest2;
		float max = 0.8f;
		float accel = 0.06f;
		float deveö = 0.01f;
		public static vec2 movTest = vec2();
		public static vec2 vel;


		float timer = 0;

		public override void Update(float delta)
		{
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
			


			
			

				Apos.y = System.Math.Clamp(Apos.y + (vel.y * delta),0,game_height - 32);
				Apos.x = System.Math.Clamp(Apos.x + (vel.x * delta),0,game_width - 32);
				

			

			if(gCurrentKeyStates[(int)SDL2.SDL.Scancode.F] && gCurrentKeyStates[(int)SDL2.SDL.Scancode.F] != gLastKeyStates[(int)SDL2.SDL.Scancode.F])
			{
				if(!Game.fullscreen)
				{
					SDL2.SDL.SetWindowFullscreen(SDLManager.gGameWindow,(.)SDL2.SDL.WindowFlags.Fullscreen);
					Game.fullscreen = true;
				}
				else
				{
					SDL2.SDL.SetWindowFullscreen(SDLManager.gGameWindow,0);
					Game.fullscreen = false;

				}
			}
				

		}

		public override void Draw()
		{
		
		   myTexture.Render((.)Apos.x,(.)Apos.y);
			
			SDL2.SDL.SetRenderDrawColor(SDLManager.gGameRender,255,255,255,255);
			SDL2.SDL.RenderDrawLine(SDLManager.gGameRender,(.)Apos.x +16,(.)Apos.y+16,(.)Ball.pos.x+32,(.)Ball.pos.y+32);
			SDL2.SDL.SetRenderDrawColor(SDLManager.gGameRender,0x55,0x45,0x65,0xFF);
		}

		public override void Destroy()
		{
			delete myTexture;
		}

		public override void Init()
		{
			Apos.y = 500;
			Apos.x = 500;
			
			movTest.x = 0;
			movTest.y = 0;

			vel.x = 0;
			vel.y = 0;

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
