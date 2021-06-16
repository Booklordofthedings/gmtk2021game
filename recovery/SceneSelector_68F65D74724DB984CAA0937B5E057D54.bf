using SDL2;
using System;
namespace bounty_game
{
	class SceneSelector : Hud
	{
		public bool* gCurrentKeyStates;
		public bool[] gLastKeyStates;
		public static SDL2.SDLMixer.Chunk *select = null;
		float timer = 0;
		SDL.Rect b1 = .(game_width/2 -150,game_height/2-25,300,50);
		SDL.Point[?] points = SDL.Point[](.(game_width/2,game_height/2 -75),.(game_width/2 -12,game_height/2 -50),.(game_width/2 +12,game_height/2 -50),.(game_width/2,game_height/2 -75));
		SDL.Point[?] points2 = SDL.Point[](.(game_width/2,game_height/2 +75),.(game_width/2 -12,game_height/2 +50),.(game_width/2 + 12,game_height/2 +50),.(game_width/2,game_height/2 +75));

		int cselect = 0;
		String[3] options = String[](
			"Arcade mode",
			"Guide Screen",
			"End game"
			);
		public bool isinit = false;
		public Texture[] textures = new Texture[4]();
		public override void Draw(float delta)
		{
			if(!isinit)
			{
				for(int i < options.Count)
				{
					textures[i] = new Texture();
					textures[i].LoadFromString(options[i],SDL.Color(0xFF,0xFf,0xFf,0xFF),SDLManager.LargeFont);
				}
				isinit = true;
				select = SDLMixer.LoadWAV("Assets/select.wav");
			}
					timer +=  delta/1000;
			gCurrentKeyStates = Game.gCurrentScene.gCurrentKeyStates;
			gLastKeyStates = Game.gCurrentScene.gLastKeyStates;
			if(gCurrentKeyStates[(int)SDL2.SDL.Scancode.W] && gCurrentKeyStates[(int)SDL2.SDL.Scancode.W]  != gLastKeyStates[(int)SDL.Scancode.W])
				cselect--;
			else if(gCurrentKeyStates[(int)SDL2.SDL.Scancode.S] && gCurrentKeyStates[(int)SDL2.SDL.Scancode.S]  != gLastKeyStates[(int)SDL.Scancode.S])
				cselect++;

			if(gCurrentKeyStates[(int)SDL2.SDL.Scancode.Return] && gCurrentKeyStates[(int)SDL2.SDL.Scancode.Return]  != gLastKeyStates[(int)SDL.Scancode.Return] && timer > 0.5)
			{
				switch(cselect)
				{
				case 0:
					SDLMixer.PlayChannel(-1,select,0);
					Game.gCurrentScene = new TestScene();
					Game.changedScene = true;
					break;

				case 1:
					SDLMixer.PlayChannel(-1,select,0);

					Game.gCurrentScene = new InfoScene();
					Game.changedScene = true;
					break;

				case 2:
					Game.quit = true;
					break;
				default:
				}
			
			}

			if(cselect > options.Count-1)
				cselect = options.Count-1;
			else if(cselect < 0)
				cselect = 0;

			SDL.SetRenderDrawColor(SDLManager.gGameRender,0x00,0xFF,0x00,0xFF);
			SDL.RenderDrawRect(SDLManager.gGameRender,&b1);
			SDL.RenderDrawLines(SDLManager.gGameRender,&points,4);
			SDL.RenderDrawLines(SDLManager.gGameRender,&points2,4);
			textures[cselect].Render(game_width/2 - textures[cselect].GetWidth/2,game_height/2 - textures[cselect].GetHeight/2);
			SDL2.SDL.SetRenderDrawColor(SDLManager.gGameRender,0x55,0x45,0x65,0xFF);
		}
		public ~this()
		{
			for(Texture i in textures)
				delete i;

			delete textures;
			SDLMixer.FreeChunk(select);
		}
	}
	
}
