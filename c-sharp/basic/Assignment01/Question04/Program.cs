using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using QisUtils;

namespace Question04
{
    public class SalesFigure
    {
        public int StoreNumber { get; set; }
        public int Amount { get; set; }
        public SalesFigure(int storeNumber)
        {
            this.StoreNumber = storeNumber;
        }
        public bool ParseSalesFigure(string input)
        {
            int value;
            if (!int.TryParse(input, out value) || value < 0)
            {
                throw new Exception("Invalid sales figure. Please enter a number greater than 0.");
            }
            Amount = value;
            return true;
        }
    }
    public class SalesFigureBarChart: QisApp
    {
        public void ExecuteSolution(RedirectedIO io)
        {
            SalesFigure[] salesFigures = new SalesFigure[5];
            for (int i = 0; i < salesFigures.Length; i++)
            {
                salesFigures[i] = new SalesFigure(i + 1);
                Console.WriteLine("Enter today's sales for store " + (i + 1) + ": ");
                salesFigures[i].ParseSalesFigure(io.ReadLine());
            }
            for (int i = 0; i < salesFigures.Length; i++)
            {
                Console.Write("Store " + (i + 1) + ": ");
                StringBuilder sb = new StringBuilder();
                for (int j = 0; j < salesFigures[i].Amount / 100; j++)
                {
                    sb.Append("*");
                }
                io.WriteLine(sb.ToString());
            }
        }
    }
    public class SalesFigureBarChartTestData : TestData
    {
        public SalesFigureBarChartTestData(Queue<string> salesFigures
            , Queue<string> expectedSubmission
            , string expectedException) : base(expectedException)
        {
            foreach (var figure in salesFigures)
            {
                GetStreamedInput().Enqueue(figure);
                TestDescription += figure + ", ";
            }
            foreach (string output in expectedSubmission)
            {
                ExpectedSubmission.Enqueue(output);
            }
        }

        public override string GetTestDescription()
        {
            return TestDescription;
        }
    }
    public class Program
    {
        public static void Main(string[] args)
        {
            //new QisWorkBench().RunWithTestData(new SalesFigureBarChart(), new TestData[] {
            //    new SalesFigureBarChartTestData(
            //        new Queue<string>(new string[] { "1000", "2000", "3000", "1500", "2500" }),
            //        new Queue<string>(new string[] { "**********", "********************", "******************************", "***************", "*************************" }), 
            //        ""),

            //    new SalesFigureBarChartTestData(
            //        new Queue<string>(new string[] { "0", "100", "3000", "2000", "1500" }),
            //        new Queue<string>(new string[] { "", "*", "******************************", "********************", "***************" }), 
            //        ""),

            //    new SalesFigureBarChartTestData(
            //        new Queue<string>(new string[] { "99", "101", "2999", "2000", "2000" }),
            //        new Queue<string>(new string[] { "", "*", "*****************************", "********************", "********************" }), 
            //        ""),

            //    new SalesFigureBarChartTestData(
            //        new Queue<string>(new string[] { "abc", "2000", "3000", "1500", "2500" }),
            //        new Queue<string>(new string[] { "", "********************", "******************************", "***************", "*************************" }), 
            //        "Invalid sales figure. Please enter a number greater than 0."),

            //    new SalesFigureBarChartTestData(
            //        new Queue<string>(new string[] { "-100", "2000", "3000", "1500", "2500" }),
            //        new Queue<string>(new string[] { "", "********************", "******************************", "***************", "*************************" }), 
            //        "Invalid sales figure. Please enter a number greater than 0.")
            //});
            new QisWorkBench().Run(new SalesFigureBarChart());
        }
    }
}
