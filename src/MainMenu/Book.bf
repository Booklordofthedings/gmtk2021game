namespace bounty_game
{
	class Book : Entity
	{
		
		public override void Update(float delta)
		{

		}

		public override void Draw()
		{
			
			SDLManager.GetBookTitle().Render( game_width/2 - SDLManager.GetBookTitle().GetWidth/2, game_height/2 - SDLManager.GetBookTitle().GetHeight/2);
		}

		public override void Destroy()
		{

		}

		public override void Init()
		{

		}
	}
}
