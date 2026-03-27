const mongoose = require("mongoose");

const userSchema = new mongoose.Schema(
  {
    lastName: {
      type: String,
      required: [true, "Last name is required."],
      trim: true
    },
    firstName: {
      type: String,
      required: [true, "First name is required."],
      trim: true
    },
    dateOfBirth: {
      type: Date
    },
    address1: {
      type: String,
      trim: true
    },
    address2: {
      type: String,
      trim: true
    },
    city: {
      type: String,
      trim: true
    },
    postalCode: {
      type: String,
      trim: true
    },
    country: {
      type: String,
      trim: true
    },
    phoneNumber: {
      type: String,
      trim: true
    },
    email: {
      type: String,
      required: [true, "Email is required."],
      trim: true,
      lowercase: true,
      match: [/\S+@\S+\.\S+/, "Please enter a valid email address."]
    },
    userNotes: {
      type: String,
      trim: true
    }
  },
  {
    timestamps: true
  }
);

module.exports = mongoose.model("User", userSchema);
