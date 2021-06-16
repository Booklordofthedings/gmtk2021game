namespace bounty_game
{
	class MenuScene : Scene
	{
		public override void Load()
		{
			base.Load();
			this.AddEntity(new foreground());
			this.AddEntity(new Info());
			this.SceneHuds.Add(new SceneSelector());
			
			
		}
		public override void Delete()
		{
			base.Delete();
		}
	}
}
