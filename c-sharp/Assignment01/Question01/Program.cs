using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using QisUtils;

namespace Question01
{
    class ExpectedCinemaData
    {
        public int NumberOfFilm { get; set; }
        public int Age { get; set; }
        public void ParseNumberOfFilm(string input)
        {
            int value;
            if (!Int32.TryParse(input, out value) || value < 1 || value > 5)
            {
                throw new Exception("Invalid number of film input: " + input);
            }
            NumberOfFilm = value;
        }
        public void ParseAge(string input)
        {
            int value;
            if (!Int32.TryParse(input, out value) || value < 1)
            {
                throw new Exception("Invalid age input: " + input);
            }
            Age = value;
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

        public void ExecuteSolution(RedirectedInput input, Action<string> submit)
        {
            Film[] films = new Film[] {
                new Film { Name = "Species", RequiredAge = "14" },
                new Film { Name = "Fight Club", RequiredAge = "14" },
                new Film { Name = "Stargate", RequiredAge = "PG" },
                new Film { Name = "The Terminator", RequiredAge = "18" },
                new Film { Name = "Surf's Up", RequiredAge = "F" }
            };
            Console.WriteLine("Welcome to Famous Players\n"
                + "We are presently showing:");
            for (int i = 0; i < films.Length; i++)
            {
                Console.WriteLine((i + 1) + ". " + films[i].Name + "(" + films[i].RequiredAge + ")");
            }
            Console.WriteLine("Enter the number of the film you wish to see: ");
            ExpectedCinemaData expectedData = new ExpectedCinemaData();
            expectedData.ParseNumberOfFilm(input.Read());
            Console.WriteLine("Enter your age: ");
            expectedData.ParseAge(input.Read());
            if (films[expectedData.NumberOfFilm - 1].MatchAge(expectedData.Age))
            {
                submit("Enjoy the film");
            }
            else
            {
                submit("Access Denied - You are too young");
            }
        }
    }

    class CinemaTestData : TestData
    {
        private Queue<string> streamedInput;
        private string testDescription;
        public CinemaTestData(ExpectedCinemaData expectedData, string expectedSubmission, string expectedException)
        {
            streamedInput = new Queue<string>();
            streamedInput.Enqueue(expectedData.NumberOfFilm.ToString());
            streamedInput.Enqueue(expectedData.Age.ToString());
            this.ExpectedSubmission = expectedSubmission;
            this.ExpectedException = expectedException;
            testDescription = " numberOfFilm: " + expectedData.NumberOfFilm + " age: " + expectedData.Age;
        }

        public override Queue<string> GetStreamedInput()
        {
            return streamedInput;
        }

        public override string GetTestDescription()
        {
            return testDescription;
        }
    }

    class Program
    {
        public static void Main(string[] args)
        {
            new QisWorkBench().RunWithTestData(new Cinema(), new TestData[] {
                new CinemaTestData(new ExpectedCinemaData { NumberOfFilm = 1, Age = 13 }, 
                    "Access Denied - You are too young", ""),
                new CinemaTestData(new ExpectedCinemaData { NumberOfFilm = 1, Age = 14 }, 
                    "Enjoy the film", ""),
                new CinemaTestData(new ExpectedCinemaData { NumberOfFilm = 1, Age = 0 }, 
                    "", "Invalid age input: 0"),
                new CinemaTestData(new ExpectedCinemaData { NumberOfFilm = 2, Age = 13 }, 
                    "Access Denied - You are too young", ""),
                new CinemaTestData(new ExpectedCinemaData { NumberOfFilm = 2, Age = 0 }, 
                    "", "Invalid age input: 0"),
                new CinemaTestData(new ExpectedCinemaData { NumberOfFilm = 0, Age = 13 }, 
                    "", "Invalid number of film input: 0"),
                new CinemaTestData(new ExpectedCinemaData { NumberOfFilm = 3, Age = 19 }, 
                    "Enjoy the film", ""),
                new CinemaTestData(new ExpectedCinemaData { NumberOfFilm = 0, Age = 18 }, 
                    "", "Invalid number of film input: 0"),
                new CinemaTestData(new ExpectedCinemaData { NumberOfFilm = -90, Age = 18 }, 
                    "", "Invalid number of film input: -90"),
                new CinemaTestData(new ExpectedCinemaData { NumberOfFilm = 4, Age = -89 }, 
                    "", "Invalid age input: -89"),
                new CinemaTestData(new ExpectedCinemaData { NumberOfFilm = 5, Age = 13 }, 
                    "Enjoy the film", ""),
                new CinemaTestData(new ExpectedCinemaData { NumberOfFilm = 4, Age = 17 }, 
                    "Access Denied - You are too young", ""),
                new CinemaTestData(new ExpectedCinemaData { NumberOfFilm = 4, Age = 18 }, 
                    "Enjoy the film", ""),
                new CinemaTestData(new ExpectedCinemaData { NumberOfFilm = 6, Age = 18 }, 
                    "", "Invalid number of film input: 6"),
                new CinemaTestData(new ExpectedCinemaData { NumberOfFilm = 3, Age = 999 }, 
                    "Enjoy the film", "")
            });
        }
    }
}
