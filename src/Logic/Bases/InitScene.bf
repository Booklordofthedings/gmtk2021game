namespace bounty_game
{
	class InitScene : Scene
	{
		public override void Load()
		{
			base.Load();
			AddEntity(new Book());
			AddEntity(new Image());
		}
	}
	class Image : Entity
	{
		float timer = 0;
		bool doDraw = true;
		public override void Update(float delta)
		{
			
			timer = timer + 1*delta;

			if(timer > 1*1000)
			{
				doDraw = false;
				if(timer > 2.5*1000)
				{
					Game.gCurrentScene = new MenuScene();
					Game.changedScene = true;
				}
				
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
			if(doDraw)
				SDLManager.GetBeefTitle().Render((.)x,(.)y);
		}
	}

}
