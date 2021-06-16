using System.Collections;
namespace bounty_game
{
	class FastSlime : Entity
	{
		Texture myTexture;
			float speed = 400f;
			public static List<Slime> slimes;
			public static SDL2.SDLMixer.Chunk *death = null;
			float targetAngle = 0;
			public static int wave = 1;
			float timer = 0;
			
			public override void Update(float delta)
			{
				int alive = 0;
				timer += delta/1000;
				
				
				for(int i = 0; i < slimes.Count; i++)
				{
					
						alive++;
						vec2 move;
						//move towards player
						move.x = (PlayerBoxes.Apos.x - slimes[i].pos.x);
						move.y = (PlayerBoxes.Apos.y - slimes[i].pos.y);
						
							targetAngle = System.Math.Atan2(move.y,move.x);

							let pi=3.142f, tau=2*pi;
							let 
							  diffA = (targetAngle+tau - slimes[i]. moveAngle)%tau,
							  diffB = (targetAngle-tau - slimes[i].moveAngle)%tau;

							if(System.Math.Abs(diffA) < System.Math.Abs(diffB))
							  slimes[i].moveAngle += 0.004f*diffA;
							else
							  slimes[i].moveAngle += 0.004f*diffB;

							slimes[i].pos.x += System.Math.Cos(slimes[i].moveAngle)* speed *(delta/1000);
							slimes[i].pos.y += System.Math.Sin(slimes[i].moveAngle) * speed* (delta/1000);
						
						
						

						//calculate collision
						float x =  Ball.pos.x - slimes[i].pos.x;
						float y = Ball.pos.y - slimes[i].pos.y;
						float lenght = System.Math.Sqrt(x*x + y*y);
						if(lenght < 60)
						{
							slimes[i].isHurt = true;
							slimes[i].vel.x += (.)(-x * Ball.vel.x * 3);
							slimes[i].vel.y += (.)(-y * Ball.vel.y * 3);
						}

						
						//decrease velocity
						slimes[i].vel.x -= 0.9f*slimes[i].vel.x * (delta/1000);
						slimes[i].vel.y -= 0.9f*slimes[i].vel.y * (delta/1000);
						//move towards velocity
						slimes[i].pos.x += slimes[i].vel.x * (delta/1000);
						slimes[i].pos.y += slimes[i].vel.y * (delta/1000);
					

						if(slimes[i].pos.x > game_width -32)
						{
							SDL2.SDLMixer.PlayChannel(-1,death,0);
							slimes.RemoveAt(i);
							PlayerBoxes.hp += 90;
							KillHud.count += 3;
						}
						else if(slimes[i].pos.x < 0)
						{
							SDL2.SDLMixer.PlayChannel(-1,death,0);
							
							slimes.RemoveAt(i);
							PlayerBoxes.hp += 90;
							KillHud.count += 3;
						}
						else if(slimes[i].pos.y > game_height - 32)
						{
							SDL2.SDLMixer.PlayChannel(-1,death,0);
						  
							slimes.RemoveAt(i);
							PlayerBoxes.hp += 90;
							KillHud.count += 3;
						}
						else if(slimes[i].pos.y < 0)
						{
							SDL2.SDLMixer.PlayChannel(-1,death,0);
							
							slimes.RemoveAt(i);
							PlayerBoxes.hp += 90;
							KillHud.count += 3;
						
					}
					
					
				}
				
				
			}

			public override void Draw()
			{
				for(int i = 0; i < slimes.Count; i++)
				{
					
						if(slimes[i].isHurt)
						{
							myTexture.SetColor(255,0,0);
							slimes[i].isHurt = false;
						}
						else
						{
							myTexture.SetColor(255,255,255);
						}
						myTexture.Render((.)slimes[i].pos.x,(.)slimes[i].pos.y);
					
				}
			

			}

			public override void Destroy()
			{
				delete myTexture;
				delete slimes;
				wave = 1;
				SDL2.SDLMixer.FreeChunk(death);
			}

			public override void Init()
			{
				death = SDL2.SDLMixer.LoadWAV("Assets/deathfast.wav");
				myTexture = new Texture();
				myTexture.LoadFromFile("Assets/slimef.png");

				slimes = new List<Slime>(50);
					

				
			}
			public static void GenerateSlimes(int wave)
			{
				if(System.gRand.Next(-1,0) < 0 && wave >= 10)
				{
					int amount = System.gRand.Next(0,(.)(0.5*wave));
					if(amount > 0)
					{
						for(int i = amount;i > 0;--i)
						{
							int ran = System.gRand.Next(0,3);
							if(ran == 0)
							{
								Slime a = Slime();
								a.pos.x  = System.gRand.Next(0,game_width);
								a.pos.y = System.gRand.Next(0,150);	
								slimes.Add(a);
							}
							if(ran == 1)
							{
								Slime a = Slime();
								a.pos.x  = System.gRand.Next(0,game_width);
								a.pos.y = System.gRand.Next(game_height-150,game_height);	
								slimes.Add(a);
							}
							if(ran == 2)
							{
								Slime a = Slime();
								a.pos.x  = System.gRand.Next(0,150);
								a.pos.y = System.gRand.Next(0,game_height);	
								slimes.Add(a);
							}
							if(ran == 3)
							{
								Slime a = Slime();
								a.pos.x  = System.gRand.Next(game_width-150,game_width);
								a.pos.y = System.gRand.Next(0,game_height);	
								slimes.Add(a);
							}
							amount--;
						}
				}
				
				}

			}
	}
}

