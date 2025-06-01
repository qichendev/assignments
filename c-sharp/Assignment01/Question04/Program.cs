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
        public int storeNumber { get; set; }
        public int salesFigure { get; set; }
        public SalesFigure(int storeNumber)
        {
            this.storeNumber = storeNumber;
        }
        public bool parseSalesFigure(string input)
        {
            int value;
            if (!int.TryParse(input, out value) || value < 0)
            {
                throw new Exception("Invalid sales figure. Please enter a number greater than 0.");
            }
            salesFigure = value;
            return true;
        }
    }
    public class SalesFigureBarChart: QisApp
    {
        public void executeSolution(RedirectedIO io)
        {
            SalesFigure[] salesFigures = new SalesFigure[5];
            for (int i = 0; i < salesFigures.Length; i++)
            {
                salesFigures[i] = new SalesFigure(i + 1);
                Console.WriteLine("Enter today's sales for store " + (i + 1) + ": ");
                salesFigures[i].parseSalesFigure(io.readLine());
            }
            for (int i = 0; i < salesFigures.Length; i++)
            {
                Console.Write("Store " + (i + 1) + ": ");
                StringBuilder sb = new StringBuilder();
                for (int j = 0; j < salesFigures[i].salesFigure / 100; j++)
                {
                    sb.Append("*");
                }
                io.writeLine(sb.ToString());
            }
        }
    }
    public class SalesFigureBarChartTestData : TestData
    {
        public SalesFigureBarChartTestData(Queue<string> salesFigures
            , Queue<string> expectedSubmission
            , string expectedException) : base(salesFigures, expectedSubmission, expectedException){}
    }
    public class Program
    {
        public static void Main(string[] args)
        {
            new QisWorkBench().runWithTestData(new SalesFigureBarChart(), new TestData[] {
                new SalesFigureBarChartTestData(
                    new Queue<string>(new string[] { "1000", "2000", "3000", "1500", "2500" }),
                    new Queue<string>(new string[] { "**********", "********************", "******************************", "***************", "*************************" }), 
                    ""),
                
                new SalesFigureBarChartTestData(
                    new Queue<string>(new string[] { "0", "100", "3000", "2000", "1500" }),
                    new Queue<string>(new string[] { "", "*", "******************************", "********************", "***************" }), 
                    ""),
                
                new SalesFigureBarChartTestData(
                    new Queue<string>(new string[] { "99", "101", "2999", "2000", "2000" }),
                    new Queue<string>(new string[] { "", "*", "*****************************", "********************", "********************" }), 
                    ""),
                
                new SalesFigureBarChartTestData(
                    new Queue<string>(new string[] { "abc", "2000", "3000", "1500", "2500" }),
                    new Queue<string>(new string[] { "", "********************", "******************************", "***************", "*************************" }), 
                    "Invalid sales figure. Please enter a number greater than 0."),
                
                new SalesFigureBarChartTestData(
                    new Queue<string>(new string[] { "-100", "2000", "3000", "1500", "2500" }),
                    new Queue<string>(new string[] { "", "********************", "******************************", "***************", "*************************" }), 
                    "Invalid sales figure. Please enter a number greater than 0.")
            });
        }
    }
}
