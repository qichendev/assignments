using System;
using System.Collections.Generic;
using System.Linq;
namespace QisUtils
{
    public interface RedirectedIO
    {
        string readLine();
        void writeLine(string output);
    }
    public interface QisApp
    {
        void executeSolution(RedirectedIO redirectedInput);
    }
    public abstract class TestData : RedirectedIO
    {
        public TestData(string expectedException = "")
        {
            this.expectedException = expectedException;
            streamedInput = new Queue<string>();
            actualSubmission = new Queue<string>();
            expectedSubmission = new Queue<string>();
            testDescription = string.Empty;
        }
        public string readLine()
        {
            return streamedInput.Dequeue();
        }
        public void writeLine(string output)
        {
            actualSubmission.Enqueue(output);
        }
        public Queue<string> streamedInput { get; set; }
        public Queue<string> actualSubmission { get; set; }
        public Queue<string> expectedSubmission { get; set; }
        public string expectedException { get; set; }
        public string testDescription { get; set; }
    };
    public class QisWorkBench
    {
        private void displayTestResult(string testDescription, bool isPassed)
        {
            Console.Write(testDescription);
            Console.ForegroundColor = isPassed ? ConsoleColor.Green : ConsoleColor.Red;
            Console.WriteLine(isPassed ? " Passed" : " Failed");
            Console.ResetColor();
        }
        public void runWithTestData(QisApp qisApp, TestData[] testData)
        {
            for (var i = 0; i < testData.Length; i++)
            {
                var test = testData[i];
                try
                {
                    qisApp.executeSolution(test);
                    displayTestResult("Test No." + (i + 1) + ": " 
                        + "Expected Submission: " + string.Join(", ", test.expectedSubmission) 
                        + " Actual Submission: " + string.Join(", ", test.actualSubmission)
                        , test.expectedSubmission.Cast<string>().SequenceEqual(test.actualSubmission.Cast<string>()));
                }
                catch (Exception e)
                {
                    displayTestResult("Test No." + (i + 1) + ": " + test.testDescription
                        + " exception: " + e.Message, e.Message == test.expectedException);
                }
            }
        }
        private class ConsoleIO : RedirectedIO
        {
            public string readLine()
            {
                return Console.ReadLine();
            }
            public void writeLine(string output)
            {
                Console.WriteLine(output);
            }
        }
        public void run(QisApp qisApp)
        {
            try
            {
                qisApp.executeSolution(new ConsoleIO());
            }
            catch (Exception e)
            {
                Console.WriteLine("Error: " + e.Message);
            }
        }
    }
}