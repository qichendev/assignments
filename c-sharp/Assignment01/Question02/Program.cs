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
        public int Weight { get; set; }
        public void ParseWeight(string input)
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
            Weight = value;
        }
    }

    class PotatoClassifier: QisApp
    {
        private string GetGrade(int weight)
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
        public void ExecuteSolution(RedirectedInput input, Action<string> submit)
        {
            Console.WriteLine("Enter the weight of the potato in grams: ");
            ExpectedPotatoData data = new ExpectedPotatoData();
            data.ParseWeight(input.Read());
            submit(GetGrade(data.Weight));
        }
    }

    class PotatoTestData : TestData
    {
        private Queue<string> streamedInput;
        private string testDescription;
        public override string ExpectedSubmission { get; set; }
        public override string ExpectedException { get; set; }
        public PotatoTestData(ExpectedPotatoData expectedData
            , string expectedSubmission
            , string expectedException)
        {
            streamedInput = new Queue<string>();
            streamedInput.Enqueue(expectedData.Weight.ToString());
            ExpectedSubmission = expectedSubmission;
            ExpectedException = expectedException;
            testDescription = " weight: " + expectedData.Weight;
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
            //new QisWorkBench().RunWithTestData(new PotatoClassifier(), new TestData[] {
            //    new PotatoTestData(new ExpectedPotatoData { Weight = 809 }, "Z", ""),
            //    new PotatoTestData(new ExpectedPotatoData { Weight = 454 }, "B", ""),
            //    new PotatoTestData(new ExpectedPotatoData { Weight = 240 }, "A", ""),
            //    new PotatoTestData(new ExpectedPotatoData { Weight = 0 }, "X", ""),
            //    new PotatoTestData(new ExpectedPotatoData { Weight = -1 }, "", "Invalid weight input: -1"),
            //    new PotatoTestData(new ExpectedPotatoData { Weight = int.MaxValue }, "Z", ""),
            //    new PotatoTestData(new ExpectedPotatoData { Weight = int.MinValue }, "", "Invalid weight input: -2147483648"),
            //    new PotatoTestData(new ExpectedPotatoData { Weight = 999999999 }, "Z", ""),
            //    new PotatoTestData(new ExpectedPotatoData { Weight = -999999999 }, "", "Invalid weight input: -999999999")
            //});
            new QisWorkBench().Run(new PotatoClassifier());
        }
    }
}
