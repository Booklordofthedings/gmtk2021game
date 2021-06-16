namespace bounty_game
{
	class KillHud : Entity
	{
		public static int count;
		public static float timeLived;
		Texture slime;
		Texture tcount;
		Texture ttimeLived;
		public override void Update(float delta)
		{
			timeLived += delta/1000;
		}

		public override void Draw()
		{
			slime.Render(5+PlayerBoxes.hitoffsetx,50+PlayerBoxes.hitoffsety);
			tcount.LoadFromString(count.ToString(.. scope .() ),SDL2.SDL.Color(0xFF,0xFf,0xFf,0xFF),SDLManager.GetDefaultFont());
			tcount.Render(40+PlayerBoxes.hitoffsetx,66+PlayerBoxes.hitoffsety);
			ttimeLived.LoadFromString(timeLived.ToString(.. scope .() ),SDL2.SDL.Color(0xFF,0xFf,0xFf,0xFF),SDLManager.GetDefaultFont());
			ttimeLived.Render(10+PlayerBoxes.hitoffsetx,85+PlayerBoxes.hitoffsety);
		}

		public override void Destroy()
		{
			delete slime;
			delete tcount;
			delete ttimeLived;
		}

		public override void Init()
		{
			slime = new Texture();
			slime.LoadFromFile("Assets/slimedeath.png");
			tcount = new Texture();
			ttimeLived = new Texture();
			count = 0;
			timeLived = 0;
		}
	}
}
