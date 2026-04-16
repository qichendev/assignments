const mongoose = require("mongoose");

const userRepository = require("../models/userRepository");

const editableFields = [
  "lastName",
  "firstName",
  "dateOfBirth",
  "address1",
  "address2",
  "city",
  "postalCode",
  "country",
  "phoneNumber",
  "email",
  "userNotes"
];

function buildUserPayload(body) {
  const payload = {};

  editableFields.forEach((field) => {
    const value = body[field];

    if (field === "dateOfBirth") {
      payload[field] = value ? new Date(value) : undefined;
      return;
    }

    payload[field] = typeof value === "string" ? value.trim() : "";
  });

  return payload;
}

function normalizeValidationErrors(error) {
  if (!error || !error.errors) {
    return [];
  }

  return Object.values(error.errors).map((item) => item.message);
}

exports.listUsers = async (req, res, next) => {
  try {
    const users = await userRepository.listUsers();
    res.json(users);
  } catch (error) {
    next(error);
  }
};

exports.getUser = async (req, res, next) => {
  try {
    if (!mongoose.isValidObjectId(req.params.id)) {
      return res.status(404).json({ message: "User not found." });
    }

    const user = await userRepository.findUserById(req.params.id);

    if (!user) {
      return res.status(404).json({ message: "User not found." });
    }

    res.json(user);
  } catch (error) {
    next(error);
  }
};

exports.createUser = async (req, res, next) => {
  const payload = buildUserPayload(req.body);

  try {
    const user = await userRepository.createUser(payload);
    res.status(201).json(user);
  } catch (error) {
    if (error.name === "ValidationError") {
      return res.status(400).json({
        message: "User validation failed.",
        errors: normalizeValidationErrors(error)
      });
    }

    next(error);
  }
};

exports.updateUser = async (req, res, next) => {
  const { id } = req.params;
  const payload = buildUserPayload(req.body);

  try {
    if (!mongoose.isValidObjectId(id)) {
      return res.status(404).json({ message: "User not found." });
    }

    const user = await userRepository.findUserById(id);

    if (!user) {
      return res.status(404).json({ message: "User not found." });
    }

    const updatedUser = await userRepository.updateUser(id, payload);
    res.json(updatedUser);
  } catch (error) {
    if (error.name === "ValidationError") {
      return res.status(400).json({
        message: "User validation failed.",
        errors: normalizeValidationErrors(error)
      });
    }

    next(error);
  }
};

exports.deleteUser = async (req, res, next) => {
  try {
    if (!mongoose.isValidObjectId(req.params.id)) {
      return res.status(404).json({ message: "User not found." });
    }

    const deletedUser = await userRepository.deleteUser(req.params.id);

    if (!deletedUser) {
      return res.status(404).json({ message: "User not found." });
    }

    res.status(204).send();
  } catch (error) {
    next(error);
  }
};
