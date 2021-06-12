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
			if(_surface == null)
				return .Err;

			if(SDL.RenderReadPixels(SDLManager.gGameRender,null,_surface.format.format,_surface.pixels,_surface.pitch) != 0)
			{
				SDL.FreeSurface(_surface);
				return .Err;
			}


			String path = scope String(SDL.GetBasePath());
			path.AppendF("Screenshots\\");

			if(!Directory.Exists(path))
				Directory.CreateDirectory(path);

			path.Append(DateTime.Now.Ticks.ToString(.. scope .() ));
			path.AppendF(".png");

			if(SDLImage.SavePNG(_surface,path) != 0)
			{
				SDL.FreeSurface(_surface);
				return .Err;
			}

			SDL.FreeSurface(_surface);

			return .Ok;
		}
	}
}
