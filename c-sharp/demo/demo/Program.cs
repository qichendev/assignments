using System;
using System.Collections.Generic;

namespace Assignment1
{
    internal class Program
    {
        class Film
        {
            public bool MatchAge(int age)
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
        class Cinema
        {
            private static int ReadIntFromString(string input, Func<string, int> OnReadError)
            {
                return int.TryParse(input, out int ret) ? ret : OnReadError(input);
            }
            public static void Entry(Func<string> getNumberOfFilm = null
                , Func<string> getUserAge = null
                , Action<string> Feedback = null)
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
                var numberOfFilm = ReadIntFromString(getNumberOfFilm == null ? Console.ReadLine() : getNumberOfFilm()
                    , input => {
                        throw new Exception("Invalid number of film input: " + input);
                    }
                );
                Console.WriteLine("Enter your age: ");
                var age = ReadIntFromString(getUserAge == null ? Console.ReadLine() : getUserAge()
                    , input => {
                        throw new Exception("Invalid age input: " + input);
                    });
                Feedback = Feedback == null ? Console.WriteLine : Feedback;
                if (films[numberOfFilm - 1].MatchAge(age))
                {
                    Feedback("Enjoy the film");
                }
                else
                {
                    Feedback("Access Denied - You are too young");
                }
            }
        }
        class CinemaTestRunner
        {
            public static void Run()
            {
                const string injectedLargeNumber = "999999999999999999999999999999999999999";
                const string injectedSmallNumber = "-0.0000000000000000000000000000000000001";
                var TestData = new []{
                    new {
                        numberOfFilm = "1",
                        age = "13",
                        expectedFeedback = "Access Denied - You are too young"
                    },
                    new {
                        numberOfFilm = "1",
                        age = "14",
                        expectedFeedback = "Enjoy the film"
                    },
                    new {
                        numberOfFilm = "1",
                        age = injectedLargeNumber,
                        expectedException = "Invalid age input: " + injectedLargeNumber
                    },
                    new {
                        numberOfFilm = "2",
                        age = "13",
                        expectedFeedback = "Access Denied - You are too young",
                    },
                    new {
                        numberOfFilm = "2",
                        age = injectedSmallNumber,
                        expectedException = "Invalid age input: " + injectedSmallNumber
                    },
                    new {
                        numberOfFilm = injectedLargeNumber,
                        age = "13",
                        expectedException = "Invalid number of film input: " + injectedLargeNumber
                    },
                    new {
                        numberOfFilm = "3",
                        age = "19",
                        expectedFeedback = "Enjoy the film"
                    },
                    new {
                        numberOfFilm = injectedSmallNumber,
                        age = "18",
                        expectedException = "Invalid number of film input: " + injectedSmallNumber
                    },
                    new {
                        numberOfFilm = "4",
                        age = "18",
                        expectedFeedback = "Enjoy the film"
                    },
                    new {
                        numberOfFilm = "4",
                        age = "17",
                        expectedFeedback = "Access Denied - You are too young"
                    },
                    new {
                        numberOfFilm = "5",
                        age = "13",
                        expectedFeedback = "Enjoy the film"
                    },
                };
                foreach (var test in TestData)
                {
                    var testDescription = "Test: " + test.numberOfFilm + " " + test.age;
                    try
                    {
                        Cinema.Entry(
                            () => test.numberOfFilm,
                            () => test.age,
                            (message) => {
                                if (message == test.expectedFeedback)
                                {
                                    Console.WriteLine(testDescription + " Passed");
                            }
                            else
                            {
                                Console.WriteLine(testDescription + " Failed");
                            }
                        }
                    );
                    }
                    catch (Exception e)
                    {
                        if (e.Message == test.expectedException)
                        {
                            Console.WriteLine(testDescription + " Passed");
                        }
                        else
                        {
                            Console.WriteLine(testDescription + " Failed");
                        }
                    }
                }
            }
        }
        static void Main(string[] args)
        {
            CinemaTestRunner.Run();
            // Cinema.Entry();
        }
    }
}
