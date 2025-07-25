using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace A3
{
    internal class Program
    {
        // main method
        static void Main(string[] args)
        {
            TestPart1();
            TestPart2();
        }
        // test part 2
        static void TestPart2()
        {
            var matcher = new BracketMatcher();
            string [] inputs = { "{[()]}", "{}{}}{" };
            foreach (var input in inputs)
            {
                bool isValid = matcher.IsValid(input);
                Console.WriteLine($"Input: {input} - Valid: {isValid}");
            }
        }
        // test part 1
        static void TestPart1()
        {
            Playlist playlist = new Playlist("My Awesome Playlist");
            Track track1 = new Track("Song 1", "Artist 1", "Album 1", 180);
            Track track2 = new Track("Song 2", "Artist 2", "Album 2", 240);
            Track track3 = new Track("Song 3", "Artist 3", "Album 3", 300);
            Track track4 = new Track("Song 4", "Artist 4", "Album 4", 200);

            playlist.Add(track1);
            playlist.Add(track2);
            playlist.Add(track3);
            playlist.Add(track4);

            Console.WriteLine($"--- Initial Playlist (Songs: {playlist.Count}) ---");
            Console.WriteLine($"Playlist: {playlist.Name}");
            Console.WriteLine(playlist.ToString()); // Playing: Song 1 by Artist 1

            playlist.Next();
            Console.WriteLine(playlist.ToString()); // Playing: Song 2 by Artist 2

            playlist.Next();
            Console.WriteLine(playlist.ToString()); // Playing: Song 3 by Artist 3

            playlist.Next();
            Console.WriteLine(playlist.ToString()); // Playing: Song 4 by Artist 4

            playlist.Next();
            Console.WriteLine(playlist.ToString()); // Playing: Song 4 by Artist 4


            Console.WriteLine("\n--- Testing Shuffle ---");
            playlist.Shuffle();
            Console.WriteLine("Playlist has been shuffled.");
            Console.WriteLine(playlist.ToString());
            playlist.Next();
            Console.WriteLine(playlist.ToString());
            playlist.Next();
            Console.WriteLine(playlist.ToString());


            Console.WriteLine($"\n--- Testing Remove (Songs: {playlist.Count}) ---");
            Track trackToRemove = new Track("Song 2", "Artist 2", "Album 2", 240);
            Console.WriteLine($"Removing '{trackToRemove.Name}'...");
            playlist.Remove(trackToRemove);
            Console.WriteLine($"Playlist now has {playlist.Count} songs.");


            Console.WriteLine("\n--- Final Playlist State ---");
            playlist.Shuffle();
            Console.WriteLine($"Currently {playlist.Count} songs left. Shuffled again.");
            Console.WriteLine(playlist.ToString());
            playlist.Next();
            Console.WriteLine(playlist.ToString());
            playlist.Next();
            Console.WriteLine(playlist.ToString());
        }
    }
}
