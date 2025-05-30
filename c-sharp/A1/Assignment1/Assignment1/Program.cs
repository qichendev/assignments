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
                if (numberOfFilm < 1 || numberOfFilm > films.Length)
                {
                    throw new Exception("Invalid number of film input: " + numberOfFilm);
                }
                Console.WriteLine("Enter your age: ");
                var age = ReadIntFromString(getUserAge == null ? Console.ReadLine() : getUserAge()
                    , input => {
                        throw new Exception("Invalid age input: " + input);
                    });
                if (age < 0)
                {
                    throw new Exception("Invalid age input: " + age);
                }
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
        class CinemaRunner
        {
            private static void DisplayTestResult(string testDescription, bool isPassed)
            {
                Console.Write(testDescription);
                Console.ForegroundColor = isPassed ? ConsoleColor.Green : ConsoleColor.Red;
                Console.WriteLine(isPassed ? " Passed" : " Failed");
                Console.ResetColor();
            }

            public static void RunAllTests()
            {
                const string injectedLargeNumber = "999999999999999999999999999999999999999";
                const string injectedSmallNumber = "-0.0000000000000000000000000000000000001";
                var TestData = new[] {
                    new {numberOfFilm = "1"
                        , age = "13"
                        , expectedFeedback = "Access Denied - You are too young"
                        , expectedException = "" },
                    new { numberOfFilm = "1", age = "14"
                        , expectedFeedback = "Enjoy the film"
                        , expectedException = "" },
                    new { numberOfFilm = "1"
                        , age = injectedLargeNumber, expectedFeedback = ""
                        , expectedException = "Invalid age input: " + injectedLargeNumber },
                    new { numberOfFilm = "2"
                        , age = "13"
                        , expectedFeedback = "Access Denied - You are too young", expectedException = "" },
                    new { numberOfFilm = "2"
                        , age = injectedSmallNumber
                        , expectedFeedback = "", expectedException = "Invalid age input: " + injectedSmallNumber },
                    new { numberOfFilm = injectedLargeNumber
                        , age = "13"
                        , expectedFeedback = ""
                        , expectedException = "Invalid number of film input: " + injectedLargeNumber },
                    new { numberOfFilm = "3"
                        , age = "19"
                        , expectedFeedback = "Enjoy the film"
                        , expectedException = "" },
                    new { numberOfFilm = injectedSmallNumber
                        , age = "18", expectedFeedback = ""
                        , expectedException = "Invalid number of film input: " + injectedSmallNumber },
                    new { numberOfFilm = "4"
                        , age = "18"
                        , expectedFeedback = "Enjoy the film"
                        , expectedException = "" },
                    new { numberOfFilm = "4"
                        , age = "17"
                        , expectedFeedback = "Access Denied - You are too young"
                        , expectedException = "" },
                    new { numberOfFilm = "5"
                        , age = "13"
                        , expectedFeedback = "Enjoy the film"
                        , expectedException = "" }
                };
                foreach (var test in TestData)
                {
                    var testDescription = "Test: " + test.numberOfFilm + " " + test.age;
                    try
                    {
                        Cinema.Entry(
                            () => test.numberOfFilm,
                            () => test.age,
                            message =>
                            {
                                DisplayTestResult(testDescription + " feedback: " + message, message == test.expectedFeedback);
                            }
                        );
                    }
                    catch (Exception e)
                    {
                        DisplayTestResult(testDescription + " exception: " + e.Message, e.Message == test.expectedException);
                    }
                }
            }
            public static void Run()
            {
                try
                {
                    Cinema.Entry();
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                }
            }
        }

        static void Main(string[] args)
        {
            CinemaRunner.RunAllTests();
            // CinemaRunner.Run();
        }
    }
}
