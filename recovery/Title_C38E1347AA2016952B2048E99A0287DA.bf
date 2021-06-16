namespace bounty_game
{
	class Title : Hud
	{
		public static System.String title;
		static Texture cText = new Texture() ~ delete(_);
		static float ypos = 100;
		public override void Draw(float delta)
		{
				

			cText.LoadFromString(title,SDL2.SDL.Color(0xFF,0xFF,0xFF,0xFF),SDLManager.LargeFont);
			cText.Render(game_width/2 - cText.GetWidth/2,(.) ypos);
			ypos -= 0.1f*delta;
		}
		public static void WaveShowcase(int wave)
		{
			ypos = 100;
			delete title;
			title = new System.String("Wave: ");
			title.Append(wave.ToString(.. scope .()));
			cText.LoadFromString(title,SDL2.SDL.Color(0xFF,0xFF,0xFF,0xFF),SDLManager.LargeFont);
		}
		public this()
		{
			title = new System.String("Wave: 1");
		}
	}
}
