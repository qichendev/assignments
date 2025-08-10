using System;
using System.Collections.Generic;
using System.Linq;

namespace Assign04_W24
{
    internal class Program
    {
        // Entry point of the application
        static void Main(string[] args)
        {
            DealershipService service = new DealershipService(); // Instantiate DealershipService class

            while (true)
            {
                Console.WriteLine("\nWelcome to the Car Dealership Console Application");
                Console.WriteLine("1. Add Vehicle");
                Console.WriteLine("2. List Available Vehicles");
                Console.WriteLine("3. Search Vehicles");
                Console.WriteLine("4. Manage Sales");
                Console.WriteLine("5. Exit");
                Console.WriteLine("Please enter your choice:");

                if (!int.TryParse(Console.ReadLine(), out int choice))
                {
                    Console.WriteLine("Invalid input. Please enter a number.");
                    continue;
                }

                switch (choice)
                {
                    case 1:
                        AddVehicle(service);
                        break;
                    case 2:
                        service.ListAvailableVehicles();
                        break;
                    case 3:
                        SearchVehicles(service);
                        break;
                    case 4:
                        service.ManageSales();
                        break;
                    case 5:
                        Console.WriteLine("Exiting the program. Be excellent to each other.");
                        return;
                    default:
                        Console.WriteLine("Strange things are afoot at the Circle K. Please select a valid option.");
                        break;
                }
            }
        }

        // Method to add a new vehicle to the inventory
        static void AddVehicle(DealershipService service)
        {
            Console.WriteLine("Adding a new vehicle...");

            Console.Write("Enter vehicle type (car/truck/suv): ");
            string vehicleType = Console.ReadLine()?.ToLower();

            if (vehicleType != "car" && vehicleType != "truck" && vehicleType != "suv")
            {
                Console.WriteLine("Invalid vehicle type. Please enter Car, Truck, or SUV.");
                return;
            }

            string make = ReadString("Enter Make: ");
            string model = ReadString("Enter Model: ");
            int year = ReadInt($"Enter Year ({1900}-{DateTime.Now.Year + 1}): ", 1900, DateTime.Now.Year + 1);
            decimal price = ReadDecimal("Enter Price: ", 0, 2000000);

            switch (vehicleType)
            {
                case "car":
                    int numberOfDoors = ReadInt("Enter Number of Doors (2-5): ", 2, 5);
                    service.AddVehicle(new Car(make, model, year, price, numberOfDoors));
                    break;
                case "truck":
                    int payloadCapacity = ReadInt("Enter Payload Capacity in lbs (500-20000): ", 500, 20000);
                    service.AddVehicle(new Truck(make, model, year, price, payloadCapacity));
                    break;
                case "suv":
                    int seatingCapacity = ReadInt("Enter Seating Capacity (2-9): ", 2, 9);
                    service.AddVehicle(new SUV(make, model, year, price, seatingCapacity));
                    break;
            }
        }

        // Method to search for vehicles based on criteria
        static void SearchVehicles(DealershipService service)
        {
            Console.WriteLine("Search for vehicles...");
            Console.WriteLine("1. Search by Make, Model, or Year");
            Console.WriteLine("2. Search by Price Range");
            Console.WriteLine("Please enter your choice:");

            if (!int.TryParse(Console.ReadLine(), out int choice))
            {
                Console.WriteLine("Invalid input. Please enter a number.");
                return;
            }

            switch (choice)
            {
                case 1:
                    string criteria = ReadString("Enter search criteria (Make, Model, or Year): ");
                    service.SearchVehicles(criteria);
                    break;
                case 2:
                    decimal minPrice = ReadDecimal("Enter minimum price: ", 0, 2000000);
                    decimal maxPrice = ReadDecimal($"Enter maximum price: ", minPrice, 2000000);
                    service.SearchVehicles(minPrice, maxPrice);
                    break;
                default:
                    Console.WriteLine("Invalid choice. Returning to main menu.");
                    break;
            }
        }

        // Helper methods for reading and validating user input
        private static string ReadString(string prompt)
        {
            string value;
            do
            {
                Console.Write(prompt);
                value = Console.ReadLine();
                if (string.IsNullOrWhiteSpace(value))
                {
                    Console.WriteLine("Input cannot be empty. Please try again.");
                }
            } while (string.IsNullOrWhiteSpace(value));
            return value;
        }

        // Helper method to read and validate integer input within a specified range
        private static int ReadInt(string prompt, int min, int max)
        {
            int value;
            while (true)
            {
                Console.Write(prompt);
                if (int.TryParse(Console.ReadLine(), out value) && value >= min && value <= max)
                {
                    return value;
                }
                Console.WriteLine($"Invalid input. Please enter a whole number between {min} and {max}.");
            }
        }

        // Helper method to read and validate decimal input within a specified range
        private static decimal ReadDecimal(string prompt, decimal min, decimal max)
        {
            decimal value;
            while (true)
            {
                Console.Write(prompt);
                if (decimal.TryParse(Console.ReadLine(), out value) && value >= min && value <= max)
                {
                    return value;
                }
                Console.WriteLine($"Invalid input. Please enter a number between {min} and {max}.");
            }
        }
    }

    // Vehicle base class and derived
    public abstract class Vehicle
    {
        public string Make { get; set; }
        public string Model { get; set; }
        public int Year { get; set; }
        public decimal Price { get; set; }

        protected Vehicle(string make, string model, int year, decimal price)
        {
            Make = make;
            Model = model;
            Year = year;
            Price = price;
        }

        public abstract void DisplayInfo();
    }

    // Derived classes for different vehicle types
    public class Car : Vehicle
    {
        public int NumberOfDoors { get; set; }
        public Car(string make, string model, int year, decimal price, int numberOfDoors)
            : base(make, model, year, price)
        {
            NumberOfDoors = numberOfDoors;
        }
        public override void DisplayInfo()
        {
            Console.WriteLine($"Car: {Make} {Model} ({Year}) - ${Price:C}, Doors: {NumberOfDoors}");
        }
    }

    // Derived class for Truck
    public class Truck : Vehicle
    {
        public int PayloadCapacity { get; set; }
        public Truck(string make, string model, int year, decimal price, int payloadCapacity)
            : base(make, model, year, price)
        {
            PayloadCapacity = payloadCapacity;
        }
        public override void DisplayInfo()
        {
            Console.WriteLine($"Truck: {Make} {Model} ({Year}) - ${Price:C}, Payload Capacity: {PayloadCapacity} lbs");
        }
    }

    // Derived class for SUV
    public class SUV : Vehicle
    {
        public int SeatingCapacity { get; set; }
        public SUV(string make, string model, int year, decimal price, int seatingCapacity)
            : base(make, model, year, price)
        {
            SeatingCapacity = seatingCapacity;
        }
        public override void DisplayInfo()
        {
            Console.WriteLine($"SUV: {Make} {Model} ({Year}) - ${Price:C}, Seating Capacity: {SeatingCapacity}");
        }
    }

    // Service class to manage dealership operations
    public class DealershipService
    {
        private List<Vehicle> Inventory { get; set; }

        public DealershipService()
        {
            Inventory = new List<Vehicle>();
        }

        public void AddVehicle(Vehicle vehicle)
        {
            Inventory.Add(vehicle);
            Console.WriteLine("Vehicle added to inventory successfully.");
        }

        // Method to list all available vehicles
        public void ListAvailableVehicles()
        {
            if (Inventory.Count == 0)
            {
                Console.WriteLine("No vehicles available in the inventory.");
                return;
            }
            Console.WriteLine("Available Vehicles:");
            foreach (var vehicle in Inventory)
            {
                vehicle.DisplayInfo();
            }
        }

        // Method to search vehicles by make, model, or year
        public void SearchVehicles(string criteria)
        {
            if (Inventory.Count == 0)
            {
                Console.WriteLine("No vehicles available in the inventory.");
                return;
            }

            var matchingVehicles = Inventory.Where(v =>
                v.Make.IndexOf(criteria, StringComparison.OrdinalIgnoreCase) >= 0 ||
                v.Model.IndexOf(criteria, StringComparison.OrdinalIgnoreCase) >= 0 ||
                v.Year.ToString().Contains(criteria)).ToList();

            DisplaySearchResults(matchingVehicles);
        }

        // Overloaded method to search vehicles by price range
        public void SearchVehicles(decimal minPrice, decimal maxPrice)
        {
            if (Inventory.Count == 0)
            {
                Console.WriteLine("No vehicles available in the inventory.");
                return;
            }

            var matchingVehicles = Inventory.Where(v => v.Price >= minPrice && v.Price <= maxPrice).ToList();
            DisplaySearchResults(matchingVehicles);
        }

        // Helper method to display search results
        private void DisplaySearchResults(List<Vehicle> vehicles)
        {
            if (vehicles.Count == 0)
            {
                Console.WriteLine("No vehicles found matching the search criteria.");
            }
            else
            {
                Console.WriteLine("Search Results:");
                foreach (var vehicle in vehicles)
                {
                    vehicle.DisplayInfo();
                }
            }
        }

        // Method to manage sales of vehicles
        public void ManageSales()
        {
            if (Inventory.Count == 0)
            {
                Console.WriteLine("No vehicles available in the inventory to sell.");
                return;
            }

            Console.WriteLine("Available Vehicles for Sale:");
            for (int i = 0; i < Inventory.Count; i++)
            {
                Console.WriteLine($"{i + 1}. {Inventory[i].Make} {Inventory[i].Model} ({Inventory[i].Year}) - ${Inventory[i].Price:C}");
            }

            Console.WriteLine("Select a vehicle to sell (enter the corresponding number):");
            if (!int.TryParse(Console.ReadLine(), out int selectedIndex) || selectedIndex < 1 || selectedIndex > Inventory.Count)
            {
                Console.WriteLine("Invalid selection. Please enter a valid number.");
                return;
            }

            Vehicle selectedVehicle = Inventory[selectedIndex - 1];

            Console.WriteLine("Selected Vehicle:");
            selectedVehicle.DisplayInfo();

            Console.Write("Enter buyer's name: ");
            string buyerName = Console.ReadLine();
            Console.Write("Enter buyer's email: ");
            string buyerEmail = Console.ReadLine();

            Console.WriteLine("Confirm sale of the selected vehicle? (Y/N)");
            string confirmation = Console.ReadLine();
            if (confirmation?.ToUpper() == "Y")
            {
                Inventory.Remove(selectedVehicle);
                Console.WriteLine("Sale completed successfully. Vehicle removed from inventory.");
            }
            else
            {
                Console.WriteLine("Sale canceled. Vehicle remains in inventory.");
            }
        }
    }
}
