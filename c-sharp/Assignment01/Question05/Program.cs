using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Question05
{
    public class RoShamBoEngine
    {
        public static void Main(string[] args)
        {
            string[] choices = { "rock", "paper", "scissors" };
            Random random = new Random();
            int computerChoice = random.Next(choices.Length);
            Console.WriteLine("Rock, Paper, Scissors!");
            Console.WriteLine("Enter your choice: ");
            string userChoice = Console.ReadLine();
            Console.WriteLine("Computer chose: " + choices[computerChoice]);
            if (userChoice.ToLower() == choices[computerChoice])
            {
                Console.WriteLine("It's a draw!");
            }
            else if (userChoice.ToLower() == "rock" && choices[computerChoice] == "scissors")
            {
                Console.WriteLine("You win!");
            }
            else if (userChoice.ToLower() == "paper" && choices[computerChoice] == "rock")
            {
                Console.WriteLine("You win!");
            }
            else if (userChoice.ToLower() == "scissors" && choices[computerChoice] == "paper")
            {
                Console.WriteLine("You win!");
            }
            else
            {
                Console.WriteLine("You lose!");
            }
        }
    }
}
