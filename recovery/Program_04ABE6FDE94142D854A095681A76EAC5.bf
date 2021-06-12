using System;
using SDL2;
namespace bounty_game
{
	public static{
		public static String game_Name = "Hasty Heist";
		public static int32 game_width = 1280;
		public static int32 game_height = 720;
	}
	class Program
	{
		public static void Main()
		{
			Game.Init(game_Name,game_width,ga);
			Game.Run();
			Game.Close();
		}
	}
}
