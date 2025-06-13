using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using QisUtils;

namespace Question07
{
    class ExpectedCinemaData
    {
        public int NumberOfFilm { get; set; }
        public int Age { get; set; }
        public bool ParseNumberOfFilm(string input)
        {
            int numberOfFilm;
            if (!Int32.TryParse(input, out numberOfFilm) || numberOfFilm < 1 || numberOfFilm > 5)
            {
                Console.WriteLine("That film number is out of range. Please enter a number between 1 and 5: ");
                return false;
            }
            this.NumberOfFilm = numberOfFilm;
            return true;
        }
        public bool ValidateRating(string input)
        {
            int age;
            if (!Int32.TryParse(input, out age) || age < 5 || age > 120)
            {
                Console.WriteLine("That age is out of range. Please enter an age between 5 and 120: ");
                return false;
            }
            this.Age = age;
            return true;
        }
    }

    public class Cinema : QisApp
    {
        class Film
        {
            public bool MatchAge(int age)
            {
                if (RequiredAge == "PG" || RequiredAge == "F")
                {
                    return true;
                }
                return age >= Int32.Parse(RequiredAge);
            }
            public string Name { get; set; }
            public string RequiredAge { get; set; }
        }

        public void ExecuteSolution(RedirectedIO io)
        {
            Film[] films = new Film[] {
                new Film { Name = "Species", RequiredAge = "14" },
                new Film { Name = "Fight Club", RequiredAge = "14" },
                new Film { Name = "Stargate", RequiredAge = "PG" },
                new Film { Name = "The Terminator", RequiredAge = "18" },
                new Film { Name = "Surf's Up", RequiredAge = "F" }
            };
            do
            {
                Console.WriteLine("Welcome to Famous Players\n"
                    + "We are presently showing:");
                for (int i = 0; i < films.Length; i++)
                {
                    Console.WriteLine((i + 1) + ". " + films[i].Name + "(" + films[i].RequiredAge + ")");
                }
                Console.WriteLine("Enter the number of the film you wish to see: ");
                ExpectedCinemaData expectedData = new ExpectedCinemaData();
                do
                {
                }
                while (!expectedData.ParseNumberOfFilm(io.ReadLine()));
                Console.WriteLine("Enter your age: ");
                do
                {
                }
                while (!expectedData.ValidateRating(io.ReadLine()));
                if (films[expectedData.NumberOfFilm - 1].MatchAge(expectedData.Age))
                {
                    io.WriteLine("Enjoy the film");
                }
                else
                {
                    io.WriteLine("Access Denied - You are too young");
                }
                Console.WriteLine("Another customer? (Y or N): ");
            } while (io.ReadLine() != "N");
        }
    }

    class CinemaTestData : TestData
    {
        public CinemaTestData(string[] bunchUserOptionAndFilmNumberAndAge, string[] expectedSubmission, string expectedException): base(expectedException)
        {
            foreach (var filmNumberAndAge in bunchUserOptionAndFilmNumberAndAge)
            {
                GetStreamedInput().Enqueue(filmNumberAndAge);
                TestDescription += filmNumberAndAge + ", ";
            }
            foreach (string output in expectedSubmission)
            {
                ExpectedSubmission.Enqueue(output);
            }
        }

        public override string GetTestDescription()
        {
            return TestDescription;
        }
    }

    class Program
    {
        public static void Main(string[] args)
        {
            new QisWorkBench().RunWithTestData(new Cinema(), new TestData[] {
                new CinemaTestData(new string[] { "1", "13", "N" }, 
                    new string[] { "Access Denied - You are too young" }, ""),
                new CinemaTestData(new string[] { "1", "14", "N" }, 
                    new string[] { "Enjoy the film" }, ""),
                new CinemaTestData(new string[] { "0", "1", "1", "0", "1", "5", "N" }, 
                    new string[] { "Access Denied - You are too young" }, ""),
                new CinemaTestData(new string[] { "2", "13", "N" }, 
                    new string[] { "Access Denied - You are too young" }, ""),
                new CinemaTestData(new string[] { "2", "0", "2", "5", "N" }, 
                    new string[] { "Access Denied - You are too young" }, ""),
                new CinemaTestData(new string[] { "0", "1", "13", "N" }, 
                    new string[] { "Access Denied - You are too young" }, ""),
                new CinemaTestData(new string[] { "3", "19", "N" }, 
                    new string[] { "Enjoy the film" }, ""),
                new CinemaTestData(new string[] { "0", "1", "18", "N" }, 
                    new string[] { "Enjoy the film" }, ""),
                new CinemaTestData(new string[] { "-90", "1", "18", "N" }, 
                    new string[] { "Enjoy the film" }, ""),
                new CinemaTestData(new string[] { "4", "-89", "4", "5", "N" }, 
                    new string[] { "Access Denied - You are too young" }, ""),
                new CinemaTestData(new string[] { "5", "13", "N" }, 
                    new string[] { "Enjoy the film" }, ""),
                new CinemaTestData(new string[] { "4", "17", "N" }, 
                    new string[] { "Access Denied - You are too young" }, ""),
                new CinemaTestData(new string[] { "4", "18", "N" }, 
                    new string[] { "Enjoy the film" }, ""),
                new CinemaTestData(new string[] { "6", "1", "18", "N" }, 
                    new string[] { "Enjoy the film" }, ""),
                new CinemaTestData(new string[] { "3", "999", "3", "19", "N" }, 
                    new string[] { "Enjoy the film" }, ""),
                new CinemaTestData(new string[] { "1", "13", "Y", "2", "14", "N" }, 
                    new string[] { "Access Denied - You are too young", "Enjoy the film" }, ""),
                new CinemaTestData(new string[] { "3", "19", "Y", "4", "17", "N" }, 
                    new string[] { "Enjoy the film", "Access Denied - You are too young" }, ""),
                new CinemaTestData(new string[] { "5", "13", "Y", "1", "14", "N" }, 
                    new string[] { "Enjoy the film", "Enjoy the film" }, "")
            });
        }
    }
}