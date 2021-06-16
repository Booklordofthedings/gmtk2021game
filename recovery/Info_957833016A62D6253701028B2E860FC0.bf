namespace bounty_game
{
	class Info : Entity
	{
		Texture jam = new Texture();
		Texture logo = new Texture();
		Texture tex = new Texture();
		System.String text = """
			- Slime Slammer -

			Submission to the gmtk 2021 gamejam

			Made by: Booklordofthedings
			@Booklordofthed1

			Programming language: Beeflang
			Engine: none (selfmade + sdl2)
			Fonts:
			Old Newspaper type
			Sono by Tyler Fink

			Special thanks:
			ppl from the Beef discord for tech support
			""";
		public override void Update(float delta)
		{
			
		}

		public override void Draw()
		{
			jam.Render(0,500);
			logo.Render(game_width/2 - logo.GetWidth/2 ,0);
			tex.Render(game_width-tex.GetWidth -5,game_height-tex.GetHeight-5);
		}

		public override void Destroy()
		{
			delete tex;
			delete jam;
			delete logo;
		}

		public override void Init()
		{
			jam.LoadFromFile("Assets/jam.png");
			logo.LoadFromFile("Assets/logo.png");
			tex.LoadFromStringWrapped(text,SDL2.SDL.Color(0xFF,0xFf,0xFf,0xFF),SDLManager.GetDefaultFont(),200);
		}
	}
}
