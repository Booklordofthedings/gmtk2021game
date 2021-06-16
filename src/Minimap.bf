namespace bounty_game
{
	class Minimap : Hud
	{
		public override void Draw(float delta)
		{
			SDL2.SDL.SetRenderDrawColor(SDLManager.gGameRender,255,255,255,255);
			SDL2.SDL.Rect test = .(5+PlayerBoxes.hitoffsetx,600+PlayerBoxes.hitoffsety, 160,90);
			SDL2.SDL.RenderDrawRect(SDLManager.gGameRender,&test);
			SDL2.SDL.Rect pos = .((.)(160*PlayerBoxes.Apos.x/1280)+5-5+PlayerBoxes.hitoffsetx,(.)(90*PlayerBoxes.Apos.y/720)+600-5+PlayerBoxes.hitoffsety,10,10);
			SDL2.SDL.RenderDrawRect(SDLManager.gGameRender,&pos);

			for(int i < Enemier.slimes.Count)
			{
				
					SDL2.SDL.RenderDrawPoint(SDLManager.gGameRender,(.)(160*Enemier.slimes[i].pos.x/1280)+5+PlayerBoxes.hitoffsetx,(.)(90*Enemier.slimes[i].pos.y/720)+600+PlayerBoxes.hitoffsety);
			}
		}
	}
}
