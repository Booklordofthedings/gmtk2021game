namespace bounty_game
{
	class EndScene : Scene
	{
		public override void Load()
		{
			base.Load();
			this.AddEntity(new Background());
			
			this.AddEntity(new foreground());

			this.AddEntity(new EndHud());
		}
	}

	class EndHud : Entity
	{
		
		public bool* gCurrentKeyStates;
		public bool[] gLastKeyStates;
		public static int wave;
		public static int killcount;
		public static float timer;
		public static float score;

		public System.String text = """
			Game ended
			press Enter to restart
			My Highscore: 10291
			""";
		Texture tt;
		Texture tw;
		SDL2.SDLMixer.Chunk *pdeath = null;
		public override void Update(float delta)
		{
			gCurrentKeyStates = Game.gCurrentScene.gCurrentKeyStates;
			gLastKeyStates = Game.gCurrentScene.gLastKeyStates;
			timer +=  delta/1000;
			if(gCurrentKeyStates[(int)SDL2.SDL.Scancode.Return] && gCurrentKeyStates[(int)SDL2.SDL.Scancode.Return]  != gLastKeyStates[(int)SDL2.SDL.Scancode.Return] && timer > 1)
			{
				Game.gCurrentScene = new MenuScene();
				Game.changedScene = true;
			}
		}

		public override void Draw()
		{
			tt.Render(game_width/2 - tt.GetWidth/2,game_height/2 - tt.GetHeight/2);
			tw.Render(game_width/2 - tw.GetWidth/2,game_height/2 - tw.GetHeight/2 -100);
		}

		public override void Destroy()
		{
		  
			delete tt;
			delete tw;
			SDL2.SDLMixer.FreeChunk(pdeath);
		}

		public override void Init()
		{
				pdeath = SDL2.SDLMixer.LoadWAV("Assets/pdeath.wav");
			SDL2.SDLMixer.PlayChannel(-1,pdeath,0);
			score = 5 * killcount + 100* wave + 2 * timer;
			tt = new Texture();
			tt.LoadFromString(scope System.String("Your Score: ")..Append(score.ToString(.. scope .())),
				SDL2.SDL.Color(0xFF,0xFf,0xFf,0xFF),SDLManager.LargeFont);
			tw = new Texture();
			tw.LoadFromStringWrapped(text,SDL2.SDL.Color(0xFF,0xFf,0xFf,0xFF),SDLManager.LargeFont,500);
			
		}
	}
}
