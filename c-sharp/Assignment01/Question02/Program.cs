using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using QisUtils;

namespace Question02
{
    class ExpectedPotatoData
    {
        public int weight { get; set; }
        public void parseWeight(string input)
        {
            int value;
            if (!Int32.TryParse(input, out value))
            {
                throw new Exception("Invalid weight input: " + input);
            }
            if (value < 0)
            {
                throw new Exception("Invalid weight input: " + value);
            }
            weight = value;
        }
    }

    class PotatoClassifier: QisApp
    {
        private string getGrade(int weight)
        {
            if (weight >= 809)
                return "Z";
            else if (weight >= 454)
                return "B";
            else if (weight >= 240)
                return "A";
            else
                return "X";
        }
        public void executeSolution(RedirectedInput input, Action<string> submit)
        {
            Console.WriteLine("Enter the weight of the potato in grams: ");
            ExpectedPotatoData data = new ExpectedPotatoData();
            data.parseWeight(input.read());
            submit(getGrade(data.weight));
        }
    }

    class PotatoTestData : TestData
    {
        private Queue<string> streamedInput;
        private string testDescription;
        public PotatoTestData(ExpectedPotatoData expectedData
            , string expectedSubmission
            , string expectedException)
        {
            streamedInput = new Queue<string>();
            streamedInput.Enqueue(expectedData.weight.ToString());
            this.expectedSubmission = expectedSubmission;
            this.expectedException = expectedException;
            testDescription = " weight: " + expectedData.weight;
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
            new QisWorkBench().runWithTestData(new PotatoClassifier(), new TestData[] {
                new PotatoTestData(new ExpectedPotatoData { weight = 809 }, "Z", ""),
                new PotatoTestData(new ExpectedPotatoData { weight = 454 }, "B", ""),
                new PotatoTestData(new ExpectedPotatoData { weight = 240 }, "A", ""),
                new PotatoTestData(new ExpectedPotatoData { weight = 0 }, "X", ""),
                new PotatoTestData(new ExpectedPotatoData { weight = -1 }, "", "Invalid weight input: -1"),
                new PotatoTestData(new ExpectedPotatoData { weight = int.MaxValue }, "Z", ""),
                new PotatoTestData(new ExpectedPotatoData { weight = int.MinValue }, "", "Invalid weight input: -2147483648"),
                new PotatoTestData(new ExpectedPotatoData { weight = 999999999 }, "Z", ""),
                new PotatoTestData(new ExpectedPotatoData { weight = -999999999 }, "", "Invalid weight input: -999999999")
            });
        }
    }
}
