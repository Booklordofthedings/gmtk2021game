using System;
using System.IO;
using SDL2;
namespace bounty_game
{
	class DebugRenderTexture
	{
		///Create a screenshot
		public static Result<void> Screenshot()
		{
		    SDL.Rect viewport;
			SDL.Surface* _surface;

			SDL.RenderGetViewport(SDLManager.gGameRender,out viewport);
			_surface = SDL.CreateRGBSurface(0,viewport.w,viewport.h,32,0,0,0,0);
			

			SDL.RenderReadPixels(SDLManager.gGameRender,null,_surface.format.format,_surface.pixels,_surface.pitch);


			String path = scope String(SDL.GetBasePath());
			path.AppendF("Screenshots\\");

			
			Directory.CreateDirectory(path);
			path.Append(DateTime.Now.Ticks.ToString(.. scope .() ));
			path.AppendF(".png");

			SDLImage.SavePNG(_surface,path);
			

			SDL.FreeSurface(_surface);

			return .Ok;
		}
	}
}
