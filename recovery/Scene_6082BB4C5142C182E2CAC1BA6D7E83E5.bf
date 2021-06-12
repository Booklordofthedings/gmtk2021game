using System;
using System.Collections;
using SDL2;
namespace bounty_game
{
	class Scene
	{
		public List<Entity> SceneEntities;
		public List<Hud> SceneHuds;
		public List<Hud> DebugHud;

		public static bool doDraw = true;	//
		public static bool doDebug =  false;	//
		private bool doHud = true;	//
		private bool runGame = true;	//
		//Take screenshot					|
		//Reload Scene	//
		private bool showConsole = false;
		public bool* gCurrentKeyStates;
		public bool[] gLastKeyStates;
		int32 len;

		/*
			Debug key commands:
		alt + 1 = take screenshot
		alt + 2 = toggle debug menu
		alt + 3 = toggle hud
		alt + 4 = toggle rendering
		alt + 5 = toggle pause
		alt + 6 = reset scene

		// Unimplemented
		alt + 7 = (show console)
		alt + 8 = (show debug menu)
		*/


		private static float deltaT = 0;
		private static float measurement = 1;
		private static float smoothing = 0.9f;
		
		protected this()
		{
			Load();
		}
		public ~this()
		{
			Delete();
		}
		public virtual void Update(float delta)
		{
			deltaT = delta;
			gCurrentKeyStates = SDL2.SDL.GetKeyboardState(&len);
			
			if(gCurrentKeyStates[(int)SDL2.SDL.Scancode.Key2] && gLastKeyStates[(int)SDL2.SDL.Scancode.Key2] != gCurrentKeyStates[(int)SDL2.SDL.Scancode.Key2] && gCurrentKeyStates[(int)SDL2.SDL.Scancode.RAlt])
				Scene.doDebug = !doDebug;
			if(gCurrentKeyStates[(int)SDL2.SDL.Scancode.Key3] && gLastKeyStates[(int)SDL2.SDL.Scancode.Key3] != gCurrentKeyStates[(int)SDL2.SDL.Scancode.Key3] && gCurrentKeyStates[(int)SDL2.SDL.Scancode.RAlt])
				doHud = !doHud;
			if(gCurrentKeyStates[(int)SDL2.SDL.Scancode.Key4] && gLastKeyStates[(int)SDL2.SDL.Scancode.Key4] != gCurrentKeyStates[(int)SDL2.SDL.Scancode.Key4] && gCurrentKeyStates[(int)SDL2.SDL.Scancode.RAlt])
				Scene.doDraw = !Scene.doDraw;
			if(gCurrentKeyStates[(int)SDL2.SDL.Scancode.Key5] && gLastKeyStates[(int)SDL2.SDL.Scancode.Key5] != gCurrentKeyStates[(int)SDL2.SDL.Scancode.Key5] && gCurrentKeyStates[(int)SDL2.SDL.Scancode.RAlt])
				runGame = !runGame;
			if(gCurrentKeyStates[(int)SDL2.SDL.Scancode.Key6] && gLastKeyStates[(int)SDL2.SDL.Scancode.Key6] != gCurrentKeyStates[(int)SDL2.SDL.Scancode.Key6] && gCurrentKeyStates[(int)SDL2.SDL.Scancode.RAlt])
			{
				Reset();
			}

			

			if(runGame)
				for(Entity e in SceneEntities)
					e.Update(delta);

			Draw(delta);
			for(int i < len)
				gLastKeyStates[i] = gCurrentKeyStates[i];

			if(Game.changedScene)
			{
				delete this;
				Game.changedScene = false;
			}
		}
		public void Draw(float delta)
		{
			if(Scene.doDraw)
			{
				for(Entity e in SceneEntities)
					e.Draw();
				for(Hud e in SceneHuds)
					e.Draw();
				if(Scene.doDebug)
				{
					for(Hud e in DebugHud)
						e.Draw();

					SDL.SetRenderDrawColor(SDLManager.gGameRender,0xFF,0xFF,0xFF,0xFF);

					measurement = (measurement * smoothing) + (1/(deltaT/1000) * (1.0f-smoothing));

					Texture fps = scope Texture();
					fps.LoadFromString(measurement.ToString(.. scope String()),SDL.Color(0xFF,0xFF,0xFF,0xFF),SDLManager.GetDefaultFont());
					fps.Render(0,20);
					//
					Texture mpos = scope Texture();
					int32 mx = 0, my = 0;
					SDL.GetMouseState(&mx,&my);
					String values = mx.ToString(.. scope String());
					values.AppendF(" / ");
					values.AppendF(my.ToString(.. scope String()));
					mpos.LoadFromString(values,SDL.Color(0xFF,0xFF,0xFF,0xFF),SDLManager.GetDefaultFont());
					mpos.Render(0,0);
					//
					SDL.SetRenderDrawColor(SDLManager.gGameRender,0x55,0x45,0x65,0xFF);
				}
			}
			

			if(gCurrentKeyStates[(int)SDL2.SDL.Scancode.Key1] && gLastKeyStates[(int)SDL2.SDL.Scancode.Key1] != gCurrentKeyStates[(int)SDL2.SDL.Scancode.Key1] && gCurrentKeyStates[(int)SDL2.SDL.Scancode.RAlt])
				DebugRenderTexture.Screenshot();

			
			

		}
		public void AddEntity(Entity entity)
		{
			entity.Init();
			SceneEntities.Add(entity);
			
		}
		public void RemoveEntity(Entity entity)
		{
			SceneEntities.Remove(entity);
			delete(entity);
		}

		public void Reset()
		{
			Delete();
			Load();
		}

		///Reset the current scene to its default state
		public virtual void Delete()
		{
			for(Entity i in SceneEntities)
				i.Destroy();
			DeleteContainerAndItems!(this.SceneHuds);
			DeleteContainerAndItems!(this.SceneEntities);
			DeleteContainerAndItems!(this.DebugHud);
			delete gLastKeyStates;

		}
		public virtual void Load()
		{
			SDL2.SDL.GetKeyboardState(&len);
			gLastKeyStates = new bool[len];
			SceneEntities = new List<Entity>();
			SceneHuds = new List<Hud>();
			DebugHud = new List<Hud>();
		}

		
	}
}
