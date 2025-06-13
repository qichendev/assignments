using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using QisUtils;

namespace Question03
{
    class ExpectedCinemaData
    {
        public int numberOfFilm { get; set; }
        public int age { get; set; }
        public bool parseNumberOfFilm(string input)
        {
            int numberOfFilm;
            if (!Int32.TryParse(input, out numberOfFilm) || numberOfFilm < 1 || numberOfFilm > 5)
            {
                Console.WriteLine("That film number is out of range. Please enter a number between 1 and 5: ");
                return false;
            }
            this.numberOfFilm = numberOfFilm;
            return true;
        }
        public bool parseAge(string input)
        {
            int age;
            if (!Int32.TryParse(input, out age) || age < 5 || age > 120)
            {
                Console.WriteLine("That age is out of range. Please enter an age between 5 and 120: ");
                return false;
            }
            this.age = age;
            return true;
        }
    }

    public class Cinema : QisApp
    {
        class Film
        {
            public bool matchAge(int age)
            {
                if (requiredAge == "PG" || requiredAge == "F")
                {
                    return true;
                }
                return age >= Int32.Parse(requiredAge);
            }
            public string name { get; set; }
            public string requiredAge { get; set; }
        }

        public void executeSolution(RedirectedIO io)
        {
            Film[] films = new Film[] {
                new Film { name = "Species", requiredAge = "14" },
                new Film { name = "Fight Club", requiredAge = "14" },
                new Film { name = "Stargate", requiredAge = "PG" },
                new Film { name = "The Terminator", requiredAge = "18" },
                new Film { name = "Surf's Up", requiredAge = "F" }
            };
            do
            {
                Console.WriteLine("Welcome to Famous Players\n"
                    + "We are presently showing:");
                for (int i = 0; i < films.Length; i++)
                {
                    Console.WriteLine((i + 1) + ". " + films[i].name + "(" + films[i].requiredAge + ")");
                }
                Console.WriteLine("Enter the number of the film you wish to see: ");
                ExpectedCinemaData expectedData = new ExpectedCinemaData();
                do
                {
                }
                while (!expectedData.parseNumberOfFilm(io.readLine()));
                Console.WriteLine("Enter your age: ");
                do
                {
                }
                while (!expectedData.parseAge(io.readLine()));
                if (films[expectedData.numberOfFilm - 1].matchAge(expectedData.age))
                {
                    io.writeLine("Enjoy the film");
                }
                else
                {
                    io.writeLine("Access Denied - You are too young");
                }
                Console.WriteLine("Another customer? (Y or N): ");
            } while (io.readLine() != "N");
        }
    }

    class CinemaTestData : TestData
    {
        public CinemaTestData(string[] bunchUserOptionAndFilmNumberAndAge, string[] expectedSubmission, string expectedException): base(expectedException)
        {
            foreach (var filmNumberAndAge in bunchUserOptionAndFilmNumberAndAge)
            {
                base.streamedInput.Enqueue(filmNumberAndAge);
                base.testDescription += filmNumberAndAge + ", ";
            }
            foreach (string output in expectedSubmission)
            {
                base.expectedSubmission.Enqueue(output);
            }
            this.expectedException = expectedException;
        }
    }

    class Program
    {
        public static void Main(string[] args)
        {
            new QisWorkBench().RunWithTestData(new Cinema(), new TestData[] {
                new CinemaTestData(new int[] { 1, 13 }, 
                    new string[] { "Access Denied - You are too young" }, ""),
                new CinemaTestData(new int[] { 1, 14 }, 
                    new string[] { "Enjoy the film" }, ""),
                new CinemaTestData(new int[] { 0, 1, 1, 0, 1, 5 }, 
                    new string[] { "Access Denied - You are too young" }, ""),
                new CinemaTestData(new int[] { 2, 13 }, 
                    new string[] { "Access Denied - You are too young" }, ""),
                new CinemaTestData(new int[] { 2, 0, 2, 5 }, 
                    new string[] { "Access Denied - You are too young" }, ""),
                new CinemaTestData(new int[] { 0, 1, 13 }, 
                    new string[] { "Access Denied - You are too young" }, ""),
                new CinemaTestData(new int[] { 3, 19 }, 
                    new string[] { "Enjoy the film" }, ""),
                new CinemaTestData(new int[] { 0, 1, 18 }, 
                    new string[] { "Enjoy the film" }, ""),
                new CinemaTestData(new int[] { -90, 1, 18 }, 
                    new string[] { "Enjoy the film" }, ""),
                new CinemaTestData(new int[] { 4, -89, 4, 5 }, 
                    new string[] { "Access Denied - You are too young" }, ""),
                new CinemaTestData(new int[] { 5, 13 }, 
                    new string[] { "Enjoy the film" }, ""),
                new CinemaTestData(new int[] { 4, 17 }, 
                    new string[] { "Access Denied - You are too young" }, ""),
                new CinemaTestData(new int[] { 4, 18 }, 
                    new string[] { "Enjoy the film" }, ""),
                new CinemaTestData(new int[] { 6, 1, 18 }, 
                    new string[] { "Enjoy the film" }, ""),
                new CinemaTestData(new int[] { 3, 999, 3, 19 }, 
                    new string[] { "Enjoy the film" }, "")
            });
        }
    }
}