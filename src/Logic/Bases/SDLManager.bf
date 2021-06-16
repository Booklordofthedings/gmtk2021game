using System;
using System.Collections;
using SDL2;
namespace bounty_game
{
	class SDLManager
	{
		//global variables
		public static SDL.Window* gGameWindow;
		public static SDL.Renderer* gGameRender;
		public static SDL.Event gGameEvents;

		//Global static variables
		private static Texture BeefTitle;
		private static Texture BookTitle;
		private static SDLTTF.Font *DefaultFont;
		public static SDLTTF.Font *LargeFont;
		public static Texture GetBeefTitle()
		{
			return BeefTitle;
		}
		public static Texture GetBookTitle()
		{
			return BookTitle;
		}
		public static SDLTTF.Font* GetDefaultFont()
		{
			return DefaultFont;
		}

		///Initialize SDL2
		public static Result<void> Init(String gGameTitle,int32 gGameWidth, int32 gGameHeight)
		{
			if(SDL.Init(.Everything) < 0)
				return .Err;
			gGameWindow = SDL.CreateWindow(gGameTitle,.Centered,.Centered,gGameWidth,gGameHeight,.Shown);
			if(gGameWindow == null)
				return .Err;
			gGameRender = SDL.CreateRenderer(gGameWindow,-1, .Accelerated);
			if(gGameRender == null)
				return .Err;
			SDL.SetRenderDrawColor(gGameRender,0x55,0x45,0x65,0xFF);
			SDLImage.InitFlags ImgFlags = SDLImage.InitFlags.PNG;
			if((int)((SDLImage.InitFlags)SDLImage.Init(ImgFlags) & ImgFlags) != 2)
				return .Err;
			if(SDLTTF.Init() < 0)
				return .Err;
			if(SDLMixer.OpenAudio(44100,SDLMixer.MIX_DEFAULT_FORMAT,2,2048) < 0)
				return .Err;
			return .Ok;
		}

		public static void LoadStandartMedia()
		{
			BeefTitle = new Texture();
			BeefTitle.LoadFromMem(&BeefIncludes.beef_title,BeefIncludes.beef_title.Count*8);
			BookTitle = new Texture();
			BookTitle.LoadFromMem(&BeefIncludes.bookhead,BeefIncludes.bookhead.Count*8);
			SDL.RWOps* temp = SDL.RWFromMem(&BeefIncludes.sono_regular,BeefIncludes.sono_regular.Count*8);
			DefaultFont = SDLTTF.OpenFontRW(temp,1,12);
			LargeFont = SDLTTF.OpenFontRW(temp,1,30);

		}

		///Close everything SDL2
		public static void Close()
		{
			BeefTitle.free();
			BookTitle.free();
			delete(BeefTitle);
			delete(BookTitle);
			SDLTTF.CloseFont(DefaultFont);
			SDL.DestroyWindow(gGameWindow);
			SDL.DestroyRenderer(gGameRender);
			SDL.Quit();
			SDLImage.Quit();
			SDLTTF.Quit();
			SDLMixer.Quit();
		}

	}
}
