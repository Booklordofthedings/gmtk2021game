namespace bounty_game
{
	class Ball : Entity
	{
		public static vec2 pos;
		public static vec2 vel;
		Texture myTexture;

		public static Texture abil;
		public static Texture abil2;
		float multx;
		float multy;

		public static float timer = 0;
		public override void Update(float delta)
		{
			timer += delta/1000;
			

			vel.x += (PlayerBoxes.Apos.x - (pos.x+16))*(0.015f)*(delta/1000);
			vel.y += (PlayerBoxes.Apos.y - (pos.y-64))*(0.015f)*(delta/1000);

			vel.x -= 0.004f*vel.x * delta;
			vel.y -= 0.004f*vel.y * delta;

			int32 x = 0,y = 0;
			if(SDL2.SDL.GetMouseState(&x,&y) == SDL2.SDL.BUTTON_LMASK && timer > 2)
			{
				vel.x = (x -  Ball.pos.x);
 				vel.y = (y -Ball.pos.y);
				vel.normalize();
				vel.x = vel.x * 2;
				vel.y = vel.y * 2;
				timer = 0;
				myTexture.SetColor(0xFF,0xFF,0xFF);
			}

			pos.x += vel.x * (delta);
			pos.y += vel.y * (delta);

			pos.y = System.Math.Clamp(pos.y + (vel.y * delta),0,game_height - 64);
			pos.x = System.Math.Clamp(pos.x + (vel.x * delta),0,game_width - 64);
		}

		public override void Draw()
		{
			if(timer > 2)
				myTexture.SetColor(0x90,0x3f,0x39);
			myTexture.Render((.)pos.x,(.)pos.y);
		}

		public override void Destroy()
		{
			delete myTexture;
			delete abil;
			delete abil2;
			timer = 0;
		}

		public override void Init()
		{
			
			pos.x =500;
			pos.y = 500;
			vel.x = 0;
			vel.y = 0;
			abil = new Texture();
			abil.LoadFromFile("Assets/abil.png");
			abil2 = new Texture();
			abil2.LoadFromFile("Assets/abil2.png");
			myTexture = new Texture();
			myTexture.LoadFromFile("Assets/ball.png");
		}
	}
	class abil : Hud
	{
		public override void Draw(float delta)
		{
			/*
			Ball.abil.Render(231,5);
			if(Ball.timer > 2)
				Ball.abil2.Render(231,5);
			*/
		}
	}
}
