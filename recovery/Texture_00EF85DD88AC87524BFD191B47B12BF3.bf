using System;
using SDL2;
namespace bounty_game
{
	class Texture
	{

		//Private member variables of the texture
		private int32 mWidth;
		private int32 mHeight;

		private SDL.Texture* mTexture;
		public ~this()
		{
			free();
		}
		//Loading functions
		///Load a Texture from a specific path
		public Result<void> LoadFromFile(String path)
		{
			free();
			SDL.Texture* newTexture = null;

			SDL.Surface* loadedSurface = SDLImage.Load(path);
			if(loadedSurface == null)
				return .Err;
			newTexture = SDL.CreateTextureFromSurface(SDLManager.gGameRender,loadedSurface);
			if(newTexture == null)
				return .Err;

			mWidth = loadedSurface.w;
			mHeight = loadedSurface.h;

			SDL.FreeSurface(loadedSurface);
			this.mTexture = newTexture;
			return .Ok;
		}
		///Load a Texture from memory
		public Result<void> LoadFromMem(void* data, int32 size)
		{
			free();
			SDL2.SDL.Texture* newTexture = null;
			SDL.Surface* tempsurface = null;
			SDL.RWOps* temp = SDL.RWFromMem(data,size);
			tempsurface = SDLImage.Load_RW(temp,0);
			if(tempsurface == null)
				return .Err;
			newTexture = SDL.CreateTextureFromSurface(SDLManager.gGameRender,tempsurface);
			if(newTexture == null)
				return .Err;

			mWidth = tempsurface.w;
			mHeight = tempsurface.h;

			SDL2.SDL.FreeSurface(tempsurface);

			this.mTexture = newTexture;
			return .Ok;
		}
		public Result<void> LoadFromString(String text,SDL.Color color, SDLTTF.Font* font)
		{
			free();
			SDL.Surface* textSurface = SDLTTF.RenderText_Solid(font,text,color);
			if(textSurface == null)
				return .Err;
			mTexture = SDL.CreateTextureFromSurface(SDLManager.gGameRender,textSurface);
			if(mTexture == null)
				return .Err;

			mWidth = textSurface.w;
			mHeight = textSurface.h;
			SDL.FreeSurface(textSurface);

			return .Ok;

		}

		public int32 GetWidth
		{
			get
			{
				return mWidth;
			}
		}
		public int32 GetHeight
		{
			get
			{
				return mHeight;
			}
		}

		[Inline]
		public void SetColor(uint8 r, uint8 g, uint8 b)
		{
			SDL.SetTextureColorMod(mTexture,r,g,b);
		}
		[Inline]
		public void SetBlendMode( SDL.BlendMode blending )
		{
			SDL.SetTextureBlendMode(mTexture,blending);
		}
		[Inline]
		public void SetAlpha( uint8 alpha )
		{
			SDL.SetTextureAlphaMod(mTexture,alpha);
		}

		public void free()
		{
			if(mTexture != null)
			{
				SDL2.SDL.DestroyTexture(mTexture);
				mTexture = null;
				mWidth = 0;
				mHeight = 0;
			}
		}
		///Renders texture at given point
		public void Render( int32 x, int32 y, SDL.Rect* clip = null, double angle = 0.0, SDL.Point* center = null, SDL.RendererFlip flip = .None )
		{
			SDL.Rect renderQuad = SDL.Rect(x,y,mWidth,mHeight);
			if(clip != null)
			{
				renderQuad.w = clip.w;
				renderQuad.h = clip.h;
			}

			SDL.RenderCopyEx(SDLManager.gGameRender,mTexture,clip,&renderQuad,angle,center,flip);
		}

	}
}
