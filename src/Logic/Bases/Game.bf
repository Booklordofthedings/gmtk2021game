using System;
using System.Collections;
using SDL2;
namespace bounty_game
{
	class Game
	{
		public static Scene gCurrentScene;
		
		public static bool quit = false;
		private static double Framtime;
		private static float measurement = 1;
		private static float smoothing = 0.9f;

		public static bool changedScene = false;
		public static bool fullscreen = false;

		public static void Init(String GameTitle,int32 width,int32 height)
		{
			if(SDLManager.Init(GameTitle,width,height) == .Err)
				Runtime.FatalError("Couldnt initialize the game");
			SDLManager.LoadStandartMedia();
		
		}
		public static void Close()
		{
			SDLManager.Close();
		}
		public static void Run()
		{
			
			gCurrentScene =  new InitScene();
			double beforeTime = (double)SDL.GetPerformanceCounter() / SDL.GetPerformanceFrequency();
			while(!quit)
			{
				while(SDL.PollEvent(out SDLManager.gGameEvents) != 0)
				{
					if(SDLManager.gGameEvents.type == .Quit)
						quit = true;
				}
				SDL.RenderClear(SDLManager.gGameRender);

				
					if(Scene.doDebug && Scene.doDraw)
					{
						SDL.SetRenderDrawColor(SDLManager.gGameRender,0xFF,0xFF,0xFF,0xFF);
						SDL.Rect* Test = scope SDL.Rect(0,35,(.)(Framtime*100000),20); 
						SDL.RenderFillRect(SDLManager.gGameRender,Test);
						SDL.SetRenderDrawColor(SDLManager.gGameRender,0x55,0x45,0x65,0xFF);
					}
					
				
				
				Framtime =(double)SDL.GetPerformanceCounter() / SDL.GetPerformanceFrequency();
				
				double currentTime = (double)SDL.GetPerformanceCounter() / SDL.GetPerformanceFrequency();
				float deltaTime = (.)(currentTime - beforeTime)*1000;
				beforeTime = currentTime;

				
			
				
				SDL.SetRenderDrawColor(SDLManager.gGameRender,0x55,0x45,0x65,0xFF);
				

				gCurrentScene.Update(deltaTime);
				


				SDL.RenderPresent(SDLManager.gGameRender);
				Framtime =(double)SDL.GetPerformanceCounter() / SDL.GetPerformanceFrequency() - Framtime;


				
			}
			delete gCurrentScene;
		}

	}
}
