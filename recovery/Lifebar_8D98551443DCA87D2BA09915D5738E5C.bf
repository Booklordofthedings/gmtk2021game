namespace bounty_game
{
	class Lifebar : Hud
	{
		public static float hight= 30;
		public override void Draw(float delta)
		{
			
			SDL2.SDL.SetRenderDrawColor(SDLManager.gGameRender,0x90,0x3f,0x39,255);
			SDL2.SDL.Rect test = .(5+PlayerBoxes.hitoffsetx,5+PlayerBoxes.hitoffsety, (.)(200*PlayerBoxes.hp/PlayerBoxes.maxhp),30);
			SDL2.SDL.RenderFillRect(SDLManager.gGameRender,&test);
			SDL2.SDL.SetRenderDrawColor(SDLManager.gGameRender,0xFF,0xFF,0xFF,0xFF);
			SDL2.SDL.Rect test2 = .(4+PlayerBoxes.hitoffsetx,4+PlayerBoxes.hitoffsety, 201,31);
			SDL2.SDL.RenderDrawRect(SDLManager.gGameRender,&test2);
		}
	}
}
