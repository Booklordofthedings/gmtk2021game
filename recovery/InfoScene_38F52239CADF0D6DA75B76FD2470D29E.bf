namespace bounty_game
{
	class InfoScene : Scene
	{
		public override void Load()
		{
			base.Load();
			this.AddEntity(new Background());
			this.AddEntity(new foreground());
			this.AddEntity(new Item());
		}
	}
	class Item : Entity
	{
		public bool* gCurrentKeyStates;
		public bool[] gLastKeyStates;
		public System.String Text = """
			Guide:
			WASD: Move
			M1: Launch flail
			Throw the slimes back into the forest to kill them.
			Killing slimes will grant hp, hp will slowly deplete over time
			Mushrooms will spawn that grant usefull effects.
			If your hp is 0 you have lost.
			

			How long can you survive ?

			Enter to exit this page
			""";
		Texture myTexture;
		float timer = 0;
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
			myTexture.Render(game_width/2 - myTexture.GetWidth/2,game_height/2 - myTexture.GetHeight/2);
			
		}

		public override void Destroy()
		{
			delete myTexture;
		}

		public override void Init()
		{
			myTexture = new Texture();
			myTexture.LoadFromStringWrapped(Text,SDL2.SDL.Color(0xFF,0xFf,0xFf,0xFF),SDLManager.LargeFont,500);
		}
	}
}
