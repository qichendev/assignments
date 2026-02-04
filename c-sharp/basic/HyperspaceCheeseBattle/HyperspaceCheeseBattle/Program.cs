using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HyperspaceCheeseBattle
{
    enum Direction
    {
        Up,
        Down,
        Left,
        Right
    }

    struct BoardSquare
    {
        public Direction Dir;
        public bool IsCheese;
    }

    struct Player
    {
        public string Name;
        public int X;
        public int Y;
    }

    internal class Program
    {
        static bool gameOver = false;
        static Random diceRandom = new Random();

        static BoardSquare[,] board = new BoardSquare[8,8]
        {
            { new BoardSquare{Dir=Direction.Down, IsCheese=false}, new BoardSquare{Dir=Direction.Right, IsCheese=false}, new BoardSquare{Dir=Direction.Right, IsCheese=false}, new BoardSquare{Dir=Direction.Right, IsCheese=false}, new BoardSquare{Dir=Direction.Right, IsCheese=false}, new BoardSquare{Dir=Direction.Right, IsCheese=false}, new BoardSquare{Dir=Direction.Right, IsCheese=false}, new BoardSquare{Dir=Direction.Down, IsCheese=false} },
            { new BoardSquare{Dir=Direction.Up, IsCheese=false}, new BoardSquare{Dir=Direction.Up, IsCheese=false}, new BoardSquare{Dir=Direction.Right, IsCheese=false}, new BoardSquare{Dir=Direction.Down, IsCheese=true}, new BoardSquare{Dir=Direction.Right, IsCheese=false}, new BoardSquare{Dir=Direction.Right, IsCheese=false}, new BoardSquare{Dir=Direction.Down, IsCheese=false}, new BoardSquare{Dir=Direction.Left, IsCheese=false} },
            { new BoardSquare{Dir=Direction.Right, IsCheese=false}, new BoardSquare{Dir=Direction.Right, IsCheese=false}, new BoardSquare{Dir=Direction.Up, IsCheese=false}, new BoardSquare{Dir=Direction.Left, IsCheese=false}, new BoardSquare{Dir=Direction.Up, IsCheese=false}, new BoardSquare{Dir=Direction.Up, IsCheese=false}, new BoardSquare{Dir=Direction.Left, IsCheese=false}, new BoardSquare{Dir=Direction.Left, IsCheese=false} },
            { new BoardSquare{Dir=Direction.Right, IsCheese=true}, new BoardSquare{Dir=Direction.Right, IsCheese=false}, new BoardSquare{Dir=Direction.Up, IsCheese=false}, new BoardSquare{Dir=Direction.Left, IsCheese=false}, new BoardSquare{Dir=Direction.Up, IsCheese=false}, new BoardSquare{Dir=Direction.Up, IsCheese=false}, new BoardSquare{Dir=Direction.Left, IsCheese=false}, new BoardSquare{Dir=Direction.Left, IsCheese=false} },
            { new BoardSquare{Dir=Direction.Right, IsCheese=false}, new BoardSquare{Dir=Direction.Right, IsCheese=false}, new BoardSquare{Dir=Direction.Up, IsCheese=false}, new BoardSquare{Dir=Direction.Left, IsCheese=false}, new BoardSquare{Dir=Direction.Up, IsCheese=false}, new BoardSquare{Dir=Direction.Up, IsCheese=false}, new BoardSquare{Dir=Direction.Left, IsCheese=true}, new BoardSquare{Dir=Direction.Left, IsCheese=false} },
            { new BoardSquare{Dir=Direction.Right, IsCheese=false}, new BoardSquare{Dir=Direction.Right, IsCheese=false}, new BoardSquare{Dir=Direction.Up, IsCheese=false}, new BoardSquare{Dir=Direction.Left, IsCheese=true}, new BoardSquare{Dir=Direction.Up, IsCheese=false}, new BoardSquare{Dir=Direction.Up, IsCheese=false}, new BoardSquare{Dir=Direction.Left, IsCheese=false}, new BoardSquare{Dir=Direction.Left, IsCheese=false} },
            { new BoardSquare{Dir=Direction.Right, IsCheese=false}, new BoardSquare{Dir=Direction.Right, IsCheese=false}, new BoardSquare{Dir=Direction.Up, IsCheese=false}, new BoardSquare{Dir=Direction.Left, IsCheese=false}, new BoardSquare{Dir=Direction.Up, IsCheese=false}, new BoardSquare{Dir=Direction.Left, IsCheese=false}, new BoardSquare{Dir=Direction.Left, IsCheese=false}, new BoardSquare{Dir=Direction.Left, IsCheese=false} },
            { new BoardSquare{Dir=Direction.Right, IsCheese=false}, new BoardSquare{Dir=Direction.Right, IsCheese=false}, new BoardSquare{Dir=Direction.Right, IsCheese=false}, new BoardSquare{Dir=Direction.Right, IsCheese=false}, new BoardSquare{Dir=Direction.Right, IsCheese=false}, new BoardSquare{Dir=Direction.Right, IsCheese=false}, new BoardSquare{Dir=Direction.Right, IsCheese=false}, new BoardSquare{Dir=Direction.Right, IsCheese=false} },
        };

        static Player[] players;

        // Generate random dice roll
        static int DiceThrow()
        {
            return diceRandom.Next(1, 7);
        }

        // Check if rocket in square
        static bool RocketInSquare(int X, int Y)
        {
            for (int i = 0; i < players.Length; i++)
            {
                if (players[i].X == X && players[i].Y == Y)
                {
                    return true;
                }
            }
            return false;
        }

        // Check if cheese power square
        static bool CheesePowerSquare(int x, int y)
        {
            if (x < 0 || x > 7 || y < 0 || y > 7)
                return false;
            return board[y, x].IsCheese;
        }

        // Display player status
        static void ShowStatus()
        {
            Console.WriteLine($"There are {players.Length} players in the game");
            
            for (int i = 0; i < players.Length; i++)
            {
                if (players[i].X == -1 && players[i].Y == 7)
                {
                    Console.WriteLine($"{players[i].Name} is at the starting position (off board)");
                }
                else
                {
                    Console.WriteLine($"{players[i].Name} is on square ({players[i].X},{players[i].Y})");
                }
            }
            Console.WriteLine();
        }

        // Handle cheese power actions
        static void HandleCheesePower(int playerNo)
        {
            Console.WriteLine($"\n{players[playerNo].Name} has landed on a Cheese Power square!");
            Console.WriteLine("Choose your action:");
            Console.WriteLine("1. Fire Cheese Deathray at another player");
            Console.WriteLine("2. Use Cheese Power for an extra dice throw");
            
            Console.Write("Enter your choice (1 or 2): ");
            string choice = Console.ReadLine();
            
            if (choice == "1")
            {
                Console.WriteLine("\nAvailable targets:");
                for (int i = 0; i < players.Length; i++)
                {
                    if (i != playerNo && players[i].X != -1)
                    {
                        Console.WriteLine($"{i + 1}. {players[i].Name} at ({players[i].X},{players[i].Y})");
                    }
                }
                
                Console.Write("Enter target player number: ");
                if (int.TryParse(Console.ReadLine(), out int targetPlayer) && 
                    targetPlayer > 0 && targetPlayer <= players.Length && 
                    targetPlayer - 1 != playerNo && players[targetPlayer - 1].X != -1)
                {
                    targetPlayer--;
                    
                    Console.WriteLine($"\n{players[targetPlayer].Name}'s engines have exploded!");
                    Console.WriteLine("Choose a position on the bottom row (0-7):");
                    
                    bool validPosition = false;
                    while (!validPosition)
                    {
                        Console.Write("Enter X position (0-7): ");
                        if (int.TryParse(Console.ReadLine(), out int newX) && newX >= 0 && newX <= 7)
                        {
                            if (!RocketInSquare(newX, 7))
                            {
                                players[targetPlayer].X = newX;
                                players[targetPlayer].Y = 7;
                                Console.WriteLine($"{players[targetPlayer].Name} has been sent to ({newX},7)");
                                validPosition = true;
                            }
                            else
                            {
                                Console.WriteLine("That position is occupied. Choose another position.");
                            }
                        }
                        else
                        {
                            Console.WriteLine("Invalid position. Please enter a number between 0 and 7.");
                        }
                    }
                }
                else
                {
                    Console.WriteLine("Invalid target. Cheese Power wasted.");
                }
            }
            else if (choice == "2")
            {
                Console.WriteLine($"\n{players[playerNo].Name} gets an extra dice throw!");
                int extraDice = DiceThrow();
                Console.WriteLine($"Extra dice roll: {extraDice}");
                
                Direction direction = board[players[playerNo].Y, players[playerNo].X].Dir;
                int newX = players[playerNo].X;
                int newY = players[playerNo].Y;
                
                switch (direction)
                {
                    case Direction.Up:
                        newY += extraDice;
                        break;
                    case Direction.Down:
                        newY -= extraDice;
                        break;
                    case Direction.Left:
                        newX -= extraDice;
                        break;
                    case Direction.Right:
                        newX += extraDice;
                        break;
                }
                
                if (newX >= 0 && newX <= 7 && newY >= 0 && newY <= 7 && !RocketInSquare(newX, newY))
                {
                    players[playerNo].X = newX;
                    players[playerNo].Y = newY;
                    Console.WriteLine($"{players[playerNo].Name} extra move to ({newX},{newY})");
                }
                else
                {
                    Console.WriteLine($"{players[playerNo].Name} cannot make extra move. Staying at current position.");
                }
            }
            else
            {
                Console.WriteLine("Invalid choice. Cheese Power wasted.");
            }
        }

        // Execute single player turn
        private static void PlayerTurn(int playerNo)
        {
            int diceRoll = DiceThrow();
            Console.WriteLine($"{players[playerNo].Name} rolls a {diceRoll}");
            
            int currentX = players[playerNo].X;
            int currentY = players[playerNo].Y;
            
            if (currentX == -1 && currentY == 7)
            {
                players[playerNo].X = 0;
                players[playerNo].Y = 7;
                currentX = 0;
                currentY = 7;
            }
            
            Direction direction = board[currentY, currentX].Dir;
            
            int newX = currentX;
            int newY = currentY;
            
            switch (direction)
            {
                case Direction.Up:
                    newY += diceRoll;
                    break;
                case Direction.Down:
                    newY -= diceRoll;
                    break;
                case Direction.Left:
                    newX -= diceRoll;
                    break;
                case Direction.Right:
                    newX += diceRoll;
                    break;
            }
            
            if (newX < 0 || newX > 7 || newY < 0 || newY > 7)
            {
                Console.WriteLine($"Player {players[playerNo].Name} cannot move off the board. Staying at ({currentX},{currentY})");
                return;
            }
            
            while (RocketInSquare(newX, newY))
            {
                Direction collisionDirection = board[newY, newX].Dir;
                
                switch (collisionDirection)
                {
                    case Direction.Up:
                        newY += 1;
                        break;
                    case Direction.Down:
                        newY -= 1;
                        break;
                    case Direction.Left:
                        newX -= 1;
                        break;
                    case Direction.Right:
                        newX += 1;
                        break;
                }
                
                if (newX < 0 || newX > 7 || newY < 0 || newY > 7)
                {
                    Console.WriteLine($"Player {players[playerNo].Name} cannot find an empty square. Staying at ({currentX},{currentY})");
                    return;
                }
            }
            
            players[playerNo].X = newX;
            players[playerNo].Y = newY;
            
            Console.WriteLine($"Player {players[playerNo].Name} moved to ({newX},{newY})");
            
            if (CheesePowerSquare(newX, newY))
            {
                HandleCheesePower(playerNo);
            }
            
            if (newX == 7 && newY == 0)
            {
                Console.WriteLine($"\n🎉 {players[playerNo].Name} has reached the finish! 🎉");
                Console.WriteLine($"{players[playerNo].Name} wins the Hyperspace Cheese Battle!");
                gameOver = true;
            }
        }

        // Execute all player turns
        static void MakeMoves()
        {
            for (int i = 0; i < players.Length; i++)
            {
                if (gameOver) break;
                
                Console.WriteLine($"\n--- {players[i].Name}'s turn ---");
                PlayerTurn(i);
                
                if (gameOver) break;
            }
        }

        // Initialize new game
        static void ResetGame()
        {
            Console.WriteLine("=== Hyperspace Cheese Battle ===");
            Console.Write("Enter number of players (2-4): ");
            int numPlayers = int.Parse(Console.ReadLine());
            
            if (numPlayers < 2 || numPlayers > 4)
            {
                Console.WriteLine("Invalid number of players. Using 2 players.");
                numPlayers = 2;
            }
            
            players = new Player[numPlayers];
            gameOver = false;
            
            for (int i = 0; i < numPlayers; i++)
            {
                Console.Write($"Enter name for Player {i + 1}: ");
                players[i].Name = Console.ReadLine();
                players[i].X = -1;
                players[i].Y = 7;
            }
            
            Console.WriteLine("Game initialized!");
        }
        
        // Main entry point
        public static void Main(string[] args)
        {
            Run(args);
        }
        
        // Main game loop
        public static void Run(string[] args)
        {
            ResetGame();
            
            while (!gameOver)
            {
                ShowStatus();
                MakeMoves();
                
                if (!gameOver)
                {
                    Console.Write("\nPress return for next round...");
                    Console.ReadLine();
                }
            }
            
            Console.WriteLine("\nGame over!");
            ShowStatus();
        }
    }
}