namespace bounty_game
{
	class Background : Entity
	{
		Texture myTexture;
		public override void Update(float delta)
		{

		}

		public override void Draw()
		{
			myTexture.Render(0,0);
		}

		public override void Destroy()
		{
		   delete myTexture;
		}

		public override void Init()
		{
			myTexture = new Texture();
			myTexture.LoadFromFile("Assets/bg.png");
		}
	}
}
