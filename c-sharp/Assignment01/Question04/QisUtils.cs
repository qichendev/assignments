using System;
using System.Collections.Generic;
using System.Linq;
namespace QisUtils
{
    public interface RedirectedIO
    {
        string ReadLine();
        void WriteLine(string output);
    }
    public interface QisApp
    {
        void ExecuteSolution(RedirectedIO redirectedInput);
    }
    public abstract class TestData : RedirectedIO
    {
        private Queue<string> streamedInput;
        private Queue<string> actualSubmission;
        private Queue<string> expectedSubmission;
        private string testDescription;
        private string expectedException;

        public TestData(string expectedException = "")
        {
            this.expectedException = expectedException;
            streamedInput = new Queue<string>();
            actualSubmission = new Queue<string>();
            expectedSubmission = new Queue<string>();
            testDescription = string.Empty;
        }

        public string ReadLine()
        {
            return streamedInput.Dequeue();
        }

        public void WriteLine(string output)
        {
            actualSubmission.Enqueue(output);
        }

        public Queue<string> GetStreamedInput()
        {
            return streamedInput;
        }

        public abstract string GetTestDescription();

        public string ExpectedException { get { return expectedException; } set { expectedException = value; } }
        public Queue<string> ActualSubmission { get { return actualSubmission; } }
        public Queue<string> ExpectedSubmission { get { return expectedSubmission; } set { expectedSubmission = value; } }
        public string TestDescription { get { return testDescription; } set { testDescription = value; } }
    }
    public class QisWorkBench
    {
        private void DisplayTestResult(string testDescription, bool isPassed)
        {
            Console.Write(testDescription);
            Console.ForegroundColor = isPassed ? ConsoleColor.Green : ConsoleColor.Red;
            Console.WriteLine(isPassed ? " Passed" : " Failed");
            Console.ResetColor();
        }
        public void RunWithTestData(QisApp qisApp, TestData[] testData)
        {
            for (var i = 0; i < testData.Length; i++)
            {
                var test = testData[i];
                try
                {
                    qisApp.ExecuteSolution(test);
                    DisplayTestResult("Test No." + (i + 1) + ": " 
                        + "Expected Submission: " + string.Join(", ", test.ExpectedSubmission) 
                        + " Actual Submission: " + string.Join(", ", test.ActualSubmission)
                        , test.ExpectedSubmission.Cast<string>().SequenceEqual(test.ActualSubmission.Cast<string>()));
                }
                catch (Exception e)
                {
                    DisplayTestResult("Test No." + (i + 1) + ": " + test.TestDescription
                        + " exception: " + e.Message, e.Message == test.ExpectedException);
                }
            }
        }
        private class ConsoleIO : RedirectedIO
        {
            public string ReadLine()
            {
                return Console.ReadLine();
            }
            public void WriteLine(string output)
            {
                Console.WriteLine(output);
            }
        }
        public void Run(QisApp qisApp)
        {
            try
            {
                qisApp.ExecuteSolution(new ConsoleIO());
            }
            catch (Exception e)
            {
                Console.WriteLine("Error: " + e.Message);
            }
        }
    }
}