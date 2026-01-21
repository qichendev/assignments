using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace A5
{
    // Abstract base class for Rebel Alliance operatives
    public abstract class Rebel
    {
        // Protected properties
        protected string Name;
        protected string Species;
        protected string Homeworld;
        protected string Rank;
        protected int MissionsCompleted;

        // Constructor
        protected Rebel(string name, string species, string homeworld, string rank, int missionsCompleted)
        {
            Name = name;
            Species = species;
            Homeworld = homeworld;
            Rank = rank;
            MissionsCompleted = missionsCompleted;
        }

        // Getters and Setters
        public string GetName() => Name;
        public void SetName(string name) => Name = name;
        
        public string GetSpecies() => Species;
        public void SetSpecies(string species) => Species = species;
        
        public string GetHomeworld() => Homeworld;
        public void SetHomeworld(string homeworld) => Homeworld = homeworld;
        
        public string GetRank() => Rank;
        public void SetRank(string rank) => Rank = rank;
        
        public int GetMissionsCompleted() => MissionsCompleted;
        public void SetMissionsCompleted(int missionsCompleted) => MissionsCompleted = missionsCompleted;

        // Override ToString method
        public override string ToString()
        {
            return $"{Name}, a {Species} from {Homeworld}, Age {Rank}, Missions: {MissionsCompleted}";
        }

        // Override Equals method to compare by Name and Homeworld
        public override bool Equals(object obj)
        {
            if (obj == null || GetType() != obj.GetType())
                return false;

            Rebel other = (Rebel)obj;
            return Name == other.Name && Homeworld == other.Homeworld;
        }

        // Override GetHashCode when overriding Equals
        public override int GetHashCode()
        {
            return Name.GetHashCode() ^ Homeworld.GetHashCode();
            //return HashCode.Combine(Name, Homeworld);
        }
    }

    // Spy subclass
    public class Spy : Rebel
    {
        private int StealthLevel;
        private bool IsUndercover;

        public Spy(string name, string species, string homeworld, int age, int missionsCompleted, bool isUndercover)
            : base(name, species, homeworld, age.ToString(), missionsCompleted)
        {
            StealthLevel = new Random().Next(1, 11); // Random stealth level 1-10
            IsUndercover = isUndercover;
        }

        public string GetIntelReport()
        {
            if (IsUndercover)
            {
                if (StealthLevel >= 8)
                    return $"{Name} is gathering intel under deep cover.";
                else if (StealthLevel >= 5)
                    return $"{Name} is gathering intel while maintaining cover.";
                else
                    return $"{Name} is gathering intel but may be compromised.";
            }
            else
            {
                if (StealthLevel >= 8)
                    return $"{Name} is gathering intel with exceptional stealth.";
                else if (StealthLevel >= 5)
                    return $"{Name} is gathering intel with moderate stealth.";
                else
                    return $"{Name} is gathering intel with basic stealth.";
            }
        }
    }

    // Pilot subclass
    public class Pilot : Rebel
    {
        private string StarfighterModel;
        private int FlightHours;

        public Pilot(string name, string species, string homeworld, int age, int missionsCompleted, string starfighterModel)
            : base(name, species, homeworld, age.ToString(), missionsCompleted)
        {
            StarfighterModel = starfighterModel;
            FlightHours = new Random().Next(100, 1001); // Random flight hours 100-1000
        }

        public string FlyMission()
        {
            if (FlightHours >= 800)
                return $"{Name} is flying a {StarfighterModel} into battle with expert precision!";
            else if (FlightHours >= 500)
                return $"{Name} is flying a {StarfighterModel} into battle!";
            else
                return $"{Name} is flying a {StarfighterModel} into battle with growing confidence!";
        }
    }

    // Jedi subclass
    public class Jedi : Rebel
    {
        private string LightsaberColor;
        private bool IsCouncilMember;

        public Jedi(string name, string species, string homeworld, int age, int missionsCompleted, string lightsaberColor)
            : base(name, species, homeworld, age.ToString(), missionsCompleted)
        {
            LightsaberColor = lightsaberColor;
            IsCouncilMember = new Random().Next(2) == 1; // Random council membership
        }

        public string UseTheForce()
        {
            if (IsCouncilMember)
            {
                return $"{Name} uses the Force with wisdom and wields a {LightsaberColor} lightsaber as a Council member.";
            }
            else
            {
                return $"{Name} uses the Force and wields a {LightsaberColor} lightsaber.";
            }
        }
    }

    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Rebel Roster");
            Console.WriteLine();

            // Create the list of Rebel operatives
            List<Rebel> rebelTeam = new List<Rebel>
            {
                new Spy("Cassian Andor", "Human", "Fest", 32, 15, true),
                new Pilot("Wedge Antilles", "Human", "Corellia", 28, 24, "X-Wing"),
                new Jedi("Luke Skywalker", "Human", "Tatooine", 25, 30, "Green"),
                new Pilot("Hera Syndulla", "Twi'lek", "Ryloth", 35, 40, "Ghost")
            };

            // Loop through the list and call ToString() on each one
            foreach (Rebel rebel in rebelTeam)
            {
                Console.WriteLine(rebel.ToString());
                
                // Call the specific method for each type
                if (rebel is Spy spy)
                {
                    Console.WriteLine(spy.GetIntelReport());
                }
                else if (rebel is Pilot pilot)
                {
                    Console.WriteLine(pilot.FlyMission());
                }
                else if (rebel is Jedi jedi)
                {
                    Console.WriteLine(jedi.UseTheForce());
                }
                
                Console.WriteLine();
            }

            // Use Equals() to compare two operatives for duplication
            Console.WriteLine("Checking for duplicates:");
            if (rebelTeam[0].Equals(rebelTeam[1]))
            {
                Console.WriteLine("Cassian Andor and Wedge Antilles are duplicates.");
            }
            else
            {
                Console.WriteLine("Cassian Andor and Wedge Antilles are NOT duplicates.");
            }
            Console.WriteLine();

            // Display summary
            int totalMissions = rebelTeam.Sum(r => r.GetMissionsCompleted());
            int spyCount = rebelTeam.OfType<Spy>().Count();
            int pilotCount = rebelTeam.OfType<Pilot>().Count();
            int jediCount = rebelTeam.OfType<Jedi>().Count();

            Console.WriteLine($"Total Missions Completed: {totalMissions}");
            Console.WriteLine($"Spies: {spyCount}");
            Console.WriteLine($"Pilots: {pilotCount}");
            Console.WriteLine($"Jedi: {jediCount}");

            Console.WriteLine("\nPress any key to exit...");
            Console.ReadKey();
        }
    }
}
