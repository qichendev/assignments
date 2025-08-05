using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assign04_W24
{
    internal class Program
    {
        static void Main(string[] args)
        {
            DealershipService service = new DealershipService(); // Instantiate DealershipService class

            while (true)
            {
                Console.WriteLine("Welcome to the Car Dealership Console Application");
                Console.WriteLine("1. Add Vehicle");
                Console.WriteLine("2. List Available Vehicles");
                Console.WriteLine("3. Search Vehicles");
                Console.WriteLine("4. Manage Sales");
                Console.WriteLine("5. Exit");
                Console.WriteLine("Please enter your choice:");

                int choice;
                if (!int.TryParse(Console.ReadLine(), out choice))
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

        static void AddVehicle(DealershipService service)
        {
            // Implement logic to add a vehicle to the inventory
            Console.WriteLine("Adding a new vehicle...");
            Console.Write("Enter vehicle type (car/truck/suv): ");
            string vehicleType = Console.ReadLine();
            switch (vehicleType.ToLower())
            {
                case "car":
                    Console.WriteLine("Enter Make: ");
                    string make = Console.ReadLine();
                    Console.WriteLine("Enter Model: ");
                    string model = Console.ReadLine();
                    Console.WriteLine("Enter Year: ");
                    int year = int.Parse(Console.ReadLine());
                    Console.WriteLine("Enter Price: ");
                    decimal price = decimal.Parse(Console.ReadLine());
                    Console.WriteLine("Enter Number of Doors: ");
                    int numberOfDoors = int.Parse(Console.ReadLine());
                    Car car = new Car(make, model, year, price, numberOfDoors);
                    service.AddVehicle(car);
                    break;
                case "truck":
                    Console.WriteLine("Enter Make: ");
                    string make = Console.ReadLine();
                    Console.WriteLine("Enter Model: ");
                    string model = Console.ReadLine();
                    Console.WriteLine("Enter Year: ");
                    int year = int.Parse(Console.ReadLine());
                    Console.WriteLine("Enter Price: ");
                    decimal price = decimal.Parse(Console.ReadLine());
                    Console.WriteLine("Enter Payload Capacity: ");
                    int payloadCapacity = int.Parse(Console.ReadLine());
                    Truck truck = new Truck(make, model, year, price, payloadCapacity);
                    service.AddVehicle(truck);
                    break;
                case "suv":
                    Console.WriteLine("Enter Make: ");
                    string make = Console.ReadLine();
                    Console.WriteLine("Enter Model: ");
                    string model = Console.ReadLine();
                    Console.WriteLine("Enter Year: ");
                    int year = int.Parse(Console.ReadLine());
                    Console.WriteLine("Enter Price: ");
                    int seatingCapacity = int.Parse(Console.ReadLine());
                    SUV suv = new SUV(make, model, year, price, seatingCapacity);
                    service.AddVehicle(suv);
                    break;
                default:
                    Console.WriteLine("Invalid vehicle type. Please enter Car, Truck, or SUV.");
                    break;
            }
        }

        static void SearchVehicles(DealershipService service)
        {
            // Implement logic to search for vehicles
            Console.WriteLine("Searching for vehicles...");
            Console.WriteLine("Enter search criteria: ");
            string criteria = Console.ReadLine();
            service.SearchVehicles(criteria);
        }

    }

    public abstract class Vehicle
    {
        // Properties
        public string Make { get; set; }
        public string Model { get; set; }
        public int Year { get; set; }
        public decimal Price { get; set; }

        // Constructor
        public Vehicle(string make, string model, int year, decimal price)
        {
            Make = make;
            Model = model;
            Year = year;
            Price = price;
        }

        // Abstract method to be implemented by derived classes
        public abstract void DisplayInfo();
    }
    public class Car : Vehicle
    {
        // Additional properties specific to Car
        public int NumberOfDoors { get; set; }
        // Constructor
        public Car(string make, string model, int year, decimal price, int numberOfDoors)
            : base(make, model, year, price)
        {
            NumberOfDoors = numberOfDoors;
        }
        // Implementation of abstract method
        public override void DisplayInfo()
        {
            Console.WriteLine($"Car: {Make} {Model} ({Year}) - ${Price}, Doors: {NumberOfDoors}");
        }
    }
    public class Truck : Vehicle
    {
        // Additional properties specific to Truck
        public int PayloadCapacity { get; set; }
        // Constructor
        public Truck(string make, string model, int year, decimal price, int payloadCapacity)
            : base(make, model, year, price)
        {
            PayloadCapacity = payloadCapacity;
        }
        // Implementation of abstract method
        public override void DisplayInfo()
        {
            Console.WriteLine($"Truck: {Make} {Model} ({Year}) - ${Price}, Payload Capacity: {PayloadCapacity} lbs");
        }
    }
    public class SUV : Vehicle
    {
        // Additional properties specific to SUV
        public int SeatingCapacity { get; set; }
        // Constructor
        public SUV(string make, string model, int year, decimal price, int seatingCapacity)
            : base(make, model, year, price)
        {
            SeatingCapacity = seatingCapacity;
        }
        // Implementation of abstract method
        public override void DisplayInfo()
        {
            Console.WriteLine($"SUV: {Make} {Model} ({Year}) - ${Price}, Seating Capacity: {SeatingCapacity}");
        }
    }

    // Class representing the dealership service
    public class DealershipService
    {
        // Placeholder class for dealership service functionalities
        // Implement methods for adding vehicles, listing available vehicles, searching vehicles, and managing sales
        // List to store vehicles in the inventory
        private List<Vehicle> Inventory { get; set; }

        // Constructor
        public DealershipService()
        {
            Inventory = new List<Vehicle>();
        }

        // Method to add a vehicle to the inventory
        public void AddVehicle(Vehicle vehicle)
        {
            Inventory.Add(vehicle);
            Console.WriteLine("Vehicle added to inventory successfully.");
        }

        // Method to list available vehicles in the inventory
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

        // Method to search for vehicles based on criteria
        public void SearchVehicles(string criteria)
        {
            if (Inventory.Count == 0)
            {
                Console.WriteLine("No vehicles available in the inventory.");
                return;
            }

            List<Vehicle> matchingVehicles = new List<Vehicle>();
            foreach (var vehicle in Inventory)
            {
                if (vehicle.Make.IndexOf(criteria, StringComparison.OrdinalIgnoreCase) >= 0 ||
                    vehicle.Model.IndexOf(criteria, StringComparison.OrdinalIgnoreCase) >= 0 ||
                    vehicle.Price.ToString().IndexOf(criteria, StringComparison.OrdinalIgnoreCase) >= 0)
                {
                    matchingVehicles.Add(vehicle);
                }
            }

            if (matchingVehicles.Count == 0)
            {
                Console.WriteLine("No vehicles found matching the search criteria.");
            }
            else
            {
                Console.WriteLine("Search Results:");
                foreach (var vehicle in matchingVehicles)
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
                Console.WriteLine($"{i + 1}. {Inventory[i].Make} {Inventory[i].Model} ({Inventory[i].Year}) - ${Inventory[i].Price}");
            }

            Console.WriteLine("Select a vehicle to sell (enter the corresponding number):");
            int selectedIndex;
            if (!int.TryParse(Console.ReadLine(), out selectedIndex) || selectedIndex < 1 || selectedIndex > Inventory.Count)
            {
                Console.WriteLine("Invalid selection. Please enter a valid number.");
                return;
            }

            Vehicle selectedVehicle = Inventory[selectedIndex - 1];

            Console.WriteLine("Selected Vehicle:");
            selectedVehicle.DisplayInfo();

            Console.WriteLine("Enter buyer information:");
            Console.Write("Name: ");
            string buyerName = Console.ReadLine();
            Console.Write("Email: ");
            string buyerEmail = Console.ReadLine();

            Console.WriteLine("Confirm sale of the selected vehicle? (Y/N)");
            string confirmation = Console.ReadLine();
            if (confirmation.ToUpper() == "Y")
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
