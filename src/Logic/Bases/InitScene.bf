namespace bounty_game
{
	class InitScene : Scene
	{
		public override void Load()
		{
			base.Load();
			AddEntity(new Image());
		}
	}
	class Image : Entity
	{
		float timer = 0;
		public override void Update(float delta)
		{
			
			timer = timer + 1*delta;

			if(timer > 1.5*1000)
			{
				Game.gCurrentScene = new TestScene();
				Game.changedScene = true;
			}
		}

		public override void Destroy()
		{

		}

		public override void Init()
		{
			this.x = game_width/2 - SDLManager.GetBeefTitle().GetWidth/2;
			this.y = game_height/2 - SDLManager.GetBeefTitle().GetHeight/2;
		}
		public override void Draw()
		{
			SDLManager.GetBeefTitle().Render((.)x,(.)y);
		}
	}

}
