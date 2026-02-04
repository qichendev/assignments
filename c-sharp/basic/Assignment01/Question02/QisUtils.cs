using System;
using System.Collections.Generic;
namespace QisUtils
{
    public interface DataSource
    {
        string ReadLine();
    }
    public class RedirectedInput
    {
        private DataSource dataSource;
        public RedirectedInput(DataSource dataSource)
        {
            this.dataSource = dataSource;
        }
        public string Read()
        {
            return dataSource.ReadLine();
        }
    }
    public interface QisApp
    {
        void ExecuteSolution(RedirectedInput redirectedInput, Action<string> submit);
    }
    public abstract class TestData : DataSource
    {
        public abstract Queue<string> GetStreamedInput();
        public string ReadLine()
        {
            return GetStreamedInput().Dequeue();
        }
        public abstract string GetTestDescription();
        public virtual string ExpectedSubmission { get; set; }
        public virtual string ExpectedException { get; set; }
    };
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
                    var redirectedInput = new RedirectedInput(test);
                    qisApp.ExecuteSolution(redirectedInput
                        , submission => {
                            bool isPassed = string.IsNullOrEmpty(test.ExpectedSubmission) ? 
                                string.IsNullOrEmpty(submission) : 
                                submission == test.ExpectedSubmission;
                            DisplayTestResult("Test No." + (i + 1) + ": " + test.GetTestDescription()
                                + " submission: " + submission, isPassed);
                        });
                }
                catch (Exception e)
                {
                    bool isPassed = string.IsNullOrEmpty(test.ExpectedException) ? 
                        string.IsNullOrEmpty(e.Message) : 
                        e.Message == test.ExpectedException;
                    DisplayTestResult("Test No." + (i + 1) + ": " + test.GetTestDescription()
                        + " exception: " + e.Message, isPassed);
                }
            }
        }
        private class ConsoleInput : DataSource
        {
            public string ReadLine()
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
        public void Run(QisApp qisApp)
        {
            try
            {
                qisApp.ExecuteSolution(new RedirectedInput(new ConsoleInput()), Console.WriteLine);
            }
            catch (Exception e)
            {
                Console.WriteLine("Error: " + e.Message);
            }
        }
    }
}