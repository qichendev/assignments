require("dotenv").config();

const connectToDatabase = require("../config/db");
const User = require("../models/User");

const firstNames = ["Avery", "Jordan", "Morgan", "Taylor", "Riley", "Casey", "Jamie", "Quinn"];
const lastNames = ["Chen", "Patel", "Smith", "Brown", "Garcia", "Wilson", "Lee", "Martin"];
const cities = ["Toronto", "Vancouver", "Montreal", "Calgary", "Ottawa", "Halifax"];
const countries = ["Canada", "United States", "United Kingdom", "Australia"];
const notes = [
  "Prefers email follow-up after business hours.",
  "Interested in product updates and account reminders.",
  "Requested a phone call before any address change.",
  "Long-term customer with complete contact information."
];

function pick(items) {
  return items[Math.floor(Math.random() * items.length)];
}

function buildUser(index) {
  const firstName = pick(firstNames);
  const lastName = pick(lastNames);
  const birthYear = 1970 + Math.floor(Math.random() * 35);

  return {
    firstName,
    lastName,
    dateOfBirth: new Date(`${birthYear}-0${1 + (index % 9)}-${10 + (index % 18)}`),
    address1: `${100 + index} College Street`,
    address2: index % 3 === 0 ? `Unit ${index}` : "",
    city: pick(cities),
    postalCode: `M${index}A ${index}B${index}`,
    country: pick(countries),
    phoneNumber: `416-555-${String(1000 + index).slice(-4)}`,
    email: `${firstName}.${lastName}.${index}@example.com`.toLowerCase(),
    userNotes: pick(notes)
  };
}

async function seedUsers() {
  if (!process.env.MONGODB_URI) {
    throw new Error("Set MONGODB_URI before running npm run seed.");
  }

  await connectToDatabase();

  await User.deleteMany({});
  await User.insertMany(Array.from({ length: 16 }, (_, index) => buildUser(index + 1)));

  console.log("Seeded 16 users.");
  process.exit(0);
}

seedUsers().catch((error) => {
  console.error(error.message);
  process.exit(1);
});
