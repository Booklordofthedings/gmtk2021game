namespace bounty_game
{
	abstract class Entity
	{
		public float x = 0;
		public float y = 0;
		public abstract void Update(float delta);
		public abstract void Draw();
		public abstract void Destroy();
		public abstract void Init();
	}
}
