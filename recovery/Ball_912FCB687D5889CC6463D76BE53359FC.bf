namespace bounty_game
{
	class Ball : Entity
	{
		public static vec2 pos;
		public static vec2 vel;
		Texture myTexture;
		float multx;
		float multy;
		public override void Update(float delta)
		{
			
			
			vel.x += (PlayerBoxes.Apos.x - (pos.x+16))*(0.0078f)*(delta/1000);
			vel.y += (PlayerBoxes.Apos.y - (pos.y+16))*(0.0078f)*(delta/1000);

			vel.x -= 0.0009f*vel.x;
			vel.y -= 0.0009f*vel.y;

			pos.x += vel.x;
			pos.y += vel.y;

			pos.y = System.Math.Clamp(pos.y + (vel.y * delta),0,game_height - 64);
			pos.x = System.Math.Clamp(pos.x + (vel.x * delta),0,game_width - 64);
		}

		public override void Draw()
		{
			myTexture.Render((.)pos.x,(.)pos.y);
		}

		public override void Destroy()
		{
			delete myTexture;
		}

		public override void Init()
		{
			pos.x = 100;
			pos.y = 100;
			vel.x = 0;
			vel.y = 0;

			myTexture = new Texture();
			myTexture.LoadFromFile("Assets/ball.png");
		}
	}
}
