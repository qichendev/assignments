using System;
using System.Collections.Generic;
namespace QisUtils
{
    public interface DataSource
    {
        string readLine();
    }
    public class RedirectedInput
    {
        private DataSource dataSource;
        public RedirectedInput(DataSource dataSource)
        {
            this.dataSource = dataSource;
        }
        public string read()
        {
            return dataSource.readLine();
        }
    }
    public interface QisApp
    {
        void executeSolution(RedirectedInput redirectedInput, Action<string> submit);
    }
    public abstract class TestData : DataSource
    {
        public abstract Queue<string> getStreamedInput();
        public string readLine()
        {
            return getStreamedInput().Dequeue();
        }
        public abstract string getTestDescription();
        public string expectedSubmission { get; set; }
        public string expectedException { get; set; }
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
                    var redirectedInput = new RedirectedInput(test);
                    qisApp.executeSolution(redirectedInput
                        , submission => displayTestResult("Test No." + (i + 1) + ": " + test.getTestDescription()
                            + " submission: " + submission, submission == test.expectedSubmission));
                }
                catch (Exception e)
                {
                    displayTestResult("Test No." + (i + 1) + ": " + test.getTestDescription()
                        + " exception: " + e.Message, e.Message == test.expectedException);
                }
            }
        }
        private class ConsoleInput : DataSource
        {
            public string readLine()
            {
                var ret = Console.ReadLine();
                if (ret != null)
                {
                    return ret.Trim();
                }
                else
                {
                    throw new Exception("Input cannot be empty");
                }
            }
        }
        public void run(QisApp qisApp)
        {
            try
            {
                qisApp.executeSolution(new RedirectedInput(new ConsoleInput()), Console.WriteLine);
            }
            catch (Exception e)
            {
                Console.WriteLine("Error: " + e.Message);
            }
        }
    }
}