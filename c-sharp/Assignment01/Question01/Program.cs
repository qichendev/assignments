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
        public int numberOfFilm { get; set; }
        public int age { get; set; }
        public void parseNumberOfFilm(string input)
        {
            int value;
            if (!Int32.TryParse(input, out value) || value < 1 || value > 5)
            {
                throw new Exception("Invalid number of film input: " + input);
            }
            numberOfFilm = value;
        }
        public void parseAge(string input)
        {
            int value;
            if (!Int32.TryParse(input, out value) || value < 1)
            {
                throw new Exception("Invalid age input: " + input);
            }
            age = value;
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

        public void executeSolution(RedirectedInput input, Action<string> submit)
        {
            Film[] films = new Film[] {
                new Film { name = "Species", requiredAge = "14" },
                new Film { name = "Fight Club", requiredAge = "14" },
                new Film { name = "Stargate", requiredAge = "PG" },
                new Film { name = "The Terminator", requiredAge = "18" },
                new Film { name = "Surf's Up", requiredAge = "F" }
            };
            Console.WriteLine("Welcome to Famous Players\n"
                + "We are presently showing:");
            for (int i = 0; i < films.Length; i++)
            {
                Console.WriteLine((i + 1) + ". " + films[i].name + "(" + films[i].requiredAge + ")");
            }
            Console.WriteLine("Enter the number of the film you wish to see: ");
            ExpectedCinemaData expectedData = new ExpectedCinemaData();
            expectedData.parseNumberOfFilm(input.read());
            Console.WriteLine("Enter your age: ");
            expectedData.parseAge(input.read());
            if (films[expectedData.numberOfFilm - 1].matchAge(expectedData.age))
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
            streamedInput.Enqueue(expectedData.numberOfFilm.ToString());
            streamedInput.Enqueue(expectedData.age.ToString());
            this.expectedSubmission = expectedSubmission;
            this.expectedException = expectedException;
            testDescription = " numberOfFilm: " + expectedData.numberOfFilm + " age: " + expectedData.age;
        }

        public override Queue<string> getStreamedInput()
        {
            return streamedInput;
        }

        public override string getTestDescription()
        {
            return testDescription;
        }
    }

    class Program
    {
        public static void Main(string[] args)
        {
            new QisWorkBench().runWithTestData(new Cinema(), new TestData[] {
                new CinemaTestData(new ExpectedCinemaData { numberOfFilm = 1, age = 13 }, 
                    "Access Denied - You are too young", ""),
                new CinemaTestData(new ExpectedCinemaData { numberOfFilm = 1, age = 14 }, 
                    "Enjoy the film", ""),
                new CinemaTestData(new ExpectedCinemaData { numberOfFilm = 1, age = 0 }, 
                    "", "Invalid age input: 0"),
                new CinemaTestData(new ExpectedCinemaData { numberOfFilm = 2, age = 13 }, 
                    "Access Denied - You are too young", ""),
                new CinemaTestData(new ExpectedCinemaData { numberOfFilm = 2, age = 0 }, 
                    "", "Invalid age input: 0"),
                new CinemaTestData(new ExpectedCinemaData { numberOfFilm = 0, age = 13 }, 
                    "", "Invalid number of film input: 0"),
                new CinemaTestData(new ExpectedCinemaData { numberOfFilm = 3, age = 19 }, 
                    "Enjoy the film", ""),
                new CinemaTestData(new ExpectedCinemaData { numberOfFilm = 0, age = 18 }, 
                    "", "Invalid number of film input: 0"),
                new CinemaTestData(new ExpectedCinemaData { numberOfFilm = -90, age = 18 }, 
                    "", "Invalid number of film input: -90"),
                new CinemaTestData(new ExpectedCinemaData { numberOfFilm = 4, age = -89 }, 
                    "", "Invalid age input: -89"),
                new CinemaTestData(new ExpectedCinemaData { numberOfFilm = 5, age = 13 }, 
                    "Enjoy the film", ""),
                new CinemaTestData(new ExpectedCinemaData { numberOfFilm = 4, age = 17 }, 
                    "Access Denied - You are too young", ""),
                new CinemaTestData(new ExpectedCinemaData { numberOfFilm = 4, age = 18 }, 
                    "Enjoy the film", ""),
                new CinemaTestData(new ExpectedCinemaData { numberOfFilm = 6, age = 18 }, 
                    "", "Invalid number of film input: 6"),
                new CinemaTestData(new ExpectedCinemaData { numberOfFilm = 3, age = 999 }, 
                    "Enjoy the film", "")
            });
        }
    }
}
